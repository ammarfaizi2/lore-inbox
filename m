Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262232AbVDFPoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbVDFPoy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 11:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbVDFPoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 11:44:54 -0400
Received: from mail.aknet.ru ([217.67.122.194]:23817 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S262232AbVDFPou (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 11:44:50 -0400
Message-ID: <425403F6.409@aknet.ru>
Date: Wed, 06 Apr 2005 19:44:54 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Petr Vandrovec <VANDROVE@vc.cvut.cz>
Subject: Re: crash in entry.S restore_all, 2.6.12-rc2, x86, PAGEALLOC
References: <20050405065544.GA21360@elte.hu> <4252E2C9.9040809@aknet.ru> <Pine.LNX.4.58.0504051217180.2215@ppc970.osdl.org> <4252EA01.7000805@aknet.ru> <Pine.LNX.4.58.0504051249090.2215@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504051249090.2215@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Linus Torvalds wrote:
> Yes. But how do you have _such_ an empty stack when the interrupt comes
> in? See what I mean?
Yes, I hope so.

> IOW, that requires that the kernel stack would have
> only two words on it when the interrupt happens. How?
Well, you can simply do something like this:

--- entry.S.old1	2005-04-05 22:54:43.000000000 +0400
+++ entry.S	2005-04-06 19:35:14.000000000 +0400
@@ -179,9 +179,9 @@
 ENTRY(sysenter_entry)
 	movl TSS_sysenter_esp0(%esp),%esp
 sysenter_past_esp:
-	sti
 	pushl $(__USER_DS)
 	pushl %ebp
+	sti
 	pushfl
 	pushl $(__USER_CS)
 	pushl $SYSENTER_RETURN

And this will "elimenate" the problem
(modulo NMI and there could be other places
too, but for me it elimenates it completely).
So I don't think this is something strange.

> So I definitely think the "bug" is in your optimization,
Yes, and I think the patch I posted, can
just work, or are there the problems with
the taken forward jump on a fast path?

> I just think it 
> should be a valid optimization
But it is totally bogus, why not should it
crash? It is probably even very good that
it does:)

> and we should just make sure our kernel 
> stack is never _so_ empty that "struct pt_regs" is not safe to 
> dereference.
I guess you'll just need to adjust the tss.esp0
then, but do you really want this? Accesing
the registers that are simply not there, doesn't
sound too good I think.
Or am I still missing your point? 

