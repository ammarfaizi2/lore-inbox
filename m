Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318974AbSH1V1Y>; Wed, 28 Aug 2002 17:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318982AbSH1V1Y>; Wed, 28 Aug 2002 17:27:24 -0400
Received: from ip68-4-60-172.pv.oc.cox.net ([68.4.60.172]:48449 "EHLO
	siamese.dyndns.org") by vger.kernel.org with ESMTP
	id <S318974AbSH1V1N>; Wed, 28 Aug 2002 17:27:13 -0400
Date: Wed, 28 Aug 2002 14:31:31 -0700
Message-Id: <200208282131.g7SLVVGx024191@siamese.dyndns.org>
To: linux-kernel@vger.kernel.org
cc: trivial@rustcorp.com.au
From: junkio@cox.net
References: <fa.iks3ohv.1flge08@ifi.uio.no>
Subject: [TRIVIAL] strlen("literal string") -> (sizeof("literal string")-1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch that does the same as what Keith Owens did in
his patch recently.

    Message-ID: <fa.iks3ohv.1flge08@ifi.uio.no>
    From: Keith Owens <kaos@ocs.com.au>
    Subject: [patch] 2.4.19 Generate better code for nfs_sillyrename
    Date: Wed, 28 Aug 2002 07:08:17 GMT

    Using strlen() generates an unnecessary inline function expansion plus
    dynamic stack adjustment.  For constant strings, strlen() == sizeof()-1
    and the object code is better.

The patch is against 2.4.19.

diff -ru 2.4.19/arch/mips/hp-lj/utils.c 2.4.19-strlen/arch/mips/hp-lj/utils.c
--- 2.4.19/arch/mips/hp-lj/utils.c	2002-08-02 10:48:43.000000000 -0700
+++ 2.4.19-strlen/arch/mips/hp-lj/utils.c	2002-08-28 01:17:20.000000000 -0700
@@ -48,7 +48,7 @@
 {
 	char* pos = strstr(cl, "reserved_buffer=");
  	if (pos) {
-		buffer_size = simple_strtol(pos+strlen("reserved_buffer="), 
+		buffer_size = simple_strtol(pos+(sizeof("reserved_buffer=")-1), 
 					    0, 10);
 		buffer_size <<= 20;
 		if (buffer_size + MIN_GEN_MEM > base_mem)
diff -ru 2.4.19/arch/mips/mips-boards/atlas/atlas_setup.c 2.4.19-strlen/arch/mips/mips-boards/atlas/atlas_setup.c
--- 2.4.19/arch/mips/mips-boards/atlas/atlas_setup.c	2002-08-02 10:48:43.000000000 -0700
+++ 2.4.19-strlen/arch/mips/mips-boards/atlas/atlas_setup.c	2002-08-28 01:17:20.000000000 -0700
@@ -92,7 +92,7 @@
 	argptr = prom_getcmdline();
 	if ((argptr = strstr(argptr, "kgdb=ttyS")) != NULL) {
 		int line;
-		argptr += strlen("kgdb=ttyS");
+		argptr += (sizeof("kgdb=ttyS")-1);
 		if (*argptr != '0' && *argptr != '1')
 			printk("KGDB: Uknown serial line /dev/ttyS%c, "
 			       "falling back to /dev/ttyS1\n", *argptr);
diff -ru 2.4.19/arch/mips/mips-boards/malta/malta_setup.c 2.4.19-strlen/arch/mips/mips-boards/malta/malta_setup.c
--- 2.4.19/arch/mips/mips-boards/malta/malta_setup.c	2002-08-02 10:48:43.000000000 -0700
+++ 2.4.19-strlen/arch/mips/mips-boards/malta/malta_setup.c	2002-08-28 01:17:20.000000000 -0700
@@ -121,7 +121,7 @@
 	argptr = prom_getcmdline();
 	if ((argptr = strstr(argptr, "kgdb=ttyS")) != NULL) {
 		int line;
-		argptr += strlen("kgdb=ttyS");
+		argptr += (sizeof("kgdb=ttyS")-1);
 		if (*argptr != '0' && *argptr != '1')
 			printk("KGDB: Uknown serial line /dev/ttyS%c, "
 			       "falling back to /dev/ttyS1\n", *argptr);
diff -ru 2.4.19/arch/mips/sgi-ip22/ip22-setup.c 2.4.19-strlen/arch/mips/sgi-ip22/ip22-setup.c
--- 2.4.19/arch/mips/sgi-ip22/ip22-setup.c	2002-08-02 10:48:43.000000000 -0700
+++ 2.4.19-strlen/arch/mips/sgi-ip22/ip22-setup.c	2002-08-28 01:17:20.000000000 -0700
@@ -173,7 +173,7 @@
 	kgdb_ttyd = prom_getcmdline();
 	if ((kgdb_ttyd = strstr(kgdb_ttyd, "kgdb=ttyd")) != NULL) {
 		int line;
-		kgdb_ttyd += strlen("kgdb=ttyd");
+		kgdb_ttyd += (sizeof("kgdb=ttyd")-1);
 		if (*kgdb_ttyd != '1' && *kgdb_ttyd != '2')
 			printk("KGDB: Uknown serial line /dev/ttyd%c, "
 			       "falling back to /dev/ttyd1\n", *kgdb_ttyd);
diff -ru 2.4.19/arch/ppc/boot/utils/mknote.c 2.4.19-strlen/arch/ppc/boot/utils/mknote.c
--- 2.4.19/arch/ppc/boot/utils/mknote.c	2001-05-24 15:02:07.000000000 -0700
+++ 2.4.19-strlen/arch/ppc/boot/utils/mknote.c	2002-08-28 01:17:21.000000000 -0700
@@ -21,7 +21,7 @@
 {
 /* header */
 	/* namesz */
-	PL(strlen("PowerPC")+1);
+	PL((sizeof("PowerPC")-1)+1);
 	/* descrsz */
 	PL(6*4);
 	/* type */
diff -ru 2.4.19/arch/ppc/boot/utils/mkprep.c 2.4.19-strlen/arch/ppc/boot/utils/mkprep.c
--- 2.4.19/arch/ppc/boot/utils/mkprep.c	2001-05-24 15:02:07.000000000 -0700
+++ 2.4.19-strlen/arch/ppc/boot/utils/mkprep.c	2002-08-28 01:17:21.000000000 -0700
@@ -250,7 +250,7 @@
   unsigned char str[256];
   
   write( out, "\t.data\n\t.globl input_data\ninput_data:\n",
-	 strlen( "\t.data\n\t.globl input_data\ninput_data:\n" ) );
+	 (sizeof("\t.data\n\t.globl input_data\ninput_data:\n")-1) );
   pos = 0;
   cksum = 0;
   while ((len = read(in, buf, sizeof(buf))) > 0)
@@ -262,7 +262,7 @@
     {
       if (cnt == 0)
       {
-	write( out, "\t.long\t", strlen( "\t.long\t" ) );
+	write( out, "\t.long\t", (sizeof("\t.long\t")-1) );
       }
       sprintf( str, "0x%02X%02X%02X%02X", lp[0], lp[1], lp[2], lp[3]);
       write( out, str, strlen(str) );
diff -ru 2.4.19/arch/ppc/kernel/pmac_feature.c 2.4.19-strlen/arch/ppc/kernel/pmac_feature.c
--- 2.4.19/arch/ppc/kernel/pmac_feature.c	2002-08-02 10:48:45.000000000 -0700
+++ 2.4.19-strlen/arch/ppc/kernel/pmac_feature.c	2002-08-28 01:17:20.000000000 -0700
@@ -1043,9 +1043,9 @@
 	prop = (char *)get_property(node, "AAPL,clock-id", NULL);
 	if (!prop)
 		return -ENODEV;
-	if (strncmp(prop, "usb0u048", strlen("usb0u048")) == 0)
+	if (strncmp(prop, "usb0u048", (sizeof("usb0u048")-1)) == 0)
 		number = 0;
-	else if (strncmp(prop, "usb1u148", strlen("usb1u148")) == 0)
+	else if (strncmp(prop, "usb1u148", (sizeof("usb1u148")-1)) == 0)
 		number = 2;
 	else
 		return -ENODEV;
diff -ru 2.4.19/arch/ppc64/boot/mknote.c 2.4.19-strlen/arch/ppc64/boot/mknote.c
--- 2.4.19/arch/ppc64/boot/mknote.c	2002-08-02 10:48:45.000000000 -0700
+++ 2.4.19-strlen/arch/ppc64/boot/mknote.c	2002-08-28 01:17:20.000000000 -0700
@@ -18,7 +18,7 @@
 {
 /* header */
 	/* namesz */
-	PL(strlen("PowerPC")+1);
+	PL((sizeof("PowerPC")-1)+1);
 	/* descrsz */
 	PL(6*4);
 	/* type */
diff -ru 2.4.19/arch/ppc64/boot/zImage.c 2.4.19-strlen/arch/ppc64/boot/zImage.c
--- 2.4.19/arch/ppc64/boot/zImage.c	2002-08-02 10:48:45.000000000 -0700
+++ 2.4.19-strlen/arch/ppc64/boot/zImage.c	2002-08-28 01:17:20.000000000 -0700
@@ -219,7 +219,7 @@
 	/* rec->data[0] = ...;	# Written below before return */
 	/* rec->data[1] = ...;	# Written below before return */
 
-	rec = bi_rec_alloc_bytes(rec, strlen("chrpboot")+1);
+	rec = bi_rec_alloc_bytes(rec, (sizeof("chrpboot")-1)+1);
 	rec->tag = BI_BOOTLOADER_ID;
 	sprintf( (char *)rec->data, "chrpboot");
 
diff -ru 2.4.19/drivers/char/ftape/zftape/zftape-vtbl.c 2.4.19-strlen/drivers/char/ftape/zftape/zftape-vtbl.c
--- 2.4.19/drivers/char/ftape/zftape/zftape-vtbl.c	2001-04-06 10:42:55.000000000 -0700
+++ 2.4.19-strlen/drivers/char/ftape/zftape/zftape-vtbl.c	2002-08-28 01:17:13.000000000 -0700
@@ -164,7 +164,7 @@
 		/* use the kernel strstr()   */
 		blocksize= strstr(label, " blocksize ");
 		if (blocksize) {
-			blocksize += strlen(" blocksize ");
+			blocksize += (sizeof(" blocksize ")-1);
 			for(*blk_sz= 0; 
 			    *blocksize >= '0' && *blocksize <= '9'; 
 			    blocksize++) {
diff -ru 2.4.19/drivers/isdn/isdn_net.c 2.4.19-strlen/drivers/isdn/isdn_net.c
--- 2.4.19/drivers/isdn/isdn_net.c	2001-12-21 09:41:54.000000000 -0800
+++ 2.4.19-strlen/drivers/isdn/isdn_net.c	2002-08-28 01:17:16.000000000 -0700
@@ -653,7 +653,7 @@
 					isdn_net_hangup(&p->dev);
 					break;
 				}
-				if (!strncmp(lp->dial->num, "LEASED", strlen("LEASED"))) {
+				if (!strncmp(lp->dial->num, "LEASED", (sizeof("LEASED")-1))) {
 					restore_flags(flags);
 					lp->dialstate = 4;
 					printk(KERN_INFO "%s: Open leased line ...\n", lp->name);
diff -ru 2.4.19/drivers/net/au1000_eth.c 2.4.19-strlen/drivers/net/au1000_eth.c
--- 2.4.19/drivers/net/au1000_eth.c	2002-08-02 10:48:50.000000000 -0700
+++ 2.4.19-strlen/drivers/net/au1000_eth.c	2002-08-28 01:17:11.000000000 -0700
@@ -707,7 +707,7 @@
 						dev->name);
 				/* use the hard coded mac addresses */
 			} else {
-				str2eaddr(ethaddr, pmac + strlen("ethaddr="));
+				str2eaddr(ethaddr, pmac + (sizeof("ethaddr=")-1));
 				memcpy(au1000_mac_addr, ethaddr, 
 						sizeof(dev->dev_addr));
 			}
diff -ru 2.4.19/drivers/s390/block/dasd.c 2.4.19-strlen/drivers/s390/block/dasd.c
--- 2.4.19/drivers/s390/block/dasd.c	2002-08-02 10:48:52.000000000 -0700
+++ 2.4.19-strlen/drivers/s390/block/dasd.c	2002-08-28 01:17:19.000000000 -0700
@@ -3830,13 +3830,13 @@
 	off += 4;
 	while (buffer[off] && !isalnum (buffer[off]))
 		off++;
-	if (!strncmp (buffer + off, "device", strlen ("device"))) {
-		off += strlen ("device");
+	if (!strncmp (buffer + off, "device", (sizeof("device")-1))) {
+		off += (sizeof("device")-1);
 		while (buffer[off] && !isalnum (buffer[off]))
 			off++;
 	}
-	if (!strncmp (buffer + off, "range=", strlen ("range="))) {
-		off += strlen ("range=");
+	if (!strncmp (buffer + off, "range=", (sizeof("range=")-1))) {
+		off += (sizeof("range=")-1);
 		while (buffer[off] && !isalnum (buffer[off]))
 			off++;
 	}
@@ -3858,15 +3858,15 @@
                         buffer);
         } else {
                 off = (long) temp - (long) buffer;
-                if (!strncmp (buffer, "add", strlen ("add"))) {
+                if (!strncmp (buffer, "add", (sizeof("add")-1))) {
                         dasd_add_range (range.from, range.to, features);
                         dasd_enable_ranges (&range, NULL, 0);
                 } else { 
                         while (buffer[off] && !isalnum (buffer[off]))
                                 off++;
-                        if (!strncmp (buffer + off, "on", strlen ("on"))) {
+                        if (!strncmp (buffer + off, "on", (sizeof("on")-1))) {
                                 dasd_enable_ranges (&range, NULL, 0);
-                        } else if (!strncmp (buffer + off, "off", strlen ("off"))) {
+                        } else if (!strncmp (buffer + off, "off", (sizeof("off")-1))) {
                                 dasd_disable_ranges (&range, NULL, 0, 1);
                         } else {
                                 printk (KERN_WARNING PRINTK_HEADER
diff -ru 2.4.19/drivers/s390/char/tape.c 2.4.19-strlen/drivers/s390/char/tape.c
--- 2.4.19/drivers/s390/char/tape.c	2001-07-25 14:12:02.000000000 -0700
+++ 2.4.19-strlen/drivers/s390/char/tape.c	2002-08-28 01:17:19.000000000 -0700
@@ -921,7 +921,7 @@
         if (tape_devices_entry) {
             memset (tape_devices_entry, 0, sizeof (struct proc_dir_entry));
             tape_devices_entry->name = "tapedevices";
-            tape_devices_entry->namelen = strlen ("tapedevices");
+            tape_devices_entry->namelen = (sizeof("tapedevices")-1);
             tape_devices_entry->low_ino = 0;
             tape_devices_entry->mode = (S_IFREG | S_IRUGO | S_IWUSR);
             tape_devices_entry->nlink = 1;
diff -ru 2.4.19/drivers/scsi/53c7xx.c 2.4.19-strlen/drivers/scsi/53c7xx.c
--- 2.4.19/drivers/scsi/53c7xx.c	2002-02-08 23:39:18.000000000 -0800
+++ 2.4.19-strlen/drivers/scsi/53c7xx.c	2002-08-28 01:17:14.000000000 -0700
@@ -409,7 +409,7 @@
          continue;
       if (!strncmp(setup_strings[x], key, strlen(key)))
          break;
-      if (!strncmp(setup_strings[x], "next", strlen("next")))
+      if (!strncmp(setup_strings[x], "next", (sizeof("next")-1)))
          return 0;
       }
    if (x == MAX_SETUP_STRINGS)
diff -ru 2.4.19/drivers/scsi/megaraid.c 2.4.19-strlen/drivers/scsi/megaraid.c
--- 2.4.19/drivers/scsi/megaraid.c	2002-08-02 10:48:53.000000000 -0700
+++ 2.4.19-strlen/drivers/scsi/megaraid.c	2002-08-28 01:17:14.000000000 -0700
@@ -3194,7 +3194,7 @@
 	}
 #endif
 	skip_id = -1;
-	if (megaraid && !strncmp (megaraid, "skip", strlen ("skip"))) {
+	if (megaraid && !strncmp (megaraid, "skip", (sizeof("skip")-1))) {
 		if (megaraid[4] != '\0') {
 			skip_id = megaraid[4] - '0';
 			if (megaraid[5] != '\0') {
diff -ru 2.4.19/drivers/scsi/wd33c93.c 2.4.19-strlen/drivers/scsi/wd33c93.c
--- 2.4.19/drivers/scsi/wd33c93.c	2002-08-02 10:48:53.000000000 -0700
+++ 2.4.19-strlen/drivers/scsi/wd33c93.c	2002-08-28 01:17:14.000000000 -0700
@@ -1727,7 +1727,7 @@
          continue;
       if (!strncmp(setup_args[x], key, strlen(key)))
          break;
-      if (!strncmp(setup_args[x], "next", strlen("next")))
+      if (!strncmp(setup_args[x], "next", (sizeof("next")-1)))
          return 0;
       }
    if (x == MAX_SETUP_ARGS)
diff -ru 2.4.19/fs/intermezzo/journal.c 2.4.19-strlen/fs/intermezzo/journal.c
--- 2.4.19/fs/intermezzo/journal.c	2002-01-26 13:09:53.000000000 -0800
+++ 2.4.19-strlen/fs/intermezzo/journal.c	2002-08-28 01:17:07.000000000 -0700
@@ -697,7 +697,7 @@
         ENTRY;
 
         mtpt_len = strlen(cache->cache_mtpt);
-        path_len = mtpt_len + strlen("/.intermezzo/") +
+        path_len = mtpt_len + (sizeof("/.intermezzo/")-1) +
                 strlen(fset->fset_name) + strlen(name);
 
         error = -ENOMEM;
diff -ru 2.4.19/fs/intermezzo/methods.c 2.4.19-strlen/fs/intermezzo/methods.c
--- 2.4.19/fs/intermezzo/methods.c	2001-11-13 09:20:56.000000000 -0800
+++ 2.4.19-strlen/fs/intermezzo/methods.c	2002-08-28 01:17:07.000000000 -0700
@@ -130,8 +130,8 @@
 
 void filter_setup_journal_ops(struct filter_fs *ops, char *cache_type)
 {
-        if ( strlen(cache_type) == strlen("ext2") &&
-             memcmp(cache_type, "ext2", strlen("ext2")) == 0 ) {
+        if ( strlen(cache_type) == (sizeof("ext2")-1) &&
+             memcmp(cache_type, "ext2", (sizeof("ext2")-1)) == 0 ) {
 #if CONFIG_EXT2_FS
                 ops->o_trops = &presto_ext2_journal_ops;
 #else
@@ -140,8 +140,8 @@
                 FDEBUG(D_SUPER, "ops at %p\n", ops);
         }
 
-        if ( strlen(cache_type) == strlen("ext3") &&
-             memcmp(cache_type, "ext3", strlen("ext3")) == 0 ) {
+        if ( strlen(cache_type) == (sizeof("ext3")-1) &&
+             memcmp(cache_type, "ext3", (sizeof("ext3")-1)) == 0 ) {
 #if defined(CONFIG_EXT3_FS) || defined (CONFIG_EXT3_FS_MODULE)
                 ops->o_trops = &presto_ext3_journal_ops;
 #else
@@ -150,8 +150,8 @@
                 FDEBUG(D_SUPER, "ops at %p\n", ops);
         }
 
-        if ( strlen(cache_type) == strlen("reiserfs") &&
-             memcmp(cache_type, "reiserfs", strlen("reiserfs")) == 0 ) {
+        if ( strlen(cache_type) == (sizeof("reiserfs")-1) &&
+             memcmp(cache_type, "reiserfs", (sizeof("reiserfs")-1)) == 0 ) {
 #if 0
 		/* #if defined(CONFIG_REISERFS_FS) || defined(CONFIG_REISERFS_FS_MODULE) */
                 ops->o_trops = &presto_reiserfs_journal_ops;
@@ -161,8 +161,8 @@
                 FDEBUG(D_SUPER, "ops at %p\n", ops);
         }
 
-        if ( strlen(cache_type) == strlen("xfs") &&
-             memcmp(cache_type, "xfs", strlen("xfs")) == 0 ) {
+        if ( strlen(cache_type) == (sizeof("xfs")-1) &&
+             memcmp(cache_type, "xfs", (sizeof("xfs")-1)) == 0 ) {
 #if 0
                 //#if defined(CONFIG_XFS_FS) || defined (CONFIG_XFS_FS_MODULE)
                 ops->o_trops = &presto_xfs_journal_ops;
@@ -172,8 +172,8 @@
                 FDEBUG(D_SUPER, "ops at %p\n", ops);
         }
 
-        if ( strlen(cache_type) == strlen("obdfs") &&
-             memcmp(cache_type, "obdfs", strlen("obdfs")) == 0 ) {
+        if ( strlen(cache_type) == (sizeof("obdfs")-1) &&
+             memcmp(cache_type, "obdfs", (sizeof("obdfs")-1)) == 0 ) {
 #if defined(CONFIG_OBDFS_FS) || defined (CONFIG_OBDFS_FS_MODULE)
                 ops->o_trops = presto_obdfs_journal_ops;
 #else
@@ -190,30 +190,30 @@
         struct filter_fs *ops = NULL;
         FENTRY;
 
-        if ( strlen(cache_type) == strlen("ext2") &&
-             memcmp(cache_type, "ext2", strlen("ext2")) == 0 ) {
+        if ( strlen(cache_type) == (sizeof("ext2")-1) &&
+             memcmp(cache_type, "ext2", (sizeof("ext2")-1)) == 0 ) {
                 ops = &filter_oppar[FILTER_FS_EXT2];
                 FDEBUG(D_SUPER, "ops at %p\n", ops);
         }
 
-        if ( strlen(cache_type) == strlen("xfs") &&
-             memcmp(cache_type, "xfs", strlen("xfs")) == 0 ) {
+        if ( strlen(cache_type) == (sizeof("xfs")-1) &&
+             memcmp(cache_type, "xfs", (sizeof("xfs")-1)) == 0 ) {
                 ops = &filter_oppar[FILTER_FS_XFS];
                 FDEBUG(D_SUPER, "ops at %p\n", ops);
         }
 
-        if ( strlen(cache_type) == strlen("ext3") &&
-             memcmp(cache_type, "ext3", strlen("ext3")) == 0 ) {
+        if ( strlen(cache_type) == (sizeof("ext3")-1) &&
+             memcmp(cache_type, "ext3", (sizeof("ext3")-1)) == 0 ) {
                 ops = &filter_oppar[FILTER_FS_EXT3];
                 FDEBUG(D_SUPER, "ops at %p\n", ops);
         }
-        if ( strlen(cache_type) == strlen("reiserfs") &&
-             memcmp(cache_type, "reiserfs", strlen("reiserfs")) == 0 ) {
+        if ( strlen(cache_type) == (sizeof("reiserfs")-1) &&
+             memcmp(cache_type, "reiserfs", (sizeof("reiserfs")-1)) == 0 ) {
                 ops = &filter_oppar[FILTER_FS_REISERFS];
                 FDEBUG(D_SUPER, "ops at %p\n", ops);
         }
-        if ( strlen(cache_type) == strlen("obdfs") &&
-             memcmp(cache_type, "obdfs", strlen("obdfs")) == 0 ) {
+        if ( strlen(cache_type) == (sizeof("obdfs")-1) &&
+             memcmp(cache_type, "obdfs", (sizeof("obdfs")-1)) == 0 ) {
                 ops = &filter_oppar[FILTER_FS_OBDFS];
                 FDEBUG(D_SUPER, "ops at %p\n", ops);
         }
diff -ru 2.4.19/fs/nfs/dir.c 2.4.19-strlen/fs/nfs/dir.c
--- 2.4.19/fs/nfs/dir.c	2002-08-02 10:48:56.000000000 -0700
+++ 2.4.19-strlen/fs/nfs/dir.c	2002-08-28 01:17:06.000000000 -0700
@@ -741,7 +741,7 @@
 	static unsigned int sillycounter;
 	const int      i_inosize  = sizeof(dir->i_ino)*2;
 	const int      countersize = sizeof(sillycounter)*2;
-	const int      slen       = strlen(".nfs") + i_inosize + countersize;
+	const int      slen       = (sizeof(".nfs")-1) + i_inosize + countersize;
 	char           silly[slen+1];
 	struct qstr    qsilly;
 	struct dentry *sdentry;
diff -ru 2.4.19/fs/reiserfs/dir.c 2.4.19-strlen/fs/reiserfs/dir.c
--- 2.4.19/fs/reiserfs/dir.c	2002-08-02 10:48:56.000000000 -0700
+++ 2.4.19-strlen/fs/reiserfs/dir.c	2002-08-28 01:17:07.000000000 -0700
@@ -202,7 +202,7 @@
     deh[0].deh_dir_id = dirid;
     deh[0].deh_objectid = objid;
     deh[0].deh_state = 0; /* Endian safe if 0 */
-    put_deh_location( &(deh[0]), EMPTY_DIR_SIZE_V1 - strlen( "." ));
+    put_deh_location( &(deh[0]), EMPTY_DIR_SIZE_V1 - (sizeof(".")-1));
     mark_de_visible(&(deh[0]));
   
     /* direntry header of ".." */
@@ -212,7 +212,7 @@
     deh[1].deh_dir_id = par_dirid;
     deh[1].deh_objectid = par_objid;
     deh[1].deh_state = 0; /* Endian safe if 0 */
-    put_deh_location( &(deh[1]), deh_location( &(deh[0]) ) - strlen( ".." ) );
+    put_deh_location( &(deh[1]), deh_location( &(deh[0]) ) - (sizeof("..")-1) );
     mark_de_visible(&(deh[1]));
 
     /* copy ".." and "." */
@@ -235,7 +235,7 @@
     deh[0].deh_dir_id = dirid;
     deh[0].deh_objectid = objid;
     deh[0].deh_state = 0; /* Endian safe if 0 */
-    put_deh_location( &(deh[0]), EMPTY_DIR_SIZE - ROUND_UP( strlen( "." ) ) );
+    put_deh_location( &(deh[0]), EMPTY_DIR_SIZE - ROUND_UP( (sizeof(".")-1) ) );
     mark_de_visible(&(deh[0]));
   
     /* direntry header of ".." */
@@ -245,7 +245,7 @@
     deh[1].deh_dir_id = par_dirid;
     deh[1].deh_objectid = par_objid;
     deh[1].deh_state = 0; /* Endian safe if 0 */
-    put_deh_location( &(deh[1]), deh_location( &(deh[0])) - ROUND_UP( strlen( ".." ) ) );
+    put_deh_location( &(deh[1]), deh_location( &(deh[0])) - ROUND_UP( (sizeof("..")-1) ) );
     mark_de_visible(&(deh[1]));
 
     /* copy ".." and "." */
diff -ru 2.4.19/include/linux/reiserfs_fs.h 2.4.19-strlen/include/linux/reiserfs_fs.h
--- 2.4.19/include/linux/reiserfs_fs.h	2002-08-24 01:20:57.000000000 -0700
+++ 2.4.19-strlen/include/linux/reiserfs_fs.h	2002-08-28 01:17:07.000000000 -0700
@@ -869,7 +869,7 @@
 
 /* empty directory contains two entries "." and ".." and their headers */
 #define EMPTY_DIR_SIZE \
-(DEH_SIZE * 2 + ROUND_UP (strlen (".")) + ROUND_UP (strlen ("..")))
+(DEH_SIZE * 2 + ROUND_UP ((sizeof(".")-1)) + ROUND_UP ((sizeof("..")-1)))
 
 /* old format directories have this size when empty */
 #define EMPTY_DIR_SIZE_V1 (DEH_SIZE * 2 + 3)

