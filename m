Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbVDEHDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVDEHDc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 03:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbVDEHDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 03:03:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:49840 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261587AbVDEHD0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 03:03:26 -0400
Date: Tue, 5 Apr 2005 00:03:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, stsp@aknet.ru
Subject: Re: crash in entry.S restore_all, 2.6.12-rc2, x86, PAGEALLOC
Message-Id: <20050405000319.4fa1d962.akpm@osdl.org>
In-Reply-To: <20050405065544.GA21360@elte.hu>
References: <20050405065544.GA21360@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> the crashes below happen when PAGEALLOC is enabled. It's this 
>  instruction:
> 
>          movb OLDSS(%esp), %ah
> 
>  OLDSS is 0x38, esp is f4f83fc8, OLDSS(%esp) is thus f4f84000, which 
>  correctly creates the PAGEALLOC pagefault. esp is off by 4 bytes?
> 
>  it could be the ESP-16-bit-corruption patch causing this,

Do you have nmis enabled?



From: Akinobu Mita <amgta@yacht.ocn.ne.jp>

With nmi_watchdog=1, I got random Oopses (Unable to handle kernel paging
request, not by the NMI oopser) from many processes.  It is not happend
with -rc1.

The following change fixes this problem.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/i386/kernel/entry.S |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/i386/kernel/entry.S~nmi_stack_correct-fix arch/i386/kernel/entry.S
--- 25/arch/i386/kernel/entry.S~nmi_stack_correct-fix	2005-04-05 00:02:48.000000000 -0700
+++ 25-akpm/arch/i386/kernel/entry.S	2005-04-05 00:02:48.000000000 -0700
@@ -550,7 +550,7 @@ nmi_stack_correct:
 	xorl %edx,%edx		# zero error code
 	movl %esp,%eax		# pt_regs pointer
 	call do_nmi
-	jmp restore_all
+	jmp restore_nocheck
 
 nmi_stack_fixup:
 	FIX_STACK(12,nmi_stack_correct, 1)
_

