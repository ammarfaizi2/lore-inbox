Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbVLIVI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbVLIVI2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 16:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbVLIVI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 16:08:28 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:37308 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932187AbVLIVI1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 16:08:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WYvVOo1Wf8xc0HDmKJPLZvs9cPQONSYF3BnAqtylc1t2XICXOpqo0wFoy3leJwTQfXbgzkeZ+YG6OfuwiuCCosvQ9QTNPjCt199SR8JrFE3cuATQXSqbs1l2K6r3+Mu59rUhpNKYP4z3KRaO9MmNl6zbZDf6LiNJYC3RT5p07hE=
Message-ID: <d120d5000512091308lb633c0an34dee39af7f498ad@mail.gmail.com>
Date: Fri, 9 Dec 2005 16:08:26 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] input: fix ucb1x00-ts breakage after conversion to dynamic input_dev allocation
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Russell King <rmk@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0512091520000.26663@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0512091520000.26663@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/05, Nicolas Pitre <nico@cam.org> wrote:
> The bd622663192e8ebebb27dc1d9397f352a82d2495 commit broke the UCB1x00
> touchscreen driver since the idev structure was assumed to be into the
> ts structure, simply casting the former to the later in a couple places.
>
> This patch fixes those, and also cache the idev pointer between multiple
> calls to input_report_abs() to avoid growing the compiled code
> needlessly.
>
> Signed-off-by: Nicolas Pitre <nico@cam.org>
>
> ---
>
> diff --git a/drivers/mfd/ucb1x00-ts.c b/drivers/mfd/ucb1x00-ts.c
> index a984c0e..e0794c2 100644
> --- a/drivers/mfd/ucb1x00-ts.c
> +++ b/drivers/mfd/ucb1x00-ts.c
> @@ -59,16 +59,18 @@ static int adcsync;
>
>  static inline void ucb1x00_ts_evt_add(struct ucb1x00_ts *ts, u16 pressure, u16 x, u16 y)
>  {
> -       input_report_abs(ts->idev, ABS_X, x);
> -       input_report_abs(ts->idev, ABS_Y, y);
> -       input_report_abs(ts->idev, ABS_PRESSURE, pressure);
> -       input_sync(ts->idev);
> +       struct input_dev *idev = ts->idev;
> +       input_report_abs(idev, ABS_X, x);
> +       input_report_abs(idev, ABS_Y, y);
> +       input_report_abs(idev, ABS_PRESSURE, pressure);
> +       input_sync(idev);
>  }
>
>  static inline void ucb1x00_ts_event_release(struct ucb1x00_ts *ts)
>  {
> -       input_report_abs(ts->idev, ABS_PRESSURE, 0);
> -       input_sync(ts->idev);
> +       struct input_dev *idev = ts->idev;
> +       input_report_abs(idev, ABS_PRESSURE, 0);
> +       input_sync(idev);
>  }
>

The changes above are not really needed. The rest is good and we
should get it int before 2.6.15 I think.

Thanks!

--
Dmitry
