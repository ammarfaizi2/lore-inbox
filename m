Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265480AbTAJSBR>; Fri, 10 Jan 2003 13:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265513AbTAJSBQ>; Fri, 10 Jan 2003 13:01:16 -0500
Received: from gra-lx1.iram.es ([150.214.224.41]:51894 "EHLO gra-lx1.iram.es")
	by vger.kernel.org with ESMTP id <S265480AbTAJSBO>;
	Fri, 10 Jan 2003 13:01:14 -0500
Date: Fri, 10 Jan 2003 19:08:00 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Ingo Molnar <mingo@elte.hu>, Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Ulrich Drepper <drepper@redhat.com>, <davej@codemonkey.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <3E1F0A8E.1070000-100000@iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> It shouldn't matter.
>
> NT is only tested by "iret", and if somebody sets NT in user space they
> get exactly what they deserve.

Indeed. I realized after I sent the previous mail that I had missed the
flags save/restore in switch_to :-(

Still, does this mean that there is some micro optimization opportunity in
the lcall7/lcall27 handlers to remove the popfl? After all TF is now
handled by some magic in do_debug unless I miss (again) something,
NT has become irrelevant, and cld in SAVE_ALL takes care of DF.

In short something like the following (I just love patches which only
remove code):

===== entry.S 1.51 vs edited =====
--- 1.51/arch/i386/kernel/entry.S	Mon Jan  6 04:54:58 2003
+++ edited/entry.S	Fri Jan 10 18:57:42 2003
@@ -156,16 +156,6 @@
 	movl %edx,EIP(%ebp)	# Now we move them to their "normal" places
 	movl %ecx,CS(%ebp)	#

-	#
-	# Call gates don't clear TF and NT in eflags like
-	# traps do, so we need to do it ourselves.
-	# %eax already contains eflags (but it may have
-	# DF set, clear that also)
-	#
-	andl $~(DF_MASK | TF_MASK | NT_MASK),%eax
-	pushl %eax
-	popfl
-
 	andl $-8192, %ebp	# GET_THREAD_INFO
 	movl TI_EXEC_DOMAIN(%ebp), %edx	# Get the execution domain
 	call *4(%edx)		# Call the lcall7 handler for the domain


>>For example, set NT and then execute sysenter with garbage in %eax, the
>>kernel will try to return (-ENOSYS) with iret and kill the task. As long
>>as it only allows a task to kill itself, it's not a big deal. But NT is
>>not cleared across task switches unless I miss something, and that looks
>>very dangerous.
>
>
> It _is_ cleared by task-switching these days. Or rather, it's saved and
> restored, so the original NT setter will get it restored when resumed.

Yeah, sorry for the noise.

>
>
>>I'm no Ingo, unfortunately, but you'll need at least the following patch
>>(the second hunk is only a typo fix) to the iret exception recovery code,
>>which used push and pops to get the smallest possible code size.
>
>
> Good job.

That was too easy since I did originally suggest the push/pop sequence :-)

	Gabriel.



