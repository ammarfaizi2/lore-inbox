Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131209AbRCGVu1>; Wed, 7 Mar 2001 16:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131210AbRCGVuR>; Wed, 7 Mar 2001 16:50:17 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:57349 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S131209AbRCGVuJ>;
	Wed, 7 Mar 2001 16:50:09 -0500
Date: Wed, 7 Mar 2001 22:49:00 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: [PATCH] ncpfs: d_add + ncp_d_validate fixes
Message-ID: <20010307224900.A1907@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, hi Alan,
  could you apply following patch into 2.4.2-ac14 and 2.4.3-pre4?
It does:

   last three hunks: do not d_add() already hashed dentry.
                     It is fix for problem discovered by Urban
                     in his smbfs. Probably it is more utilized
                     than ncpfs...
   rest: moved test for dentry->d_parent != parent before
                     call to d_validate(), instead of doing
                     it in caller after ncp_d_validate() returns.
                     Al Viro asked for this some time ago, but
                     it somewhat did not found its way into 
                     mainstream kernel yet...
                     While I was on it, I changed ncp_d_validate
                     layout a bit to get shorter code.

				Thanks,
					Petr Vandrovec
					vandrove@vc.cvut.cz



--- linux/fs/ncpfs/dir.c	Fri Feb  9 20:29:44 2001
+++ linux/fs/ncpfs/dir.c	Wed Mar  7 22:40:12 2001
@@ -328,19 +328,18 @@
 
 /* most parts from nfsd_d_validate() */
 static int
-ncp_d_validate(struct dentry *dentry)
+ncp_d_validate(struct dentry *dentry, struct dentry* parent)
 {
 	unsigned long dent_addr = (unsigned long) dentry;
-	unsigned long min_addr = PAGE_OFFSET;
-	unsigned long align_mask = 0x0F;
+	const unsigned long min_addr = PAGE_OFFSET;
+	const unsigned long align_mask = 0x0F;
 	unsigned int len;
-	int valid = 0;
 
 	if (dent_addr < min_addr)
 		goto bad_addr;
 	if (dent_addr > (unsigned long)high_memory - sizeof(struct dentry))
 		goto bad_addr;
-	if ((dent_addr & ~align_mask) != dent_addr)
+	if (dent_addr & align_mask)
 		goto bad_align;
 	if ((!kern_addr_valid(dent_addr)) || (!kern_addr_valid(dent_addr -1 +
 						sizeof(struct dentry))))
@@ -351,20 +350,21 @@
 	len = dentry->d_name.len;
 	if (len > NCP_MAXPATHLEN)
 		goto out;
+	if (dentry->d_parent != parent)
+		goto out;
 	/*
 	 * Note: d_validate doesn't dereference the parent pointer ...
 	 * just combines it with the name hash to find the hash chain.
 	 */
-	valid = d_validate(dentry, dentry->d_parent, dentry->d_name.hash, len);
-out:
-	return valid;
+	return d_validate(dentry, dentry->d_parent, dentry->d_name.hash, len);
 
 bad_addr:
 	PRINTK("ncp_d_validate: invalid address %lx\n", dent_addr);
 	goto out;
 bad_align:
 	PRINTK("ncp_d_validate: unaligned address %lx\n", dent_addr);
-	goto out;
+out:
+	return 0;
 }
 
 static struct dentry *
@@ -373,9 +373,8 @@
 	struct dentry *dent = dentry;
 	struct list_head *next;
 
-	if (ncp_d_validate(dent)) {
-		if (dent->d_parent == parent &&
-		   (unsigned long)dent->d_fsdata == fpos) {
+	if (ncp_d_validate(dent, parent)) {
+		if ((unsigned long)dent->d_fsdata == fpos) {
 			if (!dent->d_inode) {
 				dput(dent);
 				dent = NULL;
@@ -580,6 +579,7 @@
 	struct ncp_cache_control ctl = *ctrl;
 	struct qstr qname;
 	int valid = 0;
+	int hashed = 0;
 	ino_t ino = 0;
 	__u8 __name[256];
 
@@ -602,9 +602,11 @@
 		newdent = d_alloc(dentry, &qname);
 		if (!newdent)
 			goto end_advance;
-	} else
+	} else {
+		hashed = 1;
 		memcpy((char *) newdent->d_name.name, qname.name,
 							newdent->d_name.len);
+	}
 
 	if (!newdent->d_inode) {
 		entry->opened = 0;
@@ -612,7 +614,9 @@
 		newino = ncp_iget(inode->i_sb, entry);
 		if (newino) {
 			newdent->d_op = &ncp_dentry_operations;
-			d_add(newdent, newino);
+			d_instantiate(newdent, newino);
+			if (!hashed)
+				d_rehash(newdent);
 		}
 	} else
 		ncp_update_inode2(newdent->d_inode, entry);
