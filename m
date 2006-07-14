Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbWGNPYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbWGNPYW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 11:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWGNPYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 11:24:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7580 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932408AbWGNPYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 11:24:22 -0400
Date: Fri, 14 Jul 2006 08:23:55 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove volatile from nmi.c
In-Reply-To: <1152882288.1883.30.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0607140757080.5623@g5.osdl.org>
References: <1152882288.1883.30.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 14 Jul 2006, Steven Rostedt wrote:
>
> OK, I'm using this as something of an exercise to completely understand
> memory barriers.  So if something is incorrect, please let me know.

It's not an incorrect change, but perhaps more importantly, the old code 
was buggy in other ways too. Which is sadly more-than-common with anything 
that uses volatile - the issues that make people think using "volatile" is 
a good idea also tend to cause other problems if the person in question 
isn't careful (and using "volatile" obviously means that he/she/it wasn't 
very careful when writing it).

In particular, notice how "endflag" is on the _stack_ of the CPU that 
wants to send out the NMI to another CPU?

Now, think what that means for the case where we time out and return from 
the function with an error.. In particular, think about the case of the 
other CPU having been very busy, and now having a stale pointer that 
points _where_ exactly?

Also, when the caller sets "endflag", it doesn't (for barrier reasons, see 
more below) actually need to use a write barrier in either of the two 
cases, because of some _other_ issues. There are two cases of the caller 
setting endflag, and neither of them needs "set_wmb()", but it's perhaps 
instructive to show _why_.

The first case is the initialization to zero. That one doesn't need a 
write barrier, because it has _other_ serialization to any reader. In 
order for another CPU to read that value, the other CPU needs to have 
_gotten_ the pointer to it in the first place, and that implies that it 
got the "smp_call_function()" thing.

And "smp_call_function()" will better have a serialization in it, because 
otherwise _any_ user of smp_call_function() would potentially set up data 
structures that aren't then readable from other CPUs. So for the 
particular case of x86, see the "mb()" in smp_call_function() just before 
it does the "send_IPI_allbutself()".

Now, the other case is the case where we set endflag to 1 because we're no 
longer interested in the other CPU's. And the reason we don't need a 
barrier there is that WE OBVIOUSLY NO LONGER CARE when the other side 
sees the value - at that point, it's all moot, because there isn't any 
serialization left, and it's just a flag to the other CPU's saying "don't 
bother".

So let's go back to the bigger problem..

Now, there is a "reason" we'd want "endflag" to either be volatile, or 
have the "set_wmb()", and that is that the code is incorrect in the first 
place. 

Without the volatile, or the "set_wmb()", the compiler could decide to not 
do the last "endflag = 1" write _at_all_, because

 - endflag is an automatic variable

 - we're going to return from the function RSN, which de-allocates it

and as such, the "volatile" or "set_wmb()" actually forces that write to 
happen at all. It so happens that because we have a printk() in there, and 
gcc doesn't know that the printk() didn't get the address of the variable 
through the "smp_call_function()" thing, gcc won't dare to remove the 
write anyway, but let's say that the final 'printk("OK.\n");' wasn't 
there, then the compiler could have removed it.

So in that sense, "volatile" and "set_wmb()" superficially "remove a bug", 
since optimizing out the write is wrong. However, the REAL bug was totally 
elsewhere, and is the fact that "endflag" is an automatic variable in the 
first place! The compiler would have been _correct_ to optimize the store 
away, because the compiler (unlike the programmer) would have correctly 
realized that it cannot matter.

> The first removal is trivial, since the barrier in the while loop makes
> it unnecessary.

Yes, and the first removal is also very much correct.

> The second is what I think is correct.

See above. The second is "correct", in the sense that from a "volatile 
removal" standpoint it does all the right things. But it's incorrect, 
because it misses the bigger problem with the code.

So I would suggest that the _real_ fix is actually something like the 
appended, but I have to say that I didn't really look very closely into 
it.

I think that in _practice_ it probably doesn't really matter (in practice, 
the other CPU's will either get the NMI or not, and in practice, the stack 
location - even after it is released - will probably be overwritten by 
something non-zero later anyway), but I think that my fix makes it more 
obvious what is really going on, and it's easier to explain why it does 
what it does because it no longer depends on insane code.

But somebody like Ingo should probably double-check this.

(The "Have we done this already" test is just covering my ass - I don't 
think we should be calling that function more than once, but one of the 
things that happens when the "endflag" semantics are fixed is that the 
function now has history and the variable is no longer "per CPU". The 
point is, that changes how initializations etc may need to be done: in 
this case we only want to do it once, but in other cases this kind of 
change may have more far-reaching implications).

		Linus

---
diff --git a/arch/i386/kernel/nmi.c b/arch/i386/kernel/nmi.c
index 2dd928a..eb8bbbb 100644
--- a/arch/i386/kernel/nmi.c
+++ b/arch/i386/kernel/nmi.c
@@ -106,7 +106,7 @@ #ifdef CONFIG_SMP
  */
 static __init void nmi_cpu_busy(void *data)
 {
-	volatile int *endflag = data;
+	int *endflag = data;
 	local_irq_enable_in_hardirq();
 	/* Intentionally don't use cpu_relax here. This is
 	   to make sure that the performance counter really ticks,
@@ -121,10 +121,14 @@ #endif
 
 static int __init check_nmi_watchdog(void)
 {
-	volatile int endflag = 0;
+	static int endflag = 0;
 	unsigned int *prev_nmi_count;
 	int cpu;
 
+	/* Have we done this already? */
+	if (endflag)
+		return 0;
+
 	if (nmi_watchdog == NMI_NONE)
 		return 0;
 
