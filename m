Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264414AbTDXF20 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 01:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264429AbTDXF20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 01:28:26 -0400
Received: from adsl-b3-75-165.telepac.pt ([213.13.75.165]:27048 "HELO
	puma-vgertech.no-ip.com") by vger.kernel.org with SMTP
	id S264414AbTDXF2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 01:28:17 -0400
Message-ID: <3EA778E7.5040903@vgertech.com>
Date: Thu, 24 Apr 2003 06:40:55 +0100
From: Nuno Silva <nuno.silva@vgertech.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: Bernhard Kaindl <bernhard.kaindl@gmx.de>
CC: Yusuf Wilajati Purna <purna@sm.sony.co.jp>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, rmk@arm.linux.org.uk,
       linux-kernel@vger.kernel.org, arjanv@redhat.com,
       Bernhard Kaindl <bk@suse.de>
Subject: Re: [PATCH][2.4+ptrace] fix side effects of the kmod/ptrace secfix
References: <3E9E3FA9.6060509@sm.sony.co.jp> <Pine.LNX.4.53.0304190532520.1887@hase.a11.local> <3EA4CD3F.9040902@sm.sony.co.jp> <Pine.LNX.4.53.0304222236040.2341@hase.a11.local>
In-Reply-To: <Pine.LNX.4.53.0304222236040.2341@hase.a11.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning! :)

I'd like to ear an "official" word on this subject, please. :)
Is this patch still secure?

I don't like having a known root hole in my servers but i'd like to have 
the same functionallity as before. Right now it seams that I can't have 
both :(

Alan? Marcelo? Linus? HELPPPPPPPPP! :)

Regards,
Nuno Silva

Bernhard Kaindl wrote:
> Hello Marcelo, Hello Yusuf!
> 
>   I've attached a patch which fixes the remaining side effects
> which the ptrace fix posted by Alan introduced(which affect production
> systems) and I'm sending this because I think 2.4.20-rc1 should
> not be released as 2.4.21 without these problems fixed.
> 
> On Tue, 22 Apr 2003, Yusuf Wilajati Purna wrote:
> 
>>Thanks for the clarification. :-)
> 
> 
> Sorry if my descriptions in my previos mail did not have any word too
> much(really short) but I tried to make the point straight for people
> which know the code. I'm adding a little bit more verbosity now :-)
> 
> The check added by Alan's patch to ptrace_check_attach was:
> 
> +       if (!is_dumpable(child))
> +               return -EPERM;
> 
> New, replacement check in ptrace_check_attach:
> 
> +       if (!child->task_dumpable)
> +               return -EPERM;
> 
> I want to explain now, why the above use of is_dumpable() broke ptrace
> of setuid programs by root:
> 
> is_dumpable() checks if both, task_dumpable and mm->dumpable are set, and
> evaluates to false, if one of them is false.
> 
> The new kernel_thread() function added by Alan's patch sets task_dumpable
> (which is 1 by default) for the new kernel thread to 0, and this is the
> only place where his new variable is set to 0, so "non_kernel_thread"
> would accurately describe what it is saying.
> 
> By adding is_dumpable(child) to ptrace_check_attach(), the patch posted
> by Alan, not only a check if the task is a kernel thread, but also a
> check if the task changed it's uid's was added(what mm->dumpable says)
> so even root was blocked out by this check.
> 
> So, removing the wrong check to child->mm->dumpable and only checking
> child->task_dumpable (wnich really means "non_kernel_thread") is the
> first part of the fix.
> 
> The other place which needed to be touched to fix Alan's patch was
> access_process_vm(), where Alan's patch did this change:
> 
> 
>>>@@ -123,6 +127,8 @@ int access_process_vm(struct task_struct
>>>       /* Worry about races with exit() */
>>>       task_lock(tsk);
>>>       mm = tsk->mm;
>>>+       if (!is_dumpable(tsk) || (&init_mm == mm))
>>>+               mm = NULL;
>>>       if (mm)
>>>               atomic_inc(&mm->mm_users);
>>>       task_unlock(tsk);
> 
> 
> access_process_vm() is in the same code patch as ptrace_check_attach.
> 
> If you read the sys_ptrace implementation in arch/i386/kernel/ptrace.c,
> you'll find a call to ptrace_check_attach() and then, shortly afterwards,
> depending on what ptrace action was requested, a call to access_process_vm()
> 
> So the !is_dumpable(tsk) check above it just a repetition if the previous
> check which you can also replace with !tsk->task_dumpable which you correctly
> understood and you show below in your change:
> 
> 
>>Just to recapitulate,
>>The following changes to the original patch (Alan's patch):
>>
>>   int ptrace_check_attach(struct task_struct *child, int kill)
>>   {
>>           ...
>>   +      if (!child->task_dumpable)
>>   +      return -EPERM;
>>   }
>>
>>   int access_process_vm(struct task_struct *tsk, unsigned long addr,
>>void *buf, int len, int write)
>>   {
>>           ...
>>           /* Worry about races with exit() */
>>           task_lock(tsk);
>>           mm = tsk->mm;
>>   +      if (!tsk->task_dumpable || (&init_mm == mm))
>>   +                mm = NULL;
> 
> 
> Note, in addtion to breaking root's ability to trace setuid programs,
> having the tsk->mm->dumpable checked by !is_dumpable(tsk) at this place
> also broke /proc/PID/cmdline and /proc/PID/environ because access_process_vm()
> is also used by these proc functions.
> 
> If somebody says this opens a securtiy leak, I'd have to say:
> 
>  If a suid task leaks such information thru it's cmdline buffer, it's
>  the problem of the suid process not acting secure and should be reviewed.
> 
>  You would need to restrict cmdline access to all root processes(not only
>  suid) and maybe even to all processes with different capabilites and uid/gid
>  to work around problems in such processes. But you would break even more
>  system monitoring stuff this way(I've even heard shutdown is affected)
> 
> 
>>           ...
>>   }
>>
>>can solve the following side-effects introduced by the original patch:
>>
>>- /proc/PID/cmdline and /proc/PID/environ are empty for non-dumpable
>>process es
>>  even for root. (ps displays those processes in [] brackets.)
>>  http://marc.theaimsgroup.com/?l=linux-kernel&m=104807368719299&w=2
>>
>>- strace started by root cannot ptrace user threads or such non-dumpable
>>processes.
>>  http://marc.theaimsgroup.com/?l=linux-kernel&m=104835339619706&w=2
> 
> 
> Yes exacly, they do fix these side-effects, as your test correctly gives:
> 
> 
>>At least, I have confirmed this on an i386/IA-32 platform. And I have
>>checked also
>>that ptrace/kmod exploits such as isec-ptrace-kmod-exploit.c, ptrace.c,
>>km3.c cannot
>>get root privilege with the changes.
> 
> 
> Exactly, the change (effectve removal of the task->mm->dumpable flag check,
> which is not part of the kernel_thread/ptrace issue, fix the the two side
> effects you describe above while maintaining same security against the
> kmod/ptrace exploits because it only removes code that has nothing to
> do with the kernel_thread/ptrace issue, which was added by Alan's patch
> and introduced these side effects.
> 
> It's really that easy, you just have to look and the code and see it ;-)
> 
> Ok, you need to understand how the ptrace code works and how Alan's
> patch effectively blocks all possible trace attempts and backdoors,
> but once you understood how it works, it's easy to identify the parts
> of Alan's patch which cause these side effects.
> 
> It's just cleanup, nothing more, nothing very creative, but a nice
> opportunity to learn a little bit about the kernel, no deep knowledge
> about VM or something really complex is needed.
> 
> <tiny font>
> If you look sharper, you can even start cleaning up more of code added
> by the patch Alan sent (the above checks are completely unneccesary ;-)
> but you need the big picture for this and I have to give you this big
> picture in a separate mail to make this point.
> </tiny font>
> 
>>Any comments?
> 
> 
> I'm sorry that I did not send a patch the first time to make the
> change 100% clear to anybody, but I'm doing this now.
> 
> Incremental patch which applies on top of the patch posted by
> Alan and also on top of 2.4.21-rc1 is attached now.
> 
> With only this patch applied I'd think 2.4.21 could be released,
> but not without this minimum fix.
> 
> 2.4.21-rc1, if it would be released as is, has the potential of
> breaking lots of systems which rely on not seeing the side effects
> Yusuf Wilajati Purna describes above and are fixed by this
> incremental fix.
> 
> Best Regards,
> Bernhard Kaindl
> SuSE Linux
> 
> 
> ------------------------------------------------------------------------
> 
> --- kernel/ptrace.c	2003/04/22 21:14:20	1.1
> +++ kernel/ptrace.c	2003/04/22 21:15:40
> @@ -22,7 +22,7 @@
>  int ptrace_check_attach(struct task_struct *child, int kill)
>  {
>  	mb();
> -	if (!is_dumpable(child))
> +	if (!child->task_dumpable)
>  		return -EPERM;
>  
>  	if (!(child->ptrace & PT_PTRACED))
> @@ -127,7 +127,7 @@
>  	/* Worry about races with exit() */
>  	task_lock(tsk);
>  	mm = tsk->mm;
> -	if (!is_dumpable(tsk) || (&init_mm == mm))
> +	if (!tsk->task_dumpable || (&init_mm == mm))
>  		mm = NULL;
>  	if (mm)
>  		atomic_inc(&mm->mm_users);

