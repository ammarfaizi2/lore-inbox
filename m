Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRADXVJ>; Thu, 4 Jan 2001 18:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129348AbRADXVC>; Thu, 4 Jan 2001 18:21:02 -0500
Received: from james.kalifornia.com ([208.179.0.2]:29302 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S129183AbRADXUf>; Thu, 4 Jan 2001 18:20:35 -0500
Message-ID: <3A55052F.158C9B11@linux.com>
Date: Thu, 04 Jan 2001 15:20:15 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-prerelease i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
CC: twaugh@redhat.com, Andrea Arcangeli <andrea@suse.de>,
        Peter Osterlund <peter.osterlund@mailbox.swipnet.se>,
        linux-kernel@vger.kernel.org
Subject: Re: Printing to off-line printer in 2.4.0-prerelease
In-Reply-To: <200101041530.JAA92328@tomcat.admin.navo.hpc.mil>
Content-Type: multipart/mixed;
 boundary="------------08A43E183C6824DE740BB2A8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------08A43E183C6824DE740BB2A8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The only way to _assume_ a printer is online is to attempt a dummy poll for
information.  Again note that this is a strong assumption as only some new printers
return data for a poll, and legacy printers control of the data port are undefined.

The poll btw needs to be done in userspace because printers respond differently with
different polls.  Thus a 'printer driver' interface needs developed.  Oddly enough,
WinPrinters won't suffer this problem simply because of their bidirectional design
:(

-d

Jesse Pollard wrote:

> ---------  Received message begins Here  ---------
> Tim Waugh <twaugh@redhat.com>:
> > On Thu, Jan 04, 2001 at 03:39:10PM +0100, Andrea Arcangeli wrote:
> >
> > > As noted yesterday falling into parport_write will silenty lose data when the
> > > printer is off.
> >
> > (Actually it depends; I think FIFO/DMA paths are fine, but yes, the
> > software implementation can lose data.)
> >
> > > If it's not feasible to make parport_write reliable against
> > > power-off printer, then I recommend to loop in interruptible mode
> > > before entering the main loop (waiting the printer to power-on) like
> > > in latest patch from Peter.
> >
> > Have I missed a patch?  How do you know whether or not the printer is
> > on yet?
> >
> > As I understand it, you can't guarantee anything about any of the
> > signals when the printer is off, so all you can do is look for
> > 'suspicous' things (like 'no error' and 'paper out').  But some
> > printers do this during normal operation, and hence the LP_CAREFUL
> > switch.
> >
> > Return -EIO when the printer is on and off-line is a bug, sure enough.
> > That's what the -EAGAIN patch was for, and Peter's patch fixes this
> > too.
> >
> > But if you want to avoid losing data when your printer is off you need
> > to use LP_CAREFUL, and hope printing still works at all (depends on
> > your printer).
> >
> > If this goes away:
> >
> >         if ((status & LP_PERRORP) && !(LP_F(minor) & LP_CAREFUL))
> >                 /* No error. */
> >                 last = 0;
> >
> > then some people might not be able to print at all.
>
> I don't believe this is a problem that CAN be fixe, either by hardware
> or software.
>
> Originally, (wayback machine on) this was handled by a pull-up resistor
> in the parallel interface, on the "off-line" signal. ANY time the printer
> was powered off, set offline, or cable unplugged, the "off-line" signal
> was raised by the pull-up. No data lost.
>
> Now the parallel interface is bidirectional, and can have multiple devices
> attached - this "fix" cannot be used. The interface is now more of a
> buss than a single attached interface, and signals from a missing device
> (powered off or disconnected) are floating. They may float high or low,
> and depending on the environment (and which end of the cable is unplugged)
> any thing in between.
>
> Yes, I've lost printouts this way, but there's nothing I can really do
> about it other than than tell the users "don't do that - make sure the
> printer is turned on before you print".
>
> -------------------------------------------------------------------------
> Jesse I Pollard, II
> Email: pollard@navo.hpc.mil
>
> Any opinions expressed are solely my own.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

--------------08A43E183C6824DE740BB2A8
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
url:www.blue-labs.org
adr:;;;;;;
version:2.1
email;internet:david@blue-labs.org
title:Blue Labs Developer
note;quoted-printable:GPG key: http://www.blue-labs.org/david@nifty.key=0D=0A
x-mozilla-cpt:;9952
fn:David Ford
end:vcard

--------------08A43E183C6824DE740BB2A8--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
