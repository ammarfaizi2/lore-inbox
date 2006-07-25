Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWGYTrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWGYTrz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 15:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWGYTrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 15:47:55 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:65032 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932121AbWGYTrz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 15:47:55 -0400
Date: Tue, 25 Jul 2006 15:47:33 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
       a.zummo@towertech.it, jg@freedesktop.org
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
Message-ID: <20060725194733.GJ4608@hmsreliant.homelinux.net>
References: <20060725174100.GA4608@hmsreliant.homelinux.net> <03BCDC7F-13D9-42FC-86FC-30C76FD3B3B8@kernel.crashing.org> <20060725182833.GE4608@hmsreliant.homelinux.net> <44C66C91.8090700@zytor.com> <20060725192138.GI4608@hmsreliant.homelinux.net> <F09D8005-BD93-4348-9FD1-0FA5D8D096F1@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F09D8005-BD93-4348-9FD1-0FA5D8D096F1@kernel.crashing.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 09:31:32PM +0200, Segher Boessenkool wrote:
> >>Not really.  This introduces a potentially very difficult support
> >>user-visible interface.  Consider a tickless kernel -- you might  
> >>end up
> >>taking tick interrupts ONLY to update this page, since you don't have
> >>any way of knowing when userspace wants to look at it.
> >>
> >Well, you do actually know when they want to look at it.  The rtc  
> >driver only
> >unmasks its interrupt when a user space process has opened the  
> >device and sent
> >it a RTC_UIE ON or RTC_PIE_ON (or other shuch ioctl).  So if you  
> >open /dev/rtc,
> >and memory map the page, but never enable a timer method, then  
> >every read of the
> >page returns zero.  The only overhead this patch is currently  
> >adding, execution
> >time-wise is the extra time it takes to write to a the shared page  
> >variable.  If
> >the timer tick interrupt is executing, its because someone is  
> >reading tick data,
> >or plans to very soon.
> 
> But userland cannot know if there is a more efficient option to
> use than this /dev/rtc way, without using VDSO/vsyscall.
> 
Sure, but detecting if /dev/rtc via mmap is faster than gettimeofday is an
orthogonal issue to having the choice in the first place.  I say let the X guys
write code to determine at run time what is more efficient to get their job
done.  I really just wanted to give them the ability to avoid making a million
kernel traps a second for those arches where a userspace gettimeofday is not
yet implemented, or cannot be implemented.  It won't cost anything to add this
feature, and if the Xorg people can write code to use gettimeofday if its faster
than mmaped /dev/rtc (or even configured to do so at compile-time).  This patch
doesn't create any interrupts that wouldn't be generated already anyway by any
user using /dev/rtc, and even if X doesn't already use /dev/rtc, the added
interrupts are in trade for an equally fewer number of kernel traps, which I
think has to be a net savings.

I'm not saying we shouldn't implement a vsyscall on more platforms to provide a
speedup for this problem (in fact I'm interested to learn how, since I hadn't
previously considered that as a possibility), but I think offering the choice is
a smart thing to do until the latter solution gets propogated to other
arches/platforms besides x86_64

Regards
Neil

 
> 
> Segher

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/
