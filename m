Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbVDEHO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbVDEHO4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 03:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVDEHOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 03:14:48 -0400
Received: from mx2.elte.hu ([157.181.151.9]:14240 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261589AbVDEHGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 03:06:05 -0400
Date: Tue, 5 Apr 2005 09:05:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, stsp@aknet.ru,
       Andrew Morton <akpm@osdl.org>
Subject: Re: crash in entry.S restore_all, 2.6.12-rc2, x86, PAGEALLOC
Message-ID: <20050405070556.GA22562@elte.hu>
References: <20050405065544.GA21360@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405065544.GA21360@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> it could be the ESP-16-bit-corruption patch causing this, or it could 
> be an already existing latent bug getting triggered now: normally only 
> iret accesses the OLDSS, and we fix any iret faults up, but now that 
> we explicitly access %esp the esp bug shows up.

update: it's a latent condition being exposed by the ESP-corruption-fix 
patch. I reverted the ESP patch from 2.6.12-rc2, and applied the patch 
below, and it produces the same sort of crashes (attached further 
below).

	Ingo

--- linux/arch/i386/kernel/entry.S.orig
+++ linux/arch/i386/kernel/entry.S
@@ -123,6 +123,7 @@ VM_MASK		= 0x00020000
 
 
 #define RESTORE_ALL	\
+	movl OLDSS(%esp), %eax; \
 	RESTORE_REGS	\
 	addl $4, %esp;	\
 1:	iret;		\

------------->
Freeing unused kernel memory: 188k freed
Unable to handle kernel paging request at virtual address f5bda000
 printing eip:
c0102874
*pde = 00517067
*pte = 35bda000
Oops: 0000 [#1]
PREEMPT DEBUG_PAGEALLOC
Modules linked in:
CPU:    0
EIP:    0060:[<c0102874>]    Not tainted VLI
EFLAGS: 00010046   (2.6.12-rc2) 
EIP is at restore_all+0x0/0x14
eax: 00000260   ebx: 00000000   ecx: 00000000   edx: 00000001
esi: 00000000   edi: 009c0ffc   ebp: f5bd8000   esp: f5bd9fc8
ds: 007b   es: 007b   ss: 0068
Process default.hotplug (pid: 1124, threadinfo=f5bd8000 task=f5999b10)
Stack: 00000000 00000003 00000000 00000000 009c0ffc bf96dd58 000000dd 0000007b 
       0000007b ffffff00 c01027ba 00000060 00000246 0000007b 
Call Trace:
 [<c01035dc>] show_stack+0x7a/0x90
 [<c0103758>] show_registers+0x14d/0x1c5
 [<c0103956>] die+0xf4/0x186
 [<c010f15d>] do_page_fault+0x430/0x649
 [<c0103283>] error_code+0x2b/0x30
Code: 45 08 81 01 75 7d 3d 21 01 00 00 0f 83 da 00 00 00 ff 14 85 00 39 40 c0 89 44 24 18 fa 8b 4d 08 66 f7 c1 ff fe 0f 85 80 00 00 00 <8b> 44 24 38 5b 59 5a 5e 5f 5d 58 1f 07 83 c4 04 cf 8d 76 00 f6 
 <1>Unable to handle kernel paging request at virtual address f50a8000
 printing eip:
c0102874
*pde = 00515067
*pte = 350a8000
Oops: 0000 [#2]
PREEMPT DEBUG_PAGEALLOC
Modules linked in:
CPU:    0
EIP:    0060:[<c0102874>]    Not tainted VLI
EFLAGS: 00010046   (2.6.12-rc2) 
EIP is at restore_all+0x0/0x14
eax: 00000260   ebx: 00000003   ecx: 00000000   edx: 00000001
esi: 00000008   edi: 009c0ffc   ebp: f50a6000   esp: f50a7fc8
ds: 007b   es: 007b   ss: 0068
Process default.hotplug (pid: 1181, threadinfo=f50a6000 task=f55f9b10)
Stack: 00000003 bff9500c bff94f7c 00000008 009c0ffc bff94f60 000000ae 0000007b 
       0000007b ffffff00 c01027ba 00000060 00000286 0000007b 
Call Trace:
 [<c01035dc>] show_stack+0x7a/0x90
 [<c0103758>] show_registers+0x14d/0x1c5
 [<c0103956>] die+0xf4/0x186
 [<c010f15d>] do_page_fault+0x430/0x649
 [<c0103283>] error_code+0x2b/0x30
Code: 45 08 81 01 75 7d 3d 21 01 00 00 0f 83 da 00 00 00 ff 14 85 00 39 40 c0 89 44 24 18 fa 8b 4d 08 66 f7 c1 ff fe 0f 85 80 00 00 00 <8b> 44 24 38 5b 59 5a 5e 5f 5d 58 1f 07 83 c4 04 cf 8d 76 00 f6 
 <1>Unable to handle kernel paging request at virtual address f553e000
 printing eip:
c0102874
*pde = 00516067
*pte = 3553e000
Oops: 0000 [#3]
PREEMPT DEBUG_PAGEALLOC
Modules linked in:
CPU:    0
EIP:    0060:[<c0102874>]    Not tainted VLI
EFLAGS: 00010046   (2.6.12-rc2) 
EIP is at restore_all+0x0/0x14
eax: 00000260   ebx: 00000000   ecx: 00000000   edx: 00000001
esi: 00000008   edi: 009c0ffc   ebp: f553c000   esp: f553dfc8
ds: 007b   es: 007b   ss: 0068
Process default.hotplug (pid: 1113, threadinfo=f553c000 task=f5a75b10)
Stack: 00000000 00000000 080e1f3c 00000008 009c0ffc bf856de0 000000af 0000007b 
       0000007b ffffffef c01027ba 00000060 00000246 0000007b 
Call Trace:
 [<c01035dc>] show_stack+0x7a/0x90
 [<c0103758>] show_registers+0x14d/0x1c5
 [<c0103956>] die+0xf4/0x186
 [<c010f15d>] do_page_fault+0x430/0x649
 [<c0103283>] error_code+0x2b/0x30
Code: 45 08 81 01 75 7d 3d 21 01 00 00 0f 83 da 00 00 00 ff 14 85 00 39 40 c0 89 44 24 18 fa 8b 4d 08 66 f7 c1 ff fe 0f 85 80 00 00 00 <8b> 44 24 38 5b 59 5a 5e 5f 5d 58 1f 07 83 c4 04 cf 8d 76 00 f6 
 
