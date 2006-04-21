Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWDUB3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWDUB3U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 21:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWDUB3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 21:29:20 -0400
Received: from ishtar.tlinx.org ([64.81.245.74]:10894 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S932128AbWDUB3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 21:29:19 -0400
Message-ID: <4448355F.7070509@tlinx.org>
Date: Thu, 20 Apr 2006 18:29:03 -0700
From: "Linda A. Walsh" <law@tlinx.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>, "Linda A. Walsh" <law@tlinx.org>,
       Stephen Smalley <sds@tycho.nsa.gov>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       linux-security-module@vger.kernel.org, chrisw@sous-sol.org,
       linux-kernel@vger.kernel.org, Tony Jones <tonyj@suse.de>
Subject: Re: [RFC][PATCH 11/11] security: AppArmor - Export namespace	semaphore
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <20060419175034.29149.94306.sendpatchset@ermintrude.int.wirex.com> <1145536742.16456.35.camel@moss-spartans.epoch.ncsc.mil> <20060420124647.GD18604@sergelap.austin.ibm.com> <1145534735.3313.3.camel@moss-spartans.epoch.ncsc.mil> <20060420132128.GG18604@sergelap.austin.ibm.com> <1145537318.3313.40.camel@moss-spartans.epoch.ncsc.mil> <44480727.9010500@tlinx.org> <20060420230551.GA5026@infradead.org>
In-Reply-To: <20060420230551.GA5026@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Thu, Apr 20, 2006 at 03:11:51PM -0700, Linda A. Walsh wrote:
>   
>>    The *current* accepted way to get pathnames going into system
>> calls is to trap the syscall vector as audit currently does --
>>     
> It's not and it's never been.  [suggestion deleted]
   What is not?  I'm looking at entry.S, and 2 ptrace.c's, one under
arch/i386/kernel and another under kernel.  Perhaps we are talking
about different architectures?  Referring to the i386 architecture,

    entry.S has the system call table processing, no?
    This is the the code from the sysenter call:

 testw $(_TIF_SYSCALL_EMU|_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AU
DIT),TI_flags(%ebp)

    That looks like a patch for SECCOMP, SYSCALL_EMU and AUDIT that goes
off to do special processing in the system sys_trace call.  This calls the
ptrace function for every syscall, no? Doesn't that then call
kernel/ptrace.c(sys_ptrace), grab the system lock (that is
what lock_system() is for, isn't it?), which then calls the
arch-specific ptrace.c in 'arch/i386/kernel'? Or have I missed
something yet?

    Now here is code from that ptrace.c:
------------
/* notification of system call entry/exit
 * - triggered by current->work.syscall_trace
 */                    
__attribute__((regparm(3)))
int do_syscall_trace(struct pt_regs *regs, int entryexit)
{      
    ... do sysemu related stuff... 
     
    /* do the secure computing check first */
    if (!entryexit)
        secure_computing(regs->orig_eax);  

    if (unlikely(current->audit_context)) {
        if (entryexit)
            audit_syscall_exit(current, AUDITSC_RESULT(regs->eax),
                                  regs->eax);
--------------
    Doesn't ptrace trap every syscall and call audit for every syscall
when audit is enabled? 

    Perhaps my wording was confusing?  I'm sorry, I should have
said:

    "The *current* accepted way to get pathnames going into system calls is
to put a trap in the syscall vector processing code to be indirectly
called through the ptrace call with every system call as audit currently 
does..."?

    Or is that not correct either?  If not, could you please be more
specific in your objection instead of suggesting I get pointers on my sex
life?

    Of course the above code brings up a 2nd question.  Is it acceptable
for audit records to be lost, or if a system gets heavily loaded, isn't
it possible for audit_syscall to block waiting some place to record the
audit context?   Wouldn't those call occur after the "lock_kernel();"
line in kernel/ptrace.c, Could it be holding the "big kernel lock"
(still) when it blocks?  Or would audit drop the kernel lock before
blocking?

    In my last linux audit driver implementation, I had it setup such
that the audited process would block, but the system could continue so
that "auditd" (a non audited process) could free up a buffer by "reading"
it thus unblocking any processes blocked on an audit call.  But, not
hanging the system needlessly was one of my design goals.

Linda




