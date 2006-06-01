Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWFAVnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWFAVnR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 17:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWFAVnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 17:43:16 -0400
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:51848 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750770AbWFAVnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 17:43:15 -0400
Date: Thu, 1 Jun 2006 17:39:09 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.17-rc5-mm1
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200606011741_MC3-1-C158-4568@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <447DD4D3.3060205@free.fr>

On Wed, 31 May 2006 19:39:31 +0200, Laurent Riffard wrote:

> pktcdvd: writer pktcdvd0 mapped to hdc
> BUG: unable to handle kernel NULL pointer dereference at virtual address 00000084
>  printing eip:
> c01118f1
> *pde = 00000000
> Oops: 0000 [#1]
> last sysfs file: /block/pktcdvd0/removable
> Modules linked in: pktcdvd lp parport_pc parport snd_pcm_oss snd_mixer_oss snd_ens1371 gameport snd_rawmidi snd_seq_device snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd_page_alloc snd soundcore af_packet floppy ide_cd cdrom loop aes dm_crypt nl
> CPU:    0
> EIP:    0060:[<c01118f1>]    Not tainted VLI
> EFLAGS: 00010006   (2.6.17-rc5-mm1 #11) 
> EIP is at do_page_fault+0xb4/0x5bc
> eax: d6750084   ebx: d6750000   ecx: 0000007b   edx: 00000000
> esi: d6758000   edi: c011183d   ebp: d675007c   esp: d6750044
> ds: 007b   es: 007b   ss: 0068
> Process  (pid: 0, threadinfo=d674f000 task=d657c000)
> Stack: 00000000 d6750084 00000000 00000049 00000084 00000000 00001e2e 02001120 
>        00000027 00000022 00000055 d6750000 d6758000 c011183d d67500f0 c010340d 
>        d6750000 0000007b 00000000 d6758000 c011183d d67500f0 d67500f8 0000007b 
> Call Trace:
>  [<c010340d>] error_code+0x39/0x40
> Code: 00 00 c0 81 0f 84 12 02 00 00 e9 1c 05 00 00 8b 45 cc f7 40 30 00 02 02 00 74 06 e8 68 af 01 00 fb f7 43 14 ff ff ff ef 8b 55 d0 <8b> b2 84 00 00 00 0f 85 e5 01 00 00 85 f6 0f 84 dd 01 00 00 8d 
> EIP: [<c01118f1>] do_page_fault+0xb4/0x5bc SS:ESP 0068:d6750044

arch/i386/mm/fault.c::do_page_fault():

  12:   f7 40 30 00 02 02 00      testl  $0x20200,0x30(%eax)
  19:   74 06                     je     21 <_EIP+0x21>
        if (regs->eflags & (X86_EFLAGS_IF|VM_MASK))

  1b:   e8 68 af 01 00            call   1af88 <_EIP+0x1af88>
  20:   fb                        sti
                local_irq_enable();

local_irq_enable() should only be doing an sti; your code has an extra
function call. Do you have any extra patches applied?

  21:   f7 43 14 ff ff ff ef      testl  $0xefffffff,0x14(%ebx)
if (in_atomic()...

  28:   8b 55 d0                  mov    0xffffffd0(%ebp),%edx
Get tsk from local storage and put it in edx.

00000000 <_EIP>:
   0:   8b b2 84 00 00 00         mov    0x84(%edx),%esi   <=====
        mm = tsk->mm;

tsk was zero here, implying that current was 0 when the page fault happened.


   6:   0f 85 e5 01 00 00         jne    1f1 <_EIP+0x1f1>
   c:   85 f6                     test   %esi,%esi
   e:   0f 84 dd 01 00 00         je     1f1 <_EIP+0x1f1>



Andrew, should we add debug code to the fault handler to test for current == 0?

-- 
Chuck

