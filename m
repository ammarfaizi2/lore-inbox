Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVBGG7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVBGG7k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 01:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVBGG7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 01:59:40 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:19652 "EHLO suse.de")
	by vger.kernel.org with ESMTP id S261368AbVBGG7e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 01:59:34 -0500
Date: Mon, 7 Feb 2005 07:59:55 +0100
From: Vojtech Pavlik <vojtech@suse.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: David Fries <dfries@mail.win.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux joydev joystick disconnect patch 2.6.11-rc2
Message-ID: <20050207065955.GB2027@ucw.cz>
References: <20041123212813.GA3196@spacedout.fries.net> <d120d500050201072413193c62@mail.gmail.com> <20050206131241.GA19564@ucw.cz> <200502062021.13726.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200502062021.13726.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 08:21:13PM -0500, Dmitry Torokhov wrote:
> On Sunday 06 February 2005 08:12, Vojtech Pavlik wrote:
> > On Tue, Feb 01, 2005 at 10:24:39AM -0500, Dmitry Torokhov wrote:
> > > On Tue, 1 Feb 2005 08:52:15 -0600, David Fries <dfries@mail.win.org> wrote:
> > > > Currently a blocking read, select, or poll call will not return if a
> > > > joystick device is unplugged.  This patch allows them to return.
> > > > 
> > > ...
> > > > static unsigned int joydev_poll(struct file *file, poll_table *wait)
> > > > {
> > > > +       int mask = 0;
> > > >        struct joydev_list *list = file->private_data;
> > > >        poll_wait(file, &list->joydev->wait, wait);
> > > > -       if (list->head != list->tail || list->startup < list->joydev->nabs + list->joydev->nkey)
> > > > -               return POLLIN | POLLRDNORM;
> > > > -       return 0;
> > > > +       if(!list->joydev->exist)
> > > > +               mask |= POLLERR;
> > > 
> > > Probably need POLLHUP in addition (or instead of POLLERR).
> > > 
> > > >        if (joydev->open)
> > > > +       {
> > > >                input_close_device(handle);
> > > > +               wake_up_interruptible(&joydev->wait);
> > > > +       }
> > > >        else
> > > > +       {
> > > >                joydev_free(joydev);
> > > > +       }
> > > 
> > > Opening braces should go on the same line as the statement (if (...) {).
> >  
> > How about this patch?
> 
> Looks fine now. Hmm, wait a sec... Don't we also need kill_fasync calls in
> disconnect routines as well?

Yes, we do.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
