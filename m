Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263815AbUFFRTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263815AbUFFRTV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 13:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263840AbUFFRTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 13:19:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:50618 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263815AbUFFRTT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 13:19:19 -0400
Date: Sun, 6 Jun 2004 10:19:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell Leighton <russ@elegant-software.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Using getpid() often, another way? [was Re: clone() <-> getpid()
 bug in 2.6?]
In-Reply-To: <40C33A84.4060405@elegant-software.com>
Message-ID: <Pine.LNX.4.58.0406061013250.7010@ppc970.osdl.org>
References: <40C1E6A9.3010307@elegant-software.com>
 <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org> <40C32A44.6050101@elegant-software.com>
 <40C33A84.4060405@elegant-software.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 6 Jun 2004, Russell Leighton wrote:
>
> Linus said he could not imagine a program using getpid() more than a 
> handful of times...

No, I said that I could not imagine using it more than a handful of times 
_except_ for the cases of:

 - thread identification without a native thread area
 - benchmarking.

(and in both of these cases it is _wrong_ to cache the pid value)

> well, (I am ashamed to admit it) I found this getpid() bug with just 
> such a program.
> 
> Could someone can suggest an alternative to using getpid() for me? 
> Here's the problem...
> 
> I have a library that creates 2 threads using clone().

Your problem falls under the thread ID thing. It's fine and understandable 
to use getpid() for that, although you could probably do it faster if you 
are willing to use the support that modern kernels give you and that glibc 
uses: the "TLS" aka Thread Local Storage support.

Thread-local storage involved having a user-mode register that points some 
way to a special part of the address space. On x86, where the general 
register set is very limited and stealing a general reg would thus be bad, 
it uses a segment and loads the TLS pointer into a segment register 
(segment registers are registers too - and since nobody sane uses them for 
anything else these days, both %gs and %fs are freely usable).

>  Would gettid() be any better?

You'd avoid this particular glibc bug with gettid.

		Linus
