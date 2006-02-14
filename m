Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422676AbWBNT3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422676AbWBNT3M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 14:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422677AbWBNT3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 14:29:12 -0500
Received: from [81.2.110.250] ([81.2.110.250]:58861 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1422676AbWBNT3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 14:29:10 -0500
Subject: PATCH: rioboot (3 of 3)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 14 Feb 2006 19:32:11 +0000
Message-Id: <1139945531.11979.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After the indent we can now clean up unused code, and fix all
myriad cases that don't use readb/writeb properly.

Signed-off-by: Alan Cox <alan@redhat.com>

--- rioboot.c	2006-02-14 19:11:12.090078920 +0000
+++ ../../../../linux-2.6.15-mm2/drivers/char/rio/rioboot.c	2006-01-09 14:40:08.000000000 +0000
@@ -30,30 +30,27 @@
 ** -----------------------------------------------------------------------------
 */
 
-#ifdef SCCS_LABELS
-static char *_rioboot_c_sccs_ = "@(#)rioboot.c	1.3";
-#endif
-
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/termios.h>
+#include <linux/serial.h>
+#include <asm/semaphore.h>
+#include <linux/generic_serial.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
+#include <linux/delay.h>
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/string.h>
-#include <asm/semaphore.h>
+#include <asm/uaccess.h>
 
 
-#include <linux/termios.h>
-#include <linux/serial.h>
-
-#include <linux/generic_serial.h>
 
 
 
 #include "linux_compat.h"
 #include "rio_linux.h"
 #include "typdef.h"
 #include "pkt.h"
 #include "daemon.h"
 #include "rio.h"
@@ -80,9 +76,9 @@
 #include "cmdblk.h"
 #include "route.h"
 
-static int RIOBootComplete(struct rio_info *p, struct Host *HostP, uint Rup, struct PktCmd *PktCmdP);
+static int RIOBootComplete(struct rio_info *p, struct Host *HostP, unsigned int Rup, struct PktCmd *PktCmdP);
 
-static uchar RIOAtVec2Ctrl[] = {
+static const unsigned char RIOAtVec2Ctrl[] = {
 	/* 0 */ INTERRUPT_DISABLE,
 	/* 1 */ INTERRUPT_DISABLE,
 	/* 2 */ INTERRUPT_DISABLE,
@@ -101,22 +97,22 @@
 	/* 15 */ IRQ_15 | INTERRUPT_ENABLE
 };
 
-/*
-** Load in the RTA boot code.
-*/
-int RIOBootCodeRTA(p, rbp)
-struct rio_info *p;
-struct DownLoad *rbp;
+/**
+ *	RIOBootCodeRTA		-	Load RTA boot code
+ *	@p: RIO to load
+ *	@rbp: Download descriptor
+ *
+ *	Called when the user process initiates booting of the card firmware.
+ *	Lads the firmware
+ */
+
+int RIOBootCodeRTA(struct rio_info *p, struct DownLoad * rbp)
 {
 	int offset;
 
 	func_enter();
 
-	/* Linux doesn't allow you to disable interrupts during a
-	   "copyin". (Crash when a pagefault occurs). */
-	/* disable(oldspl); */
-
-	rio_dprintk(RIO_DEBUG_BOOT, "Data at user address 0x%x\n", (int) rbp->DataP);
+	rio_dprintk(RIO_DEBUG_BOOT, "Data at user address %p\n", rbp->DataP);
 
 	/*
 	 ** Check that we have set asside enough memory for this
@@ -124,7 +120,6 @@
 	if (rbp->Count > SIXTY_FOUR_K) {
 		rio_dprintk(RIO_DEBUG_BOOT, "RTA Boot Code Too Large!\n");
 		p->RIOError.Error = HOST_FILE_TOO_LARGE;
-		/* restore(oldspl); */
 		func_exit();
 		return -ENOMEM;
 	}
@@ -132,7 +127,6 @@
 	if (p->RIOBooting) {
 		rio_dprintk(RIO_DEBUG_BOOT, "RTA Boot Code : BUSY BUSY BUSY!\n");
 		p->RIOError.Error = BOOT_IN_PROGRESS;
-		/* restore(oldspl); */
 		func_exit();
 		return -EBUSY;
 	}
@@ -149,16 +143,15 @@
 	 ** because it will (eventually) be part of the Rta run time environment
 	 ** and so should be zeroed.
 	 */
-	bzero((caddr_t) p->RIOBootPackets, offset);
+	memset(p->RIOBootPackets, 0, offset);
 
 	/*
-	 ** Copy the data from user space.
+	 ** Copy the data from user space into the array
 	 */
 
-	if (copyin((int) rbp->DataP, ((caddr_t) (p->RIOBootPackets)) + offset, rbp->Count) == COPYFAIL) {
+	if (copy_from_user(((u8 *)p->RIOBootPackets) + offset, rbp->DataP, rbp->Count)) {
 		rio_dprintk(RIO_DEBUG_BOOT, "Bad data copy from user space\n");
 		p->RIOError.Error = COPYIN_FAILED;
-		/* restore(oldspl); */
 		func_exit();
 		return -EFAULT;
 	}
@@ -170,40 +163,25 @@
 	p->RIONumBootPkts = (rbp->Count + offset) / RTA_BOOT_DATA_SIZE;
 	p->RIOBootCount = rbp->Count;
 
-	/* restore(oldspl); */
 	func_exit();
 	return 0;
 }
 
+/**
+ *	rio_start_card_running		-	host card start
+ *	@HostP: The RIO to kick off
+ *
+ *	Start a RIO processor unit running. Encapsulates the knowledge
+ *	of the card type.
+ */
+
 void rio_start_card_running(struct Host *HostP)
 {
-	func_enter();
-
 	switch (HostP->Type) {
 	case RIO_AT:
 		rio_dprintk(RIO_DEBUG_BOOT, "Start ISA card running\n");
-		WBYTE(HostP->Control, BOOT_FROM_RAM | EXTERNAL_BUS_ON | HostP->Mode | RIOAtVec2Ctrl[HostP->Ivec & 0xF]);
+		writeb(BOOT_FROM_RAM | EXTERNAL_BUS_ON | HostP->Mode | RIOAtVec2Ctrl[HostP->Ivec & 0xF], &HostP->Control);
 		break;
-
-#ifdef FUTURE_RELEASE
-	case RIO_MCA:
-		/*
-		 ** MCA handles IRQ vectors differently, so we don't write 
-		 ** them to this register.
-		 */
-		rio_dprintk(RIO_DEBUG_BOOT, "Start MCA card running\n");
-		WBYTE(HostP->Control, McaTpBootFromRam | McaTpBusEnable | HostP->Mode);
-		break;
-
-	case RIO_EISA:
-		/*
-		 ** EISA is totally different and expects OUTBZs to turn it on.
-		 */
-		rio_dprintk(RIO_DEBUG_BOOT, "Start EISA card running\n");
-		OUTBZ(HostP->Slot, EISA_CONTROL_PORT, HostP->Mode | RIOEisaVec2Ctrl[HostP->Ivec] | EISA_TP_RUN | EISA_TP_BUS_ENABLE | EISA_TP_BOOT_FROM_RAM);
-		break;
-#endif
-
 	case RIO_PCI:
 		/*
 		 ** PCI is much the same as MCA. Everything is once again memory
@@ -211,16 +189,12 @@
 		 ** ports.
 		 */
 		rio_dprintk(RIO_DEBUG_BOOT, "Start PCI card running\n");
-		WBYTE(HostP->Control, PCITpBootFromRam | PCITpBusEnable | HostP->Mode);
+		writeb(PCITpBootFromRam | PCITpBusEnable | HostP->Mode, &HostP->Control);
 		break;
 	default:
 		rio_dprintk(RIO_DEBUG_BOOT, "Unknown host type %d\n", HostP->Type);
 		break;
 	}
-/* 
-	printk (KERN_INFO "Done with starting the card\n");
-	func_exit ();
-*/
 	return;
 }
 
@@ -231,40 +205,41 @@
 ** Put your rubber pants on before messing with this code - even the magic
 ** numbers have trouble understanding what they are doing here.
 */
-int RIOBootCodeHOST(p, rbp)
-struct rio_info *p;
-register struct DownLoad *rbp;
+
+int RIOBootCodeHOST(struct rio_info *p, struct DownLoad *rbp)
 {
-	register struct Host *HostP;
-	register caddr_t Cad;
-	register PARM_MAP *ParmMapP;
-	register int RupN;
+	struct Host *HostP;
+	u8 *Cad;
+	PARM_MAP *ParmMapP;
+	int RupN;
 	int PortN;
-	uint host;
-	caddr_t StartP;
-	BYTE *DestP;
+	unsigned int host;
+	u8 *StartP;
+	u8 *DestP;
 	int wait_count;
-	ushort OldParmMap;
-	ushort offset;		/* It is very important that this is a ushort */
-	/* uint byte; */
-	caddr_t DownCode = NULL;
+	u16 OldParmMap;
+	u16 offset;		/* It is very important that this is a u16 */
+	u8 *DownCode = NULL;
 	unsigned long flags;
 
 	HostP = NULL;		/* Assure the compiler we've initialized it */
+
+
+	/* Walk the hosts */
 	for (host = 0; host < p->RIONumHosts; host++) {
 		rio_dprintk(RIO_DEBUG_BOOT, "Attempt to boot host %d\n", host);
 		HostP = &p->RIOHosts[host];
 
 		rio_dprintk(RIO_DEBUG_BOOT, "Host Type = 0x%x, Mode = 0x%x, IVec = 0x%x\n", HostP->Type, HostP->Mode, HostP->Ivec);
 
-
+		/* Don't boot hosts already running */
 		if ((HostP->Flags & RUN_STATE) != RC_WAITING) {
 			rio_dprintk(RIO_DEBUG_BOOT, "%s %d already running\n", "Host", host);
 			continue;
 		}
 
 		/*
-		 ** Grab a 32 bit pointer to the card.
+		 ** Grab a pointer to the card (ioremapped)
 		 */
 		Cad = HostP->Caddr;
 
@@ -274,13 +249,14 @@
 		 ** Therefore, we need to start copying at address
 		 ** (caddr+p->RIOConf.HostLoadBase-rbp->Count)
 		 */
-		StartP = (caddr_t) & Cad[p->RIOConf.HostLoadBase - rbp->Count];
+		StartP = &Cad[p->RIOConf.HostLoadBase - rbp->Count];
 
-		rio_dprintk(RIO_DEBUG_BOOT, "kernel virtual address for host is 0x%x\n", (int) Cad);
-		rio_dprintk(RIO_DEBUG_BOOT, "kernel virtual address for download is 0x%x\n", (int) StartP);
+		rio_dprintk(RIO_DEBUG_BOOT, "kernel virtual address for host is %p\n", Cad);
+		rio_dprintk(RIO_DEBUG_BOOT, "kernel virtual address for download is %p\n", StartP);
 		rio_dprintk(RIO_DEBUG_BOOT, "host loadbase is 0x%x\n", p->RIOConf.HostLoadBase);
 		rio_dprintk(RIO_DEBUG_BOOT, "size of download is 0x%x\n", rbp->Count);
 
+		/* Make sure it fits */
 		if (p->RIOConf.HostLoadBase < rbp->Count) {
 			rio_dprintk(RIO_DEBUG_BOOT, "Bin too large\n");
 			p->RIOError.Error = HOST_FILE_TOO_LARGE;
@@ -300,39 +276,23 @@
 		 */
 		rio_dprintk(RIO_DEBUG_BOOT, "Copy in code\n");
 
-		/*
-		 ** PCI hostcard can't cope with 32 bit accesses and so need to copy 
-		 ** data to a local buffer, and then dripfeed the card.
-		 */
-		if (HostP->Type == RIO_PCI) {
-			/* int offset; */
-
-			DownCode = sysbrk(rbp->Count);
-			if (!DownCode) {
-				rio_dprintk(RIO_DEBUG_BOOT, "No system memory available\n");
-				p->RIOError.Error = NOT_ENOUGH_CORE_FOR_PCI_COPY;
-				func_exit();
-				return -ENOMEM;
-			}
-			bzero(DownCode, rbp->Count);
-
-			if (copyin((int) rbp->DataP, DownCode, rbp->Count) == COPYFAIL) {
-				rio_dprintk(RIO_DEBUG_BOOT, "Bad copyin of host data\n");
-				sysfree(DownCode, rbp->Count);
-				p->RIOError.Error = COPYIN_FAILED;
-				func_exit();
-				return -EFAULT;
-			}
-
-			HostP->Copy(DownCode, StartP, rbp->Count);
-
-			sysfree(DownCode, rbp->Count);
-		} else if (copyin((int) rbp->DataP, StartP, rbp->Count) == COPYFAIL) {
-			rio_dprintk(RIO_DEBUG_BOOT, "Bad copyin of host data\n");
+		/* Buffer to local memory as we want to use I/O space and
+		   some cards only do 8 or 16 bit I/O */
+		   
+		DownCode = vmalloc(rbp->Count);
+		if (!DownCode) {
+			p->RIOError.Error = NOT_ENOUGH_CORE_FOR_PCI_COPY;
+			func_exit();
+			return -ENOMEM;
+		}
+		if (copy_from_user(rbp->DataP, DownCode, rbp->Count)) {
+			kfree(DownCode);
 			p->RIOError.Error = COPYIN_FAILED;
 			func_exit();
 			return -EFAULT;
 		}
+		HostP->Copy(DownCode, StartP, rbp->Count);
+		vfree(DownCode);
 
 		rio_dprintk(RIO_DEBUG_BOOT, "Copy completed\n");
 
@@ -411,7 +371,7 @@
 		 ** a short branch to 0x7FF8, where a long branch is coded.
 		 */
 
-		DestP = (BYTE *) & Cad[0x7FF8];	/* <<<---- READ THE ABOVE COMMENTS */
+		DestP = (u8 *) &Cad[0x7FF8];	/* <<<---- READ THE ABOVE COMMENTS */
 
 #define	NFIX(N)	(0x60 | (N))	/* .O  = (~(.O + N))<<4 */
 #define	PFIX(N)	(0x20 | (N))	/* .O  =   (.O + N)<<4  */
@@ -427,13 +387,14 @@
 		 ** cos I don't understand 2's complement).
 		 */
 		offset = (p->RIOConf.HostLoadBase - 2) - 0x7FFC;
-		WBYTE(DestP[0], NFIX(((ushort) (~offset) >> (ushort) 12) & 0xF));
-		WBYTE(DestP[1], PFIX((offset >> 8) & 0xF));
-		WBYTE(DestP[2], PFIX((offset >> 4) & 0xF));
-		WBYTE(DestP[3], JUMP(offset & 0xF));
 
-		WBYTE(DestP[6], NFIX(0));
-		WBYTE(DestP[7], JUMP(8));
+		writeb(NFIX(((ushort) (~offset) >> (ushort) 12) & 0xF), DestP);
+		writeb(PFIX((offset >> 8) & 0xF), DestP + 1);
+		writeb(PFIX((offset >> 4) & 0xF), DestP + 2);
+		writeb(JUMP(offset & 0xF), DestP + 3);
+
+		writeb(NFIX(0), DestP + 6);
+		writeb(JUMP(8), DestP + 7);
 
 		rio_dprintk(RIO_DEBUG_BOOT, "host loadbase is 0x%x\n", p->RIOConf.HostLoadBase);
 		rio_dprintk(RIO_DEBUG_BOOT, "startup offset is 0x%x\n", offset);
@@ -448,7 +409,7 @@
 		 ** Grab a copy of the current ParmMap pointer, so we
 		 ** can tell when it has changed.
 		 */
-		OldParmMap = RWORD(HostP->__ParmMapR);
+		OldParmMap = readw(&HostP->__ParmMapR);
 
 		rio_dprintk(RIO_DEBUG_BOOT, "Original parmmap is 0x%x\n", OldParmMap);
 
@@ -467,9 +428,9 @@
 		 ** Now, wait for upto five seconds for the Tp to setup the parmmap
 		 ** pointer:
 		 */
-		for (wait_count = 0; (wait_count < p->RIOConf.StartupTime) && (RWORD(HostP->__ParmMapR) == OldParmMap); wait_count++) {
-			rio_dprintk(RIO_DEBUG_BOOT, "Checkout %d, 0x%x\n", wait_count, RWORD(HostP->__ParmMapR));
-			delay(HostP, HUNDRED_MS);
+		for (wait_count = 0; (wait_count < p->RIOConf.StartupTime) && (readw(&HostP->__ParmMapR) == OldParmMap); wait_count++) {
+			rio_dprintk(RIO_DEBUG_BOOT, "Checkout %d, 0x%x\n", wait_count, readw(&HostP->__ParmMapR));
+			mdelay(100);
 
 		}
 
@@ -477,15 +438,16 @@
 		 ** If the parmmap pointer is unchanged, then the host code
 		 ** has crashed & burned in a really spectacular way
 		 */
-		if (RWORD(HostP->__ParmMapR) == OldParmMap) {
-			rio_dprintk(RIO_DEBUG_BOOT, "parmmap 0x%x\n", RWORD(HostP->__ParmMapR));
+		if (readw(&HostP->__ParmMapR) == OldParmMap) {
+			rio_dprintk(RIO_DEBUG_BOOT, "parmmap 0x%x\n", readw(&HostP->__ParmMapR));
 			rio_dprintk(RIO_DEBUG_BOOT, "RIO Mesg Run Fail\n");
 			HostP->Flags &= ~RUN_STATE;
 			HostP->Flags |= RC_STUFFED;
-			RIOHostReset(HostP->Type, (struct DpRam *) HostP->CardP, HostP->Slot);
-		continue}
+			RIOHostReset( HostP->Type, (struct DpRam *)HostP->CardP, HostP->Slot );
+			continue;
+		}
 
-		rio_dprintk(RIO_DEBUG_BOOT, "Running 0x%x\n", RWORD(HostP->__ParmMapR));
+		rio_dprintk(RIO_DEBUG_BOOT, "Running 0x%x\n", readw(&HostP->__ParmMapR));
 
 		/*
 		 ** Well, the board thought it was OK, and setup its parmmap
@@ -496,25 +458,26 @@
 		/*
 		 ** Grab a 32 bit pointer to the parmmap structure
 		 */
-		ParmMapP = (PARM_MAP *) RIO_PTR(Cad, RWORD(HostP->__ParmMapR));
-		rio_dprintk(RIO_DEBUG_BOOT, "ParmMapP : %x\n", (int) ParmMapP);
-		ParmMapP = (PARM_MAP *) ((unsigned long) Cad + (unsigned long) ((RWORD((HostP->__ParmMapR))) & 0xFFFF));
-		rio_dprintk(RIO_DEBUG_BOOT, "ParmMapP : %x\n", (int) ParmMapP);
+		ParmMapP = (PARM_MAP *) RIO_PTR(Cad, readw(&HostP->__ParmMapR));
+		rio_dprintk(RIO_DEBUG_BOOT, "ParmMapP : %p\n", ParmMapP);
+		ParmMapP = (PARM_MAP *) ((unsigned long) Cad + readw(&HostP->__ParmMapR));
+		rio_dprintk(RIO_DEBUG_BOOT, "ParmMapP : %p\n", ParmMapP);
 
 		/*
 		 ** The links entry should be 0xFFFF; we set it up
 		 ** with a mask to say how many PHBs to use, and 
 		 ** which links to use.
 		 */
-		if ((RWORD(ParmMapP->links) & 0xFFFF) != 0xFFFF) {
+		if (readw(&ParmMapP->links) != 0xFFFF) {
 			rio_dprintk(RIO_DEBUG_BOOT, "RIO Mesg Run Fail %s\n", HostP->Name);
-			rio_dprintk(RIO_DEBUG_BOOT, "Links = 0x%x\n", RWORD(ParmMapP->links));
+			rio_dprintk(RIO_DEBUG_BOOT, "Links = 0x%x\n", readw(&ParmMapP->links));
 			HostP->Flags &= ~RUN_STATE;
 			HostP->Flags |= RC_STUFFED;
-			RIOHostReset(HostP->Type, (struct DpRam *) HostP->CardP, HostP->Slot);
-		continue}
+			RIOHostReset( HostP->Type, (struct DpRam *)HostP->CardP, HostP->Slot );
+			continue;
+		}
 
-		WWORD(ParmMapP->links, RIO_LINK_ENABLE);
+		writew(RIO_LINK_ENABLE, &ParmMapP->links);
 
 		/*
 		 ** now wait for the card to set all the parmmap->XXX stuff
@@ -522,19 +485,20 @@
 		 */
 		rio_dprintk(RIO_DEBUG_BOOT, "Looking for init_done - %d ticks\n", p->RIOConf.StartupTime);
 		HostP->timeout_id = 0;
-		for (wait_count = 0; (wait_count < p->RIOConf.StartupTime) && !RWORD(ParmMapP->init_done); wait_count++) {
+		for (wait_count = 0; (wait_count < p->RIOConf.StartupTime) && !readw(&ParmMapP->init_done); wait_count++) {
 			rio_dprintk(RIO_DEBUG_BOOT, "Waiting for init_done\n");
-			delay(HostP, HUNDRED_MS);
+			mdelay(100);
 		}
 		rio_dprintk(RIO_DEBUG_BOOT, "OK! init_done!\n");
 
-		if (RWORD(ParmMapP->error) != E_NO_ERROR || !RWORD(ParmMapP->init_done)) {
+		if (readw(&ParmMapP->error) != E_NO_ERROR || !readw(&ParmMapP->init_done)) {
 			rio_dprintk(RIO_DEBUG_BOOT, "RIO Mesg Run Fail %s\n", HostP->Name);
 			rio_dprintk(RIO_DEBUG_BOOT, "Timedout waiting for init_done\n");
 			HostP->Flags &= ~RUN_STATE;
 			HostP->Flags |= RC_STUFFED;
-			RIOHostReset(HostP->Type, (struct DpRam *) HostP->CardP, HostP->Slot);
-		continue}
+			RIOHostReset( HostP->Type, (struct DpRam *)HostP->CardP, HostP->Slot );
+			continue;
+		}
 
 		rio_dprintk(RIO_DEBUG_BOOT, "Got init_done\n");
 
@@ -546,17 +510,17 @@
 		/*
 		 ** set the time period between interrupts.
 		 */
-		WWORD(ParmMapP->timer, (short) p->RIOConf.Timer);
+		writew(p->RIOConf.Timer, &ParmMapP->timer);
 
 		/*
 		 ** Translate all the 16 bit pointers in the __ParmMapR into
-		 ** 32 bit pointers for the driver.
+		 ** 32 bit pointers for the driver in ioremap space.
 		 */
 		HostP->ParmMapP = ParmMapP;
-		HostP->PhbP = (PHB *) RIO_PTR(Cad, RWORD(ParmMapP->phb_ptr));
-		HostP->RupP = (RUP *) RIO_PTR(Cad, RWORD(ParmMapP->rups));
-		HostP->PhbNumP = (ushort *) RIO_PTR(Cad, RWORD(ParmMapP->phb_num_ptr));
-		HostP->LinkStrP = (LPB *) RIO_PTR(Cad, RWORD(ParmMapP->link_str_ptr));
+		HostP->PhbP = (PHB *) RIO_PTR(Cad, readw(&ParmMapP->phb_ptr));
+		HostP->RupP = (RUP *) RIO_PTR(Cad, readw(&ParmMapP->rups));
+		HostP->PhbNumP = (ushort *) RIO_PTR(Cad, readw(&ParmMapP->phb_num_ptr));
+		HostP->LinkStrP = (LPB *) RIO_PTR(Cad, readw(&ParmMapP->link_str_ptr));
 
 		/*
 		 ** point the UnixRups at the real Rups
@@ -592,12 +556,12 @@
 
 				PortP->PhbP = PhbP;
 
-				PortP->TxAdd = (WORD *) RIO_PTR(Cad, RWORD(PhbP->tx_add));
-				PortP->TxStart = (WORD *) RIO_PTR(Cad, RWORD(PhbP->tx_start));
-				PortP->TxEnd = (WORD *) RIO_PTR(Cad, RWORD(PhbP->tx_end));
-				PortP->RxRemove = (WORD *) RIO_PTR(Cad, RWORD(PhbP->rx_remove));
-				PortP->RxStart = (WORD *) RIO_PTR(Cad, RWORD(PhbP->rx_start));
-				PortP->RxEnd = (WORD *) RIO_PTR(Cad, RWORD(PhbP->rx_end));
+				PortP->TxAdd = (u16 *) RIO_PTR(Cad, readw(&PhbP->tx_add));
+				PortP->TxStart = (u16 *) RIO_PTR(Cad, readw(&PhbP->tx_start));
+				PortP->TxEnd = (u16 *) RIO_PTR(Cad, readw(&PhbP->tx_end));
+				PortP->RxRemove = (u16 *) RIO_PTR(Cad, readw(&PhbP->rx_remove));
+				PortP->RxStart = (u16 *) RIO_PTR(Cad, readw(&PhbP->rx_start));
+				PortP->RxEnd = (u16 *) RIO_PTR(Cad, readw(&PhbP->rx_end));
 
 				rio_spin_unlock_irqrestore(&PortP->portSem, flags);
 				/*
@@ -631,20 +595,23 @@
 
 
 
-/*
-** Boot an RTA. If we have successfully processed this boot, then
-** return 1. If we havent, then return 0.
-*/
-int RIOBootRup(p, Rup, HostP, PacketP)
-struct rio_info *p;
-uint Rup;
-struct Host *HostP;
-struct PKT *PacketP;
+/**
+ *	RIOBootRup		-	Boot an RTA
+ *	@p: rio we are working with
+ *	@Rup: Rup number
+ *	@HostP: host object
+ *	@PacketP: packet to use
+ *
+ *	If we have successfully processed this boot, then
+ *	return 1. If we havent, then return 0.
+ */
+ 
+int RIOBootRup(struct rio_info *p, unsigned int Rup, struct Host *HostP, struct PKT *PacketP)
 {
 	struct PktCmd *PktCmdP = (struct PktCmd *) PacketP->data;
 	struct PktCmd_M *PktReplyP;
 	struct CmdBlk *CmdBlkP;
-	uint sequence;
+	unsigned int sequence;
 
 	/*
 	 ** If we haven't been told what to boot, we can't boot it.
@@ -654,20 +621,17 @@
 		return 0;
 	}
 
-	/* rio_dprint(RIO_DEBUG_BOOT, NULL,DBG_BOOT,"Incoming command packet\n"); */
-	/* ShowPacket( DBG_BOOT, PacketP ); */
-
 	/*
 	 ** Special case of boot completed - if we get one of these then we
 	 ** don't need a command block. For all other cases we do, so handle
 	 ** this first and then get a command block, then handle every other
 	 ** case, relinquishing the command block if disaster strikes!
 	 */
-	if ((RBYTE(PacketP->len) & PKT_CMD_BIT) && (RBYTE(PktCmdP->Command) == BOOT_COMPLETED))
+	if ((readb(&PacketP->len) & PKT_CMD_BIT) && (readb(&PktCmdP->Command) == BOOT_COMPLETED))
 		return RIOBootComplete(p, HostP, Rup, PktCmdP);
 
 	/*
-	 ** try to unhook a command block from the command free list.
+	 ** Try to allocate a command block. This is in kernel space
 	 */
 	if (!(CmdBlkP = RIOGetCmdBlk())) {
 		rio_dprintk(RIO_DEBUG_BOOT, "No command blocks to boot RTA! come back later.\n");
@@ -688,13 +652,12 @@
 	/*
 	 ** process COMMANDS on the boot rup!
 	 */
-	if (RBYTE(PacketP->len) & PKT_CMD_BIT) {
+	if (readb(&PacketP->len) & PKT_CMD_BIT) {
 		/*
 		 ** We only expect one type of command - a BOOT_REQUEST!
 		 */
-		if (RBYTE(PktCmdP->Command) != BOOT_REQUEST) {
-			rio_dprintk(RIO_DEBUG_BOOT, "Unexpected command %d on BOOT RUP %d of host %d\n", PktCmdP->Command, Rup, HostP - p->RIOHosts);
-			ShowPacket(DBG_BOOT, PacketP);
+		if (readb(&PktCmdP->Command) != BOOT_REQUEST) {
+			rio_dprintk(RIO_DEBUG_BOOT, "Unexpected command %d on BOOT RUP %d of host %Zd\n", readb(&PktCmdP->Command), Rup, HostP - p->RIOHosts);
 			RIOFreeCmdBlk(CmdBlkP);
 			return 1;
 		}
@@ -702,20 +665,9 @@
 		/*
 		 ** Build a Boot Sequence command block
 		 **
-		 ** 02.03.1999 ARG - ESIL 0820 fix
 		 ** We no longer need to use "Boot Mode", we'll always allow
 		 ** boot requests - the boot will not complete if the device
 		 ** appears in the bindings table.
-		 ** So, this conditional is not required ...
-		 **
-		 if (p->RIOBootMode == RC_BOOT_NONE)
-		 **
-		 ** If the system is in slave mode, and a boot request is
-		 ** received, set command to BOOT_ABORT so that the boot
-		 ** will not complete.
-		 **
-		 PktReplyP->Command                      = BOOT_ABORT;
-		 else
 		 **
 		 ** We'll just (always) set the command field in packet reply
 		 ** to allow an attempted boot sequence :
@@ -728,9 +680,9 @@
 
 		CmdBlkP->Packet.len = BOOT_SEQUENCE_LEN | PKT_CMD_BIT;
 
-		bcopy("BOOT", (void *) &CmdBlkP->Packet.data[BOOT_SEQUENCE_LEN], 4);
+		memcpy((void *) &CmdBlkP->Packet.data[BOOT_SEQUENCE_LEN], "BOOT", 4);
 
-		rio_dprintk(RIO_DEBUG_BOOT, "Boot RTA on Host %d Rup %d - %d (0x%x) packets to 0x%x\n", HostP - p->RIOHosts, Rup, p->RIONumBootPkts, p->RIONumBootPkts, p->RIOConf.RtaLoadBase);
+		rio_dprintk(RIO_DEBUG_BOOT, "Boot RTA on Host %Zd Rup %d - %d (0x%x) packets to 0x%x\n", HostP - p->RIOHosts, Rup, p->RIONumBootPkts, p->RIONumBootPkts, p->RIOConf.RtaLoadBase);
 
 		/*
 		 ** If this host is in slave mode, send the RTA an invalid boot
@@ -747,32 +699,35 @@
 	/*
 	 ** It is a request for boot data.
 	 */
-	sequence = RWORD(PktCmdP->Sequence);
+	sequence = readw(&PktCmdP->Sequence);
 
-	rio_dprintk(RIO_DEBUG_BOOT, "Boot block %d on Host %d Rup%d\n", sequence, HostP - p->RIOHosts, Rup);
+	rio_dprintk(RIO_DEBUG_BOOT, "Boot block %d on Host %Zd Rup%d\n", sequence, HostP - p->RIOHosts, Rup);
 
 	if (sequence >= p->RIONumBootPkts) {
 		rio_dprintk(RIO_DEBUG_BOOT, "Got a request for packet %d, max is %d\n", sequence, p->RIONumBootPkts);
-		ShowPacket(DBG_BOOT, PacketP);
 	}
 
 	PktReplyP->Sequence = sequence;
-
-	bcopy(p->RIOBootPackets[p->RIONumBootPkts - sequence - 1], PktReplyP->BootData, RTA_BOOT_DATA_SIZE);
-
+	memcpy(PktReplyP->BootData, p->RIOBootPackets[p->RIONumBootPkts - sequence - 1], RTA_BOOT_DATA_SIZE);
 	CmdBlkP->Packet.len = PKT_MAX_DATA_LEN;
-	ShowPacket(DBG_BOOT, &CmdBlkP->Packet);
 	RIOQueueCmdBlk(HostP, Rup, CmdBlkP);
 	return 1;
 }
 
-/*
-** This function is called when an RTA been booted.
-** If booted by a host, HostP->HostUniqueNum is the booting host.
-** If booted by an RTA, HostP->Mapping[Rup].RtaUniqueNum is the booting RTA.
-** RtaUniq is the booted RTA.
-*/
-static int RIOBootComplete(struct rio_info *p, struct Host *HostP, uint Rup, struct PktCmd *PktCmdP)
+/**
+ *	RIOBootComplete		-	RTA boot is done
+ *	@p: RIO we are working with
+ *	@HostP: Host structure
+ *	@Rup: RUP being used
+ *	@PktCmdP: Packet command that was used
+ *
+ *	This function is called when an RTA been booted.
+ *	If booted by a host, HostP->HostUniqueNum is the booting host.
+ *	If booted by an RTA, HostP->Mapping[Rup].RtaUniqueNum is the booting RTA.
+ *	RtaUniq is the booted RTA.
+ */
+
+static int RIOBootComplete(struct rio_info *p, struct Host *HostP, unsigned int Rup, struct PktCmd *PktCmdP)
 {
 	struct Map *MapP = NULL;
 	struct Map *MapP2 = NULL;
@@ -782,12 +737,10 @@
 	int EmptySlot = -1;
 	int entry, entry2;
 	char *MyType, *MyName;
-	uint MyLink;
-	ushort RtaType;
-	uint RtaUniq = (RBYTE(PktCmdP->UniqNum[0])) + (RBYTE(PktCmdP->UniqNum[1]) << 8) + (RBYTE(PktCmdP->UniqNum[2]) << 16) + (RBYTE(PktCmdP->UniqNum[3]) << 24);
+	unsigned int MyLink;
+	unsigned short RtaType;
+	u32 RtaUniq = (readb(&PktCmdP->UniqNum[0])) + (readb(&PktCmdP->UniqNum[1]) << 8) + (readb(&PktCmdP->UniqNum[2]) << 16) + (readb(&PktCmdP->UniqNum[3]) << 24);
 
-	/* Was RIOBooting-- . That's bad. If an RTA sends two of them, the
-	   driver will never think that the RTA has booted... -- REW */
 	p->RIOBooting = 0;
 
 	rio_dprintk(RIO_DEBUG_BOOT, "RTA Boot completed - BootInProgress now %d\n", p->RIOBooting);
@@ -795,16 +748,16 @@
 	/*
 	 ** Determine type of unit (16/8 port RTA).
 	 */
+
 	RtaType = GetUnitType(RtaUniq);
-	if (Rup >= (ushort) MAX_RUP) {
-		rio_dprintk(RIO_DEBUG_BOOT, "RIO: Host %s has booted an RTA(%d) on link %c\n", HostP->Name, 8 * RtaType, RBYTE(PktCmdP->LinkNum) + 'A');
-	} else {
-		rio_dprintk(RIO_DEBUG_BOOT, "RIO: RTA %s has booted an RTA(%d) on link %c\n", HostP->Mapping[Rup].Name, 8 * RtaType, RBYTE(PktCmdP->LinkNum) + 'A');
-	}
+	if (Rup >= (ushort) MAX_RUP)
+		rio_dprintk(RIO_DEBUG_BOOT, "RIO: Host %s has booted an RTA(%d) on link %c\n", HostP->Name, 8 * RtaType, readb(&PktCmdP->LinkNum) + 'A');
+	else
+		rio_dprintk(RIO_DEBUG_BOOT, "RIO: RTA %s has booted an RTA(%d) on link %c\n", HostP->Mapping[Rup].Name, 8 * RtaType, readb(&PktCmdP->LinkNum) + 'A');
 
 	rio_dprintk(RIO_DEBUG_BOOT, "UniqNum is 0x%x\n", RtaUniq);
 
-	if ((RtaUniq == 0x00000000) || (RtaUniq == 0xffffffff)) {
+	if (RtaUniq == 0x00000000 || RtaUniq == 0xffffffff) {
 		rio_dprintk(RIO_DEBUG_BOOT, "Illegal RTA Uniq Number\n");
 		return TRUE;
 	}
@@ -814,9 +767,10 @@
 	 ** system, or the system is in slave mode, do not attempt to create
 	 ** a new table entry for it.
 	 */
+
 	if (!RIOBootOk(p, HostP, RtaUniq)) {
-		MyLink = RBYTE(PktCmdP->LinkNum);
-		if (Rup < (ushort) MAX_RUP) {
+		MyLink = readb(&PktCmdP->LinkNum);
+		if (Rup < (unsigned short) MAX_RUP) {
 			/*
 			 ** RtaUniq was clone booted (by this RTA). Instruct this RTA
 			 ** to hold off further attempts to boot on this link for 30
@@ -825,14 +779,13 @@
 			if (RIOSuspendBootRta(HostP, HostP->Mapping[Rup].ID, MyLink)) {
 				rio_dprintk(RIO_DEBUG_BOOT, "RTA failed to suspend booting on link %c\n", 'A' + MyLink);
 			}
-		} else {
+		} else
 			/*
 			 ** RtaUniq was booted by this host. Set the booting link
 			 ** to hold off for 30 seconds to give another unit a
 			 ** chance to boot it.
 			 */
-			WWORD(HostP->LinkStrP[MyLink].WaitNoBoot, 30);
-		}
+			writew(30, &HostP->LinkStrP[MyLink].WaitNoBoot);
 		rio_dprintk(RIO_DEBUG_BOOT, "RTA %x not owned - suspend booting down link %c on unit %x\n", RtaUniq, 'A' + MyLink, HostP->Mapping[Rup].RtaUniqueNum);
 		return TRUE;
 	}
@@ -849,13 +802,10 @@
 	 ** unit.
 	 */
 	for (entry = 0; entry < MAX_RUP; entry++) {
-		uint sysport;
+		unsigned int sysport;
 
 		if ((HostP->Mapping[entry].Flags & SLOT_IN_USE) && (HostP->Mapping[entry].RtaUniqueNum == RtaUniq)) {
 			HostP->Mapping[entry].Flags |= RTA_BOOTED | RTA_NEWBOOT;
-#ifdef NEED_TO_FIX
-			RIO_SV_BROADCAST(HostP->svFlags[entry]);
-#endif
 			if ((sysport = HostP->Mapping[entry].SysPort) != NO_PORT) {
 				if (sysport < p->RIOFirstPortsBooted)
 					p->RIOFirstPortsBooted = sysport;
@@ -867,9 +817,6 @@
 				if (RtaType == TYPE_RTA16) {
 					entry2 = HostP->Mapping[entry].ID2 - 1;
 					HostP->Mapping[entry2].Flags |= RTA_BOOTED | RTA_NEWBOOT;
-#ifdef NEED_TO_FIX
-					RIO_SV_BROADCAST(HostP->svFlags[entry2]);
-#endif
 					sysport = HostP->Mapping[entry2].SysPort;
 					if (sysport < p->RIOFirstPortsBooted)
 						p->RIOFirstPortsBooted = sysport;
@@ -877,18 +824,17 @@
 						p->RIOLastPortsBooted = sysport;
 				}
 			}
-			if (RtaType == TYPE_RTA16) {
+			if (RtaType == TYPE_RTA16)
 				rio_dprintk(RIO_DEBUG_BOOT, "RTA will be given IDs %d+%d\n", entry + 1, entry2 + 1);
-			} else {
+			else
 				rio_dprintk(RIO_DEBUG_BOOT, "RTA will be given ID %d\n", entry + 1);
-			}
 			return TRUE;
 		}
 	}
 
 	rio_dprintk(RIO_DEBUG_BOOT, "RTA not configured for this host\n");
 
-	if (Rup >= (ushort) MAX_RUP) {
+	if (Rup >= (unsigned short) MAX_RUP) {
 		/*
 		 ** It was a host that did the booting
 		 */
@@ -901,7 +847,7 @@
 		MyType = "RTA";
 		MyName = HostP->Mapping[Rup].Name;
 	}
-	MyLink = RBYTE(PktCmdP->LinkNum);
+	MyLink = readb(&PktCmdP->LinkNum);
 
 	/*
 	 ** There is no SLOT_IN_USE entry for this RTA attached to the current
@@ -923,7 +869,7 @@
 			} else
 				rio_dprintk(RIO_DEBUG_BOOT, "Found previous tentative slot (%d)\n", entry);
 			if (!p->RIONoMessage)
-				cprintf("RTA connected to %s '%s' (%c) not configured.\n", MyType, MyName, MyLink + 'A');
+				printk("RTA connected to %s '%s' (%c) not configured.\n", MyType, MyName, MyLink + 'A');
 			return TRUE;
 		}
 	}
@@ -1044,11 +990,8 @@
 			if (Flag & SLOT_IN_USE) {
 				rio_dprintk(RIO_DEBUG_BOOT, "This RTA configured on another host - move entry to current host (1)\n");
 				HostP->Mapping[entry].SysPort = MapP->SysPort;
-				CCOPY(MapP->Name, HostP->Mapping[entry].Name, MAX_NAME_LEN);
+				memcpy(HostP->Mapping[entry].Name, MapP->Name, MAX_NAME_LEN);
 				HostP->Mapping[entry].Flags = SLOT_IN_USE | RTA_BOOTED | RTA_NEWBOOT;
-#ifdef NEED_TO_FIX
-				RIO_SV_BROADCAST(HostP->svFlags[entry]);
-#endif
 				RIOReMapPorts(p, HostP, &HostP->Mapping[entry]);
 				if (HostP->Mapping[entry].SysPort < p->RIOFirstPortsBooted)
 					p->RIOFirstPortsBooted = HostP->Mapping[entry].SysPort;
@@ -1058,16 +1001,10 @@
 			} else {
 				rio_dprintk(RIO_DEBUG_BOOT, "This RTA has a tentative entry on another host - delete that entry (1)\n");
 				HostP->Mapping[entry].Flags = SLOT_TENTATIVE | RTA_BOOTED | RTA_NEWBOOT;
-#ifdef NEED_TO_FIX
-				RIO_SV_BROADCAST(HostP->svFlags[entry]);
-#endif
 			}
 			if (RtaType == TYPE_RTA16) {
 				if (Flag & SLOT_IN_USE) {
 					HostP->Mapping[entry2].Flags = SLOT_IN_USE | RTA_BOOTED | RTA_NEWBOOT | RTA16_SECOND_SLOT;
-#ifdef NEED_TO_FIX
-					RIO_SV_BROADCAST(HostP->svFlags[entry2]);
-#endif
 					HostP->Mapping[entry2].SysPort = MapP2->SysPort;
 					/*
 					 ** Map second block of ttys for 16 port RTA
@@ -1080,16 +1017,13 @@
 					rio_dprintk(RIO_DEBUG_BOOT, "SysPort %d, Name %s\n", (int) HostP->Mapping[entry2].SysPort, HostP->Mapping[entry].Name);
 				} else
 					HostP->Mapping[entry2].Flags = SLOT_TENTATIVE | RTA_BOOTED | RTA_NEWBOOT | RTA16_SECOND_SLOT;
-#ifdef NEED_TO_FIX
-				RIO_SV_BROADCAST(HostP->svFlags[entry2]);
-#endif
-				bzero((caddr_t) MapP2, sizeof(struct Map));
+				memset(MapP2, 0, sizeof(struct Map));
 			}
-			bzero((caddr_t) MapP, sizeof(struct Map));
+			memset(MapP, 0, sizeof(struct Map));
 			if (!p->RIONoMessage)
-				cprintf("An orphaned RTA has been adopted by %s '%s' (%c).\n", MyType, MyName, MyLink + 'A');
+				printk("An orphaned RTA has been adopted by %s '%s' (%c).\n", MyType, MyName, MyLink + 'A');
 		} else if (!p->RIONoMessage)
-			cprintf("RTA connected to %s '%s' (%c) not configured.\n", MyType, MyName, MyLink + 'A');
+			printk("RTA connected to %s '%s' (%c) not configured.\n", MyType, MyName, MyLink + 'A');
 		RIOSetChange(p);
 		return TRUE;
 	}
@@ -1100,7 +1034,7 @@
 	 ** so we can ignore it's ID requests.
 	 */
 	if (!p->RIONoMessage)
-		cprintf("The RTA connected to %s '%s' (%c) cannot be configured.  You cannot configure more than 128 ports to one host card.\n", MyType, MyName, MyLink + 'A');
+		printk("The RTA connected to %s '%s' (%c) cannot be configured.  You cannot configure more than 128 ports to one host card.\n", MyType, MyName, MyLink + 'A');
 	for (entry = 0; entry < HostP->NumExtraBooted; entry++) {
 		if (HostP->ExtraUnits[entry] == RtaUniq) {
 			/*
@@ -1127,13 +1061,10 @@
 ** We no longer support the RIOBootMode variable. It is all done from the
 ** "boot/noboot" field in the rio.cf file.
 */
-int RIOBootOk(p, HostP, RtaUniq)
-struct rio_info *p;
-struct Host *HostP;
-ulong RtaUniq;
+int RIOBootOk(struct rio_info *p, struct Host *HostP, unsigned long RtaUniq)
 {
 	int Entry;
-	uint HostUniq = HostP->UniqueNum;
+	unsigned int HostUniq = HostP->UniqueNum;
 
 	/*
 	 ** Search bindings table for RTA or its parent.
@@ -1151,11 +1082,7 @@
 ** slots tentative, and the second one RTA_SECOND_SLOT as well.
 */
 
-void FillSlot(entry, entry2, RtaUniq, HostP)
-int entry;
-int entry2;
-uint RtaUniq;
-struct Host *HostP;
+void FillSlot(int entry, int entry2, unsigned int RtaUniq, struct Host *HostP)
 {
 	int link;
 

