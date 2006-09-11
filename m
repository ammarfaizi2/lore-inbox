Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbWIKVh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbWIKVh1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 17:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWIKVh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 17:37:27 -0400
Received: from gw.goop.org ([64.81.55.164]:31405 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S964814AbWIKVh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 17:37:26 -0400
Message-ID: <4505D709.9020409@goop.org>
Date: Mon, 11 Sep 2006 14:37:13 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Laurent Riffard <laurent.riffard@free.fr>,
       Arjan van de Ven <arjan@infradead.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: Re: [patch] i386-PDA, lockdep: fix %gs restore
References: <20060908011317.6cb0495a.akpm@osdl.org> <450499D3.5010903@goop.org> <20060911052527.GA12301@elte.hu> <200609112220.01032.ak@suse.de>
In-Reply-To: <200609112220.01032.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Monday 11 September 2006 07:25, Ingo Molnar wrote:
>   
>> Jeremy,
>>
>> could you back out Andi's patch and try the patch below, does it fix the
>> crash too?
>>     
>
> I folded it into the original patch now thanks
>   

Ingo's patch was wrong.  Here's an update:

Subject: [patch] i386-PDA, lockdep: fix %gs restore
From: Ingo Molnar <mingo@elte.hu>

in the syscall exit path the %gs selector has to be restored _after_ the
last kernel function has been called. If lockdep is enabled then this
kernel function is TRACE_IRQS_ON.

[ Make sure the move to %gs retains its exception label - jeremy@xensource.com ]

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

---
 arch/i386/kernel/entry.S |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff -r cead1b87fd17 arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	Sun Sep 10 16:28:43 2006 -0700
+++ b/arch/i386/kernel/entry.S	Mon Sep 11 14:22:36 2006 -0700
@@ -326,11 +326,11 @@ 1:	movl (%ebp),%ebp
 	testw $_TIF_ALLWORK_MASK, %cx
 	jne syscall_exit_work
 /* if something modifies registers it must also disable sysexit */
-1:	mov  PT_GS(%esp), %gs
 	movl PT_EIP(%esp), %edx
 	movl PT_OLDESP(%esp), %ecx
+	TRACE_IRQS_ON
+1:	mov  PT_GS(%esp), %gs
 	xorl %ebp,%ebp
-	TRACE_IRQS_ON
 	ENABLE_INTERRUPTS_SYSEXIT
 	CFI_ENDPROC
 .pushsection .fixup,"ax";	\


