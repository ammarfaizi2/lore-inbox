Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751501AbWJEG2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbWJEG2j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 02:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbWJEG2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 02:28:38 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:48484 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751501AbWJEG2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 02:28:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=l5lfaNdkbE4t1l4UH/BjsOqbXo2zfTXg95MmeRLcnMWt6KdzH7xsQN5SW/t/nDxF1l4ZkPCTDJfNywnHpUXkp7K+9uhK0yQVUAVItzkA9FEVhg5wtWIAEDEO/e2YvyXvI62IpX9kWNFmHddb2Iy8XiYWQSLBHTpy7trHGgGR8C0=  ;
Message-ID: <4524A620.8020801@yahoo.com.au>
Date: Thu, 05 Oct 2006 16:28:48 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andre Noll <maan@systemlinux.org>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, andrea@suse.de,
       riel@redhat.com
Subject: Re: 2.6.18: Kernel BUG at mm/rmap.c:522
References: <20061004104018.GB22487@skl-net.de> <4523BE45.5050205@yahoo.com.au> <20061004154227.GD22487@skl-net.de> <1159976940.27331.0.camel@twins> <20061004203935.GB32161@redhat.com>
In-Reply-To: <20061004203935.GB32161@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Wed, Oct 04, 2006 at 05:49:00PM +0200, Peter Zijlstra wrote:
> 
>  > > > It is also nice if we can work out where the page actually came from. The
>  > > > following attached patch should help out a bit with that, if you could
>  > > > run with it?
>  > > Okay. I'll reboot with your patch and let you know if it crashes again.
>  > enable CONFIG_DEBUG_VM to get that.
> 
> Given this warnings still pops up from time to time, I question whether
> putting that check under DEBUG_VM was such a good idea.  It's not as
> if it's a major performance impact.  This has potential for us to lose
> valuable debugging info for a few nanoseconds performance increase in
> an already costly path.

Frustratingly, it usually doesn't tell us much (without my previous
patch), because it is normally some driver that has stuffed up their
refcounting and the page-> fields don't tell us where the page has
come from.

But..

> This patch brings it back unconditionally, and moves the BUG()
> into the if arm.

... this shouldn't hurt if gcc moves the unlikely code out of the
linear instruction stream, which I think it usually does. It shouldn't
cost _anything_ because we're already doing the branch for the BUG_ON
which you remove.

> Signed-off-by: Dave Jones <davej@redhat.com>

Thanks,
Acked-by: Nick Piggin <npiggin@suse.de>

> 
> --- local-git/mm/rmap.c~	2006-10-04 16:38:06.000000000 -0400
> +++ local-git/mm/rmap.c	2006-10-04 16:38:24.000000000 -0400
> @@ -576,15 +576,14 @@ void page_add_file_rmap(struct page *pag
>  void page_remove_rmap(struct page *page)
>  {
>  	if (atomic_add_negative(-1, &page->_mapcount)) {
> -#ifdef CONFIG_DEBUG_VM
>  		if (unlikely(page_mapcount(page) < 0)) {
>  			printk (KERN_EMERG "Eeek! page_mapcount(page) went negative! (%d)\n", page_mapcount(page));
>  			printk (KERN_EMERG "  page->flags = %lx\n", page->flags);
>  			printk (KERN_EMERG "  page->count = %x\n", page_count(page));
>  			printk (KERN_EMERG "  page->mapping = %p\n", page->mapping);
> +			BUG();
>  		}
> -#endif
> -		BUG_ON(page_mapcount(page) < 0);
> +
>  		/*
>  		 * It would be tidy to reset the PageAnon mapping here,
>  		 * but that might overwrite a racing page_add_anon_rmap


-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
