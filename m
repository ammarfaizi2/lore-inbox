Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265727AbTF2SW1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 14:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265724AbTF2SW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 14:22:27 -0400
Received: from mail.gmx.de ([213.165.64.20]:27585 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265727AbTF2SW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 14:22:26 -0400
Date: Sun, 29 Jun 2003 21:36:43 +0300
From: Dan Aloni <da-x@gmx.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: sysctl and more SIOCSIFNAME (net device rename) inconsistencies
Message-ID: <20030629183643.GA2270@callisto.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The day before yesterday I found that renaming a network 
device under 2.5 doesn't update sysfs. While trying to 
figure this out I've found that there's another stuff that 
don't get updated with the new name: sysctl.

My system renames one of my cards to ethlan on boot. Later I 
manually renamed it to another name. Here are the 3 different names 
that the kernel see for the same network device.

ifconfig, sees the right name (ethlanX):

    [root@callisto ~]# ifconfig ethlanX
    ethlanX   Link encap:Ethernet  HWaddr 00:80:AD:00:DB:BC  
              inet addr:192.168.1.1  Bcast:192.168.1.255  Mask:255.255.255.0
              BROADCAST MULTICAST  MTU:1500  Metric:1
              RX packets:2225 errors:0 dropped:0 overruns:0 frame:0
              TX packets:2984 errors:0 dropped:0 overruns:0 carrier:0
              collisions:0 txqueuelen:100 
              RX bytes:472674 (461.5 KiB)  TX bytes:2466241 (2.3 MiB)
              Interrupt:5 Base address:0xb000 

sysfs, sees the name of the device at module load time (eth0 or eth1):

    [root@callisto ~]# ls -l /sys/class/net
    total 0
    drwxr-xr-x    3 root     root            0 Jun 29 20:41 eth0
    drwxr-xr-x    3 root     root            0 Jun 29 20:41 eth1
    drwxr-xr-x    3 root     root            0 Jun 29 20:41 lo
    drwxr-xr-x    3 root     root            0 Jun 29 20:41 ppp0

sysctl, sees the name of the device at some point in time
when the directory was instantiated by the user (ethlan):

    [root@callisto ~]# ls -l /proc/sys/net/ipv4/conf  
    total 0
    dr-xr-xr-x    2 root     root            0 Jun 29 21:20 all
    dr-xr-xr-x    2 root     root            0 Jun 29 21:20 default
    dr-xr-xr-x    2 root     root            0 Jun 29 21:20 ethinet
    dr-xr-xr-x    2 root     root            0 Jun 29 21:20 ethlan
    dr-xr-xr-x    2 root     root            0 Jun 29 21:20 lo
    dr-xr-xr-x    2 root     root            0 Jun 29 21:20 ppp0

Note that this is also affects sysctl(2), as it uses /proc:

    [root@callisto /home/karrde]# sysctl -a | grep ethlan.tag
    net.ipv4.conf.ethlan.tag = 0

I think this should be fixed before 2.6. I'm starting to figure out
about sysfs, but I have no idea how to fix the sysctl part at the 
moment.

-- 
Dan Aloni
da-x@gmx.net
