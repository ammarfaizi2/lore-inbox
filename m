Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266118AbTLaFGa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 00:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266121AbTLaFGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 00:06:30 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:31872 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S266118AbTLaFG1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 00:06:27 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 30 Dec 2003 21:06:18 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       <mingo@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kthread_create
In-Reply-To: <20031231042016.958DC2C04B@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0312302100550.1457-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Dec 2003, Rusty Russell wrote:

> +struct kt_message
> +{
> +	struct task_struct *from, *to;
> +	void *info;
> +};
> +
> +static struct kt_message ktm;
> +
> +static void ktm_send(struct task_struct *to, void *info)
> +{
> +	spin_lock(&ktm_lock);
> +	ktm.to = to;
> +	ktm.from = current;
> +	ktm.info = info;
> +	if (ktm.to)
> +		wake_up_process(ktm.to);
> +	spin_unlock(&ktm_lock);
> +}
> +
> +static struct kt_message ktm_receive(void)
> +{
> +	struct kt_message m;
> +
> +	for (;;) {
> +		spin_lock(&ktm_lock);
> +		if (ktm.to == current)
> +			break;
> +		current->state = TASK_INTERRUPTIBLE;
> +		spin_unlock(&ktm_lock);
> +		schedule();
> +	}
> +	m = ktm;
> +	spin_unlock(&ktm_lock);
> +	return m;
> +}

Wouldn't it be better to put a kt_message inside a tast_struct?



- Davide



