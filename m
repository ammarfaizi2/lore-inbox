Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbVAUQeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbVAUQeS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 11:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbVAUQeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 11:34:17 -0500
Received: from styx.suse.cz ([82.119.242.94]:60617 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S262418AbVAUQdb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 11:33:31 -0500
Date: Fri, 21 Jan 2005 17:35:40 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: dtor_core@ameritech.net
Cc: Prarit Bhargava <prarit@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC]: Clean up resource allocation in i8042 driver
Message-ID: <20050121163540.GC4795@ucw.cz>
References: <41F11C66.5000707@sgi.com> <d120d500050121074313788f99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d500050121074313788f99@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2005 at 10:43:36AM -0500, Dmitry Torokhov wrote:
> Hi,
> 
> On Fri, 21 Jan 2005 10:14:46 -0500, Prarit Bhargava <prarit@sgi.com> wrote:
> > Hi,
> > 
> > The following patch cleans up resource allocations in the i8042 driver
> > when initialization fails.
> > 
> ...
> > 
> >                if (i8042_command(&param, I8042_CMD_CTL_TEST)) {
> > -                       printk(KERN_ERR "i8042.c: i8042 controller self test timeout.\n");
> > +                       if (i8042_read_status() != 0xFF)
> > +                               printk(KERN_ERR "i8042.c: i8042 controller self test timeout.\n");
> > +                       else
> > +                               printk(KERN_ERR "i8042.c: no i8042 controller found.\n");
> 
> Is this documented somewhere?

No. But vacant ports usually return 0xff. The problem here is that 0xff
is a valid value for the status register, too. Fortunately this patch
checks for 0xff only after the timeout failed.

Anyway, I suppose we could fail silently here on ia64 machines where
ACPI is present.

> >        if (i8042_platform_init())
> > +       {
> > +               del_timer_sync(&i8042_timer);
> >                return -EBUSY;
> > +       }
> > 
> 
> Couple of comments:
>  - i8042_timer has not been started yet so there is no need to delete
> it in either of the chinks.

Indeed.

> - opening brace placement does not follow Linux coding style.
> 
> I think I have some changes to i8042 in my tree, I will add
> i8042_platform_exit calls to the init routine. Thanks for noticing it!

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
