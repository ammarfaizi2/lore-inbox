Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265456AbRF1AYc>; Wed, 27 Jun 2001 20:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265457AbRF1AYW>; Wed, 27 Jun 2001 20:24:22 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:64115 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S265456AbRF1AYK>; Wed, 27 Jun 2001 20:24:10 -0400
Date: Thu, 28 Jun 2001 01:23:49 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: NIIBE Yutaka <gniibe@m17n.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swapin flush cache bug
Message-ID: <20010628012349.L1554@redhat.com>
In-Reply-To: <200106270051.f5R0pkl19282@mule.m17n.org> <Pine.LNX.4.21.0106270710050.1291-100000@freak.distro.conectiva> <200106280007.f5S07qQ04446@mule.m17n.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200106280007.f5S07qQ04446@mule.m17n.org>; from gniibe@m17n.org on Thu, Jun 28, 2001 at 09:07:52AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 28, 2001 at 09:07:52AM +0900, NIIBE Yutaka wrote:
> Marcelo Tosatti wrote:
>  > I think Stephen C. Tweedie has some considerations about the cache
>  > flushing calls on do_swap_page().
> 
> Yup.  IIRC, he said that flushing cache at do_swap_page() (which I've
> tried at first) is not good, because it's the hot path and it causes
> another performance problem in apache or sendmail, where many
> processes share the pages in swap cache.
> 
> Then, the fix I sent yesterday is second try.  The flush is moved to
> I/O routine, instead of do_swap_page().

I really want somebody who has worked on weird caching architectures
to look at it too, but I don't see that the new code works well.
First, don't we want to do a flush_page_to_ram() *before* starting the
swap IO?  There's no point dma'ing the swap page to ram if old, dirty
cache data is then going to be written back on top of that.

Secondly, the flushing of icache/dcache only needs to be done by the
time we come to use the page, so can be performed any time, before or
after the IO.  We're not going to be accessing the page during IO so
if we flush first we won't risk having stale cache data by the time
the IO completes.

So, why not just do the flushing before the IO?  Adding an async trap
to flush the page after swap IO seems the wrong approach: this should
be possible to fix synchronously.

Cheers,
 Stephen
