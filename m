Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVAMSAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVAMSAb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 13:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVAMR7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 12:59:47 -0500
Received: from rproxy.gmail.com ([64.233.170.196]:26846 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261256AbVAMR6b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 12:58:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=X8KqZ+cz0QlcvyVlbUnvXgAAHoV/luFCrOEm3C6Rk4EfZmS1fi6NNGQJNK4GlfsfucqneW36qYVX+3TMeKUUn3x4D247NSIC+HbcFFGIXSw8feOCW/mvyIYIv3+TnEpJQCVQ1PhYpXnNqdbmKpKicBzKb/U6fmwUZx0y+/EDv14=
Message-ID: <29495f1d050113095856d998ea@mail.gmail.com>
Date: Thu, 13 Jan 2005 09:58:27 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: johnpol@2ka.mipt.ru
Subject: Re: Kernel conector. Reincarnation #1.
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050113001611.0a5d8bf8@zanzibar.2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1101286481.18807.66.camel@uganda>
	 <1101287606.18807.75.camel@uganda> <20041124222857.GG3584@kroah.com>
	 <1102504677.3363.55.camel@uganda> <20041221204101.GA9831@kroah.com>
	 <1103707272.3432.6.camel@uganda> <20050112190319.GA10885@kroah.com>
	 <20050112233345.6de409d0@zanzibar.2ka.mipt.ru>
	 <20050113001611.0a5d8bf8@zanzibar.2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2005 00:16:11 +0300, Evgeniy Polyakov
<johnpol@2ka.mipt.ru> wrote:
> Sorry, forget about nasty typo.
> Current one is right.

<snip>

> diff -Nru /tmp/empty/cn_queue.c linux-2.6.9/drivers/connector/cn_queue.c
> --- /tmp/empty/cn_queue.c       1970-01-01 03:00:00.000000000 +0300
> +++ linux-2.6.9/drivers/connector/cn_queue.c    2005-01-12 23:23:45.000000000 +0300

<snip>

> +       while (atomic_read(&cbq->cb->refcnt)) {
> +               printk(KERN_INFO "Waiting for %s to become free: refcnt=%d.\n",
> +                      cbq->pdev->name, atomic_read(&cbq->cb->refcnt));
> +               set_current_state(TASK_INTERRUPTIBLE);
> +               schedule_timeout(HZ);
> +
> +               if (current->flags & PF_FREEZE)
> +                       refrigerator(PF_FREEZE);
> +
> +               if (signal_pending(current))
> +                       flush_signals(current);
> +       }

<snip>

> +       while (atomic_read(&dev->refcnt)) {
> +               printk(KERN_INFO "Waiting for %s to become free: refcnt=%d.\n",
> +                      dev->name, atomic_read(&dev->refcnt));
> +               set_current_state(TASK_INTERRUPTIBLE);
> +               schedule_timeout(HZ);
> +
> +               if (current->flags & PF_FREEZE)
> +                       refrigerator(PF_FREEZE);
> +
> +               if (signal_pending(current))
> +                       flush_signals(current);
> +       }

Would it be possible to use msleep_interruptible(1000) in both of
these locations? You only seem to be concerned with signals (not
wait-queue events) and the time is rather long (1000 msec).
signals_pending(current) will still be true upon return from
msleep_interruptible(), so it's a minimal change, I think.

Thanks,
Nish
