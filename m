Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbTKBNfk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 08:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbTKBNfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 08:35:40 -0500
Received: from ns.suse.de ([195.135.220.2]:1733 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261685AbTKBNfi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 08:35:38 -0500
Date: Sun, 2 Nov 2003 14:35:35 +0100
From: Andi Kleen <ak@suse.de>
To: Matthias Hanisch <matze@camline.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Oops in __is_prefetch with 2.6.0-test9-bk4 at boot
 time with Athlon XP 1800+
Message-Id: <20031102143535.0b9b39f2.ak@suse.de>
In-Reply-To: <200311021048.51887.matze@camline.com>
References: <Pine.LNX.4.33.0311010655490.29382-200000@homer2.camline.com>
	<20031101201446.513ce9b6.ak@suse.de>
	<200311021048.51887.matze@camline.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Nov 2003 10:48:51 +0100
Matthias Hanisch <matze@camline.com> wrote:

> Then it faults in __get_user, (double-fault), enters again __is_prefetch via
> do_page_fault, this address (the fault address in first __is_prefetch call) is
> handled properly and then the oops is reported as described yesterday.
> Applying your init patch seems to cure this problem, but then - as I said in
> the beginning - it loops infinitely.

When the __init patch helps means someone uses an exception table entry 
in an __init or __exit function. The linker cannot deal with that and the
exception table ends up unordered, which breaks the exception handling.
That's a bug and needs to be fixed because it will break more than just
__is_prefetch

There are two options: 
- Either sort the exception table at runtime
- Or track down the code. The way to track this down (if you want to do this) is to dump
the __ex_table ELF section in vmlinux using objdump. It consists of pairs
of addresses. The first address in the pair should be ordered over the section. 
Find the unordered address and decode the second address using System.map. Then fix 
that function either dropping the __init/__exit or eliminating the bad entry otherwise.
If you send me your .config in an usable way I can probably do this for you.
 
> 
> At the moment I have no more ideas what to do here...

Maybe you just have a miscompilation of some sort. Do a make mrproper and try
again. You can also try if it happens with a smaller configuration.

-Andi


> 
> 
> 
> 
> 
> 
> 
> 
