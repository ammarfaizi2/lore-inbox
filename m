Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271334AbTGQCq1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 22:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271335AbTGQCq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 22:46:27 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56076 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S271334AbTGQCqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 22:46:25 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] print_dev_t for 2.6.0-test1-mm
Date: 16 Jul 2003 20:00:57 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bf53h9$ngo$1@cesium.transmeta.com>
References: <20030716184609.GA1913@kroah.com> <20030716213451.GA1964@win.tue.nl> <20030716143902.4b26be70.akpm@osdl.org> <20030716222015.GB1964@win.tue.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030716222015.GB1964@win.tue.nl>
By author:    Andries Brouwer <aebr@win.tue.nl>
In newsgroup: linux.dev.kernel
> > > 
> > > 16-bit only: 8:8, otherwise 32-bit only: 16:16, otherwise 32:32.
> 
> > Why do we need the 16:16 option?
> 
> It is not very important, but major 0 is reserved, so if userspace
> (or a filesystem) hands us a 32-bit device number, we have to
> split that in some way, not 0+32. Life is easiest with 16+16.
> (Now the major is nonzero, otherwise we had 8+8.)
> Other choices lead to slightly more complicated code.
> 

I would still recommend the arrangement for 64-bit dev_t that I posted
a while ago:

dev_t<63:40> := major<31:8>
dev_t<39:16> := minor<31:8>
dev_t<15:8>  := major<7:0>
dev_t<7:0>   := minor<7:0>

No aliasing, no forbidden bit patterns, no conditional code, no need
for magic numbers, and it's fully compatible with the current
LSB-adjusted user space dev_t format. I also posted i386 code for the
various operations to show that they really can be done with very
little code.

If you want, you can even make it 32-bit-friendly, although it makes
it more complex; for example, this version would implement 32-bit with
a 12:20 split:

dev_t<63:44> := major<31:12>
dev_t<43:32> := minor<31:20>
dev_t<31:28> := major<11:8>
dev_t<27:16> := minor<19:8>
dev_t<15:8>  := major<7:0>
dev_t<7:0>   := minor<7:0>

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
