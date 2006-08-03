Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbWHCCBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWHCCBK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 22:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWHCCBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 22:01:10 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:44672 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751282AbWHCCBI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 22:01:08 -0400
Subject: Re: [Patch] kernel: bug fixing for kernel/kmod.c
From: Matt Helsley <matthltc@us.ibm.com>
To: Kenneth Lee <kenlee@dg.gov.cn>
Cc: Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060802143046.GA5645@kenny>
References: <20060802143046.GA5645@kenny>
Content-Type: text/plain
Date: Wed, 02 Aug 2006 18:52:40 -0700
Message-Id: <1154569960.21787.2774.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-02 at 22:30 +0800, Kenneth Lee wrote:
> I think there is a bug in kmod.c: In __call_usermodehelper(), when 
> kernel_thread(wait_for_helper, ...) return success, since
> wait_for_helper() might call complete() at any time, the sub_info should
> not be used any more.
> 
> Normally wait_for_helper() take a long time to finish, you may not get 
> problem for most of the case. But if you remove /sbin/modprobe, it may
> become easier for you to get a oop in khelper.
> 
> the following patch is made in 2.6.17.7
> 
> --- linux-2.6.17.7/kernel/kmod.c.orig   2006-08-02 22:13:21.805902750
> +0800
> +++ linux-2.6.17.7/kernel/kmod.c        2006-08-02 22:15:36.946348500
> +0800
> @@ -198,6 +198,7 @@ static void __call_usermodehelper(void *
>  {
>         struct subprocess_info *sub_info = data;
>         pid_t pid;
> +       int wait = sub_info->wait;
> 
>         /* CLONE_VFORK: wait until the usermode helper has execve'd
>          * successfully We need the data structures to stay around
> @@ -212,7 +213,7 @@ static void __call_usermodehelper(void *
>         if (pid < 0) {
>                 sub_info->retval = pid;
>                 complete(sub_info->complete);
> -       } else if (!sub_info->wait)
> +       } else if (!wait)
>                 complete(sub_info->complete);
>  }
> 

Looks like a correct fix for the race to me. I think you'd make the code
slightly easier to read by replacing the initial test too:

if (sub_info->wait)
	pid = kernel_thread(...

with:

if (wait)
	pid = kernel_thread(...

Cheers,
	-Matt Helsley

