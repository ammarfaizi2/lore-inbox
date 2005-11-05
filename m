Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbVKEMUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbVKEMUn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 07:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbVKEMUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 07:20:43 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:47028 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750966AbVKEMUm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 07:20:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XPBgdY6rnAiyzQeclG07B+bBaDQOQ2aPCJfzLwcpTj4cd/xCWJ9D6XKFiOmyKv5FtHvI8u8cZhZNxiOrERfhIzsW5s7Xdq+8+XCeRYKNrIxaEbQnQrwnGw7m21veV7lSENE1Y2gEcNwJGr/38vw+ISLE/s6trdaJZNDAxLUSA+g=
Message-ID: <7e77d27c0511050420x2bd9c5f0x@mail.gmail.com>
Date: Sat, 5 Nov 2005 20:20:41 +0800
From: Yan Zheng <yzcorp@gmail.com>
To: Fawad Lateef <fawadlateef@gmail.com>
Subject: Re: Question about the usage of kernel_thread
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1e62d1370511050331l7e71d15i7c3cdc0d153e31a6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <436C6FF7.4060206@21cn.com>
	 <1e62d1370511050331l7e71d15i7c3cdc0d153e31a6@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> AFAIK the thread created like above is a true kernel thread but in
> general practice what I saw and used that by creating thread from
> init_module, the thread first call daemonize which actually drops the
> mm related to thread and then through reparent_to_init it makes init
> as a parent of the thread/process newly created. So after daemonize
> call current->mm becomes NULL and when the scheduling is going to be
> done the previous_process->mm will be used as the current->mm and
> creating thread like above is correct.
>
> --
> Fawad Lateef
> -

Thank you very much, Fawad.

I do additional test by follow codes, the result is strange.

========================================
#include <linux/kernel.h>
#include <linux/module.h>

static int noop(void *dummy)
{
	int i = 0;
	while(i++ < 10) {
		printk("current->mm = %p\n", current->mm);
		printk("current->active_mm = %p\n", current->active_mm);
		set_current_state(TASK_INTERRUPTIBLE);
		schedule_timeout(HZ);
	}
	return 0;
}

static void create_thread(void *dummy)
{
	kernel_thread(noop, NULL, CLONE_KERNEL | SIGCHLD);
}

static struct work_struct work;

static int test_init(void)
{
	INIT_WORK(&work, create_thread, NULL);
	schedule_work(&work);
	return 0;
}
/*
static int test_init(void)
{
	kernel_thread(noop, NULL, CLONE_KERNEL | SIGCHLD);
	return 0;
}
*/

static void test_exit(void) {}
module_init(test_init);
module_exit(test_exit);
========================================

If use kernel_thread like above. the output is:
current->mm = 00000000
current->active_mm = dffd2640
current->mm = 00000000
current->active_mm = df4d50e0
current->mm = 00000000
current->active_mm = df4463c0
current->mm = 00000000
current->active_mm = df4d50e0
current->mm = 00000000
current->active_mm = c16ee3e0
current->mm = 00000000
current->active_mm = df4463c0
current->mm = 00000000
current->active_mm = c16ee3e0
current->mm = 00000000
current->active_mm = c16ee3e0
current->mm = 00000000
current->active_mm = df796380
current->mm = 00000000
current->active_mm = c16ee3e0

if use kernel_thread directly in module_init(...). the output is:
current->mm = df988060
current->active_mm = df988060
current->mm = df988060
current->active_mm = df988060
current->mm = df988060
current->active_mm = df988060
current->mm = df988060
current->active_mm = df988060
current->mm = df988060
current->active_mm = df988060
current->mm = df988060
current->active_mm = df988060
current->mm = df988060
current->active_mm = df988060
current->mm = df988060
current->active_mm = df988060
current->mm = df988060
current->active_mm = df988060
current->mm = df988060
current->active_mm = df988060

Would you please do some explanation.

Best Regards
