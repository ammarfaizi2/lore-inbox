Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbTI3Hf1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 03:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbTI3Hf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 03:35:27 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:20905 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261159AbTI3HfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 03:35:18 -0400
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Jamie Lokier <jamie@shareable.org>, Andrew Morton <akpm@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] document optimizing macro for translating PROT_ to VM_
 bits
References: <20030929090629.GF29313@actcom.co.il>
	<20030929153437.GB21798@mail.jlokier.co.uk>
	<20030930071005.GY729@actcom.co.il>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 30 Sep 2003 16:34:31 +0900
In-Reply-To: <20030930071005.GY729@actcom.co.il>
Message-ID: <buohe2u3f20.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda <mulix@mulix.org> writes:
> Ah, much nicer, thank you. I'll submit it, but first, what do you
> think about this version? it keeps the optimization and enforces the
> "bit1 and bit2 must be single bits only" rule.

On my arch it results in huge bloated code, including mul and div insns!

Here's what gcc 3.3.x does for both the prefix macro versions:

   #define _calc_vm_trans_2(x,bit1,bit2) \
    ((bit1) <= (bit2) ? ((x) & (bit1)) * ((bit2) / (bit1)) \
       : ((x) & (bit1)) / ((bit1) / (bit2)))
   int test2_0 (unsigned val)
   {
     return _calc_vm_trans_2 (val,0x20,0x80);
   }

==>

   _test2_0:
           andi 32,r6,r10	#, val, tmp43
           shl 2,r10	#, <result>
           jmp [r31]


Here's what gcc 3.3.x does for your inlined function version:

   static inline void assert_single_bit(unsigned long bit)
   {
           extern __bug() __attribute__ ((noreturn));
           if (bit & (bit - 1))
             __bug ();
   }
   static inline unsigned long 
   _calc_vm_trans_3(unsigned long x, unsigned long bit1, unsigned long bit2) 
   {
           assert_single_bit(bit1); 
           assert_single_bit(bit2); 

           return ((bit1) <= (bit2) ? ((x) & (bit1)) * ((bit2) / (bit1))
                   : ((x) & (bit1)) / ((bit1) / (bit2))); 
   }
   int test3_0 (unsigned val)
   {
     return _calc_vm_trans_3 (val,0x20,0x80);
   }

==>

   _test3_0:
           movea lo(32),r0,r7	#, bit1
           movea lo(128),r0,r5	#, bit2
           divu r7,r5,r10	# bit1, bit2, tmp55
           mov r6,r10	# val, tmp52
           and r7,r10	# bit1, tmp52
           mul r5,r10,r0	# bit2, tmp52
           jmp [r31]

[I've no idea what's up with that, I don't even think the generated code
makes sense, but it seems like the presence of inline function is
confusing something.]

-Miles
-- 
In New York, most people don't have cars, so if you want to kill a person, you
have to take the subway to their house.  And sometimes on the way, the train
is delayed and you get impatient, so you have to kill someone on the subway.
  [George Carlin]
