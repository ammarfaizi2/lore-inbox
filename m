Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268101AbUBRVIP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 16:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268100AbUBRVIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 16:08:14 -0500
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:34056 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S268101AbUBRVHu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 16:07:50 -0500
Date: Wed, 18 Feb 2004 22:08:45 +0100
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: LM Sensors <sensors@stimpy.netroedge.com>, Greg KH <greg@kroah.com>
Subject: [RFC 2.6] sensor chips sysfs interface change (long)
Message-Id: <20040218220845.361341c9.khali@linux-fr.org>
Reply-To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I plan to make rather important changes to the sysfs interface of I2C
chip drivers in Linux 2.6. The topic has already been discussed on the
lm_sensors mailing list, bug Greg KH suggested that I should explain my
intentions here too, so here I am.

THE PROBLEM

The sysfs interface to I2C chips as it exists in Linux 2.6 isn't that
bad. It has a number of benefits over the old procfs interface we used
during the times of 2.2 and 2.4 kernels. The main change (apart from the
pseudo-filesystem change itself) is that we opted for a
one-value-per-file policy, with the obvious goal to make this interface
more chip-independent. We also decided that all values, which are mainly
fixed point values, would all use the same number of decimal places,
again to make it less chip-dependent.

A few changes were made recently to enhance the chip-independency, such
as differentiating between minimum temperatures and hysteresis
temperatures.

The problem is that there are still several files that need you to know
additional information about the chip to properly use them. Examples of
that:
* Hysteresis temperature values can apply to several limits. For most
  chips it applies to the max temperature, but for some it applies to the
  critical temperature. One chip (LM80) even has the two of them, so its
  sysfs interface doesn't comply with the defined standard.
* Alarms are represented as bit vectors. The meaning of each bit is
  chipset-dependent.

There is a second, less important problem. The file naming scheme was
not chosen in accordance with what was done in previous kernels and
libsensors, the sensors information access library. When we would refer
to "temp1_max" before, the corresponding sysfs file is now "temp_max1".
I say it is less important because it doesn't affect the
chip-independency of the current interface. Still it requires additional
code in libsensors (not much, admittedly), makes "ls" group the sysfs
files in an irrelevant order, and is likely to make sysfs the future
interface "discovery" code a bit more complex.

THE REASONS FOR CHANGE

Although the problem detailed above probably makes it clear why I want
to alter the sysfs interface, I think some of you will be interested in
more details on why I want them to occur, and more specifically why I
want the changes to be made as soon as possible, although in a stable
series.

My ultimate goal is to make it possible to write a completely
chip-independent sensors library. The way things were done so far,
adding support for a new hardware monitoring chip always requires to
update the library and user-space programs (such as "sensors"). At the
moment, 75% of the libsensors code is chipset specific, and almost 90%
of the "sensors" user-space tool code is. This demonstrates how much
code we could save, would we have a truly chip-independant sysfs
interface. This also means that the library and user-space tools
wouldn't have to be updated with each new chip driver (with the
exception of the sensors.conf configuration file).

Since only 30% of the sensors chip drivers have been ported to Linux 2.6
yet, I think that if we are to change the interface, we better do it
before porting the other 70% (well, obviously less since some of them
will probably never be ported).

Also, were we to wait for Linux 2.7 before starting these changes, as
some of you might suggest, this would mean that the new sensors library
would be either usable only there (which basically means maybe 3 years
or so before a monitoring application can rely on this library only), or
it would have to support both the 2.6 and 2.7 sysfs standards. This is
likely to make the code be much more complex, for basically no benefit.

In fact, I don't feel bad to change the standard now because it is
hardly established yet. It isn't as if I were planing to change a
long-established standard. With each new Linux 2.6 release since .0, we
have been updating the standard and modified the drivers to comply with
it, so that we had to release a new libsensors each time. One more
change won't hurt much more, especially if this is this ensures this is
the last one. I also insist on the fact that, since the sysfs interface
is not chip-independent yet, applications are discouraged to access the
sysfs interface directly, and should rely on libsensors instead. Since
we keep the library in sync with the Linux 2.6 kernel (and will continue
to do so), such applications are not affected by the changes (except
that libsensors has to be updated), even the relatively important one I
propose to make here.

THE PLAN

I propose a three-step plan.

1* Change the base scheme (e.g. temp_min1 -> temp1_min). This is the
more important change (in the sense it affects all drivers and the
libsensors library) and correspond to the second problem listed above.

Benefits of the new naming scheme are:

- Back to the original (libsensors) names, more natural to the sensors
  developers. Allows some simplifications in the current libsensors.
  Represents the relations between the different values in a more
  understandable way IMHO. References in the sensors.conf configuration
  file will match the file names.

- Better ordering by "ls" and the such. Groups name by sensor instead of
  limits.

- Probably easier "browsing" code later. For example, if you want to
  treat all files related to the first temperature sensor, looking for
  files beginning with "temp1_" should be easier than looking for files
  beginning with "temp_" and ending with "1" not preceeded by another
  digit. Likewise, getting the sub-item is easy in the "temp1_min" scheme
  (access string+strlen(prefix)) and you're done) while it looks more
  tricky with the "temp_min1" scheme. Of course, all this depends on how
  you will be handling the whole thing in your application, and which
  language you use, but to make it short, it really looks like the
  "temp1_min" scheme can be handled with basic C functions while the
  "temp_min1" scheme would be more easily handled with regular
  expressions.

2* Change the hysteresis names (temp1_hyst -> temp1_max_hyst). Only some
drivers are impacted. Changes required to the library as well.

Benefits:

Increase the chip-independency by making it clear which limits the
hysteresis do apply to. The lm80 driver *needs* this since it has two
hysteresis values per temperature channel.

3* Add splitted alarm files. This doesn't break the interface (these are
new files), but on the other hand needs that we think about it a bit
more so that our choices are extendable and correct for all known
drivers.

I would like to make steps 1 and 2 occur as soon as in Linux 2.6.4 (i.e.
immediately), because they break the interface. Step 3 is required for a
fully chip-independent interface (and future library), but doesn't break
the interface and cannot be used by the current libsensors, so we can
give ourself some delay.

I will of course make the changes everywhere at once (all drivers and
library, documentation) so that applications using libsensors won't be
affected at all.

For those interested, the original thread on the lm_sensors mailing-list
is available here:
  http://archives.andrew.net.au/lm-sensors/msg06206.html
And an older one on the same topic:
  http://archives.andrew.net.au/lm-sensors/msg05028.html

Comments welcome (or even requested, according to the subject line).

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
