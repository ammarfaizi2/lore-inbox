Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271966AbTGYIob (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 04:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271967AbTGYIob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 04:44:31 -0400
Received: from ns.bmstu.ru ([195.19.32.2]:2323 "EHLO soap.bmstu.ru")
	by vger.kernel.org with ESMTP id S271965AbTGYIo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 04:44:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Serge A. Suchkov" <ss@e1.bmstu.ru>
Reply-To: ss@e1.bmstu.ru
Organization: BMSTU
To: "lkml" <linux-kernel@vger.kernel.org>
Subject: Re: [Oops report]: 2.6.0-test1-ac1 oops in umount mass-storage device
Date: Fri, 25 Jul 2003 12:53:00 +0400
X-Mailer: KMail [version 1.2]
References: <03072313251400.10306@XP1700>
In-Reply-To: <03072313251400.10306@XP1700>
Cc: linux-scsi@vger.kernel.org
MIME-Version: 1.0
Message-Id: <03072512530004.15954@XP1700>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
>
> Today I have oops in 2.6.0-test1-ac1, described below.
> I have USB plugged CF card Reader/Writer with CF card inside.
> I'm mount this device as SCSI /dev/sda1 device
>
> Next actions I'm comment by my dmesg output ...
>
> 1) Eject CF card from CF Reader without umount, and insert CF in digital

I'm  sorry. Oops was take place not after _eject_ CF, but after _disconnect_ 
USB CF reader/writer...

I wrote small script, which demonstrate described problem...

------- test-usb-storage.sh -----------
#!/bin/bash
SCSI_DEVICE=/dev/sda1
MOUNT_POINT=/mnt
IS_USB_STORAGE_DEVICE_UP=`cat /proc/bus/usb/devices | grep Driver=usb-storage`
IS_MOUNT=`mount | grep $MOUNT_POINT`

if [ "$IS_MOUNT" != "" ]
then
 echo "$MOUNT_POINT mark as already mounted ..."
 echo  $IS_MOUNT
 exit
fi

if [ "$IS_USB_STORAGE_DEVICE_UP" = "" ]
then
 echo "USB storage device not found ..."
 exit
fi

mount $SCSI_DEVICE -t auto $MOUNT_POINT -o user

if [ $? != 0 ]
then
 echo "Can't mount $SCSI_DEVICE";
 exit
fi

echo Disconnect USB storage device now...
while [ "$IS_USB_STORAGE_DEVICE_UP" != "" ]
do
sleep 1
IS_USB_STORAGE_DEVICE_UP=`cat /proc/bus/usb/devices | grep Driver=usb-storage`
done

umount $MOUNT_POINT
echo $?k !
------- test-usb-storage.sh -----------


-- 
/SS
