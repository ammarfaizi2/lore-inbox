Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269777AbRIDWzc>; Tue, 4 Sep 2001 18:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269778AbRIDWzW>; Tue, 4 Sep 2001 18:55:22 -0400
Received: from faui11.informatik.uni-erlangen.de ([131.188.31.2]:35059 "EHLO
	faui11.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S269777AbRIDWzO>; Tue, 4 Sep 2001 18:55:14 -0400
From: Ulrich Weigand <weigand@immd1.informatik.uni-erlangen.de>
Message-Id: <200109042255.AAA03096@faui11.informatik.uni-erlangen.de>
Subject: Re: [SOLVED + PATCH]: documented Oops running big-endian reiserfs on parisc architecture
To: jeffm@suse.com, ak@suse.de, linux-kernel@vger.kernel.org
Date: Wed, 5 Sep 2001 00:55:24 +0200 (MET DST)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff Mahoney wrote:

> Are the S/390 asm/unaligned.h versions broken, or is the ReiserFS code doing 
> something not planned for? It's a 16-bit member, at a 16-bit alignment 
> in the structure. The structure itself need not be aligned in any 
> particular manner as it is read directly from disk, and is a packed structure.

One other point I overlooked before: using set_bit etc on a *16-bit* 
member is fundamentally broken on S/390 anyway (and I far as I know all 
other bigendian architectures as well).  set_bit assumes to operate on
a long (or an array of longs); if you use set_bit to set bit number 0
in the bitfield starting at address X, it will actually modify the byte 
located at address X+3 (or X+7 on 64-bit bigendian machines), because
this is where the bit with value 2^0 is located in a long.

If your bitfield is only 2 bytes long, this will obviously clobber
random memory after the field ...  (Note that the _unaligned variants
do not fix this problem, they will just cause it to clobber memory
*before* the field instead, if I interpret them correctly.)

Bye,
Ulrich

-- 
  Dr. Ulrich Weigand
  weigand@informatik.uni-erlangen.de
