Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265086AbUH0N5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265086AbUH0N5Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 09:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265053AbUH0N5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 09:57:24 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:12234 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S265086AbUH0N4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 09:56:31 -0400
Date: Fri, 27 Aug 2004 14:56:20 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Gergely Tamas <dice@mfa.kfki.hu>
cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Andrew Morton <akpm@osdl.org>, Ram Pai <linuxram@us.ibm.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: data loss in 2.6.9-rc1-mm1
In-Reply-To: <200408271455.03733.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.44.0408271448041.4725-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2004, Denis Vlasenko wrote:
> On Friday 27 August 2004 13:55, Gergely Tamas wrote:
> >
> > I've hit the following data loss problem under 2.6.9-rc1-mm1.
> >
> > If I copy data from a file to another the target will be smaller then
> > the source file.
> >
> > 2.6.9-rc1 does not have this problem
> > 2.6.8.1-mm4 does not have this problem
> > 2.6.9-rc1-mm1 _does have_ this problem
> 
> I've seen some errors from KDE too. Let me do your test...
> 
> # dd if=/dev/zero of=testfile bs=$((1024*1024)) count=10
> 10+0 records in
> 10+0 records out
> # cat testfile > testfile.1
> # ls -l test*
> -rw-r--r--    1 root     root     10485760 Aug 27 14:53 testfile
> -rw-r--r--    1 root     root     10481664 Aug 27 14:53 testfile.1

Hmm, 2.6.9-rc1-mm1 looks like not a release to trust your (page
size multiple) data to!  You should find the patch below fixes it
(and, I hope, the issue the erroneous patches were trying to fix).

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.9-rc1-mm1/mm/filemap.c	2004-08-26 12:09:50.000000000 +0100
+++ linux/mm/filemap.c	2004-08-27 14:35:32.113359872 +0100
@@ -722,10 +722,7 @@ void do_generic_mapping_read(struct addr
 	offset = *ppos & ~PAGE_CACHE_MASK;
 
 	isize = i_size_read(inode);
-	if (!isize)
-		goto out;
-
-	end_index = (isize - 1) >> PAGE_CACHE_SHIFT;
+	end_index = isize >> PAGE_CACHE_SHIFT;
 
 	for (;;) {
 		struct page *page;
@@ -733,6 +730,11 @@ void do_generic_mapping_read(struct addr
 
 		if (index > end_index)
 			goto out;
+		if (index == end_index) {
+			nr = isize & ~PAGE_CACHE_MASK;
+			if (nr <= offset)
+				goto out;
+		}
 
 		cond_resched();
 		page_cache_readahead(mapping, &ra, filp, index);
@@ -831,8 +833,8 @@ readpage:
 		 * another truncate extends the file - this is desired though).
 		 */
 		isize = i_size_read(inode);
-		end_index = (isize - 1) >> PAGE_CACHE_SHIFT;
-		if (unlikely(!isize || index > end_index)) {
+		end_index = isize >> PAGE_CACHE_SHIFT;
+		if (unlikely(index > end_index)) {
 			page_cache_release(page);
 			goto out;
 		}

