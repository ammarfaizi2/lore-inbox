Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267766AbUHEQ0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267766AbUHEQ0z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 12:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267771AbUHEQ0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 12:26:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:38792 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267766AbUHEQ0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 12:26:53 -0400
Date: Thu, 5 Aug 2004 09:26:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Gene Heskett <gene.heskett@verizon.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Possible dcache BUG
In-Reply-To: <200408051133.55359.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.58.0408050913320.24588@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
 <200408042216.12215.gene.heskett@verizon.net> <Pine.LNX.4.58.0408042359460.24588@ppc970.osdl.org>
 <200408051133.55359.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Aug 2004, Denis Vlasenko wrote:
> 
> It is not a BUG().

Oh yes it is. The 2.6.8-rc2-mm2 report definitely was a BUG().

Earlier ones may not have been, but on the other hand, earlier ones may
not have had the BUG()-check for corrupted list_del() usage - it's not in
the standard kernel, and I don't know when it was added to -mm. (We used
to have it a _long_ time ago, but then we removed it because there were no
reports of problems).

> It's an oops (dereferencing a d_op pointer with value 0x00000900+14
> IIRC, Gene has complete disassembly with location of that event).

.. and that must be because of some kind of pointer corruption, where the 
dentry was either free'd twice or the dentry simply isn't a dentry at all, 
it just got to be used as such because of some bug.

> It is not reproducible on request, but happens for him from time
> to time in the same place with the same bogus value of d_op.

I've followed the discussion. You may not have noticed that the last one 
was different. (And I _think_ it may hav ebeen the first time Gene did a 
-mm kernel, so I do believe that the list_del() debugging was the thing 
that caught it).

Anyway, one other thing that makes me worry is the fact that Gene 
apparently has a K7. One of the things AMD has gotten wrong several times 
is prefetching, and it so happens that the dcache code is one of the users 
of the prefetch instruction. prude_dcache() in particular.

So I'm also entertaining the notion that there's an actual prefetch data 
corruption, not just the known AMD bug with occasional spurious page 
faults. Who else has seen the problem? What CPU's are involved?

		Linus
