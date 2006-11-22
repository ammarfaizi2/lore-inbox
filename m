Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756982AbWKVUJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756982AbWKVUJb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 15:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756983AbWKVUJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 15:09:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39913 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1756981AbWKVUJa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 15:09:30 -0500
Message-ID: <4564AE7A.6070607@redhat.com>
Date: Wed, 22 Nov 2006 14:09:30 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.8 (Macintosh/20061025)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] reject corrupt swapfiles earlier
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The fsfuzzer found this; with a corrupt small swapfile that claims to have
many pages:

[root]# file swap.741.img 
swap.741.img: Linux/i386 swap file (new style) 1 (4K pages) size 1040191487 pages
[root]# ls -l swap.741.img 
-rw-r--r-- 1 root root 16777216 Nov 22 05:18 swap.741.img

sys_swapon() will try to vmalloc all those pages, and -then- check to see if
the file is actually that large:

                if (!(p->swap_map = vmalloc(maxpages * sizeof(short)))) {
<snip>
        if (swapfilesize && maxpages > swapfilesize) {
                printk(KERN_WARNING
                       "Swap area shorter than signature indicates\n");

It seems to me that it would make more sense to move this test up before the
vmalloc, with the other checks, to avoid the OOM-killer in this situation...

Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Index: linux-2.6.18/mm/swapfile.c
===================================================================
--- linux-2.6.18.orig/mm/swapfile.c
+++ linux-2.6.18/mm/swapfile.c
@@ -1544,6 +1544,11 @@ asmlinkage long sys_swapon(const char __
 		error = -EINVAL;
 		if (!maxpages)
 			goto bad_swap;
+		if (swapfilesize && maxpages > swapfilesize) {
+			printk(KERN_WARNING
+			       "Swap area shorter than signature indicates\n");
+			goto bad_swap;
+		}
 		if (swap_header->info.nr_badpages && S_ISREG(inode->i_mode))
 			goto bad_swap;
 		if (swap_header->info.nr_badpages > MAX_SWAP_BADPAGES)
@@ -1571,12 +1576,6 @@ asmlinkage long sys_swapon(const char __
 			goto bad_swap;
 	}
 
-	if (swapfilesize && maxpages > swapfilesize) {
-		printk(KERN_WARNING
-		       "Swap area shorter than signature indicates\n");
-		error = -EINVAL;
-		goto bad_swap;
-	}
 	if (nr_good_pages) {
 		p->swap_map[0] = SWAP_MAP_BAD;
 		p->max = maxpages;

