Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267230AbUH0Sro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267230AbUH0Sro (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 14:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267254AbUH0Srn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 14:47:43 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:39896 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267269AbUH0SqM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 14:46:12 -0400
Subject: Re: data loss in 2.6.9-rc1-mm1
From: Ram Pai <linuxram@us.ibm.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Gergely Tamas <dice@mfa.kfki.hu>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0408271448041.4725-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0408271448041.4725-100000@localhost.localdomain>
Content-Type: text/plain
Organization: 
Message-Id: <1093631420.11648.14.camel@dyn319181.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Aug 2004 11:30:20 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-27 at 06:56, Hugh Dickins wrote:
> On Fri, 27 Aug 2004, Denis Vlasenko wrote:
> > On Friday 27 August 2004 13:55, Gergely Tamas wrote:
> > >
> > > I've hit the following data loss problem under 2.6.9-rc1-mm1.
> > >
> > > If I copy data from a file to another the target will be smaller then
> > > the source file.
> > >
> > > 2.6.9-rc1 does not have this problem
> > > 2.6.8.1-mm4 does not have this problem
> > > 2.6.9-rc1-mm1 _does have_ this problem
> > 
> > I've seen some errors from KDE too. Let me do your test...
> > 
> > # dd if=/dev/zero of=testfile bs=$((1024*1024)) count=10
> > 10+0 records in
> > 10+0 records out
> > # cat testfile > testfile.1
> > # ls -l test*
> > -rw-r--r--    1 root     root     10485760 Aug 27 14:53 testfile
> > -rw-r--r--    1 root     root     10481664 Aug 27 14:53 testfile.1
> 
> Hmm, 2.6.9-rc1-mm1 looks like not a release to trust your (page
> size multiple) data to!  You should find the patch below fixes it
> (and, I hope, the issue the erroneous patches were trying to fix).


Hmm.. now I fail to understand how this code works.

assuming page size is 4096, if the size of the file is 4096, is the
end_index 0 or is it 1?
I had this assumption:  

	file size in bytes			end_index
	-----------------			---------
		1 to 4096			0
		4097 to 2*4096			1
		2*4096+1 to 3*4096		2
		...				..

or is the isize value reported by i_size_read(inode) one less than the
size of the real file?

What am I missing?
RP


> 
> Signed-off-by: Hugh Dickins <hugh@veritas.com>
> 
> --- 2.6.9-rc1-mm1/mm/filemap.c	2004-08-26 12:09:50.000000000 +0100
> +++ linux/mm/filemap.c	2004-08-27 14:35:32.113359872 +0100
> @@ -722,10 +722,7 @@ void do_generic_mapping_read(struct addr
>  	offset = *ppos & ~PAGE_CACHE_MASK;
>  
>  	isize = i_size_read(inode);
> -	if (!isize)
> -		goto out;
> -
> -	end_index = (isize - 1) >> PAGE_CACHE_SHIFT;
> +	end_index = isize >> PAGE_CACHE_SHIFT;
>  
>  	for (;;) {
>  		struct page *page;
> @@ -733,6 +730,11 @@ void do_generic_mapping_read(struct addr
>  
>  		if (index > end_index)
>  			goto out;
> +		if (index == end_index) {
> +			nr = isize & ~PAGE_CACHE_MASK;
> +			if (nr <= offset)
> +				goto out;
> +		}
>  
>  		cond_resched();
>  		page_cache_readahead(mapping, &ra, filp, index);
> @@ -831,8 +833,8 @@ readpage:
>  		 * another truncate extends the file - this is desired though).
>  		 */
>  		isize = i_size_read(inode);
> -		end_index = (isize - 1) >> PAGE_CACHE_SHIFT;
> -		if (unlikely(!isize || index > end_index)) {
> +		end_index = isize >> PAGE_CACHE_SHIFT;
> +		if (unlikely(index > end_index)) {
>  			page_cache_release(page);
>  			goto out;
>  		}
> 

