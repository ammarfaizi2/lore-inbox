Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263335AbTECPNR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 11:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263336AbTECPNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 11:13:17 -0400
Received: from siaag1ab.compuserve.com ([149.174.40.4]:22744 "EHLO
	siaag1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S263335AbTECPNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 11:13:16 -0400
Date: Sat, 3 May 2003 11:24:09 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re:[PATCH][Experimental] Debugging i386 using hardware task
  switching
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305031125_MC3-1-3736-8D55@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Buoyed by the success of silly usermode testing, I got brave and stuck
an int3 instruction right in the middle of arch/i386/kernel/irq.c:do_IRQ()
and captured this:

   *1 - EIP is at do_IRQ+0x38, with interrupts disabled
   *2 - 0x50 (80) bytes of kernel stack are in use
   *3 - ECX: last two interrupts were 199485 clocks apart
        (boot CPU speed is 199.491 MHz)
   *4 - ESI: int3 has been invoked 1653673 times since boot

This is with an SMP kernel on a 1-CPU machine.  The 1000 clocks of extra
overhead every interrupt don't seem to make much of a difference...


GDT entry #16: kernel TSS at c0393800, 236 bytes:

   CS:0060 <GDT#12,RPL0>   EIP:c010afa8   eflags:00000002 <IF:0>        *1
  SS0:0068 <GDT#13,RPL0>  ESP0:c2966000
  SS1:0060 <GDT#12,RPL0>  ESP1:c0393a00
  SS2:0000 <GDT#00,RPL0>  ESP2:00000000
   SS:0068 <GDT#13,RPL0>   ESP:c2965fb0                                 *2                                      
   DS:007b <GDT#15,RPL3>  ES:007b <GDT#15,RPL3>
   FS:0000 <GDT#00,RPL0>  GS:0000 <GDT#00,RPL0>
  EAX:c10a2020  EBX:00000000  ECX:00cb5f80  EDX:00000000
  ESI:c0393c00  EDI:00000000  EBP:bffffb78     BITMAP:8000
  LDT:0088 <GDT#17,RPL0>      CR3:035d1000   LINK:0000 <GDT#00,RPL0>


GDT entry #30: debugger TSS at c0395a00, 236 bytes:

   CS:0060 <GDT#12,RPL0>   EIP:c0110173   eflags:00000006 <IF:0>
  SS0:0068 <GDT#13,RPL0>  ESP0:c03f27a0
  SS1:0000 <GDT#00,RPL0>  ESP1:00000000
  SS2:0000 <GDT#00,RPL0>  ESP2:00000000
   SS:0068 <GDT#13,RPL0>   ESP:c03f27a0
   DS:007b <GDT#15,RPL3>  ES:007b <GDT#15,RPL3>
   FS:0000 <GDT#00,RPL0>  GS:0000 <GDT#00,RPL0>
  EAX:aa72bbf2  EBX:c0341a40  ECX:00030b3d  EDX:0000004e                *3
  ESI:00193ba9  EDI:00000010  EBP:c03f03a0     BITMAP:8000
  LDT:0088 <GDT#17,RPL0>      CR3:00101000   LINK:0080 <GDT#16,RPL0>    *4



