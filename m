Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264963AbSLLSIh>; Thu, 12 Dec 2002 13:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265037AbSLLSH7>; Thu, 12 Dec 2002 13:07:59 -0500
Received: from d06lmsgate-6.uk.ibm.com ([194.196.100.252]:26850 "EHLO
	d06lmsgate-6.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S264954AbSLLSHI> convert rfc822-to-8bit; Thu, 12 Dec 2002 13:07:08 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (3/8): io fixes.
Date: Thu, 12 Dec 2002 19:07:34 +0100
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212121907.34106.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Start of chsc interface cleanup. Fix for a race condition in do_IRQ.
Fix device reference counting.

diffstat:
 drivers/s390/cio/Makefile     |    2 
 drivers/s390/cio/blacklist.c  |   10 -
 drivers/s390/cio/chsc.c       |  245 +++++++++++++-----------------------------
 drivers/s390/cio/chsc.h       |   80 +++++++++++++
 drivers/s390/cio/cio.c        |   35 ++----
 drivers/s390/cio/cio.h        |    2 
 drivers/s390/cio/css.c        |   10 +
 drivers/s390/cio/device.c     |   23 +++
 drivers/s390/cio/device_fsm.c |   20 ++-
 drivers/s390/cio/ioasm.h      |    2 
 drivers/s390/cio/qdio.c       |   34 +++--
 drivers/s390/net/cu3088.c     |    6 -
 include/asm-s390/cio.h        |    2 
 include/asm-s390x/ccwgroup.h  |    8 -
 include/asm-s390x/cio.h       |    2 
 15 files changed, 248 insertions(+), 233 deletions(-)

diff -urN linux-2.5.51/drivers/s390/cio/Makefile linux-2.5.51-s390/drivers/s390/cio/Makefile
--- linux-2.5.51/drivers/s390/cio/Makefile	Tue Dec 10 03:45:39 2002
+++ linux-2.5.51-s390/drivers/s390/cio/Makefile	Thu Dec 12 18:03:11 2002
@@ -3,7 +3,7 @@
 #
 
 obj-y += airq.o blacklist.o chsc.o cio.o css.o requestirq.o 
-export-objs += airq.o css.o chsc.o cio.o requestirq.o
+export-objs += airq.o css.o cio.o requestirq.o
 
 ccw_device-objs += device.o device_fsm.o device_ops.o
 ccw_device-objs += device_id.o device_pgid.o device_status.o
diff -urN linux-2.5.51/drivers/s390/cio/blacklist.c linux-2.5.51-s390/drivers/s390/cio/blacklist.c
--- linux-2.5.51/drivers/s390/cio/blacklist.c	Tue Dec 10 03:45:53 2002
+++ linux-2.5.51-s390/drivers/s390/cio/blacklist.c	Thu Dec 12 18:03:11 2002
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/blacklist.c
  *   S/390 common I/O routines -- blacklisting of specific devices
- *   $Revision: 1.22 $
+ *   $Revision: 1.23 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -162,10 +162,10 @@
 		else
 			blacklist_parse_parameters (buf + 5, free);
 	} else if (strncmp (buf, "add ", 4) == 0) {
-		/* FIXME: the old code was checking if the new bl'ed
-		 * devices are already known to the system so
-		 * validate_subchannel would still give a working
-		 * status. is that necessary? */
+		/* 
+		 * We don't need to check for known devices since
+		 * css_probe_device will handle this correctly. 
+		 */
 		blacklist_parse_parameters (buf + 4, add);
 	} else {
 		printk (KERN_WARNING "cio_ignore: Parse error; \n"
diff -urN linux-2.5.51/drivers/s390/cio/chsc.c linux-2.5.51-s390/drivers/s390/cio/chsc.c
--- linux-2.5.51/drivers/s390/cio/chsc.c	Tue Dec 10 03:46:10 2002
+++ linux-2.5.51-s390/drivers/s390/cio/chsc.c	Thu Dec 12 18:03:11 2002
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/chsc.c
  *   S/390 common I/O routines -- channel subsystem call
- *   $Revision: 1.43 $
+ *   $Revision: 1.46 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -37,26 +37,6 @@
 
 static int new_channel_path(int chpid, int status);
 
-int
-chsc(void *data)
-{
-	void *area;
-	int cc;
-
-	if (!data)
-		return -EINVAL;
-
-	area = (void *)get_zeroed_page(GFP_KERNEL);
-	if (!area)
-		return -ENOMEM;
-	memcpy(area, data, PAGE_SIZE);
-	cc = do_chsc(area);
-	if (cc == 0)
-		memcpy(data, area, PAGE_SIZE);
-	free_page((unsigned long)area);
-	return cc;
-}
-
 static int
 set_chp_status(int chp, int status)
 {
@@ -114,21 +94,18 @@
 	 * be page-aligned. Implement proper locking or dynamic
 	 * allocation or prove that this function does not have to be
 	 * reentrant! */
-	static struct chsc_area __attribute__ ((aligned(PAGE_SIZE))) chsc_area_ssd;
+	static struct ssd_area chsc_area_ssd 
+		__attribute__ ((aligned(PAGE_SIZE)));
 
-	typeof (chsc_area_ssd.response_block.response_block_data.ssd_res)
-		*ssd_res = &chsc_area_ssd.response_block.response_block_data.ssd_res;
+	typeof (chsc_area_ssd.response_block)
+		*ssd_res = &chsc_area_ssd.response_block;
 
-	chsc_area_ssd = (struct chsc_area) {
+	chsc_area_ssd = (struct ssd_area) {
 		.request_block = {
 			.command_code1 = 0x0010,
 			.command_code2 = 0x0004,
-			.request_block_data = {
-				.ssd_req = {
-					.f_sch = irq,
-					.l_sch = irq,
-				}
-			}
+			.f_sch = irq,
+			.l_sch = irq,
 		}
 	};
 
@@ -306,14 +283,59 @@
 #endif
 }
 
-/* this used to be in s390_process_res_acc_*, FIXME: find a better name
- * for this function */
 static int
-s390_check_valid_chpid(u8 chpid)
+s390_process_res_acc_sch(u8 chpid, __u16 fla, u32 fla_mask,
+			 struct subchannel *sch)
+{
+	int found;
+	int chp;
+	int ccode;
+	
+	/* Update our ssd_info */
+	if (chsc_get_sch_desc_irq(sch->irq))
+		return 0;
+	
+	found = 0;
+	for (chp = 0; chp <= 7; chp++)
+		/*
+		 * check if chpid is in information updated by ssd
+		 */
+		if (sch->ssd_info.valid &&
+		    sch->ssd_info.chpid[chp] == chpid &&
+		    (sch->ssd_info.fla[chp] & fla_mask) == fla) {
+			found = 1;
+			break;
+		}
+	
+	if (found == 0)
+		return 0;
+
+	/*
+	 * Do a stsch to update our subchannel structure with the
+	 * new path information and eventually check for logically
+	 * offline chpids.
+	 */
+	ccode = stsch(sch->irq, &sch->schib);
+	if (ccode > 0)
+		return 0;
+
+	return 0x80 >> chp;
+}
+
+static void
+s390_process_res_acc (u8 chpid, __u16 fla, u32 fla_mask)
 {
+	struct subchannel *sch;
+	int irq;
+	int ret;
 	char dbf_txt[15];
+
 	sprintf(dbf_txt, "accpr%x", chpid);
 	CIO_TRACE_EVENT( 2, dbf_txt);
+	if (fla != 0) {
+		sprintf(dbf_txt, "fla%x", fla);
+		CIO_TRACE_EVENT( 2, dbf_txt);
+	}
 
 	/*
 	 * I/O resources may have become accessible.
@@ -333,31 +355,14 @@
 		CIO_CRW_EVENT(0, "Error: Could not retrieve "
 			      "subchannel descriptions, will not process css"
 			      "machine check...\n");
-		return 0;
+		return;
 	}
 
 	if (!test_bit(chpid, chpids_logical))
-		return 0; /* no need to do the rest */
-
-	return 1;
-}
-
-static void
-s390_process_res_acc_chpid (u8 chpid)
-{
-	struct subchannel *sch;
-	int irq;
-	int ccode;
-	int chp;
-	int ret;
-
-	if (!s390_check_valid_chpid(chpid))
-		return;
-
-	pr_debug( KERN_DEBUG "Looking at chpid %x...\n", chpid);
+		return; /* no need to do the rest */
 
 	for (irq = 0; irq <= __MAX_SUBCHANNELS; irq++) {
-		int found;
+		int chp_mask;
 
 		sch = ioinfo[irq];
 		if (!sch) {
@@ -375,122 +380,33 @@
 				return;
 			continue;
 		}
-
+	
 		spin_lock_irq(&sch->lock);
 
-		/* Update our ssd_info */
-		if (chsc_get_sch_desc_irq(sch->irq))
-			break;
-
-		found = 0;
-		for (chp = 0; chp <= 7; chp++)
-			/*
-			 * check if chpid is in information updated by ssd
-			 */
-			if (sch->ssd_info.valid &&
-			    (sch->ssd_info.chpid[chp] == chpid)) {
-				found = 1;
-				break;
-			}
+		chp_mask = s390_process_res_acc_sch(chpid, fla, fla_mask, sch);
+		if (chp_mask == 0) {
 
-		if (found == 0) {
 			spin_unlock_irq(&sch->lock);
-			continue;
-		}
-		/*
-		 * Do a stsch to update our subchannel structure with the
-		 * new path information and eventually check for logically
-		 * offline chpids.
-		 */
-		ccode = stsch(sch->irq, &sch->schib);
-		if (ccode > 0) {
-// FIXME:		ccw_device_recognition(cdev);
-			spin_unlock_irq(&sch->lock);
-			continue;
+
+			if (fla_mask != 0)
+				break;
+			else
+				continue;
 		}
 
-		sch->lpm = sch->schib.pmcw.pim &
-			sch->schib.pmcw.pam &
-			sch->schib.pmcw.pom;
+		sch->lpm = (sch->schib.pmcw.pim &
+			    sch->schib.pmcw.pam &
+			    sch->schib.pmcw.pom)
+			| chp_mask;
 
 		chsc_validate_chpids(sch);
 
-		sch->lpm |= (0x80 >> chp);
 		dev_fsm_event(sch->dev.driver_data, DEV_EVENT_VERIFY);
 
 		spin_unlock_irq(&sch->lock);
-	}
-}
-
-static void
-s390_process_res_acc_linkaddr ( __u8 chpid, __u16 fla, u32 fla_mask)
-{
-	char dbf_txt[15];
-	struct subchannel *sch;
-	int irq;
-	int ccode;
-	int ret;
-	int j;
-
-	if (!s390_check_valid_chpid(chpid))
-		return;
 
-	sprintf(dbf_txt, "fla%x", fla);
-	CIO_TRACE_EVENT( 2, dbf_txt);
-
-	pr_debug(KERN_DEBUG "Looking at chpid %x, link addr %x...\n", chpid, fla);
-	for (irq = 0; irq <= __MAX_SUBCHANNELS; irq++) {
-		int found;
-		
-		sch = ioinfo[irq];
-		if (!sch) {
-			/* The full program again (see above), grr... */
-			ret = css_probe_device(irq);
-			if (ret == -ENXIO)
-				/* We're through */
-				return;
-			return;
-		}
-
-		/*
-		 * Walk through all subchannels and
-		 * look if our chpid and our (masked) link
-		 * address are in somewhere
-		 * Do a stsch for the found subchannels and
-		 * perform path grouping
-		 */
-
-		/* Update our ssd_info */
-		if (chsc_get_sch_desc_irq(sch->irq))
-			break;
-
-		found = 0;
-		for (j = 0; j < 8; j++)
-			if (sch->ssd_info.valid &&
-			    sch->ssd_info.chpid[j] == chpid &&
-			    (sch->ssd_info.fla[j] & fla_mask) == fla) {
-				found = 1;
-				break;
-			}
-
-		if (found == 0)
-			continue;
-
-		ccode = stsch(sch->irq, &sch->schib);
-		if (ccode > 0)
+		if (fla_mask != 0)
 			break;
-
-		sch->lpm = sch->schib.pmcw.pim &
-			sch->schib.pmcw.pam &
-			sch->schib.pmcw.pom;
-		
-		chsc_validate_chpids(sch);
-		
-		sch->lpm |= (0x80 >> j);
-		dev_fsm_event(sch->dev.driver_data, DEV_EVENT_VERIFY);
-						
-		/* We've found it, get out of here. */
-		break;
 	}
 }
 
@@ -508,7 +424,7 @@
 	 * be page-aligned. Implement proper locking or dynamic
 	 * allocation or prove that this function does not have to be
 	 * reentrant! */
-	static struct chsc_area chsc_area_sei
+	static struct sei_area chsc_area_sei
 		__attribute__ ((aligned(PAGE_SIZE))) = {
 			.request_block = {
 				.command_code1 = 0x0010,
@@ -516,8 +432,8 @@
 			}
 		};
 
-	typeof (chsc_area_sei.response_block.response_block_data.sei_res)
-		*sei_res = &chsc_area_sei.response_block.response_block_data.sei_res;
+	typeof (chsc_area_sei.response_block)
+		*sei_res = &chsc_area_sei.response_block;
 
 
 	CIO_TRACE_EVENT( 2, "prcss");
@@ -582,17 +498,17 @@
 
 		if ((sei_res->vf & 0x80) == 0) {
 			pr_debug( KERN_DEBUG "chpid: %x\n", sei_res->rsid);
-			s390_process_res_acc_chpid (sei_res->rsid);
+			s390_process_res_acc(sei_res->rsid, 0, 0);
 		} else if ((sei_res->vf & 0xc0) == 0x80) {
 			pr_debug( KERN_DEBUG "chpid: %x link addr: %x\n",
 			       sei_res->rsid, sei_res->fla);
-			s390_process_res_acc_linkaddr (sei_res->rsid,
-						       sei_res->fla, 0xff00);
+			s390_process_res_acc(sei_res->rsid, sei_res->fla,
+					     0xff00);
 		} else if ((sei_res->vf & 0xc0) == 0xc0) {
 			pr_debug( KERN_DEBUG "chpid: %x full link addr: %x\n",
 			       sei_res->rsid, sei_res->fla);
-			s390_process_res_acc_linkaddr (sei_res->rsid,
-						       sei_res->fla, 0xffff);
+			s390_process_res_acc(sei_res->rsid, sei_res->fla,
+					     0xffff);
 		}
 		pr_debug( KERN_DEBUG "\n");
 
@@ -810,4 +726,3 @@
 }
 
 module_init(register_channel_paths);
-EXPORT_SYMBOL(chsc);
diff -urN linux-2.5.51/drivers/s390/cio/chsc.h linux-2.5.51-s390/drivers/s390/cio/chsc.h
--- linux-2.5.51/drivers/s390/cio/chsc.h	Tue Dec 10 03:46:15 2002
+++ linux-2.5.51-s390/drivers/s390/cio/chsc.h	Thu Dec 12 18:03:11 2002
@@ -12,6 +12,86 @@
 #define CHSC_SEI_ACC_LINKADDR     2
 #define CHSC_SEI_ACC_FULLLINKADDR 3
 
+struct sei_area {
+	struct {
+		/* word 0 */
+		__u16 command_code1;
+		__u16 command_code2;
+		/* word 1 */
+		__u32 reserved1;
+		/* word 2 */
+		__u32 reserved2;
+		/* word 3 */
+		__u32 reserved3;
+	} __attribute__ ((packed,aligned(8))) request_block;
+	struct {
+		/* word 0 */
+		__u16 length;
+		__u16 response_code;
+		/* word 1 */
+		__u32 reserved1;
+		/* word 2 */
+		__u8  flags;
+		__u8  vf;	  /* validity flags */
+		__u8  rs;	  /* reporting source */
+		__u8  cc;	  /* content code */
+		/* word 3 */
+		__u16 fla;	  /* full link address */
+		__u16 rsid;	  /* reporting source id */
+		/* word 4 */
+		__u32 reserved2;
+		/* word 5 */
+		__u32 reserved3;
+		/* word 6 */
+		__u32 ccdf;	  /* content-code dependent field */
+		/* word 7 */
+		__u32 reserved4;
+		/* word 8 */
+		__u32 reserved5;
+		/* word 9 */
+		__u32 reserved6;
+	} __attribute__ ((packed,aligned(8))) response_block;
+} __attribute__ ((packed,aligned(PAGE_SIZE)));
+
+struct ssd_area {
+	struct {
+		/* word 0 */
+		__u16 command_code1;
+		__u16 command_code2;
+		/* word 1 */
+		__u16 reserved1;
+		__u16 f_sch;	 /* first subchannel */
+		/* word 2 */
+		__u16 reserved2;
+		__u16 l_sch;	/* last subchannel */
+		/* word 3 */
+		__u32 reserved3;
+	} __attribute__ ((packed,aligned(8))) request_block;
+	struct {
+		/* word 0 */
+		__u16 length;
+		__u16 response_code;
+		/* word 1 */
+		__u32 reserved1;
+		/* word 2 */
+		__u8 sch_valid : 1;
+		__u8 dev_valid : 1;
+		__u8 st	       : 3; /* subchannel type */
+		__u8 zeroes    : 3;
+		__u8  unit_addr;  /* unit address */
+		__u16 devno;	  /* device number */
+		/* word 3 */
+		__u8 path_mask;
+		__u8 fla_valid_mask;
+		__u16 sch;	  /* subchannel */
+		/* words 4-5 */
+		__u8 chpid[8];	  /* chpids 0-7 */
+		/* words 6-9 */
+		__u16 fla[8];	  /* full link addresses 0-7 */
+	} __attribute__ ((packed,aligned(8))) response_block;
+} __attribute__ ((packed,aligned(PAGE_SIZE)));
+
+
 struct channel_path {
 	int id;
 	int state;
diff -urN linux-2.5.51/drivers/s390/cio/cio.c linux-2.5.51-s390/drivers/s390/cio/cio.c
--- linux-2.5.51/drivers/s390/cio/cio.c	Tue Dec 10 03:46:25 2002
+++ linux-2.5.51-s390/drivers/s390/cio/cio.c	Thu Dec 12 18:03:11 2002
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/cio.c
  *   S/390 common I/O routines -- low level i/o calls
- *   $Revision: 1.89 $
+ *   $Revision: 1.90 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -609,6 +609,7 @@
 	struct subchannel *sch;
 	struct irb *irb;
 
+	irq_enter ();
 	/*
 	 * Get interrupt information from lowcore
 	 */
@@ -620,28 +621,23 @@
 		 */
 		if (tpi_info->adapter_IO == 1 &&
 		    tpi_info->int_type == IO_INTERRUPT_TYPE) {
-			irq_enter ();
 			do_adapter_IO (tpi_info->intparm);
-			irq_exit ();
 			continue;
 		}
-		/* Store interrupt response block to lowcore. */
-		if (tsch (tpi_info->irq, irb) != 0)
-			/* Not status pending or not operational. */
-			continue;
-
 		sch = ioinfo[tpi_info->irq];
-		if (!sch)
-			continue;
-
-		irq_enter ();
-		spin_lock(&sch->lock);
-		memcpy (&sch->schib.scsw, &irb->scsw, sizeof (irb->scsw));
-		if (sch->driver && sch->driver->irq)
-			sch->driver->irq(&sch->dev);
-		spin_unlock(&sch->lock);
-		irq_exit ();
-
+		if (sch)
+			spin_lock(&sch->lock);
+		/* Store interrupt response block to lowcore. */
+		if (tsch (tpi_info->irq, irb) == 0 && sch) {
+			/* Keep subchannel information word up to date. */
+			memcpy (&sch->schib.scsw, &irb->scsw,
+				sizeof (irb->scsw));
+			/* Call interrupt handler if there is one. */
+			if (sch->driver && sch->driver->irq)
+				sch->driver->irq(&sch->dev);
+		}
+		if (sch)
+			spin_unlock(&sch->lock);
 		/*
 		 * Are more interrupts pending?
 		 * If so, the tpi instruction will update the lowcore
@@ -650,6 +646,7 @@
 		 * out of the sie which costs more cycles than it saves.
 		 */
 	} while (!MACHINE_IS_VM && tpi (NULL) != 0);
+	irq_exit ();
 }
 
 #ifdef CONFIG_CCW_CONSOLE
diff -urN linux-2.5.51/drivers/s390/cio/cio.h linux-2.5.51-s390/drivers/s390/cio/cio.h
--- linux-2.5.51/drivers/s390/cio/cio.h	Tue Dec 10 03:45:42 2002
+++ linux-2.5.51-s390/drivers/s390/cio/cio.h	Thu Dec 12 18:03:11 2002
@@ -113,7 +113,6 @@
 #define to_subchannel(n) container_of(n, struct subchannel, dev)
 
 extern int cio_validate_subchannel (struct subchannel *, unsigned int);
-extern int cio_modify (struct subchannel *);
 extern int cio_enable_subchannel (struct subchannel *, unsigned int);
 extern int cio_disable_subchannel (struct subchannel *);
 extern int cio_cancel (struct subchannel *);
@@ -127,7 +126,6 @@
 extern int cio_get_options (struct subchannel *);
 
 /* Use with care. */
-extern int cio_tpi (void);
 extern struct subchannel *cio_probe_console(void);
 extern void cio_release_console(void);
 
diff -urN linux-2.5.51/drivers/s390/cio/css.c linux-2.5.51-s390/drivers/s390/cio/css.c
--- linux-2.5.51/drivers/s390/cio/css.c	Tue Dec 10 03:45:44 2002
+++ linux-2.5.51-s390/drivers/s390/cio/css.c	Thu Dec 12 18:03:11 2002
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/css.c
  *  driver for channel subsystem
- *   $Revision: 1.39 $
+ *   $Revision: 1.40 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -20,6 +20,7 @@
 #include "cio.h"
 #include "cio_debug.h"
 #include "device.h" // FIXME: dito
+#include "ioasm.h"
 
 struct subchannel *ioinfo[__MAX_SUBCHANNELS];
 unsigned int highest_subchannel;
@@ -154,6 +155,7 @@
 {
 	static DECLARE_WORK(work, do_process_crw, 0);
 	struct subchannel *sch;
+	int ccode, devno;
 
 	CIO_CRW_EVENT(2, "source is subchannel %04X\n", irq);
 
@@ -164,9 +166,13 @@
 	}
 	if (!sch->dev.driver_data)
 		return;
+	devno = sch->schib.pmcw.dev;
 	/* FIXME: css_process_crw must not know about ccw_device */
 	dev_fsm_event(sch->dev.driver_data, DEV_EVENT_NOTOPER);
-	// FIXME: revalidate machine checks?
+	ccode = stsch(irq, &sch->schib);
+	if (!ccode)
+		if (devno != sch->schib.pmcw.dev)
+			schedule_work(&work);
 }
 
 /*
diff -urN linux-2.5.51/drivers/s390/cio/device.c linux-2.5.51-s390/drivers/s390/cio/device.c
--- linux-2.5.51/drivers/s390/cio/device.c	Tue Dec 10 03:46:14 2002
+++ linux-2.5.51-s390/drivers/s390/cio/device.c	Thu Dec 12 18:03:11 2002
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/device.c
  *  bus driver for ccw devices
- *   $Revision: 1.44 $
+ *   $Revision: 1.45 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -362,18 +362,28 @@
 		sch->dev.driver_data = 0;
 		kfree (cdev->private);
 		kfree (cdev);
-		return;
+		goto out;
 	}
 
 	ret = subchannel_add_files(cdev->dev.parent);
 	if (ret)
 		printk(KERN_WARNING "%s: could not add attributes to %04x\n",
 		       __func__, sch->irq);
+out:
+	put_device(&sch->dev);
 }
 
 static void
 io_subchannel_recog(struct ccw_device *cdev, struct subchannel *sch)
 {
+	int rc;
+
+	if (!get_device(&sch->dev)) {
+		if (cdev->dev.release)
+			cdev->dev.release(&cdev->dev);
+		return;
+	}
+
 	sch->dev.driver_data = cdev;
 	sch->driver = &io_subchannel_driver;
 	cdev->ccwlock = &sch->lock;
@@ -392,12 +402,17 @@
 
 	/* Do first half of device_register. */
 	device_initialize(&cdev->dev);
-	get_device(&sch->dev);	/* keep parent refcount in sync. */
 
 	/* Start async. device sensing. */
 	spin_lock_irq(cdev->ccwlock);
-	ccw_device_recognition(cdev);
+	rc = ccw_device_recognition(cdev);
 	spin_unlock_irq(cdev->ccwlock);
+	if (rc) {
+		sch->dev.driver_data = 0;
+		put_device(&sch->dev);
+		if (cdev->dev.release)
+			cdev->dev.release(&cdev->dev);
+	}
 }
 
 static int
diff -urN linux-2.5.51/drivers/s390/cio/device_fsm.c linux-2.5.51-s390/drivers/s390/cio/device_fsm.c
--- linux-2.5.51/drivers/s390/cio/device_fsm.c	Tue Dec 10 03:46:00 2002
+++ linux-2.5.51-s390/drivers/s390/cio/device_fsm.c	Thu Dec 12 18:03:11 2002
@@ -112,7 +112,10 @@
 		CIO_DEBUG(KERN_WARNING, 2,
 			  "SenseID : unknown device %04X on subchannel %04X\n",
 			  sch->schib.pmcw.dev, sch->irq);
-		device_unregister(&cdev->dev);
+		sch->dev.driver_data = 0;
+		put_device(&sch->dev);
+		if (cdev->dev.release)
+			cdev->dev.release(&cdev->dev);
 		break;
 	case DEV_STATE_OFFLINE:
 		/* fill out sense information */
@@ -235,10 +238,8 @@
 
 	sch = to_subchannel(cdev->dev.parent);
 
-	if (state != DEV_STATE_ONLINE) {
+	if (state != DEV_STATE_ONLINE)
 		cio_disable_subchannel(sch);
-		device_unregister(&cdev->dev);
-	}
 
 	/* Reset device status. */
 	memset(&cdev->private->irb, 0, sizeof(struct irb));
@@ -246,6 +247,9 @@
 	cdev->private->state = state;
 
 	wake_up(&cdev->private->wait_q);
+
+	if (state != DEV_STATE_ONLINE)
+		put_device (&cdev->dev);
 }
 
 void
@@ -275,6 +279,8 @@
 	if (cdev->private->state != DEV_STATE_OFFLINE)
 		return -EINVAL;
 	sch = to_subchannel(cdev->dev.parent);
+	if (!get_device(&cdev->dev))
+		return -ENODEV;
 	if (cio_enable_subchannel(sch, sch->schib.pmcw.isc) != 0) {
 		/* Couldn't enable the subchannel for i/o. Sick device. */
 		dev_fsm_event(cdev, DEV_EVENT_NOTOPER);
@@ -683,19 +689,19 @@
 		[DEV_EVENT_NOTOPER]     ccw_device_online_notoper,
 		[DEV_EVENT_INTERRUPT]   ccw_device_qdio_init_irq,
 		[DEV_EVENT_TIMEOUT]     ccw_device_qdio_init_timeout,
-		[DEV_EVENT_VERIFY]      ccw_device_nop, //FIXME
+		[DEV_EVENT_VERIFY]      ccw_device_nop,
 	},
 	[DEV_STATE_QDIO_ACTIVE] {
 		[DEV_EVENT_NOTOPER]     ccw_device_online_notoper,
 		[DEV_EVENT_INTERRUPT]   ccw_device_irq,
 		[DEV_EVENT_TIMEOUT]     ccw_device_nop,
-		[DEV_EVENT_VERIFY]      ccw_device_nop, //FIXME
+		[DEV_EVENT_VERIFY]      ccw_device_nop,
 	},
 	[DEV_STATE_QDIO_CLEANUP] {
 		[DEV_EVENT_NOTOPER]     ccw_device_online_notoper,
 		[DEV_EVENT_INTERRUPT]   ccw_device_qdio_cleanup_irq,
 		[DEV_EVENT_TIMEOUT]     ccw_device_qdio_cleanup_timeout,
-		[DEV_EVENT_VERIFY]      ccw_device_nop, //FIXME
+		[DEV_EVENT_VERIFY]      ccw_device_nop,
 	},
 	/* states to wait for i/o completion before doing something */
 	[DEV_STATE_ONLINE_VERIFY] {
diff -urN linux-2.5.51/drivers/s390/cio/ioasm.h linux-2.5.51-s390/drivers/s390/cio/ioasm.h
--- linux-2.5.51/drivers/s390/cio/ioasm.h	Tue Dec 10 03:46:28 2002
+++ linux-2.5.51-s390/drivers/s390/cio/ioasm.h	Thu Dec 12 18:03:11 2002
@@ -260,7 +260,7 @@
 	return ccode;
 }
 
-extern __inline__ int do_chsc(void *chsc_area)
+extern __inline__ int chsc(void *chsc_area)
 {
 	int cc;
 
diff -urN linux-2.5.51/drivers/s390/cio/qdio.c linux-2.5.51-s390/drivers/s390/cio/qdio.c
--- linux-2.5.51/drivers/s390/cio/qdio.c	Tue Dec 10 03:46:11 2002
+++ linux-2.5.51-s390/drivers/s390/cio/qdio.c	Thu Dec 12 18:03:11 2002
@@ -53,8 +53,9 @@
 #include "device.h"
 #include "airq.h"
 #include "qdio.h"
+#include "ioasm.h"
 
-#define VERSION_QDIO_C "$Revision: 1.16 $"
+#define VERSION_QDIO_C "$Revision: 1.18 $"
 
 /****************** MODULE PARAMETER VARIABLES ********************/
 MODULE_AUTHOR("Utz Bacher <utz.bacher@de.ibm.com>");
@@ -1573,33 +1574,33 @@
 {
 	struct qdio_irq *irq_ptr;
 	struct qdio_q *q;
-	int irq;
 	int cstat,dstat;
-	char dbf_text[15]="qintXXXX";
+	char dbf_text[15];
 
-	irq = cdev->private->irq; /* FIXME: use different dbg */
         cstat = irb->scsw.cstat;
         dstat = irb->scsw.dstat;
 
-	*((int*)(&dbf_text[4]))=irq;
-	QDIO_DBF_HEX4(0,trace,dbf_text,QDIO_DBF_TRACE_LEN);
+	QDIO_DBF_TEXT4(0, trace, "qint");
+	sprintf(dbf_text, "%s", cdev->dev.bus_id);
+	QDIO_DBF_TEXT4(0, trace, dbf_text);
 	
 	if (!intparm || !cdev) {
 		QDIO_PRINT_STUPID("got unsolicited interrupt in qdio " \
-				  "handler, irq 0x%x\n",irq);
+				  "handler, device %s\n", cdev->dev.bus_id);
 		return;
 	}
 
 	irq_ptr = cdev->private->qdio_data;
 	if (!irq_ptr) {
-		sprintf(dbf_text,"uint%4x",irq);
+		QDIO_DBF_TEXT2(1, trace, "uint");
+		sprintf(dbf_text,"%s", cdev->dev.bus_id);
 		QDIO_DBF_TEXT2(1,trace,dbf_text);
-		QDIO_PRINT_ERR("received interrupt on unused irq 0x%04x!\n",
-			       irq);
+		QDIO_PRINT_ERR("received interrupt on unused device %s!\n",
+			       cdev->dev.bus_id);
 		return;
 	}
 
-	qdio_irq_check_sense(irq, irb);
+	qdio_irq_check_sense(irq_ptr->irq, irb);
 
 	if (cstat & SCHN_STAT_PCI) {
 		qdio_handle_pci(irq_ptr);
@@ -1607,21 +1608,22 @@
 	}
 
 	if ((cstat&~SCHN_STAT_PCI)||dstat) {
-		sprintf(dbf_text,"ick2%4x",irq);
+		QDIO_DBF_TEXT2(1, trace, "ick2");
+		sprintf(dbf_text,"%s", cdev->dev.bus_id);
 		QDIO_DBF_TEXT2(1,trace,dbf_text);
 		QDIO_DBF_HEX2(0,trace,&intparm,sizeof(int));
 		QDIO_DBF_HEX2(0,trace,&dstat,sizeof(int));
 		QDIO_DBF_HEX2(0,trace,&cstat,sizeof(int));
 		QDIO_PRINT_ERR("received check condition on activate " \
-			       "queues on irq 0x%x (cs=x%x, ds=x%x).\n",
-			       irq,cstat,dstat);
+			       "queues on device %s (cs=x%x, ds=x%x).\n",
+			       cdev->dev.bus_id, cstat, dstat);
 		if (irq_ptr->no_input_qs) {
 			q=irq_ptr->input_qs[0];
 		} else if (irq_ptr->no_output_qs) {
 			q=irq_ptr->output_qs[0];
 		} else {
-			QDIO_PRINT_ERR("oops... no queue registered on irq " \
-				  "0x%x!?\n",irq);
+			QDIO_PRINT_ERR("oops... no queue registered for " \
+				       "device %s!?\n", cdev->dev.bus_id);
 			goto omit_handler_call;
 		}
 		q->handler(q->irq,QDIO_STATUS_ACTIVATE_CHECK_CONDITION|
diff -urN linux-2.5.51/drivers/s390/net/cu3088.c linux-2.5.51-s390/drivers/s390/net/cu3088.c
--- linux-2.5.51/drivers/s390/net/cu3088.c	Tue Dec 10 03:45:53 2002
+++ linux-2.5.51-s390/drivers/s390/net/cu3088.c	Thu Dec 12 18:03:11 2002
@@ -1,5 +1,5 @@
 /*
- * $Id: cu3088.c,v 1.21 2002/12/03 16:26:45 cohuck Exp $
+ * $Id: cu3088.c,v 1.22 2002/12/10 09:53:55 cohuck Exp $
  *
  * CTC / LCS ccw_device driver
  *
@@ -172,5 +172,5 @@
 module_init(cu3088_init);
 module_exit(cu3088_exit);
 
-EXPORT_SYMBOL(register_cu3088_discipline);
-EXPORT_SYMBOL(unregister_cu3088_discipline);
+EXPORT_SYMBOL_GPL(register_cu3088_discipline);
+EXPORT_SYMBOL_GPL(unregister_cu3088_discipline);
diff -urN linux-2.5.51/include/asm-s390/cio.h linux-2.5.51-s390/include/asm-s390/cio.h
--- linux-2.5.51/include/asm-s390/cio.h	Tue Dec 10 03:46:19 2002
+++ linux-2.5.51-s390/include/asm-s390/cio.h	Thu Dec 12 18:03:11 2002
@@ -262,8 +262,6 @@
 
 extern int diag210(struct diag210 *addr);
 
-extern int chsc(void *data);
-
 extern void wait_cons_dev(void);
 
 #endif
diff -urN linux-2.5.51/include/asm-s390x/ccwgroup.h linux-2.5.51-s390/include/asm-s390x/ccwgroup.h
--- linux-2.5.51/include/asm-s390x/ccwgroup.h	Tue Dec 10 03:45:42 2002
+++ linux-2.5.51-s390/include/asm-s390x/ccwgroup.h	Thu Dec 12 18:03:11 2002
@@ -31,10 +31,10 @@
 
 extern int  ccwgroup_driver_register   (struct ccwgroup_driver *cdriver);
 extern void ccwgroup_driver_unregister (struct ccwgroup_driver *cdriver);
-extern int ccwgroup_create_dev (struct device *root,
-				unsigned int creator_id,
-				struct ccw_driver *gdrv,
-				int argc, char *argv[]);
+extern int ccwgroup_create (struct device *root,
+			    unsigned int creator_id,
+			    struct ccw_driver *gdrv,
+			    int argc, char *argv[]);
 
 extern int ccwgroup_probe_ccwdev(struct ccw_device *cdev);
 extern int ccwgroup_remove_ccwdev(struct ccw_device *cdev);
diff -urN linux-2.5.51/include/asm-s390x/cio.h linux-2.5.51-s390/include/asm-s390x/cio.h
--- linux-2.5.51/include/asm-s390x/cio.h	Tue Dec 10 03:45:59 2002
+++ linux-2.5.51-s390/include/asm-s390x/cio.h	Thu Dec 12 18:03:11 2002
@@ -262,8 +262,6 @@
 
 extern int diag210(struct diag210 *addr);
 
-extern int chsc(void *data);
-
 extern void wait_cons_dev(void);
 
 #endif

