Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbULTVd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbULTVd5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 16:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbULTVcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 16:32:10 -0500
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:40898 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S261647AbULTVba
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 16:31:30 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: Scheduling while atomic (2.6.10-rc3-bk13)
Date: Mon, 20 Dec 2004 13:31:35 -0800
User-Agent: KMail/1.7.1
Cc: Lee Revell <rlrevell@joe-job.com>, Greg KH <greg@kroah.com>,
       Lukas Hejtmanek <xhejtman@mail.muni.cz>, linux-kernel@vger.kernel.org
References: <20041219231015.GB4166@mail.muni.cz> <200412201152.16329.david-b@pacbell.net> <1103576264.1252.87.camel@krustophenia.net>
In-Reply-To: <1103576264.1252.87.camel@krustophenia.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412201331.35652.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 December 2004 12:57 pm, Lee Revell wrote:
> On Mon, 2004-12-20 at 11:52 -0800, David Brownell wrote:
> > Here's a quick'n'dirty patch, msleep --> mdelay.  I'd rather
> > not mdelay for that long, but this late in 2.6.10 it's safer.
> > (And this is also what OHCI does in that same code path.)
> 
> Ugh.  20ms is WAY too long to hold a spinlock.  That's guaranteed to
> cause audio skips.

During system resume?  :)

Anyone trying to use audio devices during system resume
probably deserves what they get, just now.  Best for them
to wait until after the system finishes resuming before
they start playing audio again.  (Over for example the
USB speaker hookup they were using... which has been
suspended for more than 20msec already!)


> Isn't there another way?
> 
> If OHCI calls mdelay(20) while holding a spinlock that needs to be
> fixed.

Eventually this is worth fixing ... after Linux behaves
sanely with selective device suspend/resume.

So for example, with PCI devices it sure _ought_ to be
reasonable to put devices into PCI_D3hot state, with
other active devices in PCI_D0 state and the CPU running
in C0 (or C1, C2, C3 as appropriate) ... and then rely
on ACPI to handle the device signaling PME# sanely,
by resuming the device issuing that signal.  (And to
do similar things for non-PCI/non-ACPI systems, too.)

Until then, there's no real point in trying to rework
those parts of usbcore to support selective resume
of HCDs.  Such code would never be used, and those
changes would conflict with more important work that's
going on.  (Both in terms of lines-of-code changing,
and in terms of opportunity costs.)

On the other hand, if you want to help fix all that,
we'd sure like to see your patches!

- Dave

