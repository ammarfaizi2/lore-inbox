Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbVGFHsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbVGFHsU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 03:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbVGFHrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 03:47:51 -0400
Received: from nproxy.gmail.com ([64.233.182.200]:40352 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262064AbVGFGSp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 02:18:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cG0XMZlrNgCaEpr3zE5ygxzWtE+PP9Ly/UqmJaSEIUI5GNHtnPniE89+Q54INatE3Z+wjr8jbtfYbBBeIbgVPNbjrGDT7XWItN4WGR6OPfa3q3xtZHLVLf00QFKGeP/SLDXhiwS+qK5fhjGtjUeOq7jOxRDSqx0j9ez+byG8Ows=
Message-ID: <84144f02050705231878434225@mail.gmail.com>
Date: Wed, 6 Jul 2005 09:18:37 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [PATCH] [43/48] Suspend2 2.1.9.8 for 2.6.12: 619-userspace-nofreeze.patch
Cc: linux-kernel@vger.kernel.org, Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <1120616444351@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <11206164393426@foobar.com> <1120616444351@foobar.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/05, Nigel Cunningham <nigel@suspend2.net> wrote:
> diff -ruNp 620-userui-header.patch-old/kernel/power/suspend2_core/ui.c 620-userui-header.patch-new/kernel/power/suspend2_core/ui.c
> --- 620-userui-header.patch-old/kernel/power/suspend2_core/ui.c 1970-01-01 10:00:00.000000000 +1000

Is a directory this deep really necessary? Please consider putting
this under kernel/power/.

> +++ 620-userui-header.patch-new/kernel/power/suspend2_core/ui.c 2005-07-05 23:48:59.000000000 +1000
> @@ -0,0 +1,1186 @@
> +/*
> + * kernel/power/ui.c
> + *
> + * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu>
> + * Copyright (C) 1998,2001,2002 Pavel Machek <pavel@suse.cz>
> + * Copyright (C) 2002-2003 Florent Chabaud <fchabaud@free.fr>
> + * Copyright (C) 2002-2005 Nigel Cunningham <nigel@suspend2.net>
> + *
> + * This file is released under the GPLv2.
> + *
> + * Routines for Software Suspend's user interface.
> + *
> + * The user interface code talks to a userspace program via a
> + * netlink socket.
> + *
> + * The kernel side:
> + * - starts the userui program;
> + * - sends text messages and progress bar status;
> + *
> + * The user space side:
> + * - passes messages regarding user requests (abort, toggle reboot etc)
> + *
> + */
> +#define SUSPEND_CONSOLE_C
> +
> +#include "../power.h"

Please either move this file under kernel/power/ or move the header to
include/linux/.

> +void s2_userui_message(unsigned long section, unsigned long level,
> +               int normally_logged,
> +               const char *fmt, va_list args);
> +unsigned long userui_update_progress(unsigned long value, unsigned long maximum,
> +               const char *fmt, va_list args);
> +void userui_prepare_console(void);
> +void userui_cleanup_console(void);

Shouldn't these be extern and in a header file?

> +static int userui_nl_set_state(int n)
> +{
> +       /* Only let them change certain settings */
> +       static const int suspend_action_mask =
> +               (1 << SUSPEND_REBOOT) | (1 << SUSPEND_PAUSE) | (1 << SUSPEND_SLOW) |
> +               (1 << SUSPEND_LOGALL) | (1 << SUSPEND_SINGLESTEP) |
> +               (1 << SUSPEND_PAUSE_NEAR_PAGESET_END);
> +
> +       suspend_action = (suspend_action & (~suspend_action_mask)) |
> +               (n & suspend_action_mask);
> +
> +       return 0;

Always returns zero so drop the return value.

> +}
> +
> +static int userui_nl_set_progress_granularity(int n)
> +{
> +       if (n < 1) n = 1;
> +       progress_granularity = n;
> +       return 0;

Same here.

> +}
> +
> +static int userui_user_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh, int *errp)
> +{
> +       int type;
> +       int *data;
> +
> +       *errp = 0;
> +
> +       if (!(nlh->nlmsg_flags & NLM_F_REQUEST))
> +               return 0;
> +
> +       type = nlh->nlmsg_type;
> +
> +       /* A control message: ignore them */
> +       if (type < USERUI_MSG_BASE)
> +               return 0;
> +
> +       /* Unknown message: reply with EINVAL */
> +       if (type >= USERUI_MSG_MAX) {
> +               *errp = -EINVAL;
> +               return -1;

Just return the error value and errp can go away.

> +static unsigned long userui_memory_needed(void)
> +{
> +       /* ball park figure of 128 pages */
> +       return (128 * PAGE_SIZE);

Where does this magic 128 come from?

> +}
> +
> +unsigned long userui_update_progress(unsigned long value, unsigned long maximum,
> +               const char *fmt, va_list args)
> +{
> +       static int last_step = -1;
> +       struct userui_msg_params msg;
> +       int bitshift = generic_fls(maximum) - 16;

What's this magic 16?

> +char suspend_wait_for_keypress(int timeout)
> +{
> +       int fd;
> +       char key = '\0';
> +       struct termios t, t_backup;
> +
> +       if (userui_pid != -1) {
> +               wait_for_key_via_userui();
> +               key = 32;

What's this magic 32?

> +/* abort_suspend
> + *
> + * Description: Begin to abort a cycle. If this wasn't at the user's request
> + *             (and we're displaying output), tell the user why and wait for
> + *             them to acknowledge the message.
> + * Arguments:  A parameterised string (imagine this is printk) to display,
> + *             telling the user why we're aborting.
> + */

Please use proper kerneldoc format instead of inventing your own.

> +void suspend2_schedule_message(int message_number)
> +{
> +       struct waiting_message * new_message =
> +               kmalloc(sizeof(struct waiting_message), GFP_ATOMIC);
> +
> +       if (!new_message) {
> +               printk("Argh. Unable to allocate memory for "
> +                               "scheduling the display of a message.\n");

KERN_* constants please.

> +extern asmlinkage long sys_ioctl(unsigned int fd, unsigned int cmd,
> +               unsigned long arg);

Looks as if you're doing quite a bit of sys_* calls in the kernel.
Could this stuff be pushed out to userspace by any chance?
