Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbVDEG4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVDEG4F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 02:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVDEG4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 02:56:05 -0400
Received: from mx1.elte.hu ([157.181.1.137]:41449 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261584AbVDEGzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 02:55:51 -0400
Date: Tue, 5 Apr 2005 08:55:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, stsp@aknet.ru,
       Andrew Morton <akpm@osdl.org>
Subject: crash in entry.S restore_all, 2.6.12-rc2, x86, PAGEALLOC
Message-ID: <20050405065544.GA21360@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the crashes below happen when PAGEALLOC is enabled. It's this 
instruction:

        movb OLDSS(%esp), %ah

OLDSS is 0x38, esp is f4f83fc8, OLDSS(%esp) is thus f4f84000, which 
correctly creates the PAGEALLOC pagefault. esp is off by 4 bytes?

it could be the ESP-16-bit-corruption patch causing this, or it could be 
an already existing latent bug getting triggered now: normally only iret 
accesses the OLDSS, and we fix any iret faults up, but now that we 
explicitly access %esp the esp bug shows up.

so it would be nice to understand why this triggers. It seems to be a 
sporadic event - first it hit hotplug, then input.agent. If i disable 
PAGEALLOC the system boots up fine. In any case, the ESP-corruption 
patch is not safe until this bug is understood, as it right now may read 
a random byte off the next page, and possibly doing bogus calls to the 
16-bit-fixup code.

	Ingo

-------------

BUG: Unable to handle kernel paging request at virtual address f4f84000
 printing eip:
c010287c
*pde = 00527067
*pte = 34f84000
Oops: 0000 [#1]
PREEMPT DEBUG_PAGEALLOC
Modules linked in:
CPU:    0
EIP:    0060:[<c010287c>]    Not tainted VLI
EFLAGS: 00010046   (2.6.12-rc2-RT-V0.7.43-09) 
EIP is at restore_all+0x4/0x18
eax: 00000206   ebx: 00000000   ecx: 00000000   edx: 00000001
esi: 00000000   edi: 009b63f9   ebp: f4f82000   esp: f4f83fc8
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process 10-udev.hotplug (pid: 1264, threadinfo=f4f82000 task=f5034a10)
Stack: 00000000 bfa71dd0 009c0ffc 00000000 009b63f9 bfa71d44 000000c5 0000007b 
       0000007b ffffffef c01027ba 00000060 00000206 0000007b 
Call Trace:
 [<c01036ac>] show_stack+0x7a/0x90 (32)
 [<c0103835>] show_registers+0x15a/0x1d2 (56)
 [<c0103a30>] die+0xf4/0x17e (68)
 [<c010f444>] do_page_fault+0x3de/0x60a (212)
 [<c01032eb>] error_code+0x4f/0x54 (-8076)

---------------------

BUG: Unable to handle kernel paging request at virtual address f57bc000
 printing eip:
c010287c
*pde = 00529067
*pte = 357bc000
Oops: 0000 [#1]
PREEMPT DEBUG_PAGEALLOC
Modules linked in:
CPU:    0
EIP:    0060:[<c010287c>]    Not tainted VLI
EFLAGS: 00010046   (2.6.12-rc2-RT-V0.7.43-09) 
EIP is at restore_all+0x4/0x18
eax: 00000206   ebx: b7f11000   ecx: 00000000   edx: 00000000
esi: 080e4f28   edi: 00000000   ebp: f57ba000   esp: f57bbfc8
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process input.agent (pid: 1131, threadinfo=f57ba000 task=f57b9a10)
Stack: b7f11000 00001000 009c0ffc 080e4f28 00000000 bfc112c0 0000005b 0000007b 
       0000007b ffffff00 c01027ba 00000060 00000206 0000007b 
Call Trace:
 [<c01036ac>] show_stack+0x7a/0x90 (32)
 [<c0103835>] show_registers+0x15a/0x1d2 (56)
 [<c0103a30>] die+0xf4/0x17e (68)
 [<c010f474>] do_page_fault+0x3de/0x60a (212)
 [<c01032eb>] error_code+0x4f/0x54 (-8076)
