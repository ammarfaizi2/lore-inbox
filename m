Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129851AbQKVNun>; Wed, 22 Nov 2000 08:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130772AbQKVNud>; Wed, 22 Nov 2000 08:50:33 -0500
Received: from hera.cwi.nl ([192.16.191.1]:31471 "EHLO hera.cwi.nl")
        by vger.kernel.org with ESMTP id <S129851AbQKVNuW>;
        Wed, 22 Nov 2000 08:50:22 -0500
Date: Wed, 22 Nov 2000 14:20:14 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200011221320.OAA140634.aeb@aak.cwi.nl>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] isofs/inode.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here the second patch in the isofs series.
inode.c:isofs_read_super() dereferences the variable pri
that need not be set in case of a Joliet CD, causing an Oops.
Patch below.

Andries

[While editing the diff, I left a fix for aha1542.c,
maybe you got it already.  I also left something else
that always annoyed me: valuable screen space (on a 24x80 vt)
is lost by these silly [< >] around addresses in an Oops.
They provide no information at all, but on the other hand
cause loss of information because these lines no longer
fit in 80 columns causing line wrap and the loss of the
top of the Oops.]

diff -u --recursive --new-file ../linux-2.4.0-test11/linux/arch/i386/kernel/traps.c ./linux/arch/i386/kernel/traps.c
--- ../linux-2.4.0-test11/linux/arch/i386/kernel/traps.c	Tue Nov 21 21:44:05 2000
+++ ./linux/arch/i386/kernel/traps.c	Mon Nov 20 12:17:11 2000
@@ -146,7 +146,7 @@
 		    ((addr >= module_start) && (addr <= module_end))) {
 			if (i && ((i % 8) == 0))
 				printk("\n       ");
-			printk("[<%08lx>] ", addr);
+			printk("%08lx ", addr);	/* not [<...>] */
 			i++;
 		}
 	}
@@ -166,7 +166,7 @@
 		esp = regs->esp;
 		ss = regs->xss & 0xffff;
 	}
-	printk("CPU:    %d\nEIP:    %04x:[<%08lx>]\nEFLAGS: %08lx\n",
+	printk("CPU:    %d\nEIP:    %04x:%08lx\nEFLAGS: %08lx\n",
 		smp_processor_id(), 0xffff & regs->xcs, regs->eip, regs->eflags);
 	printk("eax: %08lx   ebx: %08lx   ecx: %08lx   edx: %08lx\n",
 		regs->eax, regs->ebx, regs->ecx, regs->edx);
diff -u --recursive --new-file ../linux-2.4.0-test11/linux/drivers/scsi/aha1542.c ./linux/drivers/scsi/aha1542.c
--- ../linux-2.4.0-test11/linux/drivers/scsi/aha1542.c	Tue Nov 21 21:44:10 2000
+++ ./linux/drivers/scsi/aha1542.c	Tue Nov 21 18:01:57 2000
@@ -1416,6 +1416,7 @@
 			SCtmp = HOSTDATA(SCpnt->host)->SCint[i];
 			if (SCtmp->host_scribble) {
 				scsi_free(SCtmp->host_scribble, 512);
+				SCtmp->host_scribble = NULL;
 			}
 			HOSTDATA(SCpnt->host)->SCint[i] = NULL;
 			HOSTDATA(SCpnt->host)->mb[i].status = 0;
@@ -1478,6 +1479,7 @@
 			}
 			if (SCtmp->host_scribble) {
 				scsi_free(SCtmp->host_scribble, 512);
+				SCtmp->host_scribble = NULL;
 			}
 			HOSTDATA(SCpnt->host)->SCint[i] = NULL;
 			HOSTDATA(SCpnt->host)->mb[i].status = 0;
@@ -1546,6 +1548,7 @@
 			}
 			if (SCtmp->host_scribble) {
 				scsi_free(SCtmp->host_scribble, 512);
+				SCtmp->host_scribble = NULL;
 			}
 			HOSTDATA(SCpnt->host)->SCint[i] = NULL;
 			HOSTDATA(SCpnt->host)->mb[i].status = 0;
@@ -1681,8 +1684,10 @@
 				Scsi_Cmnd *SCtmp;
 				SCtmp = HOSTDATA(SCpnt->host)->SCint[i];
 				SCtmp->result = DID_RESET << 16;
-				if (SCtmp->host_scribble)
+				if (SCtmp->host_scribble) {
 					scsi_free(SCtmp->host_scribble, 512);
+					SCtmp->host_scribble = NULL;
+				}
 				printk(KERN_WARNING "Sending DID_RESET for target %d\n", SCpnt->target);
 				SCtmp->scsi_done(SCpnt);
 
@@ -1725,8 +1730,10 @@
 						Scsi_Cmnd *SCtmp;
 						SCtmp = HOSTDATA(SCpnt->host)->SCint[i];
 						SCtmp->result = DID_RESET << 16;
-						if (SCtmp->host_scribble)
+						if (SCtmp->host_scribble) {
 							scsi_free(SCtmp->host_scribble, 512);
+							SCtmp->host_scribble = NULL;
+						}
 						printk(KERN_WARNING "Sending DID_RESET for target %d\n", SCpnt->target);
 						SCtmp->scsi_done(SCpnt);
 
diff -u --recursive --new-file ../linux-2.4.0-test11/linux/fs/isofs/inode.c ./linux/fs/isofs/inode.c
--- ../linux-2.4.0-test11/linux/fs/isofs/inode.c	Tue Nov 21 21:44:14 2000
+++ ./linux/fs/isofs/inode.c	Wed Nov 22 13:22:09 2000
@@ -500,15 +500,13 @@
  	 * that value.
  	 */
  	blocksize = get_hardblocksize(dev);
- 	if(    (blocksize != 0)
- 	    && (blocksize > opt.blocksize) )
- 	  {
+ 	if(blocksize > opt.blocksize) {
  	    /*
  	     * Force the blocksize we are going to use to be the
  	     * hardware blocksize.
  	     */
  	    opt.blocksize = blocksize;
- 	  }
+	}
  
 	blocksize_bits = 0;
 	{
@@ -594,6 +592,7 @@
 	    brelse(bh);
 	    bh = NULL;
 	}
+
 	/*
 	 * If we fall through, either no volume descriptor was found,
 	 * or else we passed a primary descriptor looking for others.
@@ -605,9 +604,7 @@
 	pri_bh = NULL;
 
 root_found:
-	brelse(pri_bh);
-
-	if (joliet_level && opt.rock == 'n') {
+	if (joliet_level && (pri == NULL || opt.rock == 'n')) {
 	    /* This is the case of Joliet with the norock mount flag.
 	     * A disc with both Joliet and Rock Ridge is handled later
 	     */
@@ -704,6 +701,7 @@
 	 * We're all done using the volume descriptor, and may need
 	 * to change the device blocksize, so release the buffer now.
 	 */
+	brelse(pri_bh);
 	brelse(bh);
 
 	/*
@@ -873,8 +871,8 @@
 /* Life is simpler than for other filesystem since we never
  * have to create a new block, only find an existing one.
  */
-int isofs_get_block(struct inode *inode, long iblock,
-		    struct buffer_head *bh_result, int create)
+static int isofs_get_block(struct inode *inode, long iblock,
+			   struct buffer_head *bh_result, int create)
 {
 	unsigned long b_off;
 	unsigned offset, sect_size;
diff -u --recursive --new-file ../linux-2.4.0-test11/linux/include/linux/iso_fs.h ./linux/include/linux/iso_fs.h
--- ../linux-2.4.0-test11/linux/include/linux/iso_fs.h	Tue Nov 21 21:44:16 2000
+++ ./linux/include/linux/iso_fs.h	Tue Nov 21 13:39:44 2000
@@ -185,7 +185,6 @@
 int get_acorn_filename(struct iso_directory_record *, char *, struct inode *);
 
 extern struct dentry *isofs_lookup(struct inode *, struct dentry *);
-extern int isofs_get_block(struct inode *, long, struct buffer_head *, int);
 extern int isofs_bmap(struct inode *, int);
 extern struct buffer_head *isofs_bread(struct inode *, unsigned int, unsigned int);
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
