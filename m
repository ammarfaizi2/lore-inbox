Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVEAWqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVEAWqR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 18:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVEAWqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 18:46:17 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:7364 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261268AbVEAWqN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 18:46:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Fzv+2/1KahSbI3AEAaF38N0d490F169hwVfP1EUHPD8Q162BQMp+3HnmgSMlPfYOkZQH6AmYdswSg0vvscz7pSZHC7yqoYxmC2tplkUaj0+sCMXpJ3qzDbTtkP/gwOu78JWlp/e9QHfttpE3P0dXJqBRiiFiwwBO/0jlyeN8b/k=
Message-ID: <29495f1d050501154625ee7087@mail.gmail.com>
Date: Sun, 1 May 2005 15:46:13 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [linux-usb-devel] init 1 kill khubd on 2.6.11
Cc: Alan Stern <stern@rowland.harvard.edu>, arvidjaar@mail.ru,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20050501153051.2471294e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200505012021.56649.arvidjaar@mail.ru>
	 <Pine.LNX.4.44L0.0505011659130.19155-100000@netrider.rowland.org>
	 <20050501153051.2471294e.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/05, Andrew Morton <akpm@osdl.org> wrote:
> Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Sun, 1 May 2005, Andrey Borzenkov wrote:
> >
> > > Hub driver is using SIGKILL to terminate khubd. Unfortunately on a number of
> > > distributions switching init levels implicitly does "killall -9", killing
> > > khubd. The only way to restart it is to reload USB subsystem.
> > >
> > > Is signal usage in this case really needed? What about replacing it with
> > > simple flag (i.e. will patch be accepted)?
> >
> > IMO the problem lies in those distributions.  They should not
> > indiscrimately kill processes when switching init levels.
> 
> Nevertheless it's better that kernel internals not be exposed to userspace
> actions in this manner, and using signals for in-kernel IPC is crufty, IMO.
> 
> It's pretty simple to convert khubd to use the kthread API.  Something like
> this (untested):
> 
>  drivers/usb/core/hub.c |   40 +++++++++++-----------------------------
>  1 files changed, 11 insertions(+), 29 deletions(-)
> 
> diff -puN drivers/usb/core/hub.c~hub-use-kthread drivers/usb/core/hub.c
> --- 25/drivers/usb/core/hub.c~hub-use-kthread   2005-05-01 15:22:24.634539928 -0700
> +++ 25-akpm/drivers/usb/core/hub.c      2005-05-01 15:29:55.739961480 -0700

<snip>

>  static int hub_thread(void *__unused)

<snip>

> -       /* Send me a signal to get me die (for debugging) */
>         do {
>                 hub_events();
> -               wait_event_interruptible(khubd_wait, !list_empty(&hub_event_list));
> +               wait_event_interruptible(khubd_wait,
> +                               !list_empty(&hub_event_list) ||
> +                               kthread_should_stop());
>                 try_to_freeze(PF_FREEZE);
> -       } while (!signal_pending(current));
> +       } while (!kthread_should_stop() || !list_empty(&hub_event_list));

Shouldn't this simply be a wait_event(), instead of
wait_event_interruptible()? Then the do-while() can be gotten rid of,
as the only reason it is there currently, I guess, is to ignore
signals?

Also, the while's conditional should be (!kthread_should_stop() ||
list_empty(&hub_event_list) to match the negation of wait_event's?
(wait_event() expects the condition to stop on, while while() expects
the condition to continue on)

Thanks,
Nish
