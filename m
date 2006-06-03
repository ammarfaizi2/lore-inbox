Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932575AbWFCJLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575AbWFCJLs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 05:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932597AbWFCJLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 05:11:48 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43529 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932575AbWFCJLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 05:11:47 -0400
Date: Sat, 3 Jun 2006 10:11:33 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Dave Jones <davej@redhat.com>, Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Paul Dickson <paul@permanentmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Bisects that are neither good nor bad
Message-ID: <20060603091133.GA24271@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Dave Jones <davej@redhat.com>,
	Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Paul Dickson <paul@permanentmail.com>, linux-kernel@vger.kernel.org
References: <20060528140238.2c25a805.dickson@permanentmail.com> <20060528140854.34ddec2a.paul@permanentmail.com> <200605282324.13431.rjw@sisk.pl> <200605282324.13431.rjw@sisk.pl> <20060528213414.GC5741@redhat.com> <r6u079rrik.fsf@skye.ra.phy.cam.ac.uk> <20060529145255.GB32274@redhat.com> <20060530152926.GA4103@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530152926.GA4103@ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2006 at 03:29:26PM +0000, Pavel Machek wrote:
> >  > > I think I've seen the same problem on one of my (similar spec) laptops.
> >  > > Serial console was useless. On resume, there's a short spew of garbage
> >  > > (just like if the baud rate were misconfigured) over serial before it
> >  > > locks up completely.
> >  > 
> >  > <http://bugzilla.kernel.org/show_bug.cgi?id=4270> discusses a similar
> >  > problem on a couple of machines.  In my resume script (for a TP 600X),
> >  > I have to restore the serial console with
> >  > 
> >  >   setserial -a /dev/ttyS0
> >  > 
> >  > Until that magic executes, garbage characters (like modem noise)
> >  > appear across the serial console.
> > 
> > With the resume failure I'm seeing, we don't get back to userspace
> > to run anything like this. It goes bang long before that.
> > 
> > The SATA fix Mark proposed also didn't improve the situation for me :-/
> 
> If setserial -a is needed.. it means that someone really needs to fix
> suspend/resume support for serial... do it on working machine to
> enable debugging of broken ones...

I've explained why this occurs in bugzilla - but for the sake of
repeating repeating repeating myself at great length, let's repeat
it again here.

The serial layer does _not_ have access to the "current" termios
settings due to the layering by the tty subsystem.  If the serial
port being used by serial console has been opened once by the user,
but is closed at the moment when a suspend/resume cycle occurs,
the serial layer and lower level drivers do not have access to the
baud rate.

Hence, it is impossible for the serial layer to do a proper resume
in this scenario.  Either always suspend with the console port open
or never open the console port before suspend.  Alternatively, we
need the tty layer to mature, so that there is some way for drivers
to get the termios structures for the console from the upper layer.
Or maybe we need the tty layer to be responsible for implementing
suspend/resume support for tty devices.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
