Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbVGSViz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbVGSViz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 17:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbVGSViz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 17:38:55 -0400
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:43794 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261679AbVGSViw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 17:38:52 -0400
Date: Tue, 19 Jul 2005 23:39:02 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 2.6] I2C: Separate non-i2c hwmon drivers from i2c-core (0/9)
Message-Id: <20050719233902.40282559.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is a set of patches for review and comments. The aim is to start
separating a number of hardware monitoring drivers from the i2c
subsystem. Hardware monitoring (or sensors) have a long history of being
registered with the i2c subsystem even when they are not I2C (nor SMBus)
devices. This adds artificial dependencies  between various kernel
drivers, is reponsible for some weird code, and prevents us from
cleaning up some code in the i2c subsystem. For all these reasons, I
would like to separate non-I2C hardware monitoring drivers from the i2c
core.

This will be a multistep process, as we need to keep all the drivers
working and to preserve user-space compatibility (most notably with
libsensors) while cleaning up the various parts which need be.

This patchset constitutes the first big step, and is made up of 9
patches, to be applied in order. Individual patches follow, each with
comments and diffstat.

Andrew, please don't pick this for -mm yet. It'll hopefully come to you
through Greg's i2c tree when it is ready.

Additional notes:

* Stats (debugging disabled)

                                  before       after        diff

# I2C-only drivers
drivers/hwmon/adm1021.ko           16855       16820	     -35
drivers/hwmon/adm1025.ko           21677       21642	     -35
drivers/hwmon/adm1026.ko           41379       41344	     -35
drivers/hwmon/adm1031.ko           23071       23036	     -35
drivers/hwmon/adm9240.ko           21338       21303	     -35
drivers/hwmon/asb100.ko            27512       27445	     -67
drivers/hwmon/atxp1.ko             10410       10375	     -35
drivers/hwmon/ds1621.ko             9970        9903	     -67
drivers/hwmon/fscher.ko            19333       19298	     -35
drivers/hwmon/fscpos.ko            19192       19157	     -35
drivers/hwmon/gl518sm.ko           21011       20976	     -35
drivers/hwmon/gl520sm.ko           23552       23517	     -35
drivers/hwmon/lm63.ko              12532       12497	     -35
drivers/hwmon/lm75.ko               9382        9347	     -35
drivers/hwmon/lm77.ko              11666       11631	     -35
drivers/hwmon/lm80.ko              22552       22517	     -35
drivers/hwmon/lm83.ko              10146       10111	     -35
drivers/hwmon/lm85.ko              41069       41034	     -35
drivers/hwmon/lm87.ko              25868       25833	     -35
drivers/hwmon/lm90.ko              15511       15458	     -53
drivers/hwmon/lm92.ko              12072       12037	     -35
drivers/hwmon/max1619.ko           10995       10960	     -35
drivers/hwmon/w83l785ts.ko          8513        8478	     -35
drivers/i2c/chips/ds1337.ko         8800        8765	     -35
drivers/i2c/chips/eeprom.ko         8331        8296	     -35
drivers/i2c/chips/max6875.ko       10460       10425	     -35
drivers/i2c/chips/pca9539.ko        7981        7946	     -35
drivers/i2c/chips/pcf8574.ko        8260        8225	     -35
drivers/i2c/chips/pcf8591.ko        9798        9763	     -35

# hybrid drivers
drivers/hwmon/it87.ko              25924       26563	    +639
drivers/hwmon/lm78.ko              21781       22420	    +639
drivers/hwmon/w83781d.ko           39132       39745	    +613

# ISA-only drivers
drivers/hwmon/pc87360.ko           48007       47734	    -273
drivers/hwmon/sis5595.ko           20257       17401	   -2856
drivers/hwmon/smsc47b397.ko         7422        7122	    -300
drivers/hwmon/smsc47m1.ko          11330       11080	    -250
drivers/hwmon/via686a.ko           22922       20066	   -2856
drivers/hwmon/w83627ehf.ko         19155       16255	   -2900
drivers/hwmon/w83627hf.ko          35861       30955	   -4906

# core modules
drivers/i2c/busses/i2c-isa.ko       2991        5685	   +2694
drivers/i2c/i2c-core.ko            21257       21805	    +548
drivers/i2c/i2c-sensor.ko           4057        3767	    -290

total                                                     -10595

 Documentation/i2c/porting-clients |    7 -
 Documentation/i2c/writing-clients |   46 ++++-------
 drivers/hwmon/Kconfig             |    3 
 drivers/hwmon/adm1021.c           |   10 --
 drivers/hwmon/adm1025.c           |    1 
 drivers/hwmon/adm1026.c           |    1 
 drivers/hwmon/adm1031.c           |    1 
 drivers/hwmon/adm9240.c           |    2 
 drivers/hwmon/asb100.c            |   11 --
 drivers/hwmon/atxp1.c             |    1 
 drivers/hwmon/ds1621.c            |    1 
 drivers/hwmon/fscher.c            |    1 
 drivers/hwmon/fscpos.c            |    1 
 drivers/hwmon/gl518sm.c           |    1 
 drivers/hwmon/gl520sm.c           |    1 
 drivers/hwmon/it87.c              |   42 ++++++++--
 drivers/hwmon/lm63.c              |    1 
 drivers/hwmon/lm75.c              |   11 --
 drivers/hwmon/lm77.c              |    1 
 drivers/hwmon/lm78.c              |   37 +++++++-
 drivers/hwmon/lm80.c              |    1 
 drivers/hwmon/lm83.c              |    1 
 drivers/hwmon/lm85.c              |    6 -
 drivers/hwmon/lm87.c              |    1 
 drivers/hwmon/lm90.c              |    1 
 drivers/hwmon/lm92.c              |    1 
 drivers/hwmon/max1619.c           |    1 
 drivers/hwmon/pc87360.c           |   43 ++--------
 drivers/hwmon/sis5595.c           |   46 ++---------
 drivers/hwmon/smsc47b397.c        |   53 +++---------
 drivers/hwmon/smsc47m1.c          |   47 ++---------
 drivers/hwmon/via686a.c           |   46 ++---------
 drivers/hwmon/w83627ehf.c         |   40 ++-------
 drivers/hwmon/w83627hf.c          |   54 +++---------
 drivers/hwmon/w83781d.c           |   37 +++++++-
 drivers/hwmon/w83l785ts.c         |    1 
 drivers/i2c/busses/Kconfig        |    8 -
 drivers/i2c/busses/i2c-isa.c      |  158 +++++++++++++++++++++++++++++++++++---
 drivers/i2c/chips/ds1337.c        |    1 
 drivers/i2c/chips/eeprom.c        |    1 
 drivers/i2c/chips/max6875.c       |    1 
 drivers/i2c/chips/pca9539.c       |    1 
 drivers/i2c/chips/pcf8574.c       |    1 
 drivers/i2c/chips/pcf8591.c       |    1 
 drivers/i2c/i2c-core.c            |   14 ++-
 drivers/i2c/i2c-sensor-detect.c   |   45 +++-------
 include/linux/i2c-isa.h           |   36 ++++++++
 include/linux/i2c-sensor.h        |   36 +++-----
 include/linux/i2c.h               |   22 ++---
 49 files changed, 448 insertions(+), 436 deletions(-)

These stats are not necessarily very impressive by themselves, as
i2c-isa and i2c-core both increase in size quite significantly, and so
do the hybrid drivers. However this changeset opens possibilities to
many other cleanups in the future, including dropping i2c-isa altogether
(which will revert all the losses on i2c-core and i2c-isa), merging
i2c_probe and i2c_detect (100 lines of code) and reworking the way i2c
module parameters are handled (150 lines of ugly macros).

The size shrink of the ISA-only drivers is nice already. The loss on
hybrid drivers isn't very significant as this is a rare case, and even
it87 may become an ISA-only driver in the long run.

* ISA drivers are still registered with the i2c subsystem at the moment,
even if not as directly as before. This is a requirement as long as
user-space tools (libsensors) are not taught to search for hardware
monitoring drivers in /sys/class/hwmon rather than /sys/bus/i2c. I'll
work on that in parallel. In the long run, we really want these drivers
to be completely independant from the i2c subsystem, and this patchset
is a step in this direction, even if it might not be obvious at first
sight.

* Each hybrid driver could be split in three parts, one I2C part, one
ISA part and one common part. This would make things cleaner and would
suppress some artificial dependencies. There is little value in doing so
right now though, as the ISA part would still depend on i2c-core. Doing
so would also break compatibility with user-space (not by much but
still). Not sure what we want to do here as there are only three (or
even two) such drivers and there is a significant work to split them.

* i2c-isa could have been moved to drivers/hwmon or drivers/i2c as it is
no more an i2c bus driver (it never really has been), but I chose not to
do it because in the long run this module will disappear anyway - so why
bother?

Thanks,
-- 
Jean Delvare
