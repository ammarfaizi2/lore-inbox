Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263465AbTCNTYi>; Fri, 14 Mar 2003 14:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263467AbTCNTYi>; Fri, 14 Mar 2003 14:24:38 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:14483 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S263465AbTCNTYg>; Fri, 14 Mar 2003 14:24:36 -0500
Message-ID: <3E722D31.6050702@nortelnetworks.com>
Date: Fri, 14 Mar 2003 14:27:45 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, kai@tp1.ruhr-uni-bochum.de
Subject: Re: Kernel setup() and initrd problems
References: <Pine.GHP.4.53.0303130942100.16619@alderaan.science-computing.de> <Pine.LNX.4.44.0303131051160.7342-100000@chaos.physics.uiowa.edu> <b4t9i6$eon$1@cesium.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Followup to:  <Pine.LNX.4.44.0303131051160.7342-100000@chaos.physics.uiowa.edu>
> By author:    Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>

>>I think whoever came up with that just got the idea of pivot_root wrong. 
>>The idea was to get rid of the initrd special case. It should be possible 
>>to do the following, though I didn't work out the details: 
>>
>>Tell the kernel that our root dev is /dev/ram and give it an initrd which 
>>isn't really a classical initrd (with /linuxrc on it), but instead has a 
>>/sbin/init which is similar to the linuxrc above.

> It *is* possible, but you need to pass "root=/dev/ram0" to the kernel,
> for backwards compatibility reasons.  That will incidentally make it
> run /sbin/init, not /linuxrc, unless you pass init=/linuxrc as well.


Below is the script that I used to pivot from a standard ramdisk (for with
the infrastructure is already in place in our build environment) to a tmpfs
filesystem.  This requires no changes to the boot args.

This script runs as /sbin/init, sets up the tmpfs filesystem, pivots, and
hands off control to the real init program.

One interesting bit is the rework of fstab so that mount and df show the
root filesystem as tmpfs.  freeramdisk simply tells the kernel that its
okay to give up the space used by the ramdisk.

This seems to work fine, though it isn't actually in production yet, just
a private prototype.

Chris






#!/bin/bash
# Set up tmpfs filesystem as root and pivot into it.

echo "Setting up tmpfs..."

#mount the tmpfs filesystem
mount -t tmpfs tmpfs mnt -o size=37M

#copy the initrd into the tmpfs filesystem
cp -a `ls -1 | grep -v mnt | grep -v proc | grep -v lost+found` mnt

#change dirs and make some directories
cd mnt
mkdir proc mnt

#pivot the filesystems
/sbin/pivot_root . mnt

#set up the /etc/fstab file to have / listed as tmpfs
#this will be used instead of the ramdisk line
echo "tmpfs             /               tmpfs   rw,size=37M     0 0" > etc/fstab.new

#grab the rest of /etc/fstab after the first entry since we want to keep the info
tail -n +2 etc/fstab >> etc/fstab.new
mv etc/fstab.new etc/fstab

# remove this script, move the real init to the right place, and run it
mv /sbin/init.orig /sbin/init

#unmount the original ramdisk, free the memory, and run the real init
exec /sbin/chroot . sh -c 'umount /mnt; /sbin/freeramdisk; exec /sbin/init' <dev/console >dev/console 2>&1


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

