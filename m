Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265537AbUGGWIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265537AbUGGWIj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 18:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265540AbUGGWIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 18:08:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:3755 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265537AbUGGWIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 18:08:37 -0400
Date: Wed, 7 Jul 2004 15:11:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] task name handling in proc fs
Message-Id: <20040707151134.05fc1e07.akpm@osdl.org>
In-Reply-To: <20040707215246.GB4314@w-mikek2.beaverton.ibm.com>
References: <20040701220510.GA6164@w-mikek2.beaverton.ibm.com>
	<20040701151935.1f61793c.akpm@osdl.org>
	<20040701224215.GC5090@w-mikek2.beaverton.ibm.com>
	<20040701160335.229cfe03.akpm@osdl.org>
	<20040707215246.GB4314@w-mikek2.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Kravetz <kravetz@us.ibm.com> wrote:
>
> +void set_task_comm(struct task_struct *tsk, char *name)
> +{
> +	int i, ch;
> +
> +	task_lock(tsk);
> +	for (i=0; (ch = *(name++)) != '\0';) {
> +		if (ch == '/')
> +			i = 0;
> +		else
> +			if (i < (sizeof(tsk->comm) - 1))
> +				tsk->comm[i++] = ch;
> +	}
> +	tsk->comm[i] = '\0';
> +	task_unlock(tsk);
> +}

I don't think the basename logic should be in this function.  Only one
caller needs it, and if we later try to use this function to set
current->comm for per-cpu kernel threads, it will mangle the text.

root         2  0.0  0.0     0    0 ?        SW   Jul06   0:00 [migration/0]
root         3  0.0  0.0     0    0 ?        SWN  Jul06   0:00 [ksoftirqd/0]
root         4  0.0  0.0     0    0 ?        SW   Jul06   0:00 [migration/1]
root         5  0.0  0.0     0    0 ?        SWN  Jul06   0:00 [ksoftirqd/1]
root         6  0.0  0.0     0    0 ?        SW   Jul06   0:00 [migration/2]
root         7  0.0  0.0     0    0 ?        SWN  Jul06   0:00 [ksoftirqd/2]
root         8  0.0  0.0     0    0 ?        SW   Jul06   0:00 [migration/3]
root         9  0.0  0.0     0    0 ?        SWN  Jul06   0:00 [ksoftirqd/3]

We probably won't actually _do_ that, since kthread_create() uses vsnprintf(),
but pushing code which is specific to one caller into a library function
seems wrong...
