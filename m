Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268970AbUJFNHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268970AbUJFNHS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 09:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269260AbUJFNHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 09:07:18 -0400
Received: from witte.sonytel.be ([80.88.33.193]:32754 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S268970AbUJFNHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 09:07:15 -0400
Date: Wed, 6 Oct 2004 15:07:05 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Willy Tarreau <willy@w.ods.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is
 availlable
In-Reply-To: <20041006121534.GA8386@wohnheim.fh-wedel.de>
Message-ID: <Pine.GSO.4.61.0410061504140.20160@waterleaf.sonytel.be>
References: <20041005185214.GA3691@wohnheim.fh-wedel.de>
 <200410060058.57244.vda@port.imtp.ilyichevsk.odessa.ua>
 <20041006043458.GB19761@alpha.home.local> <Pine.GSO.4.61.0410061038590.20160@waterleaf.sonytel.be>
 <20041006121534.GA8386@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-630072926-1097068025=:20160"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-630072926-1097068025=:20160
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 6 Oct 2004, [iso-8859-1] Jörn Engel wrote:
> On Wed, 6 October 2004 10:43:52 +0200, Geert Uytterhoeven wrote:
> > On Wed, 6 Oct 2004, Willy Tarreau wrote:
> > > On Wed, Oct 06, 2004 at 12:58:57AM +0300, Denis Vlasenko wrote:
> > > > > +		if (open("/dev/null", O_RDWR, 0) == 0)
> > > > > +			printk("         Falling back to /dev/null.\n");
> > > > > +	}
> > > > 
> > > > What will happen if /dev is totally empty?
> > > 
> > > ... Which is the most probable reason causing this trouble.
> 
> I have no idea about the probability, but in the one case I worry
> about, a console is explicitly disabled because it is not wanted.
> /dev does exist and is populated.
> 
> > Some debug methods use register_console() to get their print routines
> > registered. If people forget to say e.g. `console=tty0' afterwards, the debug
> > console without the real device cannot be opened through /dev/console, and they
> > get a mysterious error. Usually /dev/console _is_ present in the root fs.
> 
> Yes, I thought about doing things at a different level as well.  If
> there really is no console, shouldn't /dev/console have the same
> behavious as /dev/null?
> 
> Point is that above patch is simpler and empiria didn't give me a
> reason to worry about anything else.

I'll give you another reason :-)

If I do have multiple active struct consoles registered (e.g. normal tty0 or
ttyS0 and a debug console without a real tty), and the /dev/console demux
thinks the debug console is the real one (the one opened if you open
/dev/console), printk() messages will appear on both active consoles, but
/dev/console cannot be opened.

To avoid this problem, the /dev/console demux should walk the list of active
consoles until it finds one that can be opened, or fall back to /dev/null if
none is found.

Does that sound reasonable?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
---559023410-630072926-1097068025=:20160--
