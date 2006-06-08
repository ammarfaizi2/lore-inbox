Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbWFHBh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbWFHBh0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 21:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbWFHBh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 21:37:26 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:42577 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932449AbWFHBh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 21:37:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DQSh5zP3WOwXWBg0KWZgtJes82Sl0hp8mu0IeFlCReNJ3GuVG6j00Hn5qMu23ukGmbCuMKQMMuVLYkuymFgclwDLfG0kKhamuMrvJMQ7XDVPwBT5kteNC1lLmpDPS005O4JdAxE9Rzo3LjwmoG/Q/fATmh0DEi3oyO6X0RMV1nU=
Message-ID: <9e4733910606071837l4e81c975t8d531ed9810af60f@mail.gmail.com>
Date: Wed, 7 Jun 2006 21:37:25 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Mathieu Desnoyers" <compudj@krystal.dyndns.org>
Subject: Re: Interrupts disabled for too long in printk
Cc: linux-kernel@vger.kernel.org, ltt-dev@shafik.org
In-Reply-To: <20060603111934.GA14581@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060603111934.GA14581@Krystal>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/06, Mathieu Desnoyers <compudj@krystal.dyndns.org> wrote:
> Hi,
>
> I ran some experiments with my kernel tracer (LTTng : http://ltt.polymtl.ca)
> that showed missing interrupts. I wrote a small paper to show how to use my
> tracer to solve this kind of problem which I presented at the CE Linux Form
> last April.
>
> http://tree.celinuxforum.org/CelfPubWiki/ELC2006Presentations?action=AttachFile&do=get&target=celf2006-desnoyers.pdf
>
> It shows that, when the serial console is activated, the following code disables
> interrupts for up to 15ms. On a system configured with a 250HZ timer (each 4ms),
> it means that 3 scheduler ticks are lost.
>
> In the current git :
>
> kernel/printk.c: release_console_sem()
>
>         for ( ; ; ) {
> ----->          spin_lock_irqsave(&logbuf_lock, flags);
>                 wake_klogd |= log_start - log_end;
>                 if (con_start == log_end)
>                         break;                  /* Nothing to print */
>                 _con_start = con_start;
>                 _log_end = log_end;
>                 con_start = log_end;            /* Flush */
>                 spin_unlock(&logbuf_lock);
>                 call_console_drivers(_con_start, _log_end);
> ----->          local_irq_restore(flags);
>         }

You can look at this problem from the other direction too. Why is it
taking 15ms to get between the two points? If IRQs are off how is the
serial driver getting interrupts to be able to display the message? It
is probably worthwhile to take a look and see what the serial console
driver is doing.

> I guess interrupts are disabled for a good reason (to protect this spinlock for
> being taken by a nested interrupt handler. One way I am thinking to fix this
> problem would be to do a spin try lock and fail if it is already taken.

-- 
Jon Smirl
jonsmirl@gmail.com
