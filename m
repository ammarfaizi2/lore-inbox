Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266324AbUIMHz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266324AbUIMHz3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 03:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266333AbUIMHz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 03:55:28 -0400
Received: from asplinux.ru ([195.133.213.194]:30726 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S266324AbUIMHzF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 03:55:05 -0400
Message-ID: <4145550F.8030601@sw.ru>
Date: Mon, 13 Sep 2004 12:06:39 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Roel van der Made <roel@telegraafnet.nl>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       wli@holomorphy.com
Subject: [PATCH]: Re: kernel 2.6.9-rc1-mm4 oops
References: <20040912184804.GC19067@telegraafnet.nl>
In-Reply-To: <20040912184804.GC19067@telegraafnet.nl>
Content-Type: multipart/mixed;
 boundary="------------060605050301070801090508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060605050301070801090508
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Roel van der Made wrote:
> Hi there,
> 
> This morning one of our (MySQL-)database serves crashed with the
> following kernel trace. Anyone has an idea what could've caused it?
> The machine is an SMP Xeon 2.8Ghz with 4G internal Reg. ECC ram running
> 4 scsi disks in sw raid 5 on a Debian (almost sid-)distribution.

> The trace:
> 
> ------------[ cut here ]------------
> kernel BUG at kernel/exit.c:852!
> invalid operand: 0000 [#1]
> SMP
> Modules linked in: ip_vs_wlc af_packet ipt_MARK iptable_mangle ip_tables ip_vs tg3 e1000 e100 eepro100 mii
> nfsd exportfs nfs lockd sunrpc unix
> CPU:    0
> EIP:    0060:[<c011df03>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.9-rc1-mm4-fw-xeon.1)
> EIP is at next_thread+0xc/0x41
> eax: 00000000   ebx: 00000001   ecx: 00000001   edx: e93c3aa0
> esi: 00000000   edi: e93c3aa0   ebp: 00000000   esp: f3893dd8
> ds: 007b   es: 007b   ss: 0068
> Process snmpd (pid: 1182, threadinfo=f3892000 task=f3fa1550)
> Stack: c0182368 f3893f14 e93c3aa0 c016cecb c30c8a00 c011542b c03bfbe0 c30c8a00
>        c017fcf6 e18d6eb0 e93c3aa0 0000000d c017fdad e93c3aa0 4143bbb4 247966f0
>        c016c653 c03bfbe0 e18d6eb0 c03a4bc5 c01802a0 f3e56c20 e18d6eb0 0000000d
> Call Trace:
>  [<c0182368>] do_task_stat+0x279/0x752
>  [<c016cecb>] alloc_inode+0x1b/0x146
>  [<c011542b>] do_page_fault+0x19d/0x5c7
>  [<c017fcf6>] task_dumpable+0x39/0x4a
>  [<c017fdad>] proc_pid_make_inode+0xa6/0xe5
>  [<c016c653>] d_rehash+0x55/0x79
>  [<c01802a0>] proc_pident_lookup+0x100/0x26c
>  [<c0161586>] real_lookup+0xcd/0xf0
>  [<c016b468>] dput+0x24/0x209
>  [<c0162247>] link_path_walk+0xa3e/0xd89
>  [<c0182883>] proc_tgid_stat+0x1f/0x23
>  [<c017f3ed>] proc_info_read+0x6a/0x9f
>  [<c015417f>] vfs_read+0xbc/0x127
>  [<c015444d>] sys_read+0x51/0x80
>  [<c0105cdf>] syscall_call+0x7/0xb
> Code: 8b 44 24 0c 89 04 24 e8 1d fc ff ff 83 ec 04 0f b6 44 24 08 c1 e0 08 89 04 24 e8 0a fc ff ff 89 c2
> 8b 80 d0 04 00 00 85 c0 75 08 <0f> 0b 54 03 e5

It looks like an incorrect BUG() in next_thread().

Description
~~~~~~~~~~~

Note, that during exit process there can be a thread in the system with 
tsk->sighand == NULL, since the following call trace:

release_task()
{
	....
	__exit_sighand()	<<< makes tsk->sighand == NULL;
	__unhash_process()	<<< unhashes thread
	....
}

next, we see that next_thread checks for tsk->sighand != NULL:

task_t fastcall *next_thread(const task_t *p)
{
  #ifdef CONFIG_SMP
        if (!p->sighand)
                BUG();		<<< BUG happened here!!!
        if (!spin_is_locked(&p->sighand->siglock) &&
                                !rwlock_is_locked(&tasklist_lock))
	....
}

So the question is why next_thread() should check for
(p->sighand != NULL) && spin_is_locked(&p->sighand->siglock)?

I think these checks are invalid. For example do_task_stat() (which 
called next_thread() in this BUG) checks for tsk->sighand != NULL 
explicitly.
And moreover, next_thread() DOES always works correctly, whether there 
are threads or none.

This patch removes sighand checks from the next_thread(), since they are 
incorrect and has nothing to do with the next_thread() function. So they 
could trigger BUG() when there were no actually bug at all.

Signed-Off-By: Kirill Korotaev <dev@sw.ru>

Kirill

--------------060605050301070801090508
Content-Type: text/plain;
 name="diff-next_thread"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-next_thread"

--- ./kernel/exit.c.nt	2004-09-13 11:18:26.000000000 +0400
+++ ./kernel/exit.c	2004-09-13 11:53:23.611075360 +0400
@@ -848,10 +848,7 @@ asmlinkage long sys_exit(int error_code)
 task_t fastcall *next_thread(const task_t *p)
 {
 #ifdef CONFIG_SMP
-	if (!p->sighand)
-		BUG();
-	if (!spin_is_locked(&p->sighand->siglock) &&
-				!rwlock_is_locked(&tasklist_lock))
+	if (!rwlock_is_locked(&tasklist_lock))
 		BUG();
 #endif
 	return pid_task(p->pids[PIDTYPE_TGID].pid_list.next, PIDTYPE_TGID);

--------------060605050301070801090508--

