Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266627AbSLJGBS>; Tue, 10 Dec 2002 01:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266631AbSLJGBS>; Tue, 10 Dec 2002 01:01:18 -0500
Received: from smtp.sw.oz.au ([203.31.96.1]:12816 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id <S266627AbSLJGBE>;
	Tue, 10 Dec 2002 01:01:04 -0500
Date: Tue, 10 Dec 2002 17:08:41 +1100
From: Kingsley Cheung <kingsley@aurema.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [TRIVIAL PATCH 2.4.20] madvise_willneed makes bad limit comparison
Message-ID: <20021210170841.D8843@aurema.com>
References: <20021209150426.D12270@aurema.com> <3DF43855.19F24E73@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DF43855.19F24E73@digeo.com>; from akpm@digeo.com on Sun, Dec 08, 2002 at 10:29:41PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 08, 2002 at 10:29:41PM -0800, Andrew Morton wrote:
>
> It's surely a bug, but looking at the code, one does ask "what
> on earth is it trying to do"?
> 

Thanks for that Andrew.  Yisshhhh.  I merely took the bug at face
value.  This is not as trivial as I first thought.

> 1) -EIO is not a recognised (or appropriate) return value.
> 

Aye, I overlooked that.

> 2) If the MADV_WILLNEED call fails, all the user needs to do is to
>    use a smaller chunk, and walk across the file using that chunk
>    size!  The only system-protecting limit here is the request queue
>    size.
> 
> 3) We don't know that the application will try to map all that readahead
>    at the same time anyway.  And if it does, the rlimits will catch it.
> 

Yes.  Though currently there is no enforcement for RLIMIT_RSS
implemented.  I guess when its there it will catch it when the process
starts faulting on those pages.

> Linus used "half the size of the inactive list" in sys_readahead. That's
> probably as good as anything else.  I'd suggest that we just share
> that bit of code in madvise.
> 

<snip>

> I agree that failing with an error is inappropriate.
> 
> We should limit the readahead according to machine size, disk bandwidth,
> free memory availability, shoe size, etc.  And once that's done then
> it _has_ to return success.  Otherwise the application would see
> different results depending on system size and activity.
> 
> It is just "advice".

So then something of the following without the check is more
appropriate or a starting point then?


diff -urN linux-2.4.20/mm/filemap.c linux-2.4.20patched/mm/filemap.c
--- linux-2.4.20/mm/filemap.c   Mon Dec  9 14:19:13 2002
+++ linux-2.4.20patched/mm/filemap.c    Tue Dec 10 15:30:05 2002
@@ -2455,7 +2455,7 @@
 {
        long error = -EBADF;
        struct file * file;
-       unsigned long size, rlim_rss;
+       unsigned long size, max;
 
        /* Doesn't work if there's no mapped file. */
        if (!vma->vm_file)
@@ -2469,12 +2469,10 @@
                end = vma->vm_end;
        end = ((end - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
 
-       /* Make sure this doesn't exceed the process's max rss. */
-       error = -EIO;
-       rlim_rss = current->rlim ?  current->rlim[RLIMIT_RSS].rlim_cur :
-                               LONG_MAX; /* default: see resource.h */
-       if ((vma->vm_mm->rss + (end - start)) > rlim_rss)
-               return error;
+       /* Like sys_readahead, limit to a sane percentage of inactive list.. */
+       max = nr_inactive_pages / 2;
+       if ((end - start) > max)
+               end = start + max;
 
        /* round to cluster boundaries if this isn't a "random" area. */
        if (!VM_RandomReadHint(vma)) {


-- 
		Kingsley
