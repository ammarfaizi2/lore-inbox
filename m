Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268074AbTAJA1l>; Thu, 9 Jan 2003 19:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268075AbTAJA1l>; Thu, 9 Jan 2003 19:27:41 -0500
Received: from mstr10.srv.hcvlny.cv.net ([167.206.5.29]:10434 "EHLO
	mstr10.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S268074AbTAJA1j>; Thu, 9 Jan 2003 19:27:39 -0500
Date: Thu, 09 Jan 2003 19:10:31 -0500
From: Rob Wilkens <robw@optonline.net>
Subject: Floppy bug - And fix, kind of :-)
To: linux-kernel@vger.kernel.org
Reply-to: robw@optonline.net
Message-id: <1042157430.841.29.camel@RobsPC.RobertWilkens.com>
Organization: Robert Wilkens
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Someone reported a bug in the linux.kernel newsgroup which I presumed
was somehow linked to this mailing list which I finally found my way on
to.  Glad to be here.

Anyway, enough of the pleasantries.  I'm a newbie to the Linux kernel,
but formerly a professional kernel developer.  I left for mental health
reasons, long story.

The bug that someone reported was that when they did a "dd" using the
device "/dev/fd0u1440" and there was no disk in the drive, it would only
fail about half of the time.  The rest of the tiem it would succeed,
which is bad because there was no disk and for it so succeed and not get
an ENXIO on openning the device was wrong.

I was able to reproduce this bug, and fix it, on my machine.

The fix isn't pretty, though, and it's a one line fix.  I'll leave it to
others here (open for discussion) to suggest the more propper fix, after
all I am a newbie here.  My fix may be fine, though.  I just don't know.

Basically, the error traced back to the floppy_revalidate(kdev_t dev)
function in drivers/block/floppy.c .. There's a line in there which
reads "if (NO_GEOM) {", and my fix is to change that line to "if (1) {".

Yep, that means that the code inside that block gets executed every
time.

You see, the problem is that only when the code inside that block gets
executed, though, is there some reading done from the drive which tests
the initial drive status.  

Of course, if someone is openning a special "u1440" version of the
device (minor number 28 instead of minor number 0), then there may be a
good reason that this code shouldn't be executed.  I just don't know
what that is because I don't know what those special device files are
for.

If those files are to specially handle, for example, 720kb disks in a
1440kb drive, then I'm not sure this particular piece of code being
enabled will -break- that.  Of course, I only can find one floppy disk,
and it's a 1440kb disk.  I don't have tons of floppies hanging around.

Someone may have already addressed this issue, too.  I don't know.

If anyone was interested, though, I was able to reproduce this problem
simply by not having a disk in the drive and repeatedly opening the
drive with simple test.c code (with O_WROLY|O_CREAT|O_TRUNC as dd was
using).  If I openned "/dev/fd0", I would consistently get a failure as
expected, but if I openned "/dev/fd0u1440" I would less consistently get
a failure.

I haven't checked a 2.5 kernel.  This was in 2.4.20.

-Rob

p.s. Sorry for the long message.  I figure too much detail is better
than too little.

