Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbTI3KBa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 06:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbTI3KBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 06:01:30 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:12700 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261287AbTI3KB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 06:01:26 -0400
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Jamie Lokier <jamie@shareable.org>, Andrew Morton <akpm@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] document optimizing macro for translating PROT_ to VM_
 bits
References: <20030929090629.GF29313@actcom.co.il>
	<20030929153437.GB21798@mail.jlokier.co.uk>
	<20030930071005.GY729@actcom.co.il>
	<buohe2u3f20.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<20030930074138.GG729@actcom.co.il>
	<buoad8m3dvn.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<20030930092403.GR29313@actcom.co.il>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 30 Sep 2003 19:00:53 +0900
In-Reply-To: <20030930092403.GR29313@actcom.co.il>
Message-ID: <buon0cm1tpm.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda <mulix@mulix.org> writes:
> I like code that is "future proof", especially when it doesn't cost
> anything.

Sure, it's not always worth the trouble/pain to do so unless you've
actually got some reason to think it will be mis-used.

This is seeming more and more like such a case: it's a very special
purpose macro which is only used by two other small functions, both of
which are located immediately adjacent to the macro's definition.

If it _really_ makes you nervous, give it a big warning comment with
capital letters or something; that's almost certainly enough.

> How does it fare on your arch?

Quite grotesquely:

   int test3_0 (unsigned val)
   {
     return _calc_vm_trans_3 (val,0x20,0x80);
   }

   int test3_1 (unsigned val)
   {
     return _calc_vm_trans_3 (val,0x80,0x20);
   }

==>

   __calc_vm_trans_3:
           addi -20,sp,sp	#,,
           addi -1,r7,r5	#, bit1, tmp46
           addi -1,r8,r11	#, bit2, tmp51
           mov r6,r12	# x, tmp53
           st.w r31,16[sp]	#,
           and r7,r12	# bit1, tmp53
           and r7,r5	# bit1, tmp46
           and r8,r11	# bit2, tmp51
           cmp r0,r5	# tmp46
           be .L24	#,
           cmp r0,r11	# tmp51
           be .L24	#,
           cmp r8,r7	# bit2, bit1
           bnh .L26	#,
           mov r6,r12	# x, tmp53
           and r7,r12	# bit1, tmp53
           divu r8,r7,r10	# bit2, bit1, tmp61
           ld.w 16[sp],r31	#,
           divu r7,r12,r11	# bit1, tmp53, tmp63
           mov r12,r10	# tmp53, <result>
           addi 20,sp,sp	#,,
           jmp [r31]
   .L26:
           divu r7,r8,r10	# bit1, bit2, tmp57
           mul r8,r12,r0	# bit2, tmp53
           ld.w 16[sp],r31	#,
           mov r12,r10	# tmp53, <result>
           addi 20,sp,sp	#,,
           jmp [r31]
   .L24:
           jarl ___bug,r31	#
   _test3_1:
           addi -20,sp,sp	#,,
           st.w r31,16[sp]	#,
           movea lo(128),r0,r7	#,
           movea lo(32),r0,r8	#,
           jarl __calc_vm_trans_3,r31	#
           ld.w 16[sp],r31	#,
           addi 20,sp,sp	#,,
           jmp [r31]
   _test3_0:
           addi -20,sp,sp	#,,
           st.w r31,16[sp]	#,
           movea lo(32),r0,r7	#,
           movea lo(128),r0,r8	#,
           jarl __calc_vm_trans_3,r31	#
           ld.w 16[sp],r31	#,
           addi 20,sp,sp	#,,
           jmp [r31]


If I only use one test function, gcc does a bit better, but still
generates various unnecessary function-call-related artifacts:

   int test3_0 (unsigned val)
   {
     return _calc_vm_trans_3 (val,0x20,0x80);
   }

==>

   _test3_0:
           add -16,sp	#,
           andi 32,r6,r10	#, val, tmp56
           shl 2,r10	#, <result>
           addi 16,sp,sp	#,,
           jmp [r31]

-Miles
-- 
Freedom's just another word, for nothing left to lose   --Janis Joplin
