Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030497AbWEYWl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030497AbWEYWl0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 18:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030502AbWEYWl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 18:41:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40941 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030497AbWEYWlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 18:41:25 -0400
Date: Thu, 25 May 2006 15:40:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Cc: wfg@mail.ustc.edu.cn, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/33] readahead: refactor __do_page_cache_readahead()
Message-Id: <20060525154039.66f7d149.akpm@osdl.org>
In-Reply-To: <17526.12463.412158.700850@cargo.ozlabs.ibm.com>
References: <20060524111246.420010595@localhost.localdomain>
	<348469538.91213@ustc.edu.cn>
	<20060525093039.21b4246b.akpm@osdl.org>
	<17526.12463.412158.700850@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> wrote:
>
> Andrew Morton writes:
> 
> > Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
> > > @@ -302,6 +303,8 @@ __do_page_cache_readahead(struct address
> > >  			break;
> > >  		page->index = page_offset;
> > >  		list_add(&page->lru, &page_pool);
> > > +		if (page_idx == nr_to_read - lookahead_size)
> > > +			__SetPageReadahead(page);
> > >  		ret++;
> > >  	}
> > 
> > OK.  But the __SetPageFoo() things still give me the creeps.
> 
> I just hope that Wu Fengguang, or whoever is making these patches,
> realizes that on some architectures, doing __set_bit on one CPU
> concurrently with another CPU doing set_bit on a different bit in the
> same word can result in the second CPU's update getting lost...
> 

That's true even on x86.

Yes, this is understood - in this case he's following Nick's dubious lead
in leveraging our knowledge that no other code path will be attempting to
modify this page's flags at this time.  It's just been taken off the
freelist, it's not yet on the LRU and we own the only ref to it.

The only hole I was able to shoot in this is swsusp, which walks mem_map[]
fiddling with page flags.  But when it does this, only one CPU is running.

But I'm itching for an excuse to extirpate it all ;)
