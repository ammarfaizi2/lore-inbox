Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266262AbUAMXKG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 18:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266263AbUAMXKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 18:10:06 -0500
Received: from hermes.domdv.de ([193.102.202.1]:14092 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id S266262AbUAMXJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 18:09:59 -0500
Message-ID: <40047AA6.4020200@domdv.de>
Date: Wed, 14 Jan 2004 00:09:26 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031022
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wakko Warner <wakko@animx.eu.org>
CC: Arjan van de Ven <arjanv@redhat.com>, Scott Long <scott_long@adaptec.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Proposed enhancements to MD
References: <40033D02.8000207@adaptec.com> <1074031592.4981.1.camel@laptop.fenrus.com> <20040113174422.B16728@animx.eu.org>
In-Reply-To: <20040113174422.B16728@animx.eu.org>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner wrote:
> 
> As I've understood it, the configuration for DM is userspace and the kernel
> can't do any auto detection.  This would be a "put off" for me to use as a
> root filesystem.  Configurations like this (and lvm too last I looked at it)
> require an initrd or some other way of setting up the device.  Unfortunately
> this means that there's configs in 2 locations (one not easily available,  if
> using initrd.  easily != mounting via loop!)
> 

You can always do the following: use a mini root fs on the partition 
where the kernel is located that does nothing but vgscan and friends and 
then calls pivot_root. '/sbin/init' of the mini root fs looks like:


#!/bin/sh
case "$1" in
         -s|S|single|-a|auto)
                 opt=$1
         ;;
         -b|emergency)
                 export PATH=/bin:/sbin
                 /bin/mount /proc
                 /bin/loadkeys \
			/keymaps/i386/qwertz/de-latin1-nodeadkeys.map.gz
                 exec /bin/sh < /dev/console > /dev/console 2>&1
         ;;
esac
cd /
/bin/mount /proc
/bin/mount -o remount,rw,notail,noatime,nodiratime /
/sbin/vgscan > /dev/null
/sbin/vgchange -a y > /dev/null
/bin/mount -o remount,ro,notail,noatime,nodiratime /
/bin/mount /mnt
/bin/umount /proc
cd /mnt
/sbin/pivot_root . boot
exec /bin/chroot . /bin/sh -c \
	"/bin/umount /boot ; exec /sbin/init $opt" \
	< dev/console > dev/console 2>&1



And if you have partitions of the same size on other disks and fiddle a 
bit with dd you have perfect working backups including the boot loader 
code of the master boot record on the other disks. No initrd required.
As an add-on you have an on-disk rescue system.
-- 
Andreas Steinmetz

