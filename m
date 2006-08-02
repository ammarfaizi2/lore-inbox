Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWHBF2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWHBF2y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 01:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWHBF2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 01:28:53 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5345 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751248AbWHBF2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 01:28:53 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>
Subject: Re: [PATCH 9/33] i386 boot: Add serial output support to the decompressor
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	<p73zmeoz2l4.fsf@verdi.suse.de>
	<m1ejvzx2dw.fsf@ebiederm.dsl.xmission.com>
	<200608020510.07569.ak@suse.de>
Date: Tue, 01 Aug 2006 23:27:00 -0600
In-Reply-To: <200608020510.07569.ak@suse.de> (Andi Kleen's message of "Wed, 2
	Aug 2006 05:10:07 +0200")
Message-ID: <m1odv3vhaz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

>> > /* WARNING!!
>> >  * This code is compiled with -fPIC and it is relocated dynamically
>> >  * at run time, but no relocation processing is performed.
>> >  * This means that it is not safe to place pointers in static structures.
>> >  */
>
> iirc the only static relocation in early_printk is the one to initialize
> the console pointers - that could certainly be moved to be at run
> time.

The function pointers in the console structure are also a problem.
static struct console simnow_console = {
	.name =		"simnow",
	.write =	simnow_write,
	.flags =	CON_PRINTBUFFER,
	.index =	-1,
};

>> lib/string.c might be useful.  The fact that the functions are not
>> static slightly concerns me.  I have a vague memory of non-static
>> functions generating relocations for no good reason.
>
> Would surprise me.

The context where it bit me was memtest86, if I recall correctly.
The problem there was I did process relocations and I discovered simply
by making functions static or at least non-exported I had many fewer
relocations to process.

Since I am relying on a very clever trick to generate code that
doesn't have relocations at run time I have to be careful.

So if I want to continue not processing relocations.
I need to be careful not to use constructs that will generate
a procedure linkage table, which I think only kicks in with
external functions and multiple files. 

I need to be careful not to put pointers in statically allocated
data structures.

Ideally the code would be setup so you can compile out consoles
the user finds uninteresting.

It is annoying to have to call strlen on all of the strings
you want to print..

So there are plenty of mismatches, there.
But we may be able to harmonized them, and reuse early_printk.

Eric

