Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319238AbSHNHz0>; Wed, 14 Aug 2002 03:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319239AbSHNHz0>; Wed, 14 Aug 2002 03:55:26 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:59914 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S319238AbSHNHz0>;
	Wed, 14 Aug 2002 03:55:26 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: [patch] printk from userspace
Date: Wed, 14 Aug 2002 07:59:01 +0000 (UTC)
Organization: Cistron
Message-ID: <ajd2k5$h8l$1@ncc1701.cistron.net>
References: <Pine.GSO.4.21.0208140016140.3712-100000@weyl.math.psu.edu> <Pine.LNX.4.44.0208132123500.1208-100000@home.transmeta.com>
Content-Type: text/plain; charset=iso-8859-15
X-Trace: ncc1701.cistron.net 1029311941 17685 62.216.29.67 (14 Aug 2002 07:59:01 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0208132123500.1208-100000@home.transmeta.com>,
Linus Torvalds  <torvalds@transmeta.com> wrote:
>That said, I like the notion. I've always hated the fact that all the 
>boot-time messages get lost, simply because syslogd hadn't started, and 
>as a result things like fsck ran without any sign afterwards. The kernel 
>log approach saves it all in one place.

I have a bootlogd that does a TIOCCONS on /dev/console, so
that it can capture all messages written to /dev/console.

It buffers the messages in-memory, until it is able to open
a logfile in /var/log/ at which point it writes the buffered
data to the logfile, and starts logging to that file.

The only problem is that TIOCCONS is a redirect, so there's no
output to the console anymore. Ofcourse that can be solved by
letting bootlogd open("/dev/realconsole") and sending a copy
to it, but there is no way to ask the kernel to which _real_
device /dev/console is connected.

I submitted a TIOCGDEV ioctl patch a few times during 2.2 development
but it was never integrated, alas.

So this is all solveable in userspace. No need to buffer
messages in non-swappable memory in the the kernel.

Simply add TIOCGDEV or add a flags to the TIOCCONS ioctl that
means 'copy instead of redirect'. Both are useful .. Or, hmm,
interesting, add some code so that if you write to the master
side of the pty pair to which the console is redirected, the
output ends up on the real console. That has a nice symmetric
feel to it.

Sample code is in sysvinit since 2.79 or 2.80, sysvinit-2.xx/src/bootlogd.c

Mike.

