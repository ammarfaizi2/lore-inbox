Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267076AbUBRCFz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 21:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267085AbUBRCFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 21:05:55 -0500
Received: from mail.inter-page.com ([12.5.23.93]:33298 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S267076AbUBRCFx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 21:05:53 -0500
From: "Robert White" <rwhite@casabyte.com>
To: <Valdis.Kletnieks@vt.edu>, "'Andrey Borzenkov'" <arvidjaar@mail.ru>
Cc: <der.eremit@email.de>, <linux-kernel@vger.kernel.org>
Subject: RE: Initrd Question 
Date: Tue, 17 Feb 2004 18:05:39 -0800
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAodkDQazuxky+8ha4yn4hfQEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <200402131422.i1DEMWVB011960@turing-police.cc.vt.edu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In a modern kernel you can safely multiply mount file systems.  In
particular, if you are going to pivot_root you might be better off and
happier if you mount devfs and procfs (and sysfs) in both the old and new
locations before the pivot.

So mount /dev and /proc and /sysfs (etc) as needed before the pivot.
Mount /new-root.
Then mount /new-root/dev /new-root/proc /new-root/sysfs /new-root/dev/devpts
(etc) as you expect to need it after the pivot
Do the pivot.
Then unmount the unneeded /old-root/dev etc.

This should make things much more convenient.

Mount what you need, but don't mount things that init scripts will mount
later.  There isn't much harm to be had in mounting something over itself
(e.g. "mount -t devfs devfs /dev" twice in a row) but it keeps things like
/proc/mounts nice and tidy if you keep it all straight.

Rob.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of
Valdis.Kletnieks@vt.edu
Sent: Friday, February 13, 2004 6:23 AM
To: Andrey Borzenkov
Cc: der.eremit@email.de; linux-kernel@vger.kernel.org
Subject: Re: Initrd Question 

On Fri, 13 Feb 2004 17:14:25 +0300, =?koi8-r?Q?=22?=Andrey
Borzenkov=?koi8-r?Q?=22=20?= said:

> > Should you check for /dev/.devfsd on the real root here? I thought
.devfsd
> > is created by the devfsd process, 
> 
> you are wrong here, sorry. .devfsd is created by devfs.

I see the confusion - .devfsd gets created in the directory that is
/dev at the time devfs starts up.  However, after pivot_root, that directory
has a new name, and that's where we need to check for .devfsd.

It gets even more confusing in some configurations where we end up
unmounting
/initrd/dev and then re-mounting /dev just to get it into the right place..


