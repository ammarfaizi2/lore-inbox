Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261688AbSJUVVL>; Mon, 21 Oct 2002 17:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261690AbSJUVVL>; Mon, 21 Oct 2002 17:21:11 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:21929 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261688AbSJUVVH>; Mon, 21 Oct 2002 17:21:07 -0400
Date: Mon, 21 Oct 2002 14:28:27 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: Cliff White <cliffw@osdl.org>
Cc: linux-kernel@vger.kernel.org, Matt_Domsch@Dell.com
Subject: Re: 2.5.44 compile problem: MegaRAID driver
Message-ID: <20021021212827.GF1069@beaverton.ibm.com>
Mail-Followup-To: Cliff White <cliffw@osdl.org>,
	linux-kernel@vger.kernel.org, Matt_Domsch@Dell.com
References: <200210212031.g9LKVKl18741@mail.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210212031.g9LKVKl18741@mail.osdl.org>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cliff,
	
The scsi host interface change in 2.5.44. The megaraid driver wanted
direct access to this list to reorder it. This cannot be done anymore as
we try get list coherence under control.

I sent mail to linux-megaraid-devel@dell.com about this on Saturday. I
have cc'd Matt Domsch on this mail.

You may wish to wait a bit for a response from Matt before applying the
patch.

The patch below removes the reorder as I could not see why reorder the
list. It also replaces some other traverse loops with a direct access to
the host pointer copy.

I have only compile tested this change and do not have a megaraid card.

The maintainer of the driver will need to ok and comment on any side
effects. I will look at the driver some more to see if I understand the
reorder.

-andmike
--
Michael Anderson
andmike@us.ibm.com

 megaraid.c |  182 -------------------------------------------------------------
 megaraid.h |    2 
 2 files changed, 2 insertions(+), 182 deletions(-)
------

--- 1.22/drivers/scsi/megaraid.c	Tue Oct  8 11:40:48 2002
+++ edited/drivers/scsi/megaraid.c	Mon Oct 21 14:10:35 2002
@@ -3217,7 +3217,6 @@
 	count += mega_findCard (pHostTmpl, PCI_VENDOR_ID_AMI,
 				PCI_DEVICE_ID_AMI_MEGARAID3, BOARD_QUARTZ);
 
-	mega_reorder_hosts ();
 
 #ifdef CONFIG_PROC_FS
 	if (count) {
@@ -3483,173 +3482,6 @@
 }
 
 
-static void mega_reorder_hosts (void)
-{
-	struct Scsi_Host *shpnt;
-	struct Scsi_Host *shone;
-	struct Scsi_Host *shtwo;
-	mega_host_config *boot_host;
-	int i;
-
-	/*
-	 * Find the (first) host which has it's BIOS enabled
-	 */
-	boot_host = NULL;
-	for (i = 0; i < MAX_CONTROLLERS; i++) {
-		if (mega_hbas[i].is_bios_enabled) {
-			boot_host = mega_hbas[i].hostdata_addr;
-			break;
-		}
-	}
-
-	if (boot_host == NULL) {
-		printk (KERN_WARNING "megaraid: no BIOS enabled.\n");
-		return;
-	}
-
-	/*
-	 * Traverse through the list of SCSI hosts for our HBA locations
-	 */
-	shone = shtwo = NULL;
-	for (shpnt = scsi_hostlist; shpnt; shpnt = shpnt->next) {
-		/* Is it one of ours? */
-		for (i = 0; i < MAX_CONTROLLERS; i++) {
-			if ((mega_host_config *) shpnt->hostdata ==
-			    mega_hbas[i].hostdata_addr) {
-				/* Does this one has BIOS enabled */
-				if (mega_hbas[i].hostdata_addr == boot_host) {
-
-					/* Are we first */
-					if (shtwo == NULL)	/* Yes! */
-						return;
-					else {	/* :-( */
-						shone = shpnt;
-					}
-				} else {
-					if (!shtwo) {
-						/* were we here before? xchng first */
-						shtwo = shpnt;
-					}
-				}
-				break;
-			}
-		}
-		/*
-		 * Have we got the boot host and one which does not have the bios
-		 * enabled.
-		 */
-		if (shone && shtwo)
-			break;
-	}
-	if (shone && shtwo) {
-		mega_swap_hosts (shone, shtwo);
-	}
-
-	return;
-}
-
-static void mega_swap_hosts (struct Scsi_Host *shone, struct Scsi_Host *shtwo)
-{
-	struct Scsi_Host *prevtoshtwo;
-	struct Scsi_Host *prevtoshone;
-	struct Scsi_Host *save = NULL;;
-
-	/* Are these two nodes adjacent */
-	if (shtwo->next == shone) {
-
-		if (shtwo == scsi_hostlist && shone->next == NULL) {
-
-			/* just two nodes */
-			scsi_hostlist = shone;
-			shone->next = shtwo;
-			shtwo->next = NULL;
-		} else if (shtwo == scsi_hostlist) {
-			/* first two nodes of the list */
-
-			scsi_hostlist = shone;
-			shtwo->next = shone->next;
-			scsi_hostlist->next = shtwo;
-		} else if (shone->next == NULL) {
-			/* last two nodes of the list */
-
-			prevtoshtwo = scsi_hostlist;
-
-			while (prevtoshtwo->next != shtwo)
-				prevtoshtwo = prevtoshtwo->next;
-
-			prevtoshtwo->next = shone;
-			shone->next = shtwo;
-			shtwo->next = NULL;
-		} else {
-			prevtoshtwo = scsi_hostlist;
-
-			while (prevtoshtwo->next != shtwo)
-				prevtoshtwo = prevtoshtwo->next;
-
-			prevtoshtwo->next = shone;
-			shtwo->next = shone->next;
-			shone->next = shtwo;
-		}
-
-	} else if (shtwo == scsi_hostlist && shone->next == NULL) {
-		/* shtwo at head, shone at tail, not adjacent */
-
-		prevtoshone = scsi_hostlist;
-
-		while (prevtoshone->next != shone)
-			prevtoshone = prevtoshone->next;
-
-		scsi_hostlist = shone;
-		shone->next = shtwo->next;
-		prevtoshone->next = shtwo;
-		shtwo->next = NULL;
-	} else if (shtwo == scsi_hostlist && shone->next != NULL) {
-		/* shtwo at head, shone is not at tail */
-
-		prevtoshone = scsi_hostlist;
-		while (prevtoshone->next != shone)
-			prevtoshone = prevtoshone->next;
-
-		scsi_hostlist = shone;
-		prevtoshone->next = shtwo;
-		save = shtwo->next;
-		shtwo->next = shone->next;
-		shone->next = save;
-	} else if (shone->next == NULL) {
-		/* shtwo not at head, shone at tail */
-
-		prevtoshtwo = scsi_hostlist;
-		prevtoshone = scsi_hostlist;
-
-		while (prevtoshtwo->next != shtwo)
-			prevtoshtwo = prevtoshtwo->next;
-		while (prevtoshone->next != shone)
-			prevtoshone = prevtoshone->next;
-
-		prevtoshtwo->next = shone;
-		shone->next = shtwo->next;
-		prevtoshone->next = shtwo;
-		shtwo->next = NULL;
-
-	} else {
-		prevtoshtwo = scsi_hostlist;
-		prevtoshone = scsi_hostlist;
-		save = NULL;;
-
-		while (prevtoshtwo->next != shtwo)
-			prevtoshtwo = prevtoshtwo->next;
-		while (prevtoshone->next != shone)
-			prevtoshone = prevtoshone->next;
-
-		prevtoshtwo->next = shone;
-		save = shone->next;
-		shone->next = shtwo->next;
-		prevtoshone->next = shtwo;
-		shtwo->next = save;
-	}
-	return;
-}
-
 static inline void mega_freeSgList (mega_host_config * megaCfg)
 {
 	int i;
@@ -4684,12 +4516,7 @@
 		/*
 		 * Find this host
 		 */
-		for( shpnt = scsi_hostlist; shpnt; shpnt = shpnt->next ) {
-			if( shpnt->hostdata == (unsigned long *)megaCtlrs[adapno] ) {
-				megacfg = (mega_host_config *)shpnt->hostdata;
-				break;
-			}
-		}
+		shpnt = megaCtlrs[adapno]->host;
 		if(shpnt == NULL)  return -ENODEV;
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
@@ -4804,12 +4631,7 @@
 		/*
 		 * Find this host
 		 */
-		for( shpnt = scsi_hostlist; shpnt; shpnt = shpnt->next ) {
-			if( shpnt->hostdata == (unsigned long *)megaCtlrs[adapno] ) {
-				megacfg = (mega_host_config *)shpnt->hostdata;
-				break;
-			}
-		}
+		shpnt = megaCtlrs[adapno]->host;
 		if(shpnt == NULL)  return -ENODEV;
 
 		/*
--- 1.9/drivers/scsi/megaraid.h	Sun Jul 21 01:55:49 2002
+++ edited/drivers/scsi/megaraid.h	Mon Oct 21 13:58:19 2002
@@ -988,8 +988,6 @@
 			      int lock, int intr);
 
 static int mega_is_bios_enabled (mega_host_config *);
-static void mega_reorder_hosts (void);
-static void mega_swap_hosts (struct Scsi_Host *, struct Scsi_Host *);
 
 static void mega_create_proc_entry (int index, struct proc_dir_entry *);
 static int mega_support_ext_cdb(mega_host_config *);
