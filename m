Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269176AbUJFN4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269176AbUJFN4P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 09:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269177AbUJFN4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 09:56:14 -0400
Received: from witte.sonytel.be ([80.88.33.193]:49288 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S269176AbUJFN4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 09:56:06 -0400
Date: Wed, 6 Oct 2004 15:55:52 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Willy Tarreau <willy@w.ods.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is
 availlable
In-Reply-To: <20041006133310.GD8386@wohnheim.fh-wedel.de>
Message-ID: <Pine.GSO.4.61.0410061548390.20160@waterleaf.sonytel.be>
References: <20041005185214.GA3691@wohnheim.fh-wedel.de>
 <200410060058.57244.vda@port.imtp.ilyichevsk.odessa.ua>
 <20041006043458.GB19761@alpha.home.local> <Pine.GSO.4.61.0410061038590.20160@waterleaf.sonytel.be>
 <20041006121534.GA8386@wohnheim.fh-wedel.de> <Pine.GSO.4.61.0410061504140.20160@waterleaf.sonytel.be>
 <20041006133310.GD8386@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-869693583-1097070945=:20160"
Content-ID: <Pine.GSO.4.61.0410061555510.20160@waterleaf.sonytel.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-869693583-1097070945=:20160
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.GSO.4.61.0410061555511.20160@waterleaf.sonytel.be>

On Wed, 6 Oct 2004, [iso-8859-1] Jörn Engel wrote:
> On Wed, 6 October 2004 15:07:05 +0200, Geert Uytterhoeven wrote:
> > On Wed, 6 Oct 2004, [iso-8859-1] Jörn Engel wrote:
> > > Point is that above patch is simpler and empiria didn't give me a
> > > reason to worry about anything else.
> > 
> > I'll give you another reason :-)
> > 
> > If I do have multiple active struct consoles registered (e.g. normal tty0 or
> > ttyS0 and a debug console without a real tty), and the /dev/console demux
> > thinks the debug console is the real one (the one opened if you open
> > /dev/console), printk() messages will appear on both active consoles, but
> > /dev/console cannot be opened.
> > 
> > To avoid this problem, the /dev/console demux should walk the list of active
> > consoles until it finds one that can be opened, or fall back to /dev/null if
> > none is found.
> > 
> > Does that sound reasonable?
> 
> Not to me, no.  But I was wrong before.
> 
> Having no console at all is a valid design.  It used to cause

One problem is that `console' means multiple things:
  1. The output device for printk() (multiple consoles are allowed, cfr.
     multiple console= kernel parameters and debug-only consoles)
  2. The tty (both input and output) for /sbin/init (only one instance, cfr.
     the last console= kernel parameter)

I suggested to change the logic for 2 not to use the last console= kernel
parameter if it turns out not to support input (cfr. the return value of struct
console.device()), but try the other registered struct consoles.

> problems, my patch fixes them.  A command-line option like
> "console=/dev/null" doesn't fix it because it doesn't do what it
> appears to do at first glance, so the patch is needed.

Indeed. Because the /dev/null driver doesn't call register_console().
It could be made to work that way (`console=null'), though, but make sure to
register your null-console _first_.
But I think it's simpler to just check console->device() and take appropriate
actions.

> Having a non-working console, esp. for debug, is a rather odd design.
> My approach would be to either explicitly tell the kernel to use the
> other as default console via "console=/dev/ttyS0" or not have the
> debug thing in the kernel in the first place.  Either way, no patch is
> needed.

It was not `designed' to be that way. But due to how `the console' (nr. 2 from
above) works, registration order matters. If people make the mistake (or just
forget) to say `console=ttyS0', a debug console registered later causes
problems.

And the reason the debug consoles (read: capturers) use register_console() is
to avoid code duplication.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
---559023410-869693583-1097070945=:20160--
