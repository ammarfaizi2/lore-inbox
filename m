Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263937AbUACQvC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 11:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263946AbUACQvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 11:51:01 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:34834 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263937AbUACQu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 11:50:57 -0500
Date: Sat, 3 Jan 2004 17:50:51 +0100
From: Willy TARREAU <willy@w.ods.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Willy Tarreau <willy@w.ods.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] 2.6.0-tiny1 tree for small systems
Message-ID: <20040103165051.GA2290@pcw.home.local>
References: <20031227215606.GO18208@waste.org> <20031228103500.GA29298@alpha.home.local> <20040101014655.GD18208@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040101014655.GD18208@waste.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

On Wed, Dec 31, 2003 at 07:46:55PM -0600, Matt Mackall wrote:
> Ok, I added the ability to override the arch-default CFLAGS, but sadly
> I'm unable to reproduce your space savings here with gcc 3.3.2. The
> default -march=i586 seems to produce the smallest code for me.

Same results here. I was a bit stumped at first, but finally found the reason :
by changing CFLAGS, both you and me have implictly removed '-falign-functions=0',
which is what grows up the kernel image ! I really don't understand what happens
in the kernel, because on many other programs, i386 gives me smaller progs than
i586 for -Os optimization, and -falign-functions=0 is *always* smaller. In the
kernel, i386, i586 an c3 are identical, but -falign-functions=0 is bigger by
50 kB :

-Os -mpreferred-stack-boundary=2 -march=c3 -falign-functions=0 -falign-loops=0 -falign-jumps=0 :

   text    data     bss     dec     hex filename
1306682  111227   50896 1468805  166985 vmlinux


-Os -mpreferred-stack-boundary=2 -march=c3 -falign-loops=0 -falign-jumps=0 :

   text    data     bss     dec     hex filename
1256604  111227   50896 1418727  15a5e7 vmlinux

I have tested several values and found that the second compilation above is equivalent
to the default gcc setting of -falign-functions=1. And using 1 instead of 0 in
-falign-{loops,jumps,labels} makes not difference at all. So I would suggest
adding -falign-functions=1 everywhere.

BTW, I slightly changed your patch to be able to specify several options. I did
it the dirty way because I don't know how to split the string into several words :


--- ./arch/i386/Makefile	Sat Jan  3 15:10:26 2004
+++ a./rch/i386/Makefile	Sat Jan  3 15:43:12 2004
@@ -27,7 +27,7 @@
 align := $(subst -functions=0,,$(call check_gcc,-falign-functions=0,-malign-functions=0))
 
 ifdef CONFIG_TINY_CFLAGS
-cflags-y += $(CONFIG_TINY_CFLAGS_VAL)
+cflags-y += $(shell echo $(CONFIG_TINY_CFLAGS_VAL))
 else
 cflags-$(CONFIG_M386)		+= -march=i386
 cflags-$(CONFIG_M486)		+= -march=i486


Other than that, I've compiled 2.6.1-rc1-tiny1. It's slightly smaller than 2.6.0-tiny1
here. But I had to keep CONFIG_INETPEER=y, CONFIG_DNOTIFY=y, CONFIG_PTRACE=y,
and CONFIG_CPU_SUP_* otherwise it would not link. I can give you the error reports
and .config in case you're interested.

Cheers,
Willy

