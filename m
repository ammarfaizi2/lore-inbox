Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269445AbUJLEVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269445AbUJLEVn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 00:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269448AbUJLEVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 00:21:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:19157 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269445AbUJLEVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 00:21:40 -0400
Date: Mon, 11 Oct 2004 21:19:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: rddunlap@osdl.org, geert@linux-m68k.org, davej@redhat.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: __init dependencies
Message-Id: <20041011211932.3fad6bf9.akpm@osdl.org>
In-Reply-To: <416B57DE.4070605@osdl.org>
References: <20041010225717.GA27705@redhat.com>
	<Pine.GSO.4.61.0410111333260.19312@waterleaf.sonytel.be>
	<20041011121225.2f829507.akpm@osdl.org>
	<416ADC63.6010709@osdl.org>
	<416B57DE.4070605@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>
> My experience with output of buildcheck is that it's verbose and has
>  lots of false positives.

I berated Keith over that a while back and he shot me down.  umm...


>  On Mon, 31 May 2004 23:52:14 -0700, 
>  Andrew Morton <akpm@osdl.org> wrote:
>  >
>  >gad, reference_init generates so much stuff I wonder if it's worth using. 
>  >Are all these for real?
> 
>  Apart from altinstructions, yes.  Mainly because people have not been
>  checking them.
> 
>  >perl scripts/reference_init.pl
>  >Finding objects, 1411 objects, ignoring 122 module(s)
>  >Finding conglomerates, ignoring 137 conglomerate(s)
>  >Scanning objects
>  >Error: ./arch/i386/kernel/apic.o .data refers to 0000009c R_386_32          .init.text
> 
>  arch/i386/kernel/apic.c
>  void (*wait_timer_tick)(void) = wait_8254_wraparound;
>  wait_8254_wraparound is __init.  wait_timer_tick should be __initdata,
>  which flows onto several other functions.
> 
>  >Error: ./arch/i386/kernel/cpu/mtrr/centaur.o .data refers to 00000008 R_386_32          .init.text
> 
>  That is real, centaur_mtrr_ops.init = centaur_mcr_init.  Like a lot of
>  this initialization code, we get away with the dangling reference
>  because the code is only executed at boot.
> 
>  >Error: ./arch/i386/kernel/cpu/mtrr/centaur.o .eh_frame refers to 000000dc R_386_32          .init.text
> 
>  I don't see any .eh_frame references in 2.6.7-rc2 using gcc version
>  3.3.3 20040412 (Red Hat Linux 3.3.3-7).  Where are they coming from?
> 
>  >Error: ./arch/i386/kernel/cpu/mtrr/cyrix.o .data refers to 00000028 R_386_32          .init.text
> 
>  Same as centaur.
> 
>  >Error: ./arch/i386/kernel/cpu/mtrr/generic.o .text refers to 0000038f R_386_32          .init.data
> 
>  arch/i386/kernel/cpu/mtrr/generic.c
>  generic_set_all() uses __intdata smp_changes_mask.
> 
>  >Error: ./arch/i386/kernel/smpboot.o .altinstructions refers to 00000000 R_386_32          .init.text
> 
>  altinstructions is a false positive, tweak reference_init.pl
> 
>  --- reference_init.pl.orig	2004-06-01 20:30:27.000000000 +1000
>  +++ reference_init.pl	2004-06-01 20:31:01.000000000 +1000
>  @@ -93,6 +93,7 @@
>   		     $from !~ /\.stab$/ &&
>   		     $from !~ /\.rodata$/ &&
>   		     $from !~ /\.text\.lock$/ &&
>  +		     $from !~ /\.altinstructions$/ &&
>   		     $from !~ /\.debug_/)) {
>   			printf("Error: %s %s refers to %s\n", $object, $from, $line);
>   		}
> 
>  The rest of the warnings look real, apart from the strange eh_frame.
> 

So what you think are false positives may well not be.
