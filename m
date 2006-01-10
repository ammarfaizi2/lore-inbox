Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWAJQO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWAJQO4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 11:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbWAJQO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 11:14:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10952 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932110AbWAJQO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 11:14:56 -0500
Date: Tue, 10 Jan 2006 08:14:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jens Axboe <axboe@suse.de>
cc: Byron Stanoszek <gandalf@winds.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2G memory split
In-Reply-To: <20060110143931.GM3389@suse.de>
Message-ID: <Pine.LNX.4.64.0601100804380.4939@g5.osdl.org>
References: <20060110125852.GA3389@suse.de> <20060110132957.GA28666@elte.hu>
 <20060110133728.GB3389@suse.de> <Pine.LNX.4.63.0601100840400.9511@winds.org>
 <20060110143931.GM3389@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Jan 2006, Jens Axboe wrote:
> 
> A newer version, trying to cater to the various comments in here.
> Changes:

Can we do one final cleanup? Do all the magic in _one_ place, namely the 
x86 Kconfig file.

Also, I don't think the NOHIGHMEM dependency is necessarily correct. A 
2G/2G split can be advantageous with a 16GB setup (you'll have more room 
for dentries etc), but you obviously want to have HIGHMEM for that..

Do it something like this:

	choice
		depends on EXPERIMENTAL
		prompt "Memory split"
		default DEFAULT_3G
		help
		  Select the wanted split between kernel and user memory.
		  If the address range available to the kernel is less than the
		  physical memory installed, the remaining memory will be available
		  as "high memory". Accessing high memory is a little more costly
		  than low memory, as it needs to be mapped into the kernel first.
		  Note that selecting anything but the default 3G/1G split will make
		  your kernel incompatible with binary only modules.

		config DEFAULT_3G
			bool "3G/1G user/kernel split"
		config DEFAULT_3G_OPT
			bool "3G/1G user/kernel split (for full 1G low memory)"
		config DEFAULT_2G
			bool "2G/2G user/kernel split"
		config DEFAULT_1G
			bool "1G/3G user/kernel split"
	endchoice

	config PAGE_OFFSET
		hex
		default 0xC0000000
		default 0xB0000000 if DEFAULT_3G_OPT
		default 0x78000000 if DEFAULT_2G
		default 0x40000000 if DEFAULT_1G

and then asm-i386/page.h can just do

	#define __PAGE_OFFSET ((unsigned long)CONFIG_PAGE_OFFSET)

and you're done.

If you ever want to change the offsets, you're only changing the Kconfig 
file, and as you can tell, the syntax is actually much _nicer_ that using 
the C preprocessor, since these kinds of choices is exactly what the 
Kconfig language is all about.

Please?

		Linus
