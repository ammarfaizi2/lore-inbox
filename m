Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267070AbSK2Ovl>; Fri, 29 Nov 2002 09:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267072AbSK2Ovl>; Fri, 29 Nov 2002 09:51:41 -0500
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:3076 "EHLO
	lap.molina") by vger.kernel.org with ESMTP id <S267070AbSK2Ovk>;
	Fri, 29 Nov 2002 09:51:40 -0500
Date: Fri, 29 Nov 2002 08:50:46 -0600 (CST)
From: Thomas Molina <tmolina@copper.net>
X-X-Sender: tmolina@lap.molina
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org, "Adam J. Richter" <adam@yggdrasil.com>,
       <kaos@sgi.com>
Subject: Re: [ALPHA RELEASE] module-init-tools 0.9-alpha 
In-Reply-To: <20021129111730.132532C316@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0211290812500.830-100000@lap.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Nov 2002, Rusty Russell wrote:

> 0.9-alpha Version
> o Fixed patch in NEWS to leave #include linux/elf.h, needed for
>   CONFIG_KALLSYMS.
> o Fixed extra newline in "in use by" message.
> o Fixed parsing for new-style /proc/modules.
> o Fixed version parsing code (thanks to Adam Richter's report)
> o Fixed "running out of filedescriptors" (Adam Richter)	
> o Implemented options in modprobe
> o Implemented install in modprobe
> o Implemented options in modules.conf2modprobe.conf
> o Implemented install in modules.conf2modprobe.conf
> o Implemented probeall in modules.conf2modprobe.conf
> o Implemented probe in modules.conf2modprobe.conf
> o Changed modprobe version to be constant string, for "strings" to work easily.
> 
> Lightly tested, but seems to work here.  No source RPM, since it's
> still alpha.

Your make moveold script didn't take into account that the modutils from 
RedHat and Keith Owens have lsmod, modprobe, and rmmod as symlinks to 
insmod.  I worked around that by doing a "cp insmod lsmod", etc.

I took a stock 2.5.50-bk and added the namei.c patch and the patch to 
module.h out of the NEWS file.  The RedHat 8.0 bootup scripts did not 
autoload the pcmcia_core, yenta_socket, ds, orinoco_cs, orinoco, and 
hermes modules, but I could load them by hand.  Unfortuantely, it still 
does not allow the ethernet interface to be brought up an configured.

I then tried using the 2.4.18 kernel provided by RedHat.  I didn't get the 
error messages I got using your 0.8 module init tools, but it also 
wouldn't load the ethernet drivers for my SMC2632W PCMCIA card.

When I run stock RedHat I get <beep> <beep> when the card is inserted.  Is 
it true that the first beep is when the card insertion event is handled by 
the system, and the second beep is when the ethernet interface is brought 
up an configured?

In any case, on boot up I get <beep> <boop>.  I believe this means that 
the card insertion event was handled correctly, but that the ethernet 
interface was not brought up and configured.  lsmod does show that 
pcmcia_core, yenta_socket, and ds modules were loaded, but hermes, 
orinoco, and orinoco_cs were not.  The modules could be loaded by hand, 
but that still didn't allow the ethernet interface to be brought up and 
configured.  Following is a console extract from that session (The dhcp 
command at the end is a bash script which runs dhclient with the 
parameters required for me to connect):

[root@lap root]# lsmod
Module                  Size  Used by    Not tainted
ds                      7944   1
yenta_socket           11584   1
pcmcia_core            48608   0  [ds yenta_socket]
ext3                   61440   1
jbd                    46932   1  [ext3]
[root@lap root]# modprobe orinoco_cs
WARNING: Error inserting hermes (/lib/modules/2.4.18-18.8.0/kernel/drivers/net/wireless/hermes.o): Unknown symbol in module
WARNING: Error inserting orinoco (/lib/modules/2.4.18-18.8.0/kernel/drivers/net/wireless/orinoco.o): Unknown symbol in module
FATAL: Error inserting orinoco_cs (/lib/modules/2.4.18-18.8.0/kernel/drivers/net/wireless/orinoco_cs.o): Unknown symbol in module
[root@lap root]# lsmod
Module                  Size  Used by    Not tainted
ds                      7944   1
yenta_socket           11584   1
pcmcia_core            48608   0  [ds yenta_socket]
ext3                   61440   1
jbd                    46932   1  [ext3]
[root@lap root]# ls /sbin/*.old
/sbin/depmod.old  /sbin/insmod.old  /sbin/lsmod.old  /sbin/modprobe.old  /sbin/rmmod.old
[root@lap root]# /sbin/modprobe.old hermes
[root@lap root]# /sbin/modprobe.old orinoco
[root@lap root]# /sbin/modprobe.old orinoco_cs
[root@lap root]# lsmod
Module                  Size  Used by    Not tainted
orinoco_cs              5320   0  (unused)
orinoco                32824   0  [orinoco_cs]
hermes                  7204   0  [orinoco_cs orinoco]
ds                      7944   1  [orinoco_cs]
yenta_socket           11584   1
pcmcia_core            48608   0  [orinoco_cs ds yenta_socket]
ext3                   61440   1
jbd                    46932   1  [ext3]
[root@lap root]# dhcp
SIOCSIFADDR: No such device
eth0: unknown interface: No such device
eth0: unknown interface: No such device
[root@lap root]# uname -a
Linux lap 2.4.18-18.8.0 #1 Wed Nov 13 23:08:45 EST 2002 i686 i686 i386 GNU/Linux
[root@lap root]#


