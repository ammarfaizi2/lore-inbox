Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262011AbVDLFa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbVDLFa2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 01:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbVDLFXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 01:23:20 -0400
Received: from mail.aknet.ru ([217.67.122.194]:4619 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S262019AbVDLEUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 00:20:24 -0400
Message-ID: <425B4C92.1070507@aknet.ru>
Date: Tue, 12 Apr 2005 08:20:34 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Borislav Petkov <petkov@uni-muenster.de>, jamagallon@able.es,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm3
References: <20050411012532.58593bc1.akpm@osdl.org>	<1113209793l.7664l.1l@werewolf.able.es>	<20050411024322.786b83de.akpm@osdl.org>	<200504112359.40487.petkov@uni-muenster.de> <20050411152243.22835d96.akpm@osdl.org>
In-Reply-To: <20050411152243.22835d96.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Andrew Morton wrote:
>> Program received signal SIGTRAP, Trace/breakpoint trap.
SIGTRAP - it looks like the "int $3"
triggered, not "mov    0x30(%esp),%eax",
which is just the next insn and so the
%eip points to it, but it might be
innocent. And besides, 0x30(%esp) is
EFLAGS, not OLDSS. So I think maybe my
patch is not guilty this time, it is
just the non-zero preempt count on the
return path caused by something else.

>> (gdb) p $eip
>> $1 = (void *) 0xc0102ee7
Could you please also do
"p $esp" or "info reg", so that we can
see the rest of the registers?

>> And as we see, we're at the "mov    0x30(%esp),%eax" which accesses above the 
>> bottom of the stack.
But that's strange. Another instance of
the 0x30(%esp) is there a few instructions
above this one, see it with "disas restore_all".
It is much more likely that the real offender
is the previous instruction. $eip points on
the instruction *after* the trap, which might
be innocent.

>> After applying nmi_stack_correct-fix.patch, rc2-mm3
I can't find this one in an -mm broken-outs.
Where is this patch?
Could you please also test this one:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0504.0/1287.html
 
> Interesting.  It could be an interaction between the kgdb patch and the new
> vm86 checking code.
I think so too, will have a look if I can
reproduce it.

> The above code is accessing esp+56,
Yes, but this particular instruction was
not reached. "int $3" killed the system
for some reasons.

> -	p->thread.esp0 = (unsigned long) (childregs+1) - 8;
> +	p->thread.esp0 = (unsigned long) (childregs+1) - 15;
15 is somewhat nasty - it will make the
stack unaligned, should better be 16 I
think. But I don't see why, the only
scenario we've seen were the not stored
SS/ESP, which is 8 bytes only.
If we definitely think my patch is guilty
again, then probably something like this
is necessary:

--- linux/include/asm-i386/processor.h.old      2005-03-20 14:13:02.000000000 +0300
+++ linux/include/asm-i386/processor.h  2005-04-12 07:50:11.000000000 +0400
@@ -458,7 +458,7 @@
  * be within the limit.
  */
 #define INIT_TSS  {                                                    \
-       .esp0           = sizeof(init_stack) + (long)&init_stack,       \
+       .esp0           = sizeof(init_stack) - 8 + (long)&init_stack,   \
        .ss0            = __KERNEL_DS,                                  \
        .ss1            = __KERNEL_CS,                                  \
        .ldt            = GDT_ENTRY_LDT,                                \

But I don't think the init_stack can be
abused on the sysenter path, so this is
just a wild guess.

