Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262525AbSJ3BCZ>; Tue, 29 Oct 2002 20:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262547AbSJ3BCZ>; Tue, 29 Oct 2002 20:02:25 -0500
Received: from [207.224.39.108] ([207.224.39.108]:18440 "EHLO
	detroit.freenet.org") by vger.kernel.org with ESMTP
	id <S262525AbSJ3BCY>; Tue, 29 Oct 2002 20:02:24 -0500
Date: Tue, 29 Oct 2002 20:08:20 -0500 (EST)
Message-Id: <200210300108.UAA17536@detroit.freenet.org>
From: av556@detroit.freenet.org (Kenneth M. Howlett)
To: linux-kernel@vger.kernel.org, mnalis-umsdos@voyager.hr,
       chaffee@cs.berkeley.edu, bsg@uniyar.ac.ru
Subject: PROBLEM: dos filesystem timestamps and daylight savings time
Reply-To: av556@detroit.freenet.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




A few days ago, daylight savings time ended, and now
ls --full-time says the timestamps of all the files on
my dos partition have increased by one hour.

For example, ls --full-time says the timestamp of command.com is:
last week: Tue Apr 07 06:00:00 1992
this week: Tue Apr 07 07:00:00 1992

I think the timestamps of a dos filesystem are stored in local
time. So the dos filesystem driver needs to convert the local
time to unix standard time, and then ls converts back to local
time, and displays the timestamp in local time.

I think that the problem is that the dos filesystem driver's
local time to unix standard time algorithm is compensating for
whether or not daylight savings time is in effect NOW. It should
be compensating for whether or not daylight savings time was in
effect at the time of the timestamp.

The time conversion algorithm is function date_dos2unix in file
/usr/src/linux-2.4.19/fs/fat/misc.c. Is there a way to use
tz_minuteswest from the the time of the timestamp instead of the
current tz_minuteswest?

Or before returning the number of seconds, function date_dos2unix
could determine if daylight savings time is in effect now, and if
daylight savings time was in effect at the time of the timestamp.
These determinations could return 0 or 1. Then subtract the two
determinations, which will give us -1, 0, or 1. Multiply by 3600
and add to the number of seconds.

Function fat_date_unix2dos in file
/usr/src/linux-2.4.19/fs/fat/misc.c should have a similar fix.

ls appears to convert unix standard time to local time correctly,
adjusting for whether or not daylight savings time was in effect
at the time being converted. Maybe we should look at the source
for ls, to see how ls converts time.

I am running redhat 7.2 on a pcchips741lmrt/pentiumII, with a
custom 2.4.19 kernel, compiled with gcc version 2.96. My dos
partition is plain dos, not vfat or umsdos.

