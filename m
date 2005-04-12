Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262445AbVDLUlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262445AbVDLUlx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbVDLUls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:41:48 -0400
Received: from mail.aknet.ru ([217.67.122.194]:32529 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S262445AbVDLThp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 15:37:45 -0400
Message-ID: <425C2396.6070200@aknet.ru>
Date: Tue, 12 Apr 2005 23:37:58 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: petkov@uni-muenster.de, jamagallon@able.es, linux-kernel@vger.kernel.org
Subject: [patch 0/3] Re: 2.6.12-rc2-mm3
References: <20050411012532.58593bc1.akpm@osdl.org>	<1113209793l.7664l.1l@werewolf.able.es>	<20050411024322.786b83de.akpm@osdl.org>	<200504112359.40487.petkov@uni-muenster.de>	<20050411152243.22835d96.akpm@osdl.org>	<425B4C92.1070507@aknet.ru> <20050411212712.0dbd821d.akpm@osdl.org>
In-Reply-To: <20050411212712.0dbd821d.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Andrew Morton wrote:
> OK, the `int $3' is part of the CONFIG_TRAP_BAD_SYSCALL_EXITS thing which I
> never use.
> I'm not sure what problem is actually being reported here, now you mention it.
The problem being reported here is that
CONFIG_TRAP_BAD_SYSCALL_EXITS does nothing
but locking up your machine. Actually the
bug was so obvious, that I had real troubles
finding it (the obvious things are difficult
to spot), so I found some more bugs in a
mean time.
What was the bug? GET_THREAD_INFO(%ebp) was
missing before TI_preempt_count(%ebp), hence
the accesses beyond the stack. I'll have
troubles beleiving this code worked without
a lock-ups for someone sometimes.
I fixed it differently though. The subsequent
patches are addressing the issue.

> Yup.  But are you sure that the "+ 8" is correct, given these offsets are<>
> larger than that?
I don't think they are indeed larger. The %esp
points to "struct pt_regs", which is 60 bytes
in size, and without the xss/esp = 52. Adding
8 to this gives 60, so 56(+3) looks safe to me.

> Probably it decided that some syscall got a "bad exit".  Disable
> CONFIG_TRAP_BAD_SYSCALL_EXITS.
Yes, that's the fix too.

>> > -	p->thread.esp0 = (unsigned long) (childregs+1) - 8;
>> > +	p->thread.esp0 = (unsigned long) (childregs+1) - 15;
>> 15 is somewhat nasty - it will make the
>> stack unaligned, should better be 16 I
>> think.
> ?  It's still 4-byte-aligned.
I don't see your point. Why do you think that
I substract the stack pointer by 32 bytes, for
example? I literally substract it by 8 bytes,
you propose to substract it by 15 *bytes* (not
dwords), so why would it still be aligned?
But anyway, fortunately this bug is not about
the esp0 stuff at all.

> I'm suspecting this is all due to CONFIG_TRAP_BAD_SYSCALL_EXITS taking the
> debug trap..
Sure. And that looks silly. I removed "int $3".
Patches follow. Seems to work reliable now,
but I don't know how to test it since there
seem to be no such an offending syscalls here
to test.

