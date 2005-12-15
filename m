Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbVLORnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbVLORnY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 12:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbVLORnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 12:43:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40099 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750833AbVLORnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 12:43:23 -0500
Date: Thu, 15 Dec 2005 09:42:48 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Coywolf Qi Hunt <qiyong@fc-cn.com>
cc: willy@debian.org, arnd@arndb.de, akpm@osdl.org,
       linux-kernel@vger.kernel.org, debian-glibc@lists.debian.org
Subject: Re: [patch] ioctl BLKGETSIZE64 fix
In-Reply-To: <20051215122527.GA7762@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0512150936030.3292@g5.osdl.org>
References: <20051215122527.GA7762@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 15 Dec 2005, Coywolf Qi Hunt wrote:
> 
> Two years ago, "[PATCH] use size_t for the broken ioctl numbers" brought in the problem.
> <http://lkml.org/lkml/2003/9/7/14> (also FYI: <https://lwn.net/Articles/48360/>)
> 
> The patch below fixes the bug on BLKGETSIZE64. typeof(size_t) == 32, but we expect 64. 
> The choice of `size_t' is also a mistake. We should have taken `int'.  This also affects
> userland linux-kernel-headers.
> 
> Or am I missing something? Thanks.

You're missing the fact that we can't just change existing numbers. It 
just makes the ioctl not work.

A lot of the "size_t"'s got added because people had mis-understood the 
_IOR/W macros, and had done a "sizeof()" by hand, when the macro itself 
did the sizeof. Which caused the macro to make the ioctl number be based 
on "sizeof(sizeof(realsize))", which is the same as "sizeof(size_t)".

And because we MUST NOT change the ioctl number (regardless of whether the 
number shows the correct size or not), those got changed to use "size_t" 
to match historical - if incorrect - numbering.

The _IOR/W macros got fixed so that you now _cannot_ use anything but a 
real type, so the bug shouldn't happen again, but we're stuck with the old 
broken numbers.

The number is just a number, after all. We shouldn't be using the size 
encoding in the ioctl number, afaik (since for a _lot_ of them we can't 
depend on it anyway).

		Linus
