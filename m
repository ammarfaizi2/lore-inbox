Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751484AbWGYHxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbWGYHxN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 03:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWGYHxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 03:53:13 -0400
Received: from liaag2ac.mx.compuserve.com ([149.174.40.152]:43146 "EHLO
	liaag2ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751488AbWGYHxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 03:53:11 -0400
Date: Tue, 25 Jul 2006 03:46:38 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Debugging APM - cat /proc/apm produces oops
To: Ondrej Zary <linux@rainbow-software.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <200607250348_MC3-1-C5FB-CC7F@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200607242351.37578.linux@rainbow-software.org>

On Mon, 24 Jul 2006 23:51:37 +0200, Ondrej Zary wrote:
>
> > >  printing eip:
> > > 00002f9d
> > > *pre = 00000000
> > > Oops: 0002 [#4]
> > > Modules linked in:
> > > CPU:    0
> > > EIP:    00c0:[<00002f9d>]    Not tainted VLI
> >
> >           ^^^^
> > This is the APM BIOS 16 bit code segment.
>
> Looking at BIOS disassembly:
> 2F97: push bp
> 2F98: mov bp,sp
> 2F9A: add sp,-2
> 2F9D: mov [bp][-2],bx    <-- it oopses here

That's expected.  You can push/pop/call/ret using the kernel stack
because its 32-bit stack-size attribute controls how the stack is
addressed, but using it like that makes it use 16 bits (the CS
address size.)

This could probably be fixed in the kernel but it doesn't look
worth the trouble since the fix could be really ugly.

> I realized that I can modify the BIOS easily as it's stored in shadow RAM. So 
> I replaced the offending MOV with three NOPs and tested again. This time it 
> oopsed at 0x2FAD:
> 2FAD: cmp w,[bp][-2],1
> 2FB1: je 2FCB
> 
> that jump was taken during my single stepping, so I NOPped out the CMP and 
> replaced JE with JMPS. Then booted Linux and APM seems to work fine - battery 
> percentage and remaining time is there as well as AC power status.
> There seems to be 4 these operations:
> mov [bp][-2],bx
> cmp w,[bp][-2],1
> cmp w,[bp][-2],8002
> cmp w,[bp][-2],8001
> but I've hit only the first two of them. I wonder what's that for (especially 
> when it works without that).

Something is calling this after pushing the arg to the function onto the
stack.  I guess it's always calling it with a 1 if that's all you are seeing.

-- 
Chuck

