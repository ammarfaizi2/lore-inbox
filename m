Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVAGLsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVAGLsY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 06:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbVAGLsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 06:48:24 -0500
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:61338 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP id S261348AbVAGLsS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 06:48:18 -0500
Date: Fri, 7 Jan 2005 12:47:49 +0100 (CET)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Andrew Morton <akpm@osdl.org>
cc: "Prakash K. Cheemplavam" <prakashkc@gmx.de>, bzolnier@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: APIC/LAPIC hanging problems on nForce2 system.
In-Reply-To: <20050106164952.0a46df7e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.60.0501071145240.3316@kepler.fjfi.cvut.cz>
References: <Pine.LNX.4.60.0501051604200.24191@kepler.fjfi.cvut.cz>
 <41DC1AD7.7000705@gmx.de> <Pine.LNX.4.60.0501051757300.25946@kepler.fjfi.cvut.cz>
 <41DC2113.8080604@gmx.de> <Pine.LNX.4.60.0501051821430.25946@kepler.fjfi.cvut.cz>
 <41DC2353.7010206@gmx.de> <Pine.LNX.4.60.0501060046450.26952@kepler.fjfi.cvut.cz>
 <41DCFEF0.5050105@gmx.de> <58cb370e05010605527f87297e@mail.gmail.com>
 <41DD537B.9030304@gmx.de> <20050106154650.33c3b11c.akpm@osdl.org>
 <41DDD7C3.8040406@gmx.de> <20050106164952.0a46df7e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 Jan 2005, Andrew Morton wrote:

> "Prakash K. Cheemplavam" <prakashkc@gmx.de> wrote:
> >
> > Perhaps firfox fscked up the inlined patch, so please
> > try the attached version. If it goes alright, I'll resubmit it,
> > inlcuding more detailed description.
> 
> There was no attachment.
> 
> Please go ahead and prepare a final patch against Linus's latest tree.  The
> simplest way to obtain that is via the topmost link at
> http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/.

That is strange. I got it with the attachment. I tried it and it applies 
to the vanilla 2.6.10-bk9 just fine with

	cd /usr/src/linux
	patch -p0 <always_nforce2_c1_fix.patch

Maybe the problem is that the diff is done *inside the tree and so needs 
to be applied in the /usr/src/linux (or whatever your linux directory is) 
and with -p0 there. Usually patches have one level more, so you do it 
there with -p1 or so. But otherwise it should apply. The section, that you 
mentioned in the previous mail is exactly the one that it applies to (it 
seems).

About the rationale. The problem was (as you may read in my previous mails 
to LKML with this subject) that BIOS on my board (Gigabyte GA-7NNXP) 
doesn't enable the C1 Halt Disconnect bit (bit 28 of the PCI reg. 0x6C). 
The fix that really needs to be done in order for the C1 Halt Disconnect 
to work properly, as you may read in the rationale of the original fixing 
function, is changing the 3rd byte of that PCI.0x6C register from 0x0F to 
0x01. Problem is that the original fixing function didn't apply the fix at 
all when the C1 Halt Disconnect isn't set at the moment of calling the 
fixing function (which is called only during bootup initialization of the 
nForce2), and so when the C1 Halt Disconnect is enabled later (i.e., by 
the athcool utility), the fix isn't applied and the whole system becomes 
*VERY* unstable (at least it did for me - total freeze) on heavy interrupt 
occurances (i.e., high network load, high HDD activity, etc.).

This patch really solves the problem for me and probably for others with 
unfixed BIOS as well, and (though I'm not an nForce expert) I don't think 
it may harm anyone, for whom it worked before, because except for that 
little difference of applying even when C1 Halt Disconnect is disabled, it 
does exactly the same thing.

Martin
