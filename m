Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbTDUWdu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 18:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262599AbTDUWdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 18:33:50 -0400
Received: from zero.aec.at ([193.170.194.10]:62216 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262515AbTDUWdt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 18:33:49 -0400
Date: Tue, 22 Apr 2003 00:45:46 +0200
From: Andi Kleen <ak@muc.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ulrich Drepper <drepper@redhat.com>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Runtime memory barrier patching
Message-ID: <20030421224546.GA14845@averell>
References: <3EA4660A.6000506@redhat.com> <Pine.LNX.4.44.0304211502300.17938-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304211502300.17938-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 22, 2003 at 12:05:51AM +0200, Linus Torvalds wrote:
> I would not be surprised if both AMD and Intel are playing some 
> "benchmarking games" by trying to select nop's that work badly for the 
> other side, and then showing how _their_ new CPU's are so much better by 
> having the compilers emit the "preferred" no-ops.
> 
> But maybe I'm just too cynical. And I do suspect the Hammer optimization
> guide was meant for the 64-bit mode only, because I'm pretty certain even
> AMD does badly on prefixes at least in older CPU generations.

Yes, you're right. The Athlon recommendation is pretty complicated
(they have different versions for different registers to avoid lengthening
dependency chains), but it uses different two byte nops. 

They explicitely say that it works well on "other CPUs" too which
likely means Intel.

Basically it is: 

         NOP2_EAX TEXTEQU <DB 08Bh,0C0h> ;MOV EAX, EAX
         NOP3_EAX TEXTEQU <DB 08Dh,004h,020h> ;LEA EAX, [EAX]
         NOP4_EAX TEXTEQU <DB 08Dh,044h,020h,000h> ;LEA EAX, [EAX+00]
        ;LEA EAX, [EAX+00];NOP
         NOP5_EAX TEXTEQU <DB 08Dh,044h,020h,000h,090h> 
        ;LEA EAX, [EAX+00000000]
         NOP6_EAX TEXTEQU <DB 08Dh,080h,0,0,0,0>
        ;LEA EAX, [EAX*1+00000000]
         NOP7_EAX TEXTEQU <DB 08Dh,004h,005h,0,0,0,0>
        ;LEA EAX, [EAX*1+00000000] ;NOP
         NOP8_EAX TEXTEQU <DB 08Dh,004h,005h,0,0,0,0,90h>
        ;JMP
         NOP9 TEXTEQU <DB 0EBh,007h,90h,90h,90h,90h,90h,90h,90h>

(+ the same for all other GPRs). Someone must have too much time
when documenting this ;)

But I'm not gonna resubmit with that unless if you insist on it...

-Andi

