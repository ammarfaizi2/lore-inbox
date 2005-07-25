Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVGYPRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVGYPRE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 11:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVGYPRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 11:17:04 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:22830 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261326AbVGYPRC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 11:17:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LYNiZyg/Ur1bZ6mBvzjRuu7mMRotg1Hq5X6TCeGQkwvd/BkZkgxvLyruFj3eJ1kRgOIykcPYkyFknwYLvX+nrdQH7oZlp+zmSLG7nTjf5po9KDZTiBYN8hcikwvHznbfxuT+1nSHUk60ByPDuYVZlPZOBRQkMYYH4j1L/9Nn45U=
Message-ID: <d120d500050725081664cd73fe@mail.gmail.com>
Date: Mon, 25 Jul 2005 10:16:05 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [patch 1/2] Touchscreen support for sharp sl-5500
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, vojtech@suse.cz
In-Reply-To: <20050725045607.GA1851@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050722180109.GA1879@elf.ucw.cz>
	 <20050724174756.A20019@flint.arm.linux.org.uk>
	 <20050725045607.GA1851@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 7/24/05, Pavel Machek <pavel@suse.cz> wrote:
> 
> I have made quite a lot of cleanups to touchscreen part, and it seems
> to be acceptable by input people. I think it should go into
> drivers/input/touchscreen/collie_ts.c... Also it looks to me like
> mcp.h should go into asm/arch-sa1100, so that other drivers can use it...

I have couple of nitpicks (below) and one bigger concern - I am
surprised that a driver for a physical device is implemented as an
interface to a class device. This precludes implementing any kind of
power management in the driver and pushes it into the parent and is
generally speaking is a wrong thing to do (IMHO).

If the problem is that you have a single piece of hardware you need to
bind several drivers to - I guess you will have to create a new
sub-device bus for that. Or just register sub-devices on the same bus
the parent device is registered on - I am not sure what is best in
this particular case - I am not familiar with the arch. It is my
understanding that the purpose of interfaces to to present different
"views" to userspace and therefore they are not quie suited for what
you are trying to do...

> +static int ucb1x00_thread(void *_ts)
> +{
> +       struct ucb1x00_ts *ts = _ts;
> +       struct task_struct *tsk = current;
> +       int valid;
> +
> +       ts->rtask = tsk;

Just move that assignment into ucb1x00_input_open and kill all this
"current" stuff.

> +
> +       /*
> +        * We run as a real-time thread.  However, thus far
> +        * this doesn't seem to be necessary.
> +        */
> +       tsk->policy = SCHED_FIFO;
> +       tsk->rt_priority = 1;
> +
> +       valid = 0;
> +       for (;;) {

Can we change this to "while (!kthread_should_stop())" to make me
completely happy?

Thanks!

-- 
Dmitry
