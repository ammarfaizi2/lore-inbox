Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261929AbVCZDma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbVCZDma (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 22:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbVCZDma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 22:42:30 -0500
Received: from fire.osdl.org ([65.172.181.4]:20105 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261929AbVCZDlp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 22:41:45 -0500
Date: Fri, 25 Mar 2005 19:41:42 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, torvalds@osdl.org, akpm@osdl.org
Subject: Re: Linux 2.6.11.6
Message-ID: <20050326034142.GW30522@shell0.pdx.osdl.net>
References: <20050326024616.GM28536@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050326033939.GV30522@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -Nru a/Makefile b/Makefile
--- a/Makefile	2005-03-25 18:26:00 -08:00
+++ b/Makefile	2005-03-25 18:26:00 -08:00
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 11
-EXTRAVERSION = .5
+EXTRAVERSION = .6
 NAME=Woozy Numbat
 
 # *DOCUMENTATION*
diff -Nru a/fs/binfmt_elf.c b/fs/binfmt_elf.c
--- a/fs/binfmt_elf.c	2005-03-25 18:26:00 -08:00
+++ b/fs/binfmt_elf.c	2005-03-25 18:26:00 -08:00
@@ -1008,6 +1008,7 @@
 static int load_elf_library(struct file *file)
 {
 	struct elf_phdr *elf_phdata;
+	struct elf_phdr *eppnt;
 	unsigned long elf_bss, bss, len;
 	int retval, error, i, j;
 	struct elfhdr elf_ex;
@@ -1031,44 +1032,47 @@
 	/* j < ELF_MIN_ALIGN because elf_ex.e_phnum <= 2 */
 
 	error = -ENOMEM;
-	elf_phdata = (struct elf_phdr *) kmalloc(j, GFP_KERNEL);
+	elf_phdata = kmalloc(j, GFP_KERNEL);
 	if (!elf_phdata)
 		goto out;
 
+	eppnt = elf_phdata;
 	error = -ENOEXEC;
-	retval = kernel_read(file, elf_ex.e_phoff, (char *) elf_phdata, j);
+	retval = kernel_read(file, elf_ex.e_phoff, (char *)eppnt, j);
 	if (retval != j)
 		goto out_free_ph;
 
 	for (j = 0, i = 0; i<elf_ex.e_phnum; i++)
-		if ((elf_phdata + i)->p_type == PT_LOAD) j++;
+		if ((eppnt + i)->p_type == PT_LOAD)
+			j++;
 	if (j != 1)
 		goto out_free_ph;
 
-	while (elf_phdata->p_type != PT_LOAD) elf_phdata++;
+	while (eppnt->p_type != PT_LOAD)
+		eppnt++;
 
 	/* Now use mmap to map the library into memory. */
 	down_write(&current->mm->mmap_sem);
 	error = do_mmap(file,
-			ELF_PAGESTART(elf_phdata->p_vaddr),
-			(elf_phdata->p_filesz +
-			 ELF_PAGEOFFSET(elf_phdata->p_vaddr)),
+			ELF_PAGESTART(eppnt->p_vaddr),
+			(eppnt->p_filesz +
+			 ELF_PAGEOFFSET(eppnt->p_vaddr)),
 			PROT_READ | PROT_WRITE | PROT_EXEC,
 			MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE,
-			(elf_phdata->p_offset -
-			 ELF_PAGEOFFSET(elf_phdata->p_vaddr)));
+			(eppnt->p_offset -
+			 ELF_PAGEOFFSET(eppnt->p_vaddr)));
 	up_write(&current->mm->mmap_sem);
-	if (error != ELF_PAGESTART(elf_phdata->p_vaddr))
+	if (error != ELF_PAGESTART(eppnt->p_vaddr))
 		goto out_free_ph;
 
-	elf_bss = elf_phdata->p_vaddr + elf_phdata->p_filesz;
+	elf_bss = eppnt->p_vaddr + eppnt->p_filesz;
 	if (padzero(elf_bss)) {
 		error = -EFAULT;
 		goto out_free_ph;
 	}
 
-	len = ELF_PAGESTART(elf_phdata->p_filesz + elf_phdata->p_vaddr + ELF_MIN_ALIGN - 1);
-	bss = elf_phdata->p_memsz + elf_phdata->p_vaddr;
+	len = ELF_PAGESTART(eppnt->p_filesz + eppnt->p_vaddr + ELF_MIN_ALIGN - 1);
+	bss = eppnt->p_memsz + eppnt->p_vaddr;
 	if (bss > len) {
 		down_write(&current->mm->mmap_sem);
 		do_brk(len, bss - len);
diff -Nru a/fs/ext2/dir.c b/fs/ext2/dir.c
--- a/fs/ext2/dir.c	2005-03-25 18:26:00 -08:00
+++ b/fs/ext2/dir.c	2005-03-25 18:26:00 -08:00
@@ -592,6 +592,7 @@
 		goto fail;
 	}
 	kaddr = kmap_atomic(page, KM_USER0);
+       memset(kaddr, 0, chunk_size);
 	de = (struct ext2_dir_entry_2 *)kaddr;
 	de->name_len = 1;
 	de->rec_len = cpu_to_le16(EXT2_DIR_REC_LEN(1));
diff -Nru a/fs/isofs/inode.c b/fs/isofs/inode.c
--- a/fs/isofs/inode.c	2005-03-25 18:26:00 -08:00
+++ b/fs/isofs/inode.c	2005-03-25 18:26:00 -08:00
@@ -685,6 +685,8 @@
 	  sbi->s_log_zone_size = isonum_723 (h_pri->logical_block_size);
 	  sbi->s_max_size = isonum_733(h_pri->volume_space_size);
 	} else {
+	  if (!pri)
+	    goto out_freebh;
 	  rootp = (struct iso_directory_record *) pri->root_directory_record;
 	  sbi->s_nzones = isonum_733 (pri->volume_space_size);
 	  sbi->s_log_zone_size = isonum_723 (pri->logical_block_size);
@@ -1394,6 +1396,9 @@
 	unsigned long hashval;
 	struct inode *inode;
 	struct isofs_iget5_callback_data data;
+
+	if (offset >= 1ul << sb->s_blocksize_bits)
+		return NULL;
 
 	data.block = block;
 	data.offset = offset;
diff -Nru a/fs/isofs/rock.c b/fs/isofs/rock.c
--- a/fs/isofs/rock.c	2005-03-25 18:26:00 -08:00
+++ b/fs/isofs/rock.c	2005-03-25 18:26:00 -08:00
@@ -53,6 +53,7 @@
   if(LEN & 1) LEN++;						\
   CHR = ((unsigned char *) DE) + LEN;				\
   LEN = *((unsigned char *) DE) - LEN;                          \
+  if (LEN<0) LEN=0;                                             \
   if (ISOFS_SB(inode->i_sb)->s_rock_offset!=-1)                \
   {                                                             \
      LEN-=ISOFS_SB(inode->i_sb)->s_rock_offset;                \
@@ -73,6 +74,10 @@
     offset1 = 0; \
     pbh = sb_bread(DEV->i_sb, block); \
     if(pbh){       \
+      if (offset > pbh->b_size || offset + cont_size > pbh->b_size){	\
+	brelse(pbh); \
+	goto out; \
+      } \
       memcpy(buffer + offset1, pbh->b_data + offset, cont_size - offset1); \
       brelse(pbh); \
       chr = (unsigned char *) buffer; \
@@ -103,12 +108,13 @@
     struct rock_ridge * rr;
     int sig;
     
-    while (len > 1){ /* There may be one byte for padding somewhere */
+    while (len > 2){ /* There may be one byte for padding somewhere */
       rr = (struct rock_ridge *) chr;
-      if (rr->len == 0) goto out; /* Something got screwed up here */
+      if (rr->len < 3) goto out; /* Something got screwed up here */
       sig = isonum_721(chr);
       chr += rr->len; 
       len -= rr->len;
+      if (len < 0) goto out;	/* corrupted isofs */
 
       switch(sig){
       case SIG('R','R'):
@@ -122,6 +128,7 @@
 	break;
       case SIG('N','M'):
 	if (truncate) break;
+	if (rr->len < 5) break;
         /*
 	 * If the flags are 2 or 4, this indicates '.' or '..'.
 	 * We don't want to do anything with this, because it
@@ -186,12 +193,13 @@
     struct rock_ridge * rr;
     int rootflag;
     
-    while (len > 1){ /* There may be one byte for padding somewhere */
+    while (len > 2){ /* There may be one byte for padding somewhere */
       rr = (struct rock_ridge *) chr;
-      if (rr->len == 0) goto out; /* Something got screwed up here */
+      if (rr->len < 3) goto out; /* Something got screwed up here */
       sig = isonum_721(chr);
       chr += rr->len; 
       len -= rr->len;
+      if (len < 0) goto out;	/* corrupted isofs */
       
       switch(sig){
 #ifndef CONFIG_ZISOFS		/* No flag for SF or ZF */
@@ -462,7 +470,7 @@
 	struct rock_ridge *rr;
 
 	if (!ISOFS_SB(inode->i_sb)->s_rock)
-		panic ("Cannot have symlink with high sierra variant of iso filesystem\n");
+		goto error;
 
 	block = ei->i_iget5_block;
 	lock_kernel();
@@ -487,13 +495,15 @@
 	SETUP_ROCK_RIDGE(raw_inode, chr, len);
 
       repeat:
-	while (len > 1) { /* There may be one byte for padding somewhere */
+	while (len > 2) { /* There may be one byte for padding somewhere */
 		rr = (struct rock_ridge *) chr;
-		if (rr->len == 0)
+		if (rr->len < 3)
 			goto out;	/* Something got screwed up here */
 		sig = isonum_721(chr);
 		chr += rr->len;
 		len -= rr->len;
+		if (len < 0)
+			goto out;	/* corrupted isofs */
 
 		switch (sig) {
 		case SIG('R', 'R'):
@@ -543,6 +553,7 @@
       fail:
 	brelse(bh);
 	unlock_kernel();
+      error:
 	SetPageError(page);
 	kunmap(page);
 	unlock_page(page);
diff -Nru a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
--- a/net/bluetooth/af_bluetooth.c	2005-03-25 18:26:00 -08:00
+++ b/net/bluetooth/af_bluetooth.c	2005-03-25 18:26:00 -08:00
@@ -64,7 +64,7 @@
 
 int bt_sock_register(int proto, struct net_proto_family *ops)
 {
-	if (proto >= BT_MAX_PROTO)
+	if (proto < 0 || proto >= BT_MAX_PROTO)
 		return -EINVAL;
 
 	if (bt_proto[proto])
@@ -77,7 +77,7 @@
 
 int bt_sock_unregister(int proto)
 {
-	if (proto >= BT_MAX_PROTO)
+	if (proto < 0 || proto >= BT_MAX_PROTO)
 		return -EINVAL;
 
 	if (!bt_proto[proto])
@@ -92,7 +92,7 @@
 {
 	int err = 0;
 
-	if (proto >= BT_MAX_PROTO)
+	if (proto < 0 || proto >= BT_MAX_PROTO)
 		return -EINVAL;
 
 #if defined(CONFIG_KMOD)
