Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316519AbSHJA5l>; Fri, 9 Aug 2002 20:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316503AbSHJA4K>; Fri, 9 Aug 2002 20:56:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20242 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316465AbSHJAzc>;
	Fri, 9 Aug 2002 20:55:32 -0400
Message-ID: <3D5464DB.933A017@zip.com.au>
Date: Fri, 09 Aug 2002 17:56:59 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [patch 5/12] copy_strings speedup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This is the first of three patches which reduce the amount of
kmap/kunmap traffic on highmem machines.

The workload which was tested was RAM-only dbench.  This is dominated
by copy_*_user() costs.

The three patches speed up my 4xPIII by 3%

The three patches speed up a 16P NUMA-Q by 100 to 150%

The first two patches (copy_strings and pagecache reads) speed up an
8-way by 15%.  I expect that all three patches will speed up the 8-way
by 40%.

Some of the benefit is from reduced pressure on kmap_lock.  Most of it
is from reducing the number of global TLB invalidations.


This patch fixes up copy_strings().  copy_strings does a huge amount of
kmapping.  Martin Bligh has noted that across a kernel compile this
function is the second or third largest user of kmaps in the kernel.

The fix is pretty simple: just hang onto the previous kmap as we we go
around the loop.  It reduces the number of kmappings from copy_strings
by a factor of 30.

This patch also applies to 2.4, and seems worthwhile there.



 exec.c |   60 +++++++++++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 43 insertions, 17 deletions

--- 2.5.30/fs/exec.c~copy_strings-speedup	Fri Aug  9 17:36:41 2002
+++ 2.5.30-akpm/fs/exec.c	Fri Aug  9 17:36:41 2002
@@ -185,25 +185,39 @@ static int count(char ** argv, int max)
  */
 int copy_strings(int argc,char ** argv, struct linux_binprm *bprm) 
 {
+	struct page *kmapped_page = NULL;
+	char *kaddr = NULL;
+	int ret;
+
 	while (argc-- > 0) {
 		char *str;
 		int len;
 		unsigned long pos;
 
-		if (get_user(str, argv+argc) || !(len = strnlen_user(str, bprm->p)))
-			return -EFAULT;
-		if (bprm->p < len) 
-			return -E2BIG; 
+		if (get_user(str, argv+argc) ||
+				!(len = strnlen_user(str, bprm->p))) {
+			ret = -EFAULT;
+			goto out;
+		}
+
+		if (bprm->p < len)  {
+			ret = -E2BIG;
+			goto out;
+		}
 
 		bprm->p -= len;
 		/* XXX: add architecture specific overflow check here. */ 
-
 		pos = bprm->p;
+
+		/*
+		 * The only sleeping function which we are allowed to call in
+		 * this loop is copy_from_user().  Otherwise, copy_user_state
+		 * could get trashed.
+		 */
 		while (len > 0) {
-			char *kaddr;
 			int i, new, err;
-			struct page *page;
 			int offset, bytes_to_copy;
+			struct page *page;
 
 			offset = pos % PAGE_SIZE;
 			i = pos/PAGE_SIZE;
@@ -212,32 +226,44 @@ int copy_strings(int argc,char ** argv, 
 			if (!page) {
 				page = alloc_page(GFP_HIGHUSER);
 				bprm->page[i] = page;
-				if (!page)
-					return -ENOMEM;
+				if (!page) {
+					ret = -ENOMEM;
+					goto out;
+				}
 				new = 1;
 			}
-			kaddr = kmap(page);
 
+			if (page != kmapped_page) {
+				if (kmapped_page)
+					kunmap(kmapped_page);
+				kmapped_page = page;
+				kaddr = kmap(kmapped_page);
+			}
 			if (new && offset)
 				memset(kaddr, 0, offset);
 			bytes_to_copy = PAGE_SIZE - offset;
 			if (bytes_to_copy > len) {
 				bytes_to_copy = len;
 				if (new)
-					memset(kaddr+offset+len, 0, PAGE_SIZE-offset-len);
+					memset(kaddr+offset+len, 0,
+						PAGE_SIZE-offset-len);
+			}
+			err = copy_from_user(kaddr+offset, str, bytes_to_copy);
+			if (err) {
+				ret = -EFAULT;
+				goto out;
 			}
-			err = copy_from_user(kaddr + offset, str, bytes_to_copy);
-			kunmap(page);
-
-			if (err)
-				return -EFAULT; 
 
 			pos += bytes_to_copy;
 			str += bytes_to_copy;
 			len -= bytes_to_copy;
 		}
 	}
-	return 0;
+	ret = 0;
+out:
+	if (kmapped_page)
+		kunmap(kmapped_page);
+	return ret;
 }
 
 /*

.
