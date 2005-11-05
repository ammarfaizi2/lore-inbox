Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbVKEMyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbVKEMyi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 07:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbVKEMyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 07:54:37 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:4714 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751200AbVKEMyh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 07:54:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N8jfMKM4DGP8qeRzrucbOZwVioCdspDeyIC6K014YFevSnl1kym6dNTinAPo/ibCcTMC20qt3m8WRymd0u/R31U0UfdYRwc9MlTVjYOiZosAYasUF8LYCbf96B944XUfotw5/GIY+vGc33w4SEp+Wg/oqntr1Hl5tWqqrOQWxhI=
Message-ID: <1e62d1370511050454n39719b20o3bb05e4d364e9639@mail.gmail.com>
Date: Sat, 5 Nov 2005 17:54:34 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
To: Yan Zheng <yzcorp@gmail.com>
Subject: Re: Question about the usage of kernel_thread
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7e77d27c0511050420x2bd9c5f0x@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <436C6FF7.4060206@21cn.com>
	 <1e62d1370511050331l7e71d15i7c3cdc0d153e31a6@mail.gmail.com>
	 <7e77d27c0511050420x2bd9c5f0x@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/05, Yan Zheng <yzcorp@gmail.com> wrote:
>
> I do additional test by follow codes, the result is strange.
>
> ========================================
> #include <linux/kernel.h>
> #include <linux/module.h>
>
> static int noop(void *dummy)
> {
>         int i = 0;
>         while(i++ < 10) {
>                 printk("current->mm = %p\n", current->mm);
>                 printk("current->active_mm = %p\n", current->active_mm);
>                 set_current_state(TASK_INTERRUPTIBLE);
>                 schedule_timeout(HZ);
>         }
>         return 0;
> }
>
> static void create_thread(void *dummy)
> {
>         kernel_thread(noop, NULL, CLONE_KERNEL | SIGCHLD);
> }
>
> static struct work_struct work;
>
> static int test_init(void)
> {
>         INIT_WORK(&work, create_thread, NULL);
>         schedule_work(&work);
>         return 0;
> }
> /*
> static int test_init(void)
> {
>         kernel_thread(noop, NULL, CLONE_KERNEL | SIGCHLD);
>         return 0;
> }
> */
>
> static void test_exit(void) {}
> module_init(test_init);
> module_exit(test_exit);
> ========================================
>
> If use kernel_thread like above. the output is:
> current->mm = 00000000
> current->active_mm = dffd2640
> current->mm = 00000000
> current->active_mm = df4d50e0
> current->mm = 00000000
> current->active_mm = df4463c0
> current->mm = 00000000
> current->active_mm = df4d50e0
> current->mm = 00000000
> current->active_mm = c16ee3e0
> current->mm = 00000000
> current->active_mm = df4463c0
> current->mm = 00000000
> current->active_mm = c16ee3e0
> current->mm = 00000000
> current->active_mm = c16ee3e0
> current->mm = 00000000
> current->active_mm = df796380
> current->mm = 00000000
> current->active_mm = c16ee3e0
>
> if use kernel_thread directly in module_init(...). the output is:
> current->mm = df988060
> current->active_mm = df988060
> current->mm = df988060
> current->active_mm = df988060
> current->mm = df988060
> current->active_mm = df988060
> current->mm = df988060
> current->active_mm = df988060
> current->mm = df988060
> current->active_mm = df988060
> current->mm = df988060
> current->active_mm = df988060
> current->mm = df988060
> current->active_mm = df988060
> current->mm = df988060
> current->active_mm = df988060
> current->mm = df988060
> current->active_mm = df988060
> current->mm = df988060
> current->active_mm = df988060
>
> Would you please do some explanation.
>

The thread created from the code above (means from workqueue) are
by-default have init task as a parent process as init_workqueues
function is called during the booting process init
(http://sosdg.org/~coywolf/lxr/source/init/main.c#L657) from the
function do_basic_setup
(http://sosdg.org/~coywolf/lxr/source/init/main.c#L691) so the
workqueues have current->mm = NULL and when you creates a thread from
the workqueue it also get current->mm = NULL as of parent (workqueue
interface) and current->active_mm contains the mm of the previously
running process (running/scheduled before the current process which is
scheduled)

Whereas, when you create a kernel_thread from init_module it gets the
current->mm of the parent process (insmod is process in init_module
case) and during schedule if current->mm != NULL then the
current->active_mm remains same as that of current->mm, so for
creating a pure kernel thread from init_module daemonize must be
called from thread (I think I was wrong in my previous reply as i
wronggly said "the thread created like above is a true kernel thread")
else without calling daemonize (as I saw from your test) I guess you
can't get the full features of the kernel_thread (like not able to
access __complete__ kernel address space) (CMIIW)



--
Fawad Lateef
