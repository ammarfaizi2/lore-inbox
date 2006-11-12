Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753421AbWKLWku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421AbWKLWku (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 17:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753424AbWKLWku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 17:40:50 -0500
Received: from aun.it.uu.se ([130.238.12.36]:8942 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1753421AbWKLWkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 17:40:49 -0500
Date: Sun, 12 Nov 2006 23:40:28 +0100 (MET)
Message-Id: <200611122240.kACMeS7l005120@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: 7eggert@gmx.de, akpm@osdl.org, linux-kernel@vger.kernel.org,
       mikpe@it.uu.se, mingo@elte.hu
Subject: Re: [patch] floppy: suspend/resume fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Nov 2006 22:44:28 +0100, Bodo Eggert wrote:
> > 1. You suspend and then resume, leaving the disk in the floppy drive.
> > 
> > 2. You suspend, remove the floppy disk, insert a totally different disk
> >    in the same drive, and then resume.
> > 
> > What should you do?  (Hint: without reading the disk and comparing it
> > with what you have cached you don't know if the disk has been changed
> > or not.)
> > 
> > If you argue that in case (1) you should continue to allow IO, then
> > you potentially end up scribbling over a disk when someone does (2).
> > 
> > So I'd argue that the behaviour being seen by Mikael is the _safest_
> > behaviour, and the most correct behaviour given the limitations of
> > the hardware.
> 
> - If a user suspends with a floppy in the drive, it will mostly be an error,
>   and he'll unsuspend in order to correct it.
> - If it is no error, putting a different/modified floppy into the drive
>   before resume is unlikely
> - Even if somebody does this, you can mostly detect the different disk
>   by comparing the first sector or just the FAT "serial number".
> 
> Therefore you can implement a relatively safe resume that will mostly DTRT
> but destroy data in some unlikely cases, while doing the "safe thing" would
> mostly cause a harmless (unless not noticed) kind of data loss and sometimes
> safe you from real data loss.

The bug occurs regardless of whether I leave the floppy disc in the drive
during suspend or not. 2.6.19-rc5 (vanilla and with Ingo's suspend/resume
hooks) fails the following use case as well:

1. boot
2. insert floppy disc
3. tar tvf /dev/fd0 (works)
4. manually eject floppy disc
5. suspend, later resume 
6. insert floppy disc
7. tar tvf /dev/fd0 (fails with I/O errors)
8. tar tvf /dev/fd0 (works)

Like Ingo said, something happens to the HW during suspend and we
need to figure out how to reinitialise the HW and the driver so that
things work immediately after resume.

/Mikael
