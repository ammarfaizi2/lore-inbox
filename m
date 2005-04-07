Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262504AbVDGQLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262504AbVDGQLm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 12:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbVDGQLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 12:11:42 -0400
Received: from mail.aknet.ru ([217.67.122.194]:43525 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S262504AbVDGQLh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 12:11:37 -0400
Message-ID: <42555BBF.6090704@aknet.ru>
Date: Thu, 07 Apr 2005 20:11:43 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Petr Vandrovec <VANDROVE@vc.cvut.cz>
Subject: Re: crash in entry.S restore_all, 2.6.12-rc2, x86, PAGEALLOC
References: <20050405065544.GA21360@elte.hu> <4252E2C9.9040809@aknet.ru> <Pine.LNX.4.58.0504051217180.2215@ppc970.osdl.org> <4252EA01.7000805@aknet.ru> <Pine.LNX.4.58.0504051249090.2215@ppc970.osdl.org> <425403F6.409@aknet.ru> <20050407080004.GA27252@elte.hu>
In-Reply-To: <20050407080004.GA27252@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Ingo Molnar wrote:
> now if an interrupt hits at this point, it will set up a 'same privilege 
> level' stackframe, which has eip/xcs/eflags, i.e. no esp/xss.
Yes, that's something I tried to say
when talking about the interrupt gates
(sorry if I wasn't clear).

> If upon 
> irq-return we then examine the stack due to your patch, it will be an 
> incorrect stackframe -> kaboom.
Yes, and that's where I think my patch is
at fault, i.e. it just shouldn't do this.
Another option is to make it always possible
to access OLDSS(%esp), but I think it is just
my patch have to be fixed to not do this at all.

> your patch doesnt remove the condition, it only removes the crash, 
No, that wasn't my point at all. That example
with moving "sti" was *only* to answer Linus's
question of where we have an empty stack.
And I guess I wasn't clear enough also here,
I was in a hurry :(
The real patch I meant, is this one:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0504.0/1287.html
This, I am sure, fixes a real bug. But there
can be the other approaches too.

> because it adds the 2 words space that is needed - but the information 
> relied on by your irq-return test is still bogus.
But as an example for demonstrating the problem,
I thought, it could do:)

> At this point i'd 
> suggest to remove the ESP patch altogether.
That's probably too heavy-handed. The fix is
really simple, we can either store the right
values by hands (as you propose), or fix my
patch (as I propose).

> the correct solution is to always let the sysenter path set up a full 
> and correct stackframe,
But what will this solve? If I understand you
correctly, you will push the %ss/%esp of the
user-space process that did sysenter. Then
you enable the interrupts and get pre-empted.
Now what we have: OLDSS/OLDESP are of the
user-space process, but the EFLAGS/CS/EIP
are of the kernel (where it got pre-empted
on a sysenter path). This will avoid the crash,
but the information on stack is still wrong.
Or am I missing something?

> before allowing preemption (see the attached 
> patch).
Hmm, will it work also for NMIs? You move
the sti, you can't be pre-empted, but the
NMI uses the restore_all too, no?
Also, it seems that Linus wants only the
*some* values available on stack, just to
make it not to crash. I think we can simply
adjust the tss.esp0 to point 8 bytes below
the real stack top, and so we are always safe.

