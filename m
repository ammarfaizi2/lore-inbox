Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbTDVEwE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 00:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbTDVEwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 00:52:04 -0400
Received: from NS4.Sony.CO.JP ([137.153.0.44]:5794 "EHLO ns4.sony.co.jp")
	by vger.kernel.org with ESMTP id S262914AbTDVEwB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 00:52:01 -0400
Message-ID: <3EA4CD3F.9040902@sm.sony.co.jp>
Date: Tue, 22 Apr 2003 14:03:59 +0900
From: Yusuf Wilajati Purna <purna@sm.sony.co.jp>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: Bernhard Kaindl <bk@suse.de>, rmk@arm.linux.org.uk,
       linux-kernel@vger.kernel.org, Bernhard Kaindl <bernhard.kaindl@gmx.de>,
       arjanv@redhat.com
CC: purna@sm.sony.co.jp
Subject: Re: 2.4+ptrace exploit fix breaks root's ability to strace
References: <3E9E3FA9.6060509@sm.sony.co.jp> <Pine.LNX.4.53.0304190532520.1887@hase.a11.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the clarification. :-)

Bernhard Kaindl wrote:

>On Thu, 17 Apr 2003, Yusuf Wilajati Purna wrote:
>
>>On 2003-03-22 17:28:54, Arjan van de Ven wrote:
>>
>>>On Sat, Mar 22, 2003 at 05:13:12PM +0000, Russell King wrote:
>>>
>>>>int ptrace_check_attach(struct task_struct *child, int kill)
>>>>{
>>>>	...
>>>>+       if (!is_dumpable(child))
>>>>+               return -EPERM;
>>>>}
>>>>
>>>>So, we went from being able to ptrace daemons as root, to being able to
>>>>attach daemons and then being unable to do anything with them, even if
>>>>you're root (or have the CAP_SYS_PTRACE capability).  I think this
>>>>behaviour is getting on for being described as "insane" 8) and is
>>>>clearly wrong.
>>>>
>>>ok it seems this check is too strong. It *has* to check
>>>child->task_dumpable and return -EPERM, but child->mm->dumpable is not
>>>needed.
>>>
>>So, do you mean that the following is enough:
>>
>>int ptrace_check_attach(struct task_struct *child, int kill)
>>{
>>      ...
>>+       if (!child->task_dumpable)
>>+               return -EPERM;
>>}
>>
>
>It's enough to still be safe against the ptrace/kmod exploits.
>
>I could not find a security problem in it yet because
>compute_cred() ignores the suid bit on exec when the
>process is being traced, so the strace does not get
>access to privileges from somebody else and ptrace_attach
>uses is_dumpable() which also checks task->mm->dumpable
>so a tracer can't attach to a suid program.
>
>It will also help the case Russell King describes above
>where root failed to trace a daemon which changed uids
>or a suid program, AFAICS.
>
>It is not the complete fix for it because the ptrace functions
>also use access_process_vm() where the patch had this hunk:
>
>@@ -123,6 +127,8 @@ int access_process_vm(struct task_struct
>        /* Worry about races with exit() */
>        task_lock(tsk);
>        mm = tsk->mm;
>+       if (!is_dumpable(tsk) || (&init_mm == mm))
>+               mm = NULL;
>        if (mm)
>                atomic_inc(&mm->mm_users);
>        task_unlock(tsk);
>
>You need to backout the tsk->mm->dumpable check done within is_dumpable
>here by just checking task_dumpable and then ptracing from root works
>prperly again.
>
>As the kmod ptrace fix relies on task_dumpable for it's protection against
>kernel thread trace, and you just remove the tsk->mm->dumpable check by
>replacing !is_dumpable(tsk) with !tsk->task_dumpable here also, you don't
>affect the kmod ptrace exploit protection in any way while fixing the
>ability of root to trace any task.
>
>This also fixes the problem /proc/<pid>/cmdline being empty (also for root)
>if <pid> is not dumpable, which is the other bug introduced by this hunk
>and broke process managment tools as it was also read on l-k.
>
Just to recapitulate,
The following changes to the original patch (Alan's patch):

   int ptrace_check_attach(struct task_struct *child, int kill)
   {
           ...
   +      if (!child->task_dumpable)
   +      return -EPERM;
   }

   int access_process_vm(struct task_struct *tsk, unsigned long addr, 
void *buf, int len, int write)
   {
           ...
           /* Worry about races with exit() */
           task_lock(tsk);
           mm = tsk->mm;
   +      if (!tsk->task_dumpable || (&init_mm == mm))
   +                mm = NULL;
           ...
   }

can solve the following side-effects introduced by the original patch:

- /proc/PID/cmdline and /proc/PID/environ are empty for non-dumpable 
process es
  even for root. (ps displays those processes in [] brackets.)
  http://marc.theaimsgroup.com/?l=linux-kernel&m=104807368719299&w=2

- strace started by root cannot ptrace user threads or such non-dumpable 
processes.
  http://marc.theaimsgroup.com/?l=linux-kernel&m=104835339619706&w=2

At least, I have confirmed this on an i386/IA-32 platform. And I have 
checked also
that ptrace/kmod exploits such as isec-ptrace-kmod-exploit.c, ptrace.c, 
km3.c cannot
get root privilege with the changes.

Any comments?

Thanks,
Purna


