Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVGUFew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVGUFew (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 01:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbVGUFct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 01:32:49 -0400
Received: from fmr14.intel.com ([192.55.52.68]:50588 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S261348AbVGUFcL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 01:32:11 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: Linux v2.6.13-rc3
Date: Thu, 21 Jul 2005 01:30:51 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30041AC76D@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux v2.6.13-rc3
Thread-Index: AcWH3CH2Fv60eCSNTgqVxjTa2K4itgFzvF8w
From: "Brown, Len" <len.brown@intel.com>
To: "Linus Torvalds" <torvalds@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: <acpi-devel@lists.sourceforge.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Li, Shaohua" <shaohua.li@intel.com>,
       "Yu, Luming" <luming.yu@intel.com>, "Greg KH" <greg@kroah.com>
X-OriginalArrivalTime: 21 Jul 2005 05:30:54.0297 (UTC) FILETIME=[5D3F8C90:01C58DB5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Len, ACPI people - can we fix this regression, please?
>
>Rafael even pinpoints exactly which patches are causing the 
>problem, so why didn't they get reverted before sending them off to me?

Linus,
I'm sorry it was in '-rc3' -- that is as soon as I could
muster the bk->git transition.  Now that I'm running on git,
I expect I'll be able to get the development/testing/push
pipeline moving and back on schedule.

Yes, we discovered both of these regressions in mm.
Yes, Rafael has been a sport in filing good bug reports,
and his Asus L5D has been an interesting case.

Although we broke this system, I do believe that there is
significant value in keeping these changes in the mainline,
as I believe that it is the fastest path to improved support
for all systems.  Specifically...

Re: the EC burst mode regression.
This is an extremely important fix that has been nagging
many systems for years.  It has been reported to us by
distros as well as on kernel.org:
http://bugzilla.kernel.org/show_bug.cgi?id=3851
There has been a lot of discussion about this on the
mailing list and there have been several generations
of patches.  We are confident that this approach
is the correct solution, but clearly there are
some snags.  It is probable that the snags are
model specific.

Ironically, it would be a benefit if more machines
broke like the Asus L5D because we've had a heck of
a time trying to reproduce this.  Indeed, I purchased
an AMD laptop as similar to that model as I could find
and shipped it to China explicitly for Luming to debug
this very issue.  Alas, that model, only slightly different,
works perfectly...

Re: pci_link.c regression on suspend/resume
This is the issue that Patrick was trying to describe in the KS --
that we're knowingly breaking some drivers on suspend/resume.
http://bugzilla.kernel.org/show_bug.cgi?id=3469
We intentionally removed a hack we put in to blindly restore
PCI interrupt links.  The hack can never be reliable
because the AML interpreter must run to restore PCI links
and it must run arbitrary AML code.  But it can sleep on
memory allocation and semaphores, and thus can't reliably
run before we have interrupts enabled.

We discussed this on linux-pm and at the PM-summit, and the
consensus was that making the interrupt restoring process on
resume more like boot will lead to a more robust design.
The down-side is that drivers that worked before will break,
and it is not a quick fix as we work our way through it.

thanks,
-Len
