Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272822AbRI0MvY>; Thu, 27 Sep 2001 08:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272818AbRI0MvO>; Thu, 27 Sep 2001 08:51:14 -0400
Received: from [195.66.192.167] ([195.66.192.167]:24339 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S272817AbRI0MvD>; Thu, 27 Sep 2001 08:51:03 -0400
Date: Thu, 27 Sep 2001 15:48:29 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <1024452310.20010927154829@port.imtp.ilyichevsk.odessa.ua>
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: linux-kernel@vger.kernel.org
Subject: Automount expiration bug: it does not like symlinks
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just discovered that automount misbehaves when its mount points are
syumlinks. It repeatedly reports expiration but fails to actually
unmount automounted dir.

See attached logs. My /mnt is a symlink to /.share/.local/mnt
If you plan to reproduce please note that my /etc/mtab is symlinked to
/proc/mounts which may contribute to this behavior.

# automount --timeout 5 /mnt/auto file /etc/autofs.conf
# cd /mnt/auto/hda2
# cd /
 -- in syslog: --
Sep 27 09:47:05 pegasus automount[179]: attempting to mount entry /mnt/auto/hda2
Sep 27 09:47:05 pegasus automount[3539]: lookup(file): looking up hda2
Sep 27 09:47:05 pegasus automount[3539]: lookup(file): hda2 -> -fstype=auto,noexec^I:/dev/hda2
Sep 27 09:47:05 pegasus automount[3539]: parse(sun): expanded entry: -fstype=auto,noexec^I:/dev/hda2
Sep 27 09:47:05 pegasus automount[3539]: parse(sun): dequote("fstype=auto,noexec") -> fstype=auto,noexec
Sep 27 09:47:05 pegasus automount[3539]: parse(sun): gathered options: fstype=auto,noexec
Sep 27 09:47:05 pegasus automount[3539]: parse(sun): dequote("/dev/hda2") -> /dev/hda2
Sep 27 09:47:05 pegasus automount[3539]: parse(sun): core of entry: options=fstype=auto,noexec, loc=/dev/hda2
Sep 27 09:47:05 pegasus automount[3539]: parse(sun): mounting root /mnt/auto, mountpoint hda2/, what /dev/hda2, fstype auto, options noexec
Sep 27 09:47:05 pegasus automount[3539]: do_mount /dev/hda2 /mnt/auto/hda2/ type auto options noexec using module generic
Sep 27 09:47:05 pegasus automount[3539]: mount(generic): calling mkdir_path /mnt/auto/hda2/
Sep 27 09:47:05 pegasus automount[3539]: mount(generic): calling mount -t auto -s -o noexec /dev/hda2 /mnt/auto/hda2/
Sep 27 09:47:06 pegasus automount[3539]: mount(generic): mounted /dev/hda2 type auto on /mnt/auto/hda2/
Sep 27 09:47:13 pegasus automount[3545]: running expiration on path /mnt/auto/hda2
Sep 27 09:47:13 pegasus automount[3545]: expired /mnt/auto/hda2
Sep 27 09:47:19 pegasus automount[3549]: running expiration on path /mnt/auto/hda2
Sep 27 09:47:19 pegasus automount[3549]: expired /mnt/auto/hda2
Sep 27 09:47:25 pegasus automount[3553]: running expiration on path /mnt/auto/hda2
Sep 27 09:47:25 pegasus automount[3553]: expired /mnt/auto/hda2
Sep 27 09:47:31 pegasus automount[3557]: running expiration on path /mnt/auto/hda2
Sep 27 09:47:31 pegasus automount[3557]: expired /mnt/auto/hda2
 -- here I do manual "umount /mnt/auto/hda2" --
Sep 27 09:47:39 pegasus automount[3563]: running expiration on path /mnt/auto/hda2
Sep 27 09:47:39 pegasus automount[3563]: expired /mnt/auto/hda2
 -- end of log --

# killall automount
# automount --timeout 5 /.share/.local/mnt/auto file /etc/autofs.conf
# cd /.share/.local/mnt/auto/hda2
# cd /
 -- in syslog: --
Sep 27 14:33:09 pegasus automount[9726]: attempting to mount entry /.share/.local/mnt/auto/hda2
Sep 27 14:33:09 pegasus automount[9763]: lookup(file): looking up hda2
Sep 27 14:33:09 pegasus automount[9763]: lookup(file): hda2 -> -fstype=auto,noexec^I:/dev/hda2
Sep 27 14:33:09 pegasus automount[9763]: parse(sun): expanded entry: -fstype=auto,noexec^I:/dev/hda2
Sep 27 14:33:09 pegasus automount[9763]: parse(sun): dequote("fstype=auto,noexec") -> fstype=auto,noexec
Sep 27 14:33:09 pegasus automount[9763]: parse(sun): gathered options: fstype=auto,noexec
Sep 27 14:33:09 pegasus automount[9763]: parse(sun): dequote("/dev/hda2") -> /dev/hda2
Sep 27 14:33:09 pegasus automount[9763]: parse(sun): core of entry: options=fstype=auto,noexec, loc=/dev/hda2
Sep 27 14:33:09 pegasus automount[9763]: parse(sun): mounting root /.share/.local/mnt/auto, mountpoint hda2/, what /dev/hda2, fstype auto, options noexec
Sep 27 14:33:09 pegasus automount[9763]: do_mount /dev/hda2 /.share/.local/mnt/auto/hda2/ type auto options noexec using module generic
Sep 27 14:33:09 pegasus automount[9763]: mount(generic): calling mkdir_path /.share/.local/mnt/auto/hda2/
Sep 27 14:33:09 pegasus automount[9763]: mount(generic): calling mount -t auto -s -o noexec /dev/hda2 /.share/.local/mnt/auto/hda2/
Sep 27 14:33:09 pegasus automount[9763]: mount(generic): mounted /dev/hda2 type auto on /.share/.local/mnt/auto/hda2/
Sep 27 14:33:18 pegasus automount[9790]: running expiration on path /.share/.local/mnt/auto/hda2
Sep 27 14:33:18 pegasus automount[9790]: expired /.share/.local/mnt/auto/hda2
 -- end of log --

-- 
Best regards, VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua


