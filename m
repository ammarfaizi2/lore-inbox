Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263408AbTDCPLW>; Thu, 3 Apr 2003 10:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263411AbTDCPLW>; Thu, 3 Apr 2003 10:11:22 -0500
Received: from pcow057o.blueyonder.co.uk ([195.188.53.94]:38666 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S263408AbTDCPLV>;
	Thu, 3 Apr 2003 10:11:21 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: ptrace patch fails stress testing
Reply-To: James Cownie <jcownie@etnus.com>
Date: Thu, 03 Apr 2003 16:22:48 +0100
From: James Cownie <jcownie@etnus.com>
Message-ID: <1916YC-0Qp-00@etnus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote :-

> On Tue, 2003-04-01 at 19:22, linas@austin.ibm.com wrote:
> > The problem appears to be that task->mm is dereferenced without
> > looking to see if mm is NULL. e.g. in the sched.h in the
> > is_dumpable() macro, we have task->mm->dumpable . I'm sitting
> > in front of a KDB session and I'm clearly looking at task->mm
> > which is NULL.
> > Why, how and under what conditions this race condition occurs,
> > I don't know. What the best fix is, I don't know.
> 
> Zombie process. The patch checks ->mm but must also check ->mm != NULL
> first.

We're seeing this 100% reliably with out TotalView debugger, and as
Alan suggests it happens when trying to make a ptrace call on a zombie
process.

FWIW the oops looks like this 

  >>EIP; c01197f3 <ptrace_check_attach+13/50>   <=====
  Trace; c0109bc6 <sys_ptrace+ba/580>
  Trace; c0106cb8 <error_code+34/3c>
  Trace; c0106bc7 <system_call+33/38>
  Code;  c01197f3 <ptrace_check_attach+13/50>
  00000000 <_EIP>:
  Code;  c01197f3 <ptrace_check_attach+13/50>   <=====
     0:   f6 40 7c 01               testb  $0x1,0x7c(%eax)   <=====
  Code;  c01197f7 <ptrace_check_attach+17/50>
     4:   75 07                     jne    d <_EIP+0xd> c0119800 <ptrace_check_attach+20/50>
  Code;  c01197f9 <ptrace_check_attach+19/50>
     6:   b8 ff ff ff ff            mov    $0xffffffff,%eax
  Code;  c01197fe <ptrace_check_attach+1e/50>
     b:   c3                        ret    
  Code;  c01197ff <ptrace_check_attach+1f/50>
     c:   90                        nop    
  Code;  c0119800 <ptrace_check_attach+20/50>
     d:   f6 42 18 01               testb  $0x1,0x18(%edx)
  Code;  c0119804 <ptrace_check_attach+24/50>
    11:   75 0a                     jne    1d <_EIP+0x1d> c0119810 <ptrace_check_attach+30/50>
  Code;  c0119806 <ptrace_check_attach+26/50>
    13:   b8 00 00 00 00            mov    $0x0,%eax

which corresponds to checking a null mm.

Following Alan, the fix, then is to have is_dumpable look like this :-

#define is_dumpable(tsk)	((tsk)->task_dumpable && (tsk)->mm && (tsk)->mm->dumpable)

(and be prepared un user space to get EPERM back from some ptrace
calls which previously "worked" ok.)

-- Jim 

James Cownie	<jcownie@etnus.com>
Etnus, LLC.     +44 117 9071438
http://www.etnus.com
