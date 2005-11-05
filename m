Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751475AbVKELbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbVKELbj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 06:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbVKELbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 06:31:39 -0500
Received: from xproxy.gmail.com ([66.249.82.197]:54164 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751475AbVKELbi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 06:31:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aIBnv2EtgYH5c5nEcu2v6WjOsrh1VdQiqeDz1TH/uTl+x3TJLnRUMhVBuUgg/yZOfBIwjAkV4N0IkcrNSB9zwMPgVrW/3EFo1XNhtF7cYL4hySy1yn5XMZKcvVSMt3TkznXqJspF31u6/ePXUEh1OQt6zYkLsDZmD8vizCF4HOk=
Message-ID: <1e62d1370511050331l7e71d15i7c3cdc0d153e31a6@mail.gmail.com>
Date: Sat, 5 Nov 2005 16:31:37 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
To: Yan Zheng <yanzheng@21cn.com>
Subject: Re: Question about the usage of kernel_thread
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <436C6FF7.4060206@21cn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <436C6FF7.4060206@21cn.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/05, Yan Zheng <yanzheng@21cn.com> wrote:
> Hi.
>
> In LKD2, Robert say:
> Linux delegates several tasks to kernel threads, most notably the pdflush task and the ksoftirqd task. These threads are created on system boot by other kernel threads. Indeed, a kernel thread can be created only by another kernel thread.
>
>
> But I found that kernel_thread(...) are used wildly like:
>
> #include <linux/kernel.h>
> #include <linux/module.h>
>
> static int noop(void *dummy)
> {
>         printk("current->mm = %p\n", current->mm);
>         return 0;
> }
>
> static int test_init(void)
> {
>         kernel_thread(noop, NULL, CLONE_KERNEL | SIGCHLD);
>         return 0;
> }
>
> static void test_exit(void) {}
> module_init(test_init);
> module_exit(test_exit);
>
>
> In this circumstances, The thread created by kernel_thread has "current->mm != NULL".
>
> My question is:
> The new thread is truely kernel thread ? The usage of kernel_thread(...) like this is correct?
>

AFAIK the thread created like above is a true kernel thread but in
general practice what I saw and used that by creating thread from
init_module, the thread first call daemonize which actually drops the
mm related to thread and then through reparent_to_init it makes init
as a parent of the thread/process newly created. So after daemonize
call current->mm becomes NULL and when the scheduling is going to be
done the previous_process->mm will be used as the current->mm and
creating thread like above is correct.

--
Fawad Lateef
