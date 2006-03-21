Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbWCUSLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWCUSLE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 13:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbWCUSLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 13:11:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39109 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932393AbWCUSLB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 13:11:01 -0500
Date: Tue, 21 Mar 2006 10:10:48 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Knut Petersen <Knut_Petersen@t-online.de>, Dave Jones <davej@redhat.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG] wrong bogomips  values with kernel 2.6.16
In-Reply-To: <441FFB28.5050609@t-online.de>
Message-ID: <Pine.LNX.4.64.0603211004250.3622@g5.osdl.org>
References: <441FFB28.5050609@t-online.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Mar 2006, Knut Petersen wrote:
> 
> System: AOpen i915GMm-HFS motherboard, kernel 2.6.16
> CPU: Intel(R) Pentium(R) M processor 1.86GHz stepping 08
> 
> During startup a BogoMips value  of 3730.21 is calculated. That
> should be the correct value for the cpu running at full speed.

That sounds correct. On x86, BogoMips these days is just a measure of how 
fast the timestamp counter goes (multiplied by two for totally bogus 
reasons), and a Pentium-M should have a fixed-frequency TSC that ticks at 
the highest possible frequency of the CPU, regardless of what the real 
frequency is.

So your BogoMips of 3730 sounds correct.

> But:
> 
> "cat /proc/cpuinfo" on the idle system displays the correct cpu speed, but
> a wrong bogomips value:
> 
>    cpu MHz         : 800.000
>    bogomips        : 3730.21

No, this is the _right_ bogomips value. Since the TSC is fixed-frequency, 
bogomips doesn't change with CPU frequency.

> "cat /proc/cpuinfo" on the busy system displays the correct cpu speed too, but
> again a wrong bogomips value:
> 
>    cpu MHz         : 1867.000
>    bogomips        : 8705.38

Yeah, looks like cpufreq has (totally incorrectly) scaled up the bogomips 
value.

The scaling up should actually happen if the TSC runs at core speed _or_ 
if bogomips is calculated using the old "decl + jne" loop. So I guess 
somebody "fixed" a bug that was a bug on such systems, and broke systems 
with a proper fixed-frequency TSC.

DaveJ, does this ring any bells? 

		Linus
