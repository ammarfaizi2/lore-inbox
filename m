Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268822AbTGVUUh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 16:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269106AbTGVUUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 16:20:37 -0400
Received: from nouse194035.ris.at ([212.52.194.36]:37082 "EHLO
	mail.gibraltar.at") by vger.kernel.org with ESMTP id S268822AbTGVUUd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 16:20:33 -0400
Message-ID: <3F1DA09F.4020503@gibraltar.at>
Date: Tue, 22 Jul 2003 22:37:51 +0200
From: Rene Mayrhofer <rene.mayrhofer@gibraltar.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.3.1-3 StumbleUpon/1.73
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jason Baron <jbaron@redhat.com>, vda@port.imtp.ilyichevsk.odessa.ua,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pivot_root seems to be broken in 2.4.21-ac4
References: <Pine.LNX.4.44.0307221331090.2754-100000@dhcp64-178.boston.redhat.com>	 <1058895650.4161.23.camel@dhcp22.swansea.linux.org.uk>	 <3F1D7C80.6020605@gibraltar.at> <1058904025.4160.30.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1058904025.4160.30.camel@dhcp22.swansea.linux.org.uk>
Content-Type: multipart/mixed;
 boundary="------------010803060205040400020904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010803060205040400020904
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alan,

Alan Cox wrote:
> 2.4.22pre7 has the unshare_files fix - its a security fix.
> 
> It should not have changed the behaviour so I'm very interested to
> know if that specific patch set changes the behaviour and precisely
> what your code is doing
I have now compiled vanilla 2.4.21 with the same configuration (but 
without the netfilter patch-o-matic patches, which shouldn't matter) - 
it works. But now I'm again stuck without the CLE266 module. Attached is 
the script that does the actual root fs switch (it is called from init 
after the daemons have been stopped, i.e. during runlevel change). I 
hope I haven't done anything too stupid in this script, embarassing 
myself with this post to LKML... ;)

If you want, I could send you a diff of the two trees (between my 
patched 2.4.21 and 2.4.21-ac4 trees). But it will mostly be just your 
own -ac4 patch, with preempt and patch-o-matic stuff applied.

Would it help if I tried it with 2.4.22pre7 ?

- Rene


--------------010803060205040400020904
Content-Type: text/plain;
 name="switch-to-cramfs"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="switch-to-cramfs"

#!/bin/sh
# Switch from harddisk to RAM mode.
#
# Rene Mayrhofer, 2003

. /etc/cramdisk.conf

mntpoint=/cramfs

if [ -e /on-cramfs ]; then
  echo "Already running on CRAMFS."
  exit 1
fi

if grep -q "$mntpoint" /proc/mounts; then
  umount $mntpoint/mnt 2>/dev/null
  umount $mntpoint/var 2>/dev/null
  umount $mntpoint/data 2>/dev/null
  umount $mntpoint/dev 2>/dev/null
  umount $mntpoint/proc 2>/dev/null
  umount $mntpoint
fi

echo "Building CRAMFS image"
#/usr/local/sbin/createramfs.sh
echo "Mounting CRAMFS image"
# this is stupid - why do we have to do it twice before it works ??
dd if=/boot/cramfs.img of=/dev/rd/0 2>/dev/null
mount -t cramfs /dev/rd/0 $mntpoint
dd if=/boot/cramfs.img of=/dev/rd/0 2>/dev/null
mount -t cramfs /dev/rd/0 $mntpoint
cd $mntpoint

echo "Mounting needed kernel filesystems"
mount -nt proc none proc/
mount -nt devfs none dev/

echo "Changing root to CRAMFS"
/sbin/pivot_root . mnt <dev/console >dev/console 2>&1

echo "Creating RAM disk for var/"
mount -nt tmpfs -o size=300M none var/
echo "Creating directories for var"
for d in $CREATE_VAR_DIRS; do
  mkdir -p var/$d
done
echo "Copying directories to var/"
for d in $COPY_VAR_DIRS; do
  mkdir -p var/$d
  cp -dp mnt/var/$d/* var/$d/ 2> /dev/null
done
echo "Linking directories for var"
for d in $LINK_VAR_DIRS; do
  ln -s /var-static/$d var/`dirname $d`
done

echo "Re-executing init"
/usr/sbin/chroot . /sbin/telinit u <dev/console >/dev/console 2>&1

echo "Killing all processes that still have stuff open on /mnt"
/usr/bin/killall getty
/usr/sbin/lsof -n | grep "/mnt" |
  while read name pid user fd type device size node name; do
    # don't kill ourselves or the currently running rc script ....
    if [ -d /proc/$pid ] && 
    	! cat /proc/$pid/cmdline | grep -q "switch-to-cramfs" &&
    	! cat /proc/$pid/cmdline | grep -q "/etc/init.d/rc"; then
      /bin/kill -9 $pid
    fi
  done
  
echo "Mounting data directory read-only"
if grep -q "/mnt/data" /proc/mounts; then 
  umount -n /mnt/data
fi 
mount -nt ext2 -o ro /dev/discs/disc0/part3 /data

echo -n "Postponing unmount of filesystems until runlevel switch has completed"
/usr/sbin/chroot . /bin/bash -c ' 
  # the grep -v is because the processlist contains this command itself...
  while ps ax | grep -v "\"/etc/init.d/rc\"" | grep -q "/etc/init.d/rc"; do 
    sleep 1s 
  done 
  echo "Unmounting old filesystems" 
  if grep -q "/mnt/dev" /proc/mounts; then 
    umount -n /mnt/dev
  fi 
  if grep -q "/mnt/proc/bus/usb" /proc/mounts; then
    umount -n /mnt/proc/bus/usb
  fi 
  if grep -q "/mnt/proc" /proc/mounts; then 
    umount -n /mnt/proc
  fi 
  if grep -q "/mnt/mnt/cdrom" /proc/mounts; then 
    umount -n /mnt/mnt/cdrom
  fi 
  if grep -q "/mnt/mnt/usb" /proc/mounts; then 
    umount -n /mnt/mnt/usb
  fi 
  if grep -q "/mnt/data" /proc/mounts; then 
    umount -n /mnt/data
  fi 

  if umount /mnt; then 
    /sbin/hdparm -y /dev/hda 
  fi' < /dev/null > /dev/null 2> /dev/null &
echo "."

exit 0

--------------010803060205040400020904--

