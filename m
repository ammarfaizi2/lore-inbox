Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264936AbTL1Cfy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 21:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264935AbTL1CeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 21:34:18 -0500
Received: from smtp2.att.ne.jp ([165.76.15.138]:27085 "EHLO smtp2.att.ne.jp")
	by vger.kernel.org with ESMTP id S264931AbTL1CeF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 21:34:05 -0500
Message-ID: <173b01c3cceb$05ade850$43ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.0 modules, hotplug, PCMCIA
Date: Sun, 28 Dec 2003 11:33:04 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6.0-test days, with SuSE 8.2, I reported a number of problems with
modules.  Most of these remain unchanged in 2.6.0 release.  Although SuSE
8.2 has a version of modutils which should be new enough (newer than the
Post Halloween document was at the time that someone first pointed me to a
working link for that document), I upgraded anyway.  I also updated hotplug
scripts.

1.  "rpm -Uvh modutils-2.4.25-1.i386.rpm" gave an error message that the
sensors package depends on the modules package.  This makes no sense to me,
what is there in the upgrade that could break this dependency?  I added
the --nodeps flag and did the upgrade.

2.  I also installed module-init-utils 0.9.12 from the bz2 download.  Sorry,
I noticed that 0.9.14 is available without a "pre" on it, but didn't
download it yet.  If the items in this paragraph have been fixed then please
kindly ignore this paragraph but still consider the others.  Anyway I
followed the instructions in the README:
   ./configure --prefix=/
   make moveold
   make
   make install
   ./generate-modprobe.conf /etc/modprobe.conf
   depmod 2.6.0
Sorry I am not copying the dozens of error messages from
./generate-modprobe.conf, but anyone with SuSE 8.2 can reproduce them.  When
there was no improvement, I looked at the instructions in the FAQ.  I'm not
running RedHat and I did upgrade to later than 0.9.9.  But things still
don't load properly, for which the second answer in the FAQ recommends using
non-existent file "generate-module.conf".  Presumably if that command
existed then it would overwrite the existing /etc/module.conf file.  So I
only obeyed the README not the FAQ.

3.  I also installed hotplug 2003_08_05 from the bz2 download.  I followed
the instructions in the README and they did resolve some boot-time problems.
However, the README says:  "There's more hotplug-related work yet to be done
as part of the 2.5 series; a 2.6 update will be required."  I did not find a
newer hotplug package or 2.6 update on ftp.jp.kernel.org.

4.  SuSE 8.2 defaults to using the kernel PCMCIA package rather than the
external PCMCIA package.  This is fine with me so kernel 2.6.0 also uses its
own compiled PCMCIA drivers instead of trying to make an external PCMCIA
package work with two kernels.  It seems to me that it should be OK to
compile PCMCIA as modules instead of built-in, but there were boot-time
errors, so I had to change PCMCIA and Yenta to built-in.  (This is the
opposite of the change that I had to make to mice, described in a separate
e-mail message.)  Now with PCMCIA compiled built-in, the low-level drivers
get loaded, but cardmgr still doesn't run automatically.  I can do "su" and
"cardmgr &" and then PCMCIA starts working enough to do modprobes when cards
are inserted.

5.  However, file /etc/pcmcia/serial.opts is still getting ignored under
2.6.0.  The modem is detected as containing a TI 16750 UART, and whatever
the serial driver does then, it causes the modem to hang up.  The serial
driver in 2.4.20 defaults to the same thing but 2.4.20 reads file
/etc/pcmcia/serial.opts, obeys the line SERIAL_OPTS="uart 16550A", and lets
the modem operate at 33% of its rated speed instead of hanging up.

6.  Boot messages remain schizophrenic about whether modules are enabled or
not:
   Inspecting /boot/System.map-2.6.0
   Loaded 28865 symbols from /boot/System.map-2.6.0.
   Symbols match kernel version 2.6.0.
   No module symbols loaded - kernel modules not enabled.
But lsmod shows that some modules are loaded, and there are other messages
in the system log showing that (after hacks described above) PCMCIA
correctly loaded some modules.

7.  Linux 2.4.20 was willing to drive the sound chip to some degree, a
Neomagic NM256.  KDE produces a short sound during KDE's startup under
2.4.20 but not under 2.6.0.  Under 2.6.0 the driver sometimes gives errors
about the sound chip not existing, sometimes it recommends loading the
module with option force_ac97=1, if I use option force_ac97=1 then it says
that option doesn't exist but then it tells me to try that option again,
etc.  But even under 2.4.20, the only sound I got was KDE's startup sound,
XMMS and other stuff never produced sound.

8.  Connecting a USB hard disk is recognized.  Under 2.4.20 some agent
automatically adds entries to /etc/fstab and the user can mount the
partitions.  Under 2.6.0 there is no automatic update to /etc/fstab and only
the superuser can mount the partitions.

9.  There are still other boot-time errors under 2.6.0 which do not occur
under 2.4.20.  They do not get logged to /var/log/messages or dmesg.  There
are fewer than they used to be but still they scroll off the screen very
quickly and I cannot pause the display to copy them down.  There are 17
fatal errors about non-existent devices 4-72 to 4-87 and 212-something.  The
cat command must be working a double shift because its 18th life boots
Linux.

