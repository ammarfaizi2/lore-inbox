Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267961AbUH0VW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267961AbUH0VW4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 17:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267783AbUH0VSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 17:18:45 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:4823 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267726AbUH0VNa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 17:13:30 -0400
Subject: Re: data loss in 2.6.9-rc1-mm1
From: Ram Pai <linuxram@us.ibm.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Gergely Tamas <dice@mfa.kfki.hu>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0408271950460.8349-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0408271950460.8349-100000@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-jWR5bdSPLA9+dFhUwXCI"
Organization: 
Message-Id: <1093640668.11648.50.camel@dyn319181.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Aug 2004 14:04:29 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jWR5bdSPLA9+dFhUwXCI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2004-08-27 at 12:08, Hugh Dickins wrote:
> On 27 Aug 2004, Ram Pai wrote:
> > On Fri, 2004-08-27 at 06:56, Hugh Dickins wrote:
> > > 
> > > Hmm, 2.6.9-rc1-mm1 looks like not a release to trust your (page
> > > size multiple) data to!  You should find the patch below fixes it
> > > (and, I hope, the issue the erroneous patches were trying to fix).
> > 
> > Hmm.. now I fail to understand how this code works.
> > 
> > assuming page size is 4096, if the size of the file is 4096, is the
> > end_index 0 or is it 1?
> 
> Before your change and after mine, 1; with your change, 0.
> 
> > I had this assumption:  
> > 
> > 	file size in bytes			end_index
> > 	-----------------			---------
> > 		1 to 4096			0
> > 		4097 to 2*4096			1
> > 		2*4096+1 to 3*4096		2
> > 		...				..
> 
> Well, that's what you changed it to, when you patched from the original
> 		end_index = isize >> PAGE_CACHE_SHIFT;
> to		end_index = (isize - 1) >> PAGE_CACHE_SHIFT;
> 
> But the "nr <= offset" check(s) relies on the original convention:
> 		0 to 4095			0
> 		4096 to 8191			1
> 		...				..
> 
> > or is the isize value reported by i_size_read(inode) one less than the
> > size of the real file?
> 
> No!
> 
> > What am I missing?
> 
> You're expecting end_index to be the index of the last (possibly
> incomplete) page of the file.  And that might be a reasonable way
> of working it (though the special case of an empty file hints not).
> But the nr,offset checks (I say checks because I added another like
> the one further down, hopefully to fix the extra readahead issue)
> require the original convention.  Just try it out with numbers.

got it!  Everything got changed to the new convention except that
the calculation of 'nr' just before the check "nr <= offset" .

I have generated this patch which takes care of that and hence fixes the
data loss problem as well. I guess it is cleaner too. 

This patch is generated w.r.t 2.6.8.1. If everybody blesses this patch I
will forward it to Andrew.

RP


> 
> Hugh
> 

--=-jWR5bdSPLA9+dFhUwXCI
Content-Disposition: attachment; filename=pagecache_out_of_indx_access_attempt3.patch
Content-Type: text/plain; name=pagecache_out_of_indx_access_attempt3.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- ram/linux-2.6.8.1/mm/filemap.c	2004-08-14 03:56:25.000000000 -0700
+++ linux-2.6.8.1/mm/filemap.c	2004-08-27 13:43:00.000000000 -0700
@@ -665,14 +665,18 @@ void do_generic_mapping_read(struct addr
 	offset = *ppos & ~PAGE_CACHE_MASK;
 
 	isize = i_size_read(inode);
-	end_index = isize >> PAGE_CACHE_SHIFT;
-	if (index > end_index)
+	if (!isize)
 		goto out;
 
+	end_index = (isize - 1) >> PAGE_CACHE_SHIFT;
+
 	for (;;) {
 		struct page *page;
 		unsigned long nr, ret;
 
+		if (index > end_index)
+			goto out;
+
 		cond_resched();
 		page_cache_readahead(mapping, &ra, filp, index);
 
@@ -688,7 +692,8 @@ page_ok:
 		/* nr is the maximum number of bytes to copy from this page */
 		nr = PAGE_CACHE_SIZE;
 		if (index == end_index) {
-			nr = isize & ~PAGE_CACHE_MASK;
+			BUG_ON(isize==0);
+			nr = ((isize - 1) & ~PAGE_CACHE_MASK) + 1;
 			if (nr <= offset) {
 				page_cache_release(page);
 				goto out;
@@ -770,8 +775,8 @@ readpage:
 		 * another truncate extends the file - this is desired though).
 		 */
 		isize = i_size_read(inode);
-		end_index = isize >> PAGE_CACHE_SHIFT;
-		if (index > end_index) {
+		end_index = (isize - 1) >> PAGE_CACHE_SHIFT;
+		if (unlikely(!isize || index > end_index)) {
 			page_cache_release(page);
 			goto out;
 		}

--=-jWR5bdSPLA9+dFhUwXCI--

