Return-Path: <linux-kernel-owner+w=401wt.eu-S1751432AbXAFR4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbXAFR4I (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 12:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbXAFR4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 12:56:07 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:44036 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbXAFR4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 12:56:06 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <459FE2AF.2020507@s5r6.in-berlin.de>
Date: Sat, 06 Jan 2007 18:55:59 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.20-rc3 regression?  hdparm shows 1/2...1/3 the throughput
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did anybody else notice this?  The result of "hdparm -t" under 2.6.20-rc
seems to be less than half of what you get on 2.6.19.  However, disk I/O
did *not* get slower according to bonnie++.

That is, there is no harm beyond confusion of the user.  hdparm is lying
for some reason.

Below is the output of hdparm v6.6 and bonnie++ 1.93c.  I ran hdparm 3
times each and bonnie++ 2 times to ensure that I get typical readings,
on an otherwise idle system.

hdparm -tT /dev/???:
========================================================================
2.6.19.1, IDE:
 Timing cached reads:   10728 MB in  2.00 seconds = 5371.95 MB/sec
 Timing buffered disk reads:  154 MB in  3.01 seconds =  51.11 MB/sec

2.6.19.1, SATA:
 Timing cached reads:   8028 MB in  2.00 seconds = 4017.69 MB/sec
 Timing buffered disk reads:  220 MB in  3.01 seconds =  73.18 MB/sec

2.6.19.1 + latest 1394 drivers, FireWire 800:
 Timing cached reads:   10216 MB in  2.00 seconds = 5114.73 MB/sec
 Timing buffered disk reads:  214 MB in  3.03 seconds =  70.71 MB/sec

2.6.19.1 + latest 1394 drivers, FireWire 400:
 Timing cached reads:   8892 MB in  2.00 seconds = 4449.76 MB/sec
 Timing buffered disk reads:   74 MB in  3.08 seconds =  24.02 MB/sec
========================================================================
2.6.20-rc3, IDE:
 Timing cached reads:   11492 MB in  2.00 seconds = 5753.76 MB/sec
 Timing buffered disk reads:   56 MB in  3.10 seconds =  18.09 MB/sec

2.6.20-rc3, SATA:
 Timing cached reads:   10736 MB in  2.00 seconds = 5374.70 MB/sec
 Timing buffered disk reads:  102 MB in  3.00 seconds =  33.99 MB/sec

2.6.20-rc3 + latest 1394 drivers, FireWire 800:
 Timing cached reads:   9476 MB in  2.00 seconds = 4742.33 MB/sec
 Timing buffered disk reads:   70 MB in  3.08 seconds =  22.69 MB/sec

2.6.20-rc3 + latest 1394 drivers, FireWire 400:
 Timing cached reads:   10336 MB in  2.00 seconds = 5173.65 MB/sec
 Timing buffered disk reads:   40 MB in  3.09 seconds =  12.95 MB/sec
========================================================================


bonnie++ on the SATA disk with a single 47% filled reiserfs partition:
========================================================================
2.6.19.1, SATA:
> Version 1.93c       ------Sequential Output------ --Sequential Input- --Random-
> Concurrency   1     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
> Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
> stein            2G   203  99 57389  18 26943   9   856  93 66032  17 190.8   6
> Latency             48553us     295ms    1130ms     196ms   18075us     500ms
> Version 1.93c       ------Sequential Create------ --------Random Create--------
> stein               -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
>               files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
>                  16 16541  55 +++++ +++ 18794  71 22933  79 +++++ +++ 24005  95
> Latency               107ms     129us     175ms   16613us      76us     236us
That is,
56.0 MB/s write and 64.5 MB/s read performance of sequential block I/O.
========================================================================
2.6.20-rc3, SATA:
> Version 1.93c       ------Sequential Output------ --Sequential Input- --Random-
> Concurrency   1     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
> Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
> stein            2G   210  99 57340  18 26920  10  1166  89 66805  17 195.3   5
> Latency             47794us     284ms     869ms     249ms   36229us     533ms
> Version 1.93c       ------Sequential Create------ --------Random Create--------
> stein               -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
>               files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
>                  16 19645  67 +++++ +++ 21767  83 26951  94 +++++ +++ 24859  98
> Latency               231ms      85us     120us     469us      69us     118us
That is,
56.0 MB/s write and 65.2 MB/s read performance of sequential block I/O.
========================================================================


It's a 32bit kernel on a dual core x86 PC:
> $ uname -a
> Linux stein 2.6.20-rc3 #7 SMP PREEMPT Sat Jan 6 17:07:30 CET 2007 i686 Intel(R) Core(TM)2 CPU         T7200  @ 2.00GHz GenuineIntel GNU/Linux

The motherboard is i945GT based.
> $ /usr/sbin/lspci
> 00:00.0 Host bridge: Intel Corporation Mobile Memory Controller Hub (rev 03)
> 00:01.0 PCI bridge: Intel Corporation Mobile PCI Express Graphics Port (rev 03)
> 00:02.0 VGA compatible controller: Intel Corporation Mobile Integrated Graphics Controller (rev 03)
> 00:1b.0 Class 0403: Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller (rev 01)
> 00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1 (rev 01)
> 00:1c.4 PCI bridge: Intel Corporation 82801GR/GH/GHM (ICH7 Family) PCI Express Port 5 (rev 01)
> 00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1 (rev 01)
> 00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2 (rev 01)
> 00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3 (rev 01)
> 00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4 (rev 01)
> 00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Controller (rev 01)
> 00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1)
> 00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC Interface Bridge (rev 01)
> 00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller (rev 01)
> 00:1f.2 IDE interface: Intel Corporation 82801GB/GR/GH (ICH7 Family) Serial ATA Storage Controllers cc=IDE (rev 01)
> 00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 01)
> 01:00.0 PCI bridge: Texas Instruments Unknown device 8231 (rev 03)
> 02:02.0 FireWire (IEEE 1394): Texas Instruments TSB82AA2 IEEE-1394b Link Layer Controller (rev 01)
> 04:00.0 Ethernet controller: Intel Corporation 82573L Gigabit Ethernet Controller
> 05:04.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80)

The IDE disk is a Hitachi HTE721010G9AT00 7200rpm 2.5".
The SATA disk is a Seagate ST3750640AS 7200rpm 3.5".
The FireWire disk is a dual ST3400832A 7200rpm 3.5" stripe-set on
OXFW921, tested on the 1394b and the 1394a controller.

Config is basically the same under both kernels:
http://me.in-berlin.de/~s5r6/linux1394/work-in-progress/other_stuff/config-diff-2.6.19.1--2.6.20-rc3-20070106.txt
http://me.in-berlin.de/~s5r6/linux1394/work-in-progress/other_stuff/config-2.6.20-rc3-20070106.txt

Userland is Gentoo 2006.1, kernel is Linus's with FireWire driver patches.
-- 
Stefan Richter
-=====-=-=== ---= --==-
http://arcgraph.de/sr/
