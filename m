Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVBGBVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVBGBVX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 20:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVBGBVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 20:21:23 -0500
Received: from smtp818.mail.sc5.yahoo.com ([66.163.170.4]:47215 "HELO
	smtp818.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261317AbVBGBVP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 20:21:15 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.de>
Subject: Re: [PATCH] Linux joydev joystick disconnect patch 2.6.11-rc2
Date: Sun, 6 Feb 2005 20:21:13 -0500
User-Agent: KMail/1.7.2
Cc: David Fries <dfries@mail.win.org>, linux-kernel@vger.kernel.org
References: <20041123212813.GA3196@spacedout.fries.net> <d120d500050201072413193c62@mail.gmail.com> <20050206131241.GA19564@ucw.cz>
In-Reply-To: <20050206131241.GA19564@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200502062021.13726.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 February 2005 08:12, Vojtech Pavlik wrote:
> On Tue, Feb 01, 2005 at 10:24:39AM -0500, Dmitry Torokhov wrote:
> > On Tue, 1 Feb 2005 08:52:15 -0600, David Fries <dfries@mail.win.org> wrote:
> > > Currently a blocking read, select, or poll call will not return if a
> > > joystick device is unplugged.  This patch allows them to return.
> > > 
> > ...
> > > static unsigned int joydev_poll(struct file *file, poll_table *wait)
> > > {
> > > +       int mask = 0;
> > >        struct joydev_list *list = file->private_data;
> > >        poll_wait(file, &list->joydev->wait, wait);
> > > -       if (list->head != list->tail || list->startup < list->joydev->nabs + list->joydev->nkey)
> > > -               return POLLIN | POLLRDNORM;
> > > -       return 0;
> > > +       if(!list->joydev->exist)
> > > +               mask |= POLLERR;
> > 
> > Probably need POLLHUP in addition (or instead of POLLERR).
> > 
> > >        if (joydev->open)
> > > +       {
> > >                input_close_device(handle);
> > > +               wake_up_interruptible(&joydev->wait);
> > > +       }
> > >        else
> > > +       {
> > >                joydev_free(joydev);
> > > +       }
> > 
> > Opening braces should go on the same line as the statement (if (...) {).
>  
> How about this patch?

Looks fine now. Hmm, wait a sec... Don't we also need kill_fasync calls in
disconnect routines as well?

-- 
Dmitry
