Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264307AbUE3TfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264307AbUE3TfX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 15:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264308AbUE3TfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 15:35:23 -0400
Received: from mail-ext.curl.com ([66.228.88.132]:27914 "HELO
	mail-ext.curl.com") by vger.kernel.org with SMTP id S264307AbUE3TfP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 15:35:15 -0400
From: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Message-ID: <s5gwu2tlo97.fsf@patl=users.sf.net>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.x partition breakage and dual booting
References: <40BA2213.1090209@pobox.com>
In-Reply-To: <40BA2213.1090209@pobox.com>
Date: 30 May 2004 15:35:12 -0400
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

> So it seems that the 2.6.x geometry code breaks dual booting, since
> Windows wants "sane" CHS values.  See the thread on slashdot, or
> http://www.redhat.com/archives/fedora-devel-list/2004-May/msg00908.html
> 
> Although Fedora Core is current taking grief for this, it's really a
> 2.6.x kernel problem AFAICT.
> 
> Has anybody taken the time to hunt down the csets that cause this
> massive partition table breakage?  If so, it will save me some time
> tracking this down.

Here are my contributions to the discussion:

    http://groups.google.com/groups?selm=1xXh2-850-17%40gated-at.bofh.it

    http://groups.google.com/groups?selm=1Gjko-6Y1-5%40gated-at.bofh.it

    http://groups.google.com/groups?selm=1Gju8-7bd-29%40gated-at.bofh.it

In short, starting with kernel 2.6.5, Linux invokes the real-mode
"legacy INT13" interface (INT13/AH=08) at boot time and stashes the
results away.  The EDD module exports them via sysfs.

Userspace can read these values and issue a command to
/proc/ide/hda/settings to "fix" the kernel's concept of the geometry
before running partitioning tools.

Because the legacy geometry is purely a BIOS concept, there is no way
to obtain it by talking to the disk directly.  (Sure, there may be
hints in the existing partition table.  I believe 2.4.x would use such
hints.  But this is unreliable, since it does not work if the disk is
blank or if it has been moved from a different machine.)

The reason to do this work in userspace is that there is no certain
way to map between BIOS disk numbers (80h etc.) and Linux devices.
You can make a pretty good guess, but such guessing probably does not
belong in the kernel.

I first encountered this problem while trying to install Windows using
Linux.  I contributed the "legacy geometry" support to the EDD module
specifically to deal with this issue, and it is working fine for me.

 - Pat
   http://unattended.sourceforge.net/
