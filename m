Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbUKUIwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbUKUIwb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 03:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbUKUIwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 03:52:30 -0500
Received: from hentges.net ([81.169.178.128]:6845 "EHLO
	h6563.serverkompetenz.net") by vger.kernel.org with ESMTP
	id S261936AbUKUIuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 03:50:13 -0500
Subject: Re: pci-resume patch from 2.6.7-rc2 breakes S3 resume on some
	machines
From: Matthias Hentges <mailinglisten@hentges.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1100989638.3796.9.camel@gaston>
References: <1100811950.3470.23.camel@mhcln03>
	 <20041119115507.GB1030@elf.ucw.cz> <1100872578.3692.7.camel@mhcln03>
	 <1100872578.3692.7.camel@mhcln03> <1100905563.3812.59.camel@gaston>
	 <E1CVLDU-0005jG-00@chiark.greenend.org.uk>
	 <1100921760.3561.1.camel@mhcln03>  <1100936059.5238.3.camel@gaston>
	 <1100937706.3497.11.camel@mhcln03>  <1100989638.3796.9.camel@gaston>
Content-Type: text/plain
Date: Sun, 21 Nov 2004 09:50:09 +0100
Message-Id: <1101027009.4052.11.camel@mhcln03>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, den 21.11.2004, 09:27 +1100 schrieb Benjamin Herrenschmidt:
> On Sat, 2004-11-20 at 09:01 +0100, Matthias Hentges wrote:
> > Am Samstag, den 20.11.2004, 18:34 +1100 schrieb Benjamin Herrenschmidt:
> > > On Sat, 2004-11-20 at 04:36 +0100, Matthias Hentges wrote:
> > > > Am Samstag, den 20.11.2004, 02:43 +0000 schrieb Matthew Garrett:
> > > > > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > > > > 
> > 
> > [...]
> > 
> > > > Trying to resume with radeonfb or X (DRI or fglrx) causes the machine
> > > > to freeze upon a resume.

> > > At what point does it freeze ? Is the display back before the freeze ?
> > 
> > Sadly the video *never* comes back and stays dark no matter what I try:

[...]

> > The latter shows lots of "[disabled]" entries. Is that of any use?
> 
[...]

> Difficult to say at this point, the [disabled] thing are easy fixed with
> a pci_enable_device(). Unfortunately, on some machines, the firmware
> sort-of expects the kenrel driver to reboot the card from scratch...

I did some more tests today and found out that 
"0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP
Controller (rev 21) (prog-if 00 [Normal decode])"

wasn't correctly resumed either.

I wrote a script to dump the pci data (from lspci -x $device). Importing
the data after a resume freezes the machine *if one is touching data
that hasn't been changed during S3*. If I only change the values which
were modified after resume, the machine does *not* freeze.

Maybe that's the problem with pci_default_resume. It looks like it is
just writing back the data it has stored before resuming. Maybe one
should only write the values which have actually changed?

Anyways, using my little script, i managed to restore the PCI data of
the "Processor to AGP Controller" and the Radeon card after a resume.

If X is running on VT7 and one suspends from VT1 and after resuming
switches back to VT7 ( after restoring the PCI data ), the backlight
goes on but the display is still empty.

Looks like I'm still missing something. To bad boot-radeon always
segsfaults :\ 
An int10 call after restoring the PCI data might just do the trick.
-- 
Matthias Hentges
Cologne / Germany

[www.hentges.net] -> PGP welcome, HTML tolerated
ICQ: 97 26 97 4   -> No files, no URL's

My OS: Debian SID. Geek by Nature, Linux by Choice

