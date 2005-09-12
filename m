Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbVILUvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbVILUvJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 16:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbVILUvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 16:51:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23771 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932230AbVILUvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 16:51:08 -0400
Date: Mon, 12 Sep 2005 13:49:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Sripathi Kodi <sripathik@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, patrics@interia.pl,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 2.6.13.1] Patch for invisible threads
Message-Id: <20050912134954.7bbd15b2.akpm@osdl.org>
In-Reply-To: <4325BEF3.2070901@in.ibm.com>
References: <4325BEF3.2070901@in.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sripathi Kodi <sripathik@in.ibm.com> wrote:
>
> Hi,
> 
> When the main thread of a multi-threaded program calls 'pthread_exit' before
> other threads have exited, it results in the other threads becoming
> 'invisible' to commands like 'ps'.

This stuff is subtle.   Let me cc some subtle people.

> This problem was discussed here :
> http://lkml.org/lkml/2004/10/5/234 and http://kerneltrap.org/node/3930, but
> I can't find a patch or explanation for it anywhere. This problem is only
> seen with NPTL and not with LinuxThreads, because Linuxthreads does not let
> the main thread exit (puts it to sleep) until all other threads have exited.
> 
> The problem can be easily recreated with this simple program:
> #include <pthread.h>
> #include <sys/types.h>
> #include <unistd.h>
> void *run(void *arg)
> {
>      sleep(60);
>      printf("Thread: Exiting\n");
>      pthread_exit(NULL);
> }
> int main()
> {
>      pthread_t t;
>      pthread_create(&t, NULL, run, NULL);
>      sleep(20);
>      printf("Main: exiting\n");
>      pthread_exit(NULL);
> }
> 
> After the main thread calls 'pthread_exit', it is shown to be defunct. We
> can still see the directory /proc/<pid_of_main_thread>/task using 'ls',
> 'stat' on it returns success, but 'open' on that directory returns ENOENT.
> Hence though the other thread is still running, it can't be seen.
> 
> The reason appears to be the call to __exit_fs from do_exit when the main
> thread exits. This sets the 'fs' pointer in the task struct to NULL. It also
> decrements the reference count on the fs structure, but does not release the
> memory because the other thread still holds a reference (__put_fs_struct).
> When we do open() on /proc/<pid>/task, proc_root_link() (flow is open_namei
> - may_open - proc_permission - proc_check_root - proc_root_link) tries to
> obtain the task_struct->fs of the main thread, which is now NULL. So it
> returns ENOENT.
> 
> I think we can fix this problem by the following patch. We set the fs
> pointer to NULL only if either the thread is not a thread group leader or if
> the whole thread group has exited. If the main thread is the last to exit,
> it will set the fs pointer to NULL. However, if it is not the last, it won't
> set fs pointer to NULL so that other threads can still use it. Behavior of
> __put_fs_struct is not affected.
> 
> Please let me know if this is reasonable or if there are other ways to fix
> the problem.
> 
> Thanks and regards,
> Sripathi.
> 
> 
> Signed-off-by: Sripathi Kodi <sripathik@in.ibm.com>
> 
> --- linux-2.6.13.1/kernel/exit.c	2005-09-12 02:46:26.000000000 -0500
> +++ /home/sripathi/17794/patch_2.6.13.1/exit.c	2005-09-12 02:46:15.000000000 
> -0500
> @@ -463,9 +463,11 @@ static inline void __exit_fs(struct task
>   	struct fs_struct * fs = tsk->fs;
> 
>   	if (fs) {
> -		task_lock(tsk);
> -		tsk->fs = NULL;
> -		task_unlock(tsk);
> +		if (!thread_group_leader(tsk) || !atomic_read(&tsk->signal->live)) {
> +			task_lock(tsk);
> +			tsk->fs = NULL;
> +			task_unlock(tsk);
> +		}
>   		__put_fs_struct(fs);
>   	}
>   }

A comment in there would be nice.
