Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129529AbQKWEUn>; Wed, 22 Nov 2000 23:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132242AbQKWEUd>; Wed, 22 Nov 2000 23:20:33 -0500
Received: from hera.cwi.nl ([192.16.191.1]:3047 "EHLO hera.cwi.nl")
        by vger.kernel.org with ESMTP id <S129529AbQKWEU3>;
        Wed, 22 Nov 2000 23:20:29 -0500
Date: Thu, 23 Nov 2000 04:50:22 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200011230350.EAA138908.aeb@aak.cwi.nl>
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: {PATCH} isofs stuff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After Linus' recent changes there were many complaints
about bugs in the isofs handling. Still, his code is fine.
I know about some things that still need to be done, and
already corrected two flaws yesterday or so, but people
sent me their isofs images and their problem was not caused
by anything I knew about, and behaved like a Heisenbug.

I never read assembler, but looking at the code produced
by gcc (2.95.2) it seemed peculiar, maybe an attempt to
optimize something combining the
	if (filp->f_pos >= inode->i_size)
with the
	while (filp->f_pos < inode->i_size)
slightly later.
After removal of the superfluous test
	if (filp->f_pos >= inode->i_size)
		return 0;
all suddenly worked well.

Below a working patch for which the isofs images I got
all are OK. (There is still a lot of silliness here -
superfluous parentheses, a rename of isofs_cmp to isofs_comp
in one file to avoid confusion with the isofs_cmp in another file..)

I have seen that there were discussions on the right compiler to use.
Is 2.95.2 wrong? Have other things to do tomorrow, so it will be
24 hours before I can look at this again.
Note: this is not yet a confirmed compiler bug - would have to check
more details. But after the indicated change all works for me.
Hope that the same is true for the people reporting problems.

Andries



diff -r -u linux-2.4.0-test11/linux/fs/isofs/dir.c linux-2.4.0-test11a/linux/fs/isofs/dir.c
--- linux-2.4.0-test11/linux/fs/isofs/dir.c	Wed Nov 22 16:39:32 2000
+++ linux-2.4.0-test11a/linux/fs/isofs/dir.c	Thu Nov 23 04:07:56 2000
@@ -115,11 +115,8 @@
 	char *p = NULL;		/* Quiet GCC */
 	struct iso_directory_record *de;
 
- 	if (filp->f_pos >= inode->i_size)
-		return 0;
- 
-	offset = filp->f_pos & (bufsize - 1);
-	block = filp->f_pos >> bufbits;
+	offset = (filp->f_pos & (bufsize - 1));
+	block = (filp->f_pos >> bufbits);
 	high_sierra = inode->i_sb->u.isofs_sb.s_high_sierra;
 
 	while (filp->f_pos < inode->i_size) {
@@ -132,7 +129,8 @@
 		}
 
 		de = (struct iso_directory_record *) (bh->b_data + offset);
-		if (first_de) inode_number = (bh->b_blocknr << bufbits) + offset;
+		if (first_de)
+			inode_number = (bh->b_blocknr << bufbits) + offset;
 
 		de_len = *(unsigned char *) de;
 
@@ -207,7 +205,7 @@
 		map = 1;
 		if (inode->i_sb->u.isofs_sb.s_rock) {
 			len = get_rock_ridge_filename(de, tmpname, inode);
-			if (len != 0) {
+			if (len != 0) {		/* may be -1 */
 				p = tmpname;
 				map = 0;
 			}
diff -r -u linux-2.4.0-test11/linux/fs/isofs/inode.c linux-2.4.0-test11a/linux/fs/isofs/inode.c
--- linux-2.4.0-test11/linux/fs/isofs/inode.c	Wed Nov 22 16:39:32 2000
+++ linux-2.4.0-test11a/linux/fs/isofs/inode.c	Thu Nov 23 02:15:46 2000
@@ -45,14 +45,14 @@
 
 static int isofs_hashi(struct dentry *parent, struct qstr *qstr);
 static int isofs_hash(struct dentry *parent, struct qstr *qstr);
-static int isofs_cmpi(struct dentry *dentry, struct qstr *a, struct qstr *b);
-static int isofs_cmp(struct dentry *dentry, struct qstr *a, struct qstr *b);
+static int isofs_compi(struct dentry *dentry, struct qstr *a, struct qstr *b);
+static int isofs_comp(struct dentry *dentry, struct qstr *a, struct qstr *b);
 
 #ifdef CONFIG_JOLIET
 static int isofs_hashi_ms(struct dentry *parent, struct qstr *qstr);
 static int isofs_hash_ms(struct dentry *parent, struct qstr *qstr);
-static int isofs_cmpi_ms(struct dentry *dentry, struct qstr *a, struct qstr *b);
-static int isofs_cmp_ms(struct dentry *dentry, struct qstr *a, struct qstr *b);
+static int isofs_compi_ms(struct dentry *dentry, struct qstr *a, struct qstr *b);
+static int isofs_comp_ms(struct dentry *dentry, struct qstr *a, struct qstr *b);
 #endif
 
 static void isofs_put_super(struct super_block *sb)
@@ -84,20 +84,20 @@
 static struct dentry_operations isofs_dentry_ops[] = {
 	{
 		d_hash:		isofs_hash,
-		d_compare:	isofs_cmp,
+		d_compare:	isofs_comp,
 	},
 	{
 		d_hash:		isofs_hashi,
-		d_compare:	isofs_cmpi,
+		d_compare:	isofs_compi,
 	},
 #ifdef CONFIG_JOLIET
 	{
 		d_hash:		isofs_hash_ms,
-		d_compare:	isofs_cmp_ms,
+		d_compare:	isofs_comp_ms,
 	},
 	{
 		d_hash:		isofs_hashi_ms,
-		d_compare:	isofs_cmpi_ms,
+		d_compare:	isofs_compi_ms,
 	}
 #endif
 };
@@ -173,7 +173,7 @@
  * Case insensitive compare of two isofs names.
  */
 static int
-isofs_cmpi_common(struct dentry *dentry,struct qstr *a,struct qstr *b,int ms)
+isofs_compi_common(struct dentry *dentry,struct qstr *a,struct qstr *b,int ms)
 {
 	int alen, blen;
 
@@ -197,7 +197,7 @@
  * Case sensitive compare of two isofs names.
  */
 static int
-isofs_cmp_common(struct dentry *dentry,struct qstr *a,struct qstr *b,int ms)
+isofs_comp_common(struct dentry *dentry,struct qstr *a,struct qstr *b,int ms)
 {
 	int alen, blen;
 
@@ -230,15 +230,15 @@
 }
 
 static int
-isofs_cmp(struct dentry *dentry,struct qstr *a,struct qstr *b)
+isofs_comp(struct dentry *dentry,struct qstr *a,struct qstr *b)
 {
-	return isofs_cmp_common(dentry, a, b, 0);
+	return isofs_comp_common(dentry, a, b, 0);
 }
 
 static int
-isofs_cmpi(struct dentry *dentry,struct qstr *a,struct qstr *b)
+isofs_compi(struct dentry *dentry,struct qstr *a,struct qstr *b)
 {
-	return isofs_cmpi_common(dentry, a, b, 0);
+	return isofs_compi_common(dentry, a, b, 0);
 }
 
 #ifdef CONFIG_JOLIET
@@ -255,15 +255,15 @@
 }
 
 static int
-isofs_cmp_ms(struct dentry *dentry,struct qstr *a,struct qstr *b)
+isofs_comp_ms(struct dentry *dentry,struct qstr *a,struct qstr *b)
 {
-	return isofs_cmp_common(dentry, a, b, 1);
+	return isofs_comp_common(dentry, a, b, 1);
 }
 
 static int
-isofs_cmpi_ms(struct dentry *dentry,struct qstr *a,struct qstr *b)
+isofs_compi_ms(struct dentry *dentry,struct qstr *a,struct qstr *b)
 {
-	return isofs_cmpi_common(dentry, a, b, 1);
+	return isofs_compi_common(dentry, a, b, 1);
 }
 #endif
 
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
@@ -605,9 +603,8 @@
 	pri_bh = NULL;
 
 root_found:
-	brelse(pri_bh);
 
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
@@ -873,7 +871,7 @@
 /* Life is simpler than for other filesystem since we never
  * have to create a new block, only find an existing one.
  */
-int isofs_get_block(struct inode *inode, long iblock,
+static int isofs_get_block(struct inode *inode, long iblock,
 		    struct buffer_head *bh_result, int create)
 {
 	unsigned long b_off;
diff -r -u linux-2.4.0-test11/linux/fs/isofs/namei.c linux-2.4.0-test11a/linux/fs/isofs/namei.c
--- linux-2.4.0-test11/linux/fs/isofs/namei.c	Wed Nov 22 16:39:32 2000
+++ linux-2.4.0-test11a/linux/fs/isofs/namei.c	Thu Nov 23 00:42:11 2000
@@ -123,7 +123,7 @@
 
 		if (dir->i_sb->u.isofs_sb.s_rock &&
 		    ((i = get_rock_ridge_filename(de, tmpname, dir)))) {
-			dlen = i;
+			dlen = i; 	/* possibly -1 */
 			dpnt = tmpname;
 #ifdef CONFIG_JOLIET
 		} else if (dir->i_sb->u.isofs_sb.s_joliet_level) {
@@ -142,8 +142,9 @@
 		 * Skip hidden or associated files unless unhide is set 
 		 */
 		match = 0;
-		if ((!(de->flags[-dir->i_sb->u.isofs_sb.s_high_sierra] & 5)
-		    || dir->i_sb->u.isofs_sb.s_unhide == 'y') && dlen)
+		if (dlen > 0 &&
+		    (!(de->flags[-dir->i_sb->u.isofs_sb.s_high_sierra] & 5)
+		     || dir->i_sb->u.isofs_sb.s_unhide == 'y'))
 		{
 			match = (isofs_cmp(dentry,dpnt,dlen) == 0);
 		}
diff -r -u linux-2.4.0-test11/linux/fs/isofs/rock.c linux-2.4.0-test11a/linux/fs/isofs/rock.c
--- linux-2.4.0-test11/linux/fs/isofs/rock.c	Wed Nov 22 16:39:32 2000
+++ linux-2.4.0-test11a/linux/fs/isofs/rock.c	Thu Nov 23 00:38:58 2000
@@ -152,6 +152,7 @@
   return retval;
 }
 
+/* return length of name field; 0: not found, -1: to be ignored */
 int get_rock_ridge_filename(struct iso_directory_record * de,
 			    char * retname, struct inode * inode)
 {
@@ -215,7 +216,7 @@
 	printk("RR: RE (%x)\n", inode->i_ino);
 #endif
 	if (buffer) kfree(buffer);
-	return 0;
+	return -1;
       default:
 	break;
       }
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
