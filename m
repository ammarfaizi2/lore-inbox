Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273213AbRJGQKI>; Sun, 7 Oct 2001 12:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274674AbRJGQJs>; Sun, 7 Oct 2001 12:09:48 -0400
Received: from hastur.physics.ox.ac.uk ([163.1.243.65]:47880 "EHLO
	janus.physics.ox.ac.uk") by vger.kernel.org with ESMTP
	id <S273213AbRJGQJj>; Sun, 7 Oct 2001 12:09:39 -0400
Date: Sun, 7 Oct 2001 17:09:57 +0100
From: Tim Stadelmann <Tim.Stadelmann@physics.ox.ac.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dell Latitude C600 suspend problem
Message-ID: <20011007170957.A536@univn10.univ.ox.ac.uk>
In-Reply-To: <20011007115712.A4357@univn10.univ.ox.ac.uk> <E15qEdC-0005tB-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E15qEdC-0005tB-00@the-village.bc.nu>
User-Agent: Mutt/1.3.22i
X-AVtransport: scanmails_remote
X-AVwrapper: AMaViS (http://www.amavis.org/)
X-AVscanner: Sophos sweep (http://www.sophos.com/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 07, 2001 at 03:10:14PM +0100, Alan Cox wrote:
> > A closer investigation revealed that the patch meant to correct a
> > problem with the internal ps2 pointing device on suspend is at fault.
> > Commenting out the entry in arch/i386/kernel/dmi_scan.c that triggers
> > the activation of this logic for the C600 allows the machine to
> > suspend normally.
> 
> The change doesn't affect the suspend. What it deals with is the resume
> side. When the C600 resumes it doesn't always restore the keyboard/mouse
> state.

Well, it SHOULDN'T affect the suspend...  I should have been more
precise here, but this was described in an earlier thread: the bug
does indeed prevent the machine from entering suspend mode at all.

> The actual code it runs is pckbd_pm_resume() (pc_keyb.c) so you might want
> to see if that is actually triggering and where it hangs during the resume

In fact, it turns out that the power management callback routine
doesn't check whether a suspend or a resume event triggered it.  More
importantly, it doesn't provide a return value either.  This explains
what happens: The power management code looks for a status value
returned by the callback and gets a more or less random int, which
usually dosn't happen to be 0 (== successful suspend).
 
I've written a little patch (not included yet) that makes
pckbd_pm_resume behave well in connection with the current incarnation
of the power management code.  Suspend and resume work again without
problems.

Unfortunatly, now the actual tweeks done by the callback seem to
slightly confuse my keyboard driver...?  Will look into that soon.


				Tim Stadelmann

