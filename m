Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbVJPDFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbVJPDFQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 23:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbVJPDFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 23:05:15 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:26377 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751279AbVJPDFO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 23:05:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L4aB/gv8T8AmYdtp6DOP+Be+gJjB04vRBUjXjB5zJKpZFn7jN4b52Ywf//BSPkePKKB16/CckZDwpjKeokCOqP/iZdtrA8TqqBfJA+UD7snNV8mZIOSE3LdKYHUciCUaEVC5/hHQf60kUmZ1AEJz3CcmYJQYGUiIMEaxgyzldo0=
Message-ID: <29495f1d0510152005s3643dc02ub6a0f805c6197332@mail.gmail.com>
Date: Sat, 15 Oct 2005 20:05:13 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: EDAC, core EDAC support code
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1129403217.17923.22.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1129403217.17923.22.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> This is a subset of the bluesmoke project core code, stripped of the NMI
> work which isn't ready to merge and some of the "interesting" proc
> functionality that needs reworking or just has no place in kernel. It
> requires no core kernel changes except the added scrub functions already
> posted.
>
> The goal is to merge further functionality only after the core code is
> accepted and proven in the base kernel, and only at the point the
> upstream extras are really ready to merge.
>
> Alan
>
> Signed-off-by: Alan Cox <alan@redhat.com>
>
>
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-rc2-mm1/drivers/edac/edac_mc.c linux-2.6.14-rc2-mm1/drivers/edac/edac_mc.c
> --- linux.vanilla-2.6.14-rc2-mm1/drivers/edac/edac_mc.c 1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.14-rc2-mm1/drivers/edac/edac_mc.c 2005-10-14 18:26:12.000000000 +0100

<snip>

> +static int poll_msec = 1000;

<snip>

> +static int edac_kernel_thread(void *arg)
> +{
> +       struct bs_thread_info *thread = (struct bs_thread_info *) arg;
> +
> +       /* detach thread */
> +       daemonize(thread->name);
> +
> +       current->exit_signal = SIGCHLD;
> +       allow_signal(SIGKILL);
> +       thread->task = current;
> +
> +       /* indicate to starting task we have started */
> +       complete(thread->event);
> +
> +       /* loop forever, until we are told to stop */
> +       while(thread->run != NULL) {
> +               void (*run)(unsigned long dummy);
> +
> +               /* call the function to check the memory controllers */
> +               run = thread->run;
> +               if(run)
> +                       run(thread->dummy);
> +
> +               if(signal_pending(current))
> +                       flush_signals(current);
> +
> +               /* ensure we are interruptable */
> +               set_current_state(TASK_INTERRUPTIBLE);
> +
> +               /* goto sleep for the interval */
> +               schedule_timeout((HZ * poll_msec) / 1000);

Can this either be

schedule_timeout_interruptible(msecs_to_jiffies(poll_msec));

or

msleep_interruptible(poll_msec);

?

Thanks,
Nish
