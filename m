Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264963AbRGSShG>; Thu, 19 Jul 2001 14:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265024AbRGSSg5>; Thu, 19 Jul 2001 14:36:57 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:29449 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264963AbRGSSgr>; Thu, 19 Jul 2001 14:36:47 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: cpuid_eax damages registers (2.4.7pre7)
Date: 19 Jul 2001 11:36:49 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9j79c1$5ap$1@cesium.transmeta.com>
In-Reply-To: <200107182204.f6IM4K001282@penguin.transmeta.com> <Pine.LNX.4.10.10107191113080.2341-100000@l>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Followup to:  <Pine.LNX.4.10.10107191113080.2341-100000@l>
By author:    Julian Anastasov <ja@ssi.bg>
In newsgroup: linux.dev.kernel
> 
> 	This patch works for me too (I checked all cpuid_XXX calls).
> After some thinking I produced another patch. The interesting part is
> that __volatile__ solves the problem. Patch appended. I see in other
> kernel files that volatile solves gcc bugs. The question is whether
> the volatile is needed only as a work-around or it is needed in this
> case particulary, i.e. where the output registers are not used and are
> optimized.
> 

It certainly shouldn't; obviously, the assembly code is clearly
declaring that it is outputting multiple things.  "volatile" on an
"asm" statement basically means "do this even if you don't need the
output values" (i.e. don't assume you're doing this just for the
computation), which is incorrect in this case (we *are* doing it just
for the output values, not for any side effects), but it is not really
surprising that it works around this bug.

The problem seems to be that gcc 2.91.66 thinks it can optimize away
half of an indivisible operation, which cannot be called anything but
a bug.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
