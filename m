Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267695AbUHWWJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267695AbUHWWJK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 18:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267489AbUHWWIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 18:08:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:8642 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267831AbUHWWID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 18:08:03 -0400
Date: Mon, 23 Aug 2004 15:07:44 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] lazy TSS's I/O bitmap copy ...
In-Reply-To: <Pine.LNX.4.58.0408231436370.3222@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.58.0408231500160.17766@ppc970.osdl.org>
References: <Pine.LNX.4.58.0408231311460.3221@bigblue.dev.mdolabs.com>
 <20040823233249.09e93b86.ak@suse.de> <Pine.LNX.4.58.0408231436370.3222@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 23 Aug 2004, Davide Libenzi wrote:
> 
> The eventually double GPF would happen only on TSS-IObmp-lazy tasks, ie 
> tasks using the I/O bitmap.

You could also check for the error code (at least the low 16 bits) being 
0, I guess, just to cut down the noise.

>	 The check for the I/O opcode can certainly be 
> done though, even if it'd make the code a little bit more complex.

Have to be very careful there to avoid nasty security issues. And with
ins/outs, you can have various prefixes etc, so decoding is not as trivial
as it could otherwise be. Even the regular in/out can have a data size
overrides..

in/out is also commonly used from vm86 mode, so decoding it really needs
to get all of the segmentation base crap right too. Nasty nasty nasty. 

In short, I think that if we do this at all, I'd much rather just do the
simple "trap twice" thing that Davide did. It's too easy to get it wrong
otherwise.

Or we should make this careful decoder some generic x86 function. We're
doing user instruction decoding in a number of places already, although I 
don't know how careful they generally need to be. Sadly, I really think 
that this one needs to be one of the most careful cases due to the vm86 
usage.

		Linus
