Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030247AbWILVF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbWILVF7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 17:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030270AbWILVF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 17:05:59 -0400
Received: from waste.org ([66.93.16.53]:19608 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030247AbWILVF6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 17:05:58 -0400
Date: Tue, 12 Sep 2006 16:04:25 -0500
From: Matt Mackall <mpm@selenic.com>
To: David Howells <dhowells@redhat.com>
Cc: Aubrey <aubreylee@gmail.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org, davidm@snapgear.com, gerg@snapgear.com
Subject: Re: kernel BUGs when removing largish files with the SLOB allocator
Message-ID: <20060912210425.GG19707@waste.org>
References: <20060912174339.GA19707@waste.org> <6d6a94c50609032356t47950e40lbf77f15136e67bc5@mail.gmail.com> <17162.1157365295@warthog.cambridge.redhat.com> <6d6a94c50609042052n4c1803eey4f4412f6153c4a2b@mail.gmail.com> <3551.1157448903@warthog.cambridge.redhat.com> <6d6a94c50609051935m607f976j942263dd1ac9c4fb@mail.gmail.com> <44FE4222.3080106@yahoo.com.au> <6d6a94c50609120107w1942a8d8j368dd57a271d0250@mail.gmail.com> <15193.1158088232@warthog.cambridge.redhat.com> <6495.1158094606@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6495.1158094606@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 09:56:46PM +0100, David Howells wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> 
> > > > You just broke the bit that shrinks the arena.
> > > 
> > > How?  This is only called once when things are being initialised.  There can
> > > be no SLOB objects allocated prior to that point.
> > 
> > It's on a timer.
> 
> So what then?  The timer is still initialised:
> 
> 	void kmem_cache_init(void)
> 	{
> 	+#if 0
> 		void *p = slob_alloc(PAGE_SIZE, 0, PAGE_SIZE-1);
> 
> 		if (p)
> 			free_page((unsigned long)p);
> 	+#endif
> 
> 		mod_timer(&slob_timer, jiffies + HZ);
> 	}

"allocate a page from the slob arena"
"if successful, release it to the page allocator"
"re-arm timer"

The only tricky part is the timer points back to _this very function_.

-- 
Mathematics is the supreme nostalgia of our time.
