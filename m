Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261905AbVGaTBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbVGaTBx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 15:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbVGaTBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 15:01:53 -0400
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:30225 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S261905AbVGaS7i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 14:59:38 -0400
Date: Sun, 31 Jul 2005 20:59:33 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 2.6] (0/11) hwmon vs i2c, second round
Message-Id: <20050731205933.2e2a957f.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Following my first hwmon vs. i2c series of patches, which was mostly
aiming at moving non-i2c hardware monitoring drivers away from the
i2c-core, here comes a second series which goes one step further in the
direction of a clean separation of the hmwon-specific code from the i2c
subsystem. It is made up of 11 cumulative patches, which I will now
post.

This time, I am attempting to fix two different design errors that were
made in the early days of the sensors drivers and never fixed since: i2c
code being duplicated for the sensors drivers, and non i2c-related code
used by sensors drivers being attached to the i2c subsystem.

This results in a significant code shrink, both at source (-333 lines)
and binary (-2777 bytes) levels, and in large chunks of code being moved
from drivers/i2c to drivers/hwmon (and include/linux/i2c-*.h to
include/linux/hwmon-*.h.)

There are still a few cleanups I want to do on top of that, most notably
a rewrite of i2c_probe and a better handling of address lists, but this
series is certainly the most important (and intrusive) part of the
cleanup process.

I've tried to keep the documentation up-to-date with each patch, but it
seems that this documentation would still need a full review and update,
as it contains pretty inaccurate information at places. I'll tackle that
when I'm done with the code changes.

Thanks.

 Documentation/i2c/porting-clients |   13 +-
 Documentation/i2c/writing-clients |   87 +++----------
 drivers/hwmon/Kconfig             |   51 ++-----
 drivers/hwmon/Makefile            |    1 
 drivers/hwmon/adm1021.c           |    5 
 drivers/hwmon/adm1025.c           |    9 -
 drivers/hwmon/adm1026.c           |   11 -
 drivers/hwmon/adm1031.c           |    7 -
 drivers/hwmon/adm9240.c           |    9 -
 drivers/hwmon/asb100.c            |    9 -
 drivers/hwmon/atxp1.c             |    9 -
 drivers/hwmon/ds1621.c            |    7 -
 drivers/hwmon/fscher.c            |    5 
 drivers/hwmon/fscpos.c            |    5 
 drivers/hwmon/gl518sm.c           |    5 
 drivers/hwmon/gl520sm.c           |    9 -
 drivers/hwmon/hwmon-vid.c         |  203 +++++++++++++++++++++++++++++++
 drivers/hwmon/it87.c              |   13 --
 drivers/hwmon/lm63.c              |    5 
 drivers/hwmon/lm75.c              |    7 -
 drivers/hwmon/lm77.c              |    7 -
 drivers/hwmon/lm78.c              |   17 --
 drivers/hwmon/lm80.c              |    5 
 drivers/hwmon/lm83.c              |    5 
 drivers/hwmon/lm85.c              |    9 -
 drivers/hwmon/lm87.c              |    9 -
 drivers/hwmon/lm90.c              |    5 
 drivers/hwmon/lm92.c              |    5 
 drivers/hwmon/max1619.c           |    5 
 drivers/hwmon/pc87360.c           |    2 
 drivers/hwmon/sis5595.c           |    1 
 drivers/hwmon/smsc47m1.c          |    1 
 drivers/hwmon/via686a.c           |    1 
 drivers/hwmon/w83627hf.c          |    5 
 drivers/hwmon/w83781d.c           |    9 -
 drivers/hwmon/w83792d.c           |    6 
 drivers/hwmon/w83l785ts.c         |    5 
 drivers/i2c/Makefile              |    4 
 drivers/i2c/chips/Kconfig         |   10 -
 drivers/i2c/chips/ds1337.c        |    5 
 drivers/i2c/chips/ds1374.c        |    1 
 drivers/i2c/chips/eeprom.c        |    7 -
 drivers/i2c/chips/m41t00.c        |    1 
 drivers/i2c/chips/max6875.c       |    7 -
 drivers/i2c/chips/pca9539.c       |    7 -
 drivers/i2c/chips/pcf8574.c       |    7 -
 drivers/i2c/chips/pcf8591.c       |    7 -
 drivers/i2c/chips/rtc8564.c       |    1 
 drivers/i2c/i2c-core.c            |   38 ++++-
 drivers/i2c/i2c-sensor-detect.c   |  126 -------------------
 drivers/i2c/i2c-sensor-vid.c      |   98 ---------------
 drivers/media/video/adv7170.c     |    1 
 drivers/media/video/adv7175.c     |    1 
 drivers/media/video/bt819.c       |    1 
 drivers/media/video/bt856.c       |    1 
 drivers/media/video/saa7110.c     |    1 
 drivers/media/video/saa7111.c     |    1 
 drivers/media/video/saa7114.c     |    1 
 drivers/media/video/saa7185.c     |    1 
 drivers/media/video/tuner-3036.c  |    1 
 drivers/media/video/vpx3220.c     |    1 
 include/linux/hwmon-vid.h         |   30 ++++
 include/linux/i2c-sensor.h        |  245 --------------------------------------
 include/linux/i2c-vid.h           |  111 -----------------
 include/linux/i2c.h               |  153 +++++++++++++++++++++--
 65 files changed, 551 insertions(+), 884 deletions(-)

                                                before     after      diff
drivers/hwmon/adm1021.ko                         16408     16343       -65
drivers/hwmon/adm1025.ko                         21005     20721      -284
drivers/hwmon/adm1026.ko                         40572     40352      -220
drivers/hwmon/adm1031.ko                         22799     22798        -1
drivers/hwmon/adm9240.ko                         20842     20558      -284
drivers/hwmon/asb100.ko                          26873     26725      -148
drivers/hwmon/atxp1.ko                           10242      9993      -249
drivers/hwmon/ds1621.ko                           9603      9602        -1
drivers/hwmon/fscher.ko                          18725     18724        -1
drivers/hwmon/fscpos.ko                          18896     18895        -1
drivers/hwmon/gl518sm.ko                         20420     20355       -65
drivers/hwmon/gl520sm.ko                         22904     22684      -220
drivers/hwmon/hwmon-vid.ko                           0      3417     +3417
drivers/hwmon/it87.ko                            26031     25747      -284
drivers/hwmon/lm63.ko                            12077     12076        -1
drivers/hwmon/lm75.ko                             9294      9293        -1
drivers/hwmon/lm77.ko                            11498     11433       -65
drivers/hwmon/lm78.ko                            21124     21096       -28
drivers/hwmon/lm80.ko                            22096     22095        -1
drivers/hwmon/lm83.ko                             9850      9849        -1
drivers/hwmon/lm85.ko                            40438     40218      -220
drivers/hwmon/lm87.ko                            25077     24857      -220
drivers/hwmon/lm90.ko                            15213     15148       -65
drivers/hwmon/lm92.ko                            11912     11847       -65
drivers/hwmon/max1619.ko                         10643     10642        -1
drivers/hwmon/pc87360.ko                         47225     47006      -219
drivers/hwmon/w83627hf.ko                        30422     30203      -219
drivers/hwmon/w83781d.ko                         39165     38945      -220
drivers/hwmon/w83792d.ko                         32767     32766        -1
drivers/hwmon/w83l785ts.ko                        8289      8288        -1
drivers/i2c/chips/ds1337.ko                       8677      8612       -65
drivers/i2c/chips/ds1374.ko                       6075      6067        -8
drivers/i2c/chips/eeprom.ko                       8132      8131        -1
drivers/i2c/chips/max6875.ko                      7822      7821        -1
drivers/i2c/chips/pca9539.ko                      7763      7762        -1
drivers/i2c/chips/pcf8574.ko                      8042      7977       -65
drivers/i2c/chips/pcf8591.ko                      9630      9565       -65
drivers/i2c/chips/rtc8564.ko                      6947      6939        -8
drivers/i2c/i2c-core.ko                          21451     21579      +128
drivers/i2c/i2c-sensor.ko                         3856         0     -3856
drivers/media/video/adv7170.ko                    7333      7325        -8
drivers/media/video/adv7175.ko                    7613      7605        -8
drivers/media/video/bt819.ko                      9027      9019        -8
drivers/media/video/bt856.ko                      7058      7050        -8
drivers/media/video/msp3400.ko                   31404     31499       +95
drivers/media/video/saa5246a.ko                  11254     11349       +95
drivers/media/video/saa5249.ko                   13054     13149       +95
drivers/media/video/saa7110.ko                    9512      9504        -8
drivers/media/video/saa7111.ko                    7177      7169        -8
drivers/media/video/saa7114.ko                   12048     12040        -8
drivers/media/video/saa7134/saa6752hs.ko         10489     10584       +95
drivers/media/video/saa7185.ko                    6323      6315        -8
drivers/media/video/tda7432.ko                    9373      9404       +31
drivers/media/video/tda9840.ko                    8938      9033       +95
drivers/media/video/tda9875.ko                    9234      9329       +95
drivers/media/video/tda9887.ko                   16949     17044       +95
drivers/media/video/tea6415c.ko                   7765      7860       +95
drivers/media/video/tea6420.ko                    7635      7730       +95
drivers/media/video/tuner-3036.ko                 5940      5932        -8
drivers/media/video/tuner.ko                     45355     45386       +31
drivers/media/video/tvaudio.ko                   25796     25827       +31
drivers/media/video/tveeprom.ko                  15175     15206       +31
drivers/media/video/vpx3220.ko                   10083     10075        -8
                                                           total     -2777

-- 
Jean Delvare
