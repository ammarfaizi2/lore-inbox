Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289377AbSBGQh0>; Thu, 7 Feb 2002 11:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289374AbSBGQhN>; Thu, 7 Feb 2002 11:37:13 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:38328 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S289377AbSBGQgu>; Thu, 7 Feb 2002 11:36:50 -0500
Date: Thu, 7 Feb 2002 08:36:36 -0800
From: Dave Hansen <haveblue@us.ibm.com>
Message-Id: <200202071636.g17Gaap02466@localhost.localdomain>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Removal of big kernel lock from isdn drivers [3/3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

3 of 3

isdn.bkl-remove.hydsn_cards_sem.patch:
   adds rwsemaphore hydsn_cards_sem
* hydsn_cards_sem guards the card_root list.  It is a read/write
   semaphore which must be held for write when modifying the list.

I've been examining the continuing additions of the big kernel lock 
(BKL) to the 2.5 tree.  I noticed that in 2.5.3, the ISDN subsystem 
added the BKL to several places.  In response to this, I have written 
several patches to attempt removal of the BKL from the ISDN subsystem. 
I have little knowledge of the drivers themselves, so I would like some 
assistance from those of you who understand them better.  I probably 
have an over-simplified view of the code, so my patches may be too 
simplistic. 

-- 
Dave Hansen
haveblue@us.ibm.com
diff --exclude-from=exclude -ur linux-2.5.3-clean/drivers/isdn/hysdn/hysdn_defs.h linux/drivers/isdn/hysdn/hysdn_defs.h
--- linux-2.5.3-clean/drivers/isdn/hysdn/hysdn_defs.h	Sun Sep 30 12:26:06 2001
+++ linux/drivers/isdn/hysdn/hysdn_defs.h	Mon Feb  4 11:49:04 2002
@@ -227,6 +227,7 @@
 /*****************/
 extern int cardmax;		/* number of found cards */
 extern hysdn_card *card_root;	/* pointer to first card */
+extern rw_semaphore hysdn_cards_sem; /* guards card_root */
 
 
 
diff --exclude-from=exclude -ur linux-2.5.3-clean/drivers/isdn/hysdn/hysdn_init.c linux/drivers/isdn/hysdn/hysdn_init.c
--- linux-2.5.3-clean/drivers/isdn/hysdn/hysdn_init.c	Sun Sep 30 12:26:06 2001
+++ linux/drivers/isdn/hysdn/hysdn_init.c	Mon Feb  4 11:49:04 2002
@@ -36,6 +36,7 @@
 static char *hysdn_init_revision = "$Revision: 1.6.6.6 $";
 int cardmax;			/* number of found cards */
 hysdn_card *card_root = NULL;	/* pointer to first card */
+DECLARE_RWSEM(hysdn_cards_sem); /* guards card_root */
 
 /**********************************************/
 /* table assigning PCI-sub ids to board types */
@@ -75,7 +76,8 @@
 	struct pci_dev *akt_pcidev = NULL;
 	hysdn_card *card, *card_last;
 	int i;
-
+	
+	down_write(&hysdn_cards_sem);
 	card_root = NULL;
 	card_last = NULL;
 	while ((akt_pcidev = pci_find_device(PCI_VENDOR_ID_HYPERCOPE, PCI_DEVICE_ID_HYPERCOPE_PLX,
@@ -124,6 +126,7 @@
 			card_root = card;
 		card_last = card;	/* new chain end */
 	}			/* device found */
+	up_write(&hysdn_cards_sem);
 }				/* search_cards */
 
 /************************************************************************************/
@@ -133,7 +136,7 @@
 free_resources(void)
 {
 	hysdn_card *card;
-
+	down_write(&hysdn_cards_sem);
 	while (card_root) {
 		card = card_root;
 		if (card->releasehardware)
@@ -142,6 +145,7 @@
 		kfree(card);	/* return mem */
 
 	}			/* while card_root */
+	up_write(&hysdn_cards_sem);
 }				/* free_resources */
 
 /**************************************************************************/
@@ -151,13 +155,14 @@
 stop_cards(void)
 {
 	hysdn_card *card;
-
+	down_read(&hysdn_cards_sem);
 	card = card_root;	/* first in chain */
 	while (card) {
 		if (card->stopcard)
 			card->stopcard(card);
 		card = card->next;	/* remove card from chain */
 	}			/* while card */
+	up_read(&hysdn_cards_sem);
 }				/* stop_cards */
 
 
@@ -242,11 +247,13 @@
 #endif /* CONFIG_HYSDN_CAPI */
 	stop_cards();
 #ifdef CONFIG_HYSDN_CAPI
+	down_read(&hysdn_cards_sem);
 	card = card_root;	/* first in chain */
 	while (card) {
 		hycapi_capi_release(card);
 		card = card->next;	/* remove card from chain */
 	}			/* while card */
+	up_read(&hysdn_cards_sem);
 	hycapi_cleanup();
 #endif /* CONFIG_HYSDN_CAPI */
 	hysdn_procconf_release();
diff --exclude-from=exclude -ur linux-2.5.3-clean/drivers/isdn/hysdn/hysdn_procconf.c linux/drivers/isdn/hysdn/hysdn_procconf.c
--- linux-2.5.3-clean/drivers/isdn/hysdn/hysdn_procconf.c	Sun Sep 30 12:26:06 2001
+++ linux/drivers/isdn/hysdn/hysdn_procconf.c	Mon Feb  4 11:49:04 2002
@@ -251,7 +251,7 @@
 	char *cp, *tmp;
 
 	/* now search the addressed card */
-	lock_kernel();
+	down_read(&hysdn_cards_sem);
 	card = card_root;
 	while (card) {
 		pd = card->procconf;
@@ -260,7 +260,7 @@
 		card = card->next;	/* search next entry */
 	}
 	if (!card) {
-		unlock_kernel();
+		up_read(&hysdn_cards_sem);
 		return (-ENODEV);	/* device is unknown/invalid */
 	}
 	if (card->debug_flags & (LOG_PROC_OPEN | LOG_PROC_ALL))
@@ -271,7 +271,7 @@
 		/* write only access -> write boot file or conf line */
 
 		if (!(cnf = kmalloc(sizeof(struct conf_writedata), GFP_KERNEL))) {
-			unlock_kernel();
+			up_read(&hysdn_cards_sem);
 			return (-EFAULT);
 		}
 		cnf->card = card;
@@ -283,7 +283,7 @@
 		/* read access -> output card info data */
 
 		if (!(tmp = (char *) kmalloc(INFO_OUT_LEN * 2 + 2, GFP_KERNEL))) {
-			unlock_kernel();
+			up_read(&hysdn_cards_sem);
 			return (-EFAULT);	/* out of memory */
 		}
 		filep->private_data = tmp;	/* start of string */
@@ -317,10 +317,10 @@
 		*cp++ = '\n';
 		*cp = 0;	/* end of string */
 	} else {		/* simultaneous read/write access forbidden ! */
-		unlock_kernel();
+		up_read(&hysdn_cards_sem);
 		return (-EPERM);	/* no permission this time */
 	}
-	unlock_kernel();
+	up_read(&hysdn_cards_sem);
 	return (0);
 }				/* hysdn_conf_open */
 
@@ -335,7 +335,7 @@
 	int retval = 0;
 	struct proc_dir_entry *pd;
 
-	lock_kernel();
+	down_read(&hysdn_cards_sem);
 	/* search the addressed card */
 	card = card_root;
 	while (card) {
@@ -345,7 +345,7 @@
 		card = card->next;	/* search next entry */
 	}
 	if (!card) {
-		unlock_kernel();
+		up_read(&hysdn_cards_sem);
 		return (-ENODEV);	/* device is unknown/invalid */
 	}
 	if (card->debug_flags & (LOG_PROC_OPEN | LOG_PROC_ALL))
@@ -368,7 +368,7 @@
 		if (filep->private_data)
 			kfree(filep->private_data);	/* release memory */
 	}
-	unlock_kernel();
+	up_read(&hysdn_cards_sem);
 	return (retval);
 }				/* hysdn_conf_close */
 
diff --exclude-from=exclude -ur linux-2.5.3-clean/drivers/isdn/hysdn/hysdn_proclog.c linux/drivers/isdn/hysdn/hysdn_proclog.c
--- linux-2.5.3-clean/drivers/isdn/hysdn/hysdn_proclog.c	Sun Sep 30 12:26:06 2001
+++ linux/drivers/isdn/hysdn/hysdn_proclog.c	Mon Feb  4 11:49:04 2002
@@ -254,8 +254,7 @@
 	struct procdata *pd = NULL;
 	ulong flags;
 
-	lock_kernel();
-	card = card_root;
+	down_read(&hysdn_cards_sem);
 	while (card) {
 		pd = card->proclog;
 		if (pd->log->low_ino == (ino->i_ino & 0xFFFF))
@@ -263,7 +262,7 @@
 		card = card->next;	/* search next entry */
 	}
 	if (!card) {
-		unlock_kernel();
+		up_read(&hysdn_cards_sem);
 		return (-ENODEV);	/* device is unknown/invalid */
 	}
 	filep->private_data = card;	/* remember our own card */
@@ -282,10 +281,10 @@
 			(struct log_data **) filep->private_data = &(pd->log_head);
 		restore_flags(flags);
 	} else {		/* simultaneous read/write access forbidden ! */
-		unlock_kernel();
+		up_read(&hysdn_cards_sem);
 		return (-EPERM);	/* no permission this time */
 	}
-	unlock_kernel();
+	up_read(&hysdn_cards_sem);
 	return (0);
 }				/* hysdn_log_open */
 
@@ -304,8 +303,7 @@
 	hysdn_card *card;
 	int flags, retval = 0;
 
-
-	lock_kernel();
+	down_read(&hysdn_cards_sem);
 	if ((filep->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_WRITE) {
 		/* write only access -> write debug level written */
 		retval = 0;	/* success */
@@ -347,7 +345,7 @@
 					kfree(inf);
 				}
 	}			/* read access */
-	unlock_kernel();
+	up_read(&hysdn_cards_sem);
 
 	return (retval);
 }				/* hysdn_log_close */
