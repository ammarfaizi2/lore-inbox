Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265773AbTBPDvQ>; Sat, 15 Feb 2003 22:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265777AbTBPDvQ>; Sat, 15 Feb 2003 22:51:16 -0500
Received: from franka.aracnet.com ([216.99.193.44]:10376 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265773AbTBPDvO>; Sat, 15 Feb 2003 22:51:14 -0500
Date: Sat, 15 Feb 2003 20:00:55 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: 2.5.61 oops running SDET
Message-ID: <11830000.1045368054@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0302151820200.25000-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0302151820200.25000-100000@home.transmeta.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Close, but you also need
> 
> -	buffer = task_sig(task, buffer);
> +	if (task->sighand)
> +		buffer = task_sig(task, buffer);
> 
> to actually check whether signals exist or not. Otherwise you'll just get 
> the same oops anyway (well, keeping the task locked may change timings 
> enough that it doesn't happen, but the bug will continue to be there.
> 
> I would also say that since you explicitly take the task lock, there's no 
> real reason to use "get_task_mm()" at all any more, so instead of doing 
> that (and then doing the mmput()), just get rid of the mm variable 
> entirely, and do
> 
> 	if (task->mm)
> 		buffer = task_mem(task->mm, buffer)
> 
> too. There's really no downside to just holding on to the task lock over
> the whole operation instead of incrementing and decrementing the mm
> counts and dropping the lock early.
> 
> (There are a few valid reasons for using the "get_task_mm()" function:
> 
>  - you need to block and thus drop the task lock
> 
>  - the original code just used "task->mm" directly, and using 
>    "get_task_mm()" made the original conversion to mm safe handling 
>    easier.
> 
> Neither reason is really valid any more in this function at least).

OK, I did the following, which is what I think you wanted, plus Zwane's
observation that task_state acquires the task_struct lock (we're the only 
caller, so I just removed it), but I still get the same panic and this time
the box hung. No doubt I've just done something stupid in the patch ...
(task_state takes the tasklist_lock ... is that safe to do inside task_lock?)

diff -urpN -X /home/fletch/.diff.exclude virgin/fs/proc/array.c sdet/fs/proc/array.c
--- virgin/fs/proc/array.c	Sat Feb 15 16:11:45 2003
+++ sdet/fs/proc/array.c	Sat Feb 15 19:28:34 2003
@@ -166,12 +166,10 @@ static inline char * task_state(struct t
 		p->uid, p->euid, p->suid, p->fsuid,
 		p->gid, p->egid, p->sgid, p->fsgid);
 	read_unlock(&tasklist_lock);	
-	task_lock(p);
 	buffer += sprintf(buffer,
 		"FDSize:\t%d\n"
 		"Groups:\t",
 		p->files ? p->files->max_fds : 0);
-	task_unlock(p);
 
 	for (g = 0; g < p->ngroups; g++)
 		buffer += sprintf(buffer, "%d ", p->groups[g]);
@@ -243,20 +241,20 @@ extern char *task_mem(struct mm_struct *
 int proc_pid_status(struct task_struct *task, char * buffer)
 {
 	char * orig = buffer;
-	struct mm_struct *mm = get_task_mm(task);
 
+	task_lock(task);
 	buffer = task_name(task, buffer);
 	buffer = task_state(task, buffer);
  
-	if (mm) {
-		buffer = task_mem(mm, buffer);
-		mmput(mm);
-	}
-	buffer = task_sig(task, buffer);
+	if (task->mm)
+		buffer = task_mem(task->mm, buffer);
+	if (task->sighand)
+		buffer = task_sig(task, buffer);
 	buffer = task_cap(task, buffer);
 #if defined(CONFIG_ARCH_S390)
 	buffer = task_show_regs(task, buffer);
 #endif
+	task_unlock(task);
 	return buffer - orig;
 }
 



Unable to handle kernel NULL pointer dereference at virtual address 00000014
 printing eip:
c0118b13
*pde = 2d4bf001
*pte = 00000000
Oops: 0000
CPU:    6
EIP:    0060:[<c0118b13>]    Not tainted
EFLAGS: 00010207
EIP is at render_sigset_t+0x17/0x7c
eax: 00000010   ebx: ed3d909f   ecx: ed3d9097   edx: eda60100
esi: 0000003c   edi: 00000010   ebp: ed49bf04   esp: ed49bef8
ds: 007b   es: 007b   ss: 0068
Process ps (pid: 3339, threadinfo=ed49a000 task=ee32cd20)
Stack: ed3d907d 00000002 ed3d909f 00000006 c016d85f 00000010 ed3d909f ed3d9097 
       c0233f38 eda606bc ed3d9086 ed3d907e c0233f2f ee1d7b70 eda60100 eeb4d0c0 
       ed3d9000 ee1d7b70 00000000 ed3d9000 000000d0 eeb4d0c0 c01300f6 c17119e8 
Call Trace:
 [<c016d85f>] proc_pid_status+0x26f/0x334
 [<c01300f6>] __get_free_pages+0x4e/0x54
 [<c016b517>] proc_info_read+0x53/0x130
 [<c0145295>] vfs_read+0xa5/0x128
 [<c0145522>] sys_read+0x2a/0x3c
 [<c0108b3f>] syscall_call+0x7/0xb

Code: 0f a3 37 19 d2 b8 01 00 00 00 31 c9 85 d2 0f 45 c8 8d 56 01 
 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000014
 printing eip:
c0118b13
*pde = 2d512001
*pte = 00000000
Oops: 0000
CPU:    2
EIP:    0060:[<c0118b13>]    Not tainted
EFLAGS: 00010207
EIP is at render_sigset_t+0x17/0x7c
eax: 00000010   ebx: ee34b0a0   ecx: ee34b098   edx: ed3ea7a0
esi: 0000003c   edi: 00000010   ebp: ed54ff04   esp: ed54fef8
ds: 007b   es: 007b   ss: 0068
Process ps (pid: 14710, threadinfo=ed54e000 task=ee430d40)
Stack: ee34b07e 00000002 ee34b0a0 00000006 c016d85f 00000010 ee34b0a0 ee34b098 
       c0233f38 ed3ead5c ee34b087 ee34b07f c0233f2f ee4960d0 ed3ea7a0 eec66ca0 
       ee34b000 ee4960d0 00000000 ee34b000 000000d0 eec66ca0 c01300f6 c17383b8 
Call Trace:
 [<c016d85f>] proc_pid_status+0x26f/0x334
 [<c01300f6>] __get_free_pages+0x4e/0x54
 [<c016b517>] proc_info_read+0x53/0x130
 [<c0145295>] vfs_read+0xa5/0x128
 [<c0145522>] sys_read+0x2a/0x3c
 [<c0108b3f>] syscall_call+0x7/0xb

Code: 0f a3 37 19 d2 b8 01 00 00 00 31 c9 85 d2 0f 45 c8 8d 56 01 

