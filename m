Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264899AbUASNPM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 08:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264917AbUASNPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 08:15:12 -0500
Received: from fep02.swip.net ([130.244.199.130]:19099 "EHLO
	fep02-svc.swip.net") by vger.kernel.org with ESMTP id S264899AbUASNPD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 08:15:03 -0500
Message-ID: <400BD810.5080201@free.fr>
Date: Mon, 19 Jan 2004 14:13:52 +0100
From: Jean-Luc Fontaine <jfontain@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Rick Lindsley <ricklind@us.ibm.com>
Subject: Re: kernel 2.6.1: erroneous statistics in /proc/diskstats?
References: <200401191058.i0JAw2S14446@owlet.beaverton.ibm.com>
In-Reply-To: <200401191058.i0JAw2S14446@owlet.beaverton.ibm.com>
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Rick Lindsley wrote:

|     I would like to make sure /proc/diskstats is reliable or if I am
totally
|     misunderstanding the significance of the milliseconds spent reading or
|     writing figures.

| So far as I know, they are reliable but there always could be a bug.
| Note that it is legitimate for field 8 to be greater than the time
| elapsed, since it is the *total* time spent in *all* writes.  If two write
| requests were issued simultaneously and each fulfilled simultaneously,
| taking exactly 10ms, you'd account for 20ms of "write I/O" even though
| only 10ms of time has passed.

| So, a few more details ...
| How big was it?
~  700 Mbytes
| How did you copy it (what command)?
~  a simple cp
| Were you going through a file system or direct to disk?
~  from and to reiserfs

| One thing I notice is that your hdc shows 100+ "io's in progress" both
| at start and completion.  It may be as simple as that counter is off.
| If there are IO's in progress when you start and they haven't finished
| by the time you end, then they will certainly add about 6 seconds of
| "write time" for each outstanding, apparently unfulfilled request.
| This alone could account for your extra time.  Any theories on why that
| number is so large for hdc but quite small for hdb?

I did some more measurements, this time waiting after the copy operation
ended, as in my previous experiment, I was doing the measurements while
copying:

(fields: major minor name rio rmerge rsect ruse wio wmerge wsect wuse
~  running use aveq)

# date; egrep 'hdb|hdc' /proc/diskstats
# cp 700MBFile /mnt/hdc1/tmp/
Mon Jan 19 13:53:03 CET 2004
3 64 hdb 44653 197 685454 413847 17585 24405 336784 1631535 0 176727\
~  2045781
3 65 hdb1 44846 685422 42098 336784
22 0 hdc 499 0 3960 60944 78 52 1040 84 0 2819 61028
22 1 hdc1 495 3928 130 1040
# date; egrep 'hdb|hdc' /proc/diskstats
Mon Jan 19 13:54:50 CET 2004
3 64 hdb 50822 197 2068046 489489 17786 24516 339280 1632095 0 246281\
~  2121983
3 65 hdb1 51015 2068014 42410 339280
22 0 hdc 503 0 3992 61016 5111 140110 1161768 2494462 0 44692 2555478
22 1 hdc1 499 3960 145221 1161768

Clearly, wuse on hdc is still very large:
~  2494462 - 84 = 2494378 ms = 2494 s
hdc use:
~  44692 - 2819 = 41873 ms = 41.9 s
for a copy lasting 107 s, while ruse on hdb is correct:
~  489489 - 413847 = 75642 ms = 75.6 s

Jean-Luc
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFAC9gOkG/MMvcT1qQRAs4JAJ0XUdl235mj3iIXpuz0nMiQDX+T5wCZAQzF
r1FbUAt33Wo85znsQMHXj9U=
=Dp0P
-----END PGP SIGNATURE-----

