Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbTKLDmd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 22:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbTKLDmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 22:42:33 -0500
Received: from smtp800.mail.ukl.yahoo.com ([217.12.12.142]:57528 "HELO
	smtp800.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261321AbTKLDmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 22:42:31 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: arief_mulya <arief_m_utama@telkomsel.co.id>
Subject: Re: [PATCH?] psmouse-base.c
Date: Tue, 11 Nov 2003 22:42:21 -0500
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
References: <3FAEF7BC.8060503@telkomsel.co.id> <200311111829.50521.dtor_core@ameritech.net> <3FB19ACC.4070106@telkomsel.co.id>
In-Reply-To: <3FB19ACC.4070106@telkomsel.co.id>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311112242.21753.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 November 2003 09:28 pm, arief_mulya wrote:
> Dmitry Torokhov wrote:

>
> >Does suspend/resume work at all if you don't set psmouse_resetafter to
> > 1??
>
> Nope. At least, I didn't wait that long. (I hate seeing lots of "lost
> sync" messages in my console forever, so I always reboot. And in X, you
> just get un-moveable mouse.)
>

OK, thank you for confirming it.

> >The reason I am asking is that we have alot of different PM interfaces
> > and this one is marked as deprecated. If it is not called during
> > resume it would leave the touchpad in relative mode while kernel
> > expects absolute and spews "lost sync" messages... Until Synaptics
> > decides that it's time to reset after X bad packets. Does it make any
> > sense?
>
> Personally, I don't think it makes any sense.
> If something is broken. Why do I need to see lots of funny messages
> (which I didn't even know what it means) if then it could be fixed. Or
> is it has something to do with other serio devices?
>

These messages tell you that something bad happened and data stream that
is coming from the mouse hardware does not match selected protocol. In your
case it turns out that PM callback isn't get called at all. This leaves
the touchpad in relative mode (after BIOS init) while Synaptics driver
expects so called absolute protocol. Normally you should not see these
messages, they signal that something went wrong.

Now, you activated psmouse_resetafter option. I coded it to take care of
my docking station resetting the touchpad back into relative mode without
telling anyone. If it is active then Synaptics tries to re-initialize 
itself after so many bad packets (1 in your case).

What I am trying to tell is that pm_callback does not affect anything in
your case, its psmouse_resetafter that does re-initialization.

Andrew, the patch, although probably not needed should be still valid as 
there is no point of trying to reconnect when suspending.
 
> >Btw, Synaptics is intergated into psmouse module so you don't really
> > need to edit the source to set resetafter parameter. Either pass
> >"psmouse_resetafter=X" to the kernel on boot if psmouse compiled in or
> >pass it to modprobe.
>
> I thought so, too.
> But how do you pass to modprobe something that does not available as
> Module in menuconfig?
>

There is only one module called psmouse that supports different flavors
of PS/2 protocol along with (optional) Synaptics protocol. You should try
to "modprobe psmouse psmouse_resetafter=X".

Dmitry
