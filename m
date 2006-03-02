Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWCBSZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWCBSZd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 13:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWCBSZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 13:25:33 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:23574 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S964791AbWCBSZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 13:25:32 -0500
Date: Thu, 2 Mar 2006 13:25:26 -0500
From: Jeff Mahoney <jeffm@suse.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: ReiserFS List <reiserfs-list@namesys.com>
Subject: [PATCH] reiserfs: fix unaligned bitmap usage
Message-ID: <20060302182525.GA9558@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.201-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 The bitmaps associated with generation numbers for directory entries
 are declared as an array of ints. On some platforms, this causes alignment
 exceptions.

 The following patch uses the standard bitmap declaration macros to
 declare the bitmaps, fixing the problem.

 Originally from Takashi Iwai.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Jeff Mahoney <jeffm@suse.com>

--- linux-2.6.15/fs/reiserfs/namei.c	2006-02-14 18:57:32.000000000 +0100
+++ linux-2.6.15/fs/reiserfs/namei.c	2006-02-14 18:58:24.000000000 +0100
@@ -247,7 +247,7 @@ static int linear_search_in_dir_item(str
 		/* mark, that this generation number is used */
 		if (de->de_gen_number_bit_string)
 			set_bit(GET_GENERATION_NUMBER(deh_offset(deh)),
-				(unsigned long *)de->de_gen_number_bit_string);
+				de->de_gen_number_bit_string);
 
 		// calculate pointer to name and namelen
 		de->de_entry_num = i;
@@ -431,7 +431,7 @@ static int reiserfs_add_entry(struct rei
 	struct reiserfs_de_head *deh;
 	INITIALIZE_PATH(path);
 	struct reiserfs_dir_entry de;
-	int bit_string[MAX_GENERATION_NUMBER / (sizeof(int) * 8) + 1];
+	DECLARE_BITMAP(bit_string, MAX_GENERATION_NUMBER + 1);
 	int gen_number;
 	char small_buf[32 + DEH_SIZE];	/* 48 bytes now and we avoid kmalloc
 					   if we create file with short name */
@@ -486,7 +486,7 @@ static int reiserfs_add_entry(struct rei
 
 	/* find the proper place for the new entry */
 	memset(bit_string, 0, sizeof(bit_string));
-	de.de_gen_number_bit_string = (char *)bit_string;
+	de.de_gen_number_bit_string = bit_string;
 	retval = reiserfs_find_entry(dir, name, namelen, &path, &de);
 	if (retval != NAME_NOT_FOUND) {
 		if (buffer != small_buf)
@@ -508,7 +508,7 @@ static int reiserfs_add_entry(struct rei
 	}
 
 	gen_number =
-	    find_first_zero_bit((unsigned long *)bit_string,
+	    find_first_zero_bit(bit_string,
 				MAX_GENERATION_NUMBER + 1);
 	if (gen_number > MAX_GENERATION_NUMBER) {
 		/* there is no free generation number */
--- linux-2.6.15/include/linux/reiserfs_fs.h	2006-02-14 18:57:10.000000000 +0100
+++ linux-2.6.15/include/linux/reiserfs_fs.h	2006-02-14 18:57:22.000000000 +0100
@@ -1052,7 +1052,7 @@ struct reiserfs_dir_entry {
 	int de_entrylen;
 	int de_namelen;
 	char *de_name;
-	char *de_gen_number_bit_string;
+	unsigned long *de_gen_number_bit_string;
 
 	__u32 de_dir_id;
 	__u32 de_objectid;
-- 
Jeff Mahoney
SuSE Labs
