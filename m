Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269290AbUJKWFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269290AbUJKWFk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 18:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269289AbUJKWFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 18:05:40 -0400
Received: from cantor.suse.de ([195.135.220.2]:11929 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269301AbUJKWFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 18:05:10 -0400
Date: Tue, 12 Oct 2004 00:05:08 +0200
From: Andi Kleen <ak@suse.de>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1 HPET compile problems on AMD64
Message-ID: <20041011220508.GD5461@wotan.suse.de>
References: <1097509362.12861.334.camel@dyn318077bld.beaverton.ibm.com> <20041011125421.106eff07.akpm@osdl.org> <1097526413.12861.374.camel@dyn318077bld.beaverton.ibm.com> <20041011212529.GB31731@wotan.suse.de> <1097530924.12861.392.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097530924.12861.392.camel@dyn318077bld.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 02:42:05PM -0700, Badari Pulavarty wrote:
> On Mon, 2004-10-11 at 14:25, Andi Kleen wrote:
> > On Mon, Oct 11, 2004 at 01:26:53PM -0700, Badari Pulavarty wrote:
> > > On Mon, 2004-10-11 at 12:54, Andrew Morton wrote:
> > > 
> > > > 
> > > > I assume you have CONFIG_HPET=n and CONFIG_HPET_TIMER=n?
> > > > 
> > > > Andi, what's going on here?  Should the hpet functions in
> > > > arch/x86_64/kernel/time.c be inside CONFIG_HPET_TIMER?
> > > 
> > > I haven't enable HPET, but autoconf.h gets 
> > > 
> > > # grep HPET autoconf.h
> > > #define CONFIG_HPET_TIMER 1
> > > #define CONFIG_HPET_EMULATE_RTC 1
> > > 
> > > # grep HPET .config
> > > # CONFIG_HPET is not set
> > 
> > It should be inside CONFIG_HPET. Badari's patch was correct.
> 
> make clean and oldconfig cleaned up little, but I still get
> following linking error (without my patch).
> 
> # grep HPET .config
> # CONFIG_HPET is not set
> 
> # grep HPET autoconf.h
> #undef CONFIG_HPET
> 
>   LD      .tmp_vmlinux1
> arch/x86_64/kernel/built-in.o(.init.text+0x2071): In function
> `late_hpet_init':
> arch/x86_64/kernel/entry.S:259: undefined reference to `hpet_alloc'
> 
> Andi, one thing I am not sure is - do you want entire routine
> late_hpet_init() under CONFIG_HPET or only parts of it ?

The entire function. As in this patch.

------------------------------------------------------------

Fix linking with CONFIG_HPET off

Index: linux/arch/x86_64/kernel/time.c
===================================================================
--- linux.orig/arch/x86_64/kernel/time.c	2004-10-06 02:00:23.%N +0200
+++ linux/arch/x86_64/kernel/time.c	2004-10-11 23:25:14.%N +0200
@@ -724,6 +724,7 @@
 	return (end - start) / 50;
 }
 
+#ifdef CONFIG_HPET
 static __init int late_hpet_init(void)
 {
 	struct hpet_data	hd;
@@ -770,6 +771,7 @@
 	return 0;
 }
 fs_initcall(late_hpet_init);
+#endif
 
 static int hpet_init(void)
 {


