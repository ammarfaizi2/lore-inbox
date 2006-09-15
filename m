Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751620AbWIOTtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbWIOTtk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 15:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbWIOTtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 15:49:40 -0400
Received: from natreg.rzone.de ([81.169.145.183]:5550 "EHLO natreg.rzone.de")
	by vger.kernel.org with ESMTP id S1751618AbWIOTtj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 15:49:39 -0400
Date: Fri, 15 Sep 2006 21:48:40 +0200
From: Olaf Hering <olaf@aepfle.de>
To: David Lang <dlang@digitalinsight.com>
Cc: Michael Buesch <mb@bu3sch.de>, Greg KH <greg@kroah.com>,
       Oleg Verych <olecom@flower.upol.cz>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Sven Luther <sven.luther@wanadoo.fr>, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MODULE_FIRMWARE for binary firmware(s)
Message-ID: <20060915194839.GA32654@aepfle.de>
References: <1156802900.3465.30.camel@mulgrave.il.steeleye.com> <Pine.LNX.4.63.0608290844240.30381@qynat.qvtvafvgr.pbz> <20060829183208.GA11468@kroah.com> <200608292104.24645.mb@bu3sch.de> <20060829201314.GA28680@aepfle.de> <Pine.LNX.4.63.0608291341060.30381@qynat.qvtvafvgr.pbz> <20060830054433.GA31375@aepfle.de> <Pine.LNX.4.63.0608301048180.31356@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0608301048180.31356@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, David Lang wrote:

> >initramfs is always in use.
> 
> not on my machines.

klibc can be build like:

        cd linux-2.6.*
        make headers_install INSTALL_HDR_PATH=/dev/shm/$$
        cd ..
        wget http://www.kernel.org/pub/linux/libs/klibc/Testing/klibc-1.4.29.tar.bz2
        tar xfj klibc-*.tar.bz2
        cd klibc-*
        ln -sfvbn /dev/shm/$$ linux
        make

Every other libc will do it as well, adjust the filelist as needed.
Try this as CONFIG_INITRAMFS_SOURCE= :

# A simple initramfs
dir /dev 0755 0 0
nod /dev/console 0600 0 0 c 5 1
nod /dev/kmsg 0600 0 0 c 1 11
dir /sbin 0755 0 0
dir /lib 0755 0 0
dir /lib/firmware 0755 0 0
file /lib/firmware/name.ext /tmp/foofirmware.bin 0755 0 0
file /sbin/hotplug /home/olaf/kernel/hotplug.sh 0755 0 0
file /sbin/cat /home/olaf/kernel/klibc-1.4.29/usr/utils/static/cat 0755 0 0
file /sbin/mount /home/olaf/kernel/klibc-1.4.29/usr/utils/static/mount 0755 0 0
file /sbin/mkdir /home/olaf/kernel/klibc-1.4.29/usr/utils/static/mkdir 0755 0 0
file /sbin/mknod /home/olaf/kernel/klibc-1.4.29/usr/utils/static/mknod 0755 0 0
file /sbin/minips /home/olaf/kernel/klibc-1.4.29/usr/utils/static/minips 0755 0 0
file /sbin/umount /home/olaf/kernel/klibc-1.4.29/usr/utils/static/umount 0755 0 0
file /sbin/uname /home/olaf/kernel/klibc-1.4.29/usr/utils/static/uname 0755 0 0
file /sh /home/olaf/kernel/klibc-1.4.29/usr/dash/sh 0755 0 0
#optional:
file /init /home/olaf/kernel/init.sh 0755 0 0

Try this as hotplug.sh:

#!/sh
if test "$SEQNUM" -lt 42 ; then
echo "$1 SEQNUM=$SEQNUM ACTION=$ACTION DEVPATH=$DEVPATH" > /dev/kmsg
fi
if test "$SEQNUM" = 1 ; then
        mkdir /sys
        mkdir /proc
        mount -t sysfs sysfs /sys
        mount -t proc proc /proc
        set > /1.env
        echo "$*" > /1.arg
        cat /proc/cpuinfo > /cpuinfo
        cat /sys/power/state > /state
        umount /proc
        umount /sys
fi


Try this as init.sh:
#!/sh
/sh


I assume you can adjust hotplug.sh for your ipw needs.
