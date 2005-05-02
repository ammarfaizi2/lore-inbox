Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbVEBAbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVEBAbh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 20:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbVEBAbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 20:31:37 -0400
Received: from smtp815.mail.sc5.yahoo.com ([66.163.170.1]:41346 "HELO
	smtp815.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261573AbVEBAbJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 20:31:09 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org, Nish Aravamudan <nish.aravamudan@gmail.com>
Subject: Re: [linux-usb-devel] init 1 kill khubd on 2.6.11
Date: Sun, 1 May 2005 19:31:04 -0500
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, Alan Stern <stern@rowland.harvard.edu>,
       arvidjaar@mail.ru, linux-usb-devel@lists.sourceforge.net
References: <200505012021.56649.arvidjaar@mail.ru> <20050501153051.2471294e.akpm@osdl.org> <29495f1d050501154625ee7087@mail.gmail.com>
In-Reply-To: <29495f1d050501154625ee7087@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200505011931.04985.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 01 May 2005 17:46, Nish Aravamudan wrote:
> On 5/1/05, Andrew Morton <akpm@osdl.org> wrote:
> > Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > On Sun, 1 May 2005, Andrey Borzenkov wrote:
> > >
> > > > Hub driver is using SIGKILL to terminate khubd. Unfortunately on a number of
> > > > distributions switching init levels implicitly does "killall -9", killing
> > > > khubd. The only way to restart it is to reload USB subsystem.
> > > >
> > > > Is signal usage in this case really needed? What about replacing it with
> > > > simple flag (i.e. will patch be accepted)?
> > >
> > > IMO the problem lies in those distributions.  They should not
> > > indiscrimately kill processes when switching init levels.
> > 
> > Nevertheless it's better that kernel internals not be exposed to userspace
> > actions in this manner, and using signals for in-kernel IPC is crufty, IMO.
> > 
> > It's pretty simple to convert khubd to use the kthread API.  Something like
> > this (untested):
> > 
> >  drivers/usb/core/hub.c |   40 +++++++++++-----------------------------
> >  1 files changed, 11 insertions(+), 29 deletions(-)
> > 
> > diff -puN drivers/usb/core/hub.c~hub-use-kthread drivers/usb/core/hub.c
> > --- 25/drivers/usb/core/hub.c~hub-use-kthread   2005-05-01 15:22:24.634539928 -0700
> > +++ 25-akpm/drivers/usb/core/hub.c      2005-05-01 15:29:55.739961480 -0700
> 
> <snip>
> 
> >  static int hub_thread(void *__unused)
> 
> <snip>
> 
> > -       /* Send me a signal to get me die (for debugging) */
> >         do {
> >                 hub_events();
> > -               wait_event_interruptible(khubd_wait, !list_empty(&hub_event_list));
> > +               wait_event_interruptible(khubd_wait,
> > +                               !list_empty(&hub_event_list) ||
> > +                               kthread_should_stop());
> >                 try_to_freeze(PF_FREEZE);
> > -       } while (!signal_pending(current));
> > +       } while (!kthread_should_stop() || !list_empty(&hub_event_list));
> 
> Shouldn't this simply be a wait_event(), instead of
> wait_event_interruptible()? Then the do-while() can be gotten rid of,
> as the only reason it is there currently, I guess, is to ignore
> signals?

You need "_interruptible" so your thread can enter refrigerator. Without it
you won't be able to suspend...

-- 
Dmitry
