Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261385AbTC3OwJ>; Sun, 30 Mar 2003 09:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261387AbTC3OwJ>; Sun, 30 Mar 2003 09:52:09 -0500
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:58793 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S261385AbTC3OwH>; Sun, 30 Mar 2003 09:52:07 -0500
Subject: 2.5: Can't unmount fs after using NFS
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1049036587.600.9.camel@teapot>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 30 Mar 2003 17:03:07 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since I started testing 2.5 on my NFS server, I'm having problems
unmounting filesystems that were exported by NFS (of course, before
trying to unmount, I stopped NFS):

glass:~# cat /etc/mtab
/dev/hda2 / ext3 rw,noatime 0 0
none /proc proc rw 0 0
usbdevfs /proc/bus/usb usbdevfs rw 0 0
/dev/hda3 /data ext3 rw,noatime 0 0
none /dev/pts devpts rw,gid=5,mode=620 0 0
none /dev/shm tmpfs rw 0 0
/dev/hdb2 /media ext3 rw,noatime 0 0

glass:~# cat /etc/exports
/data   192.168.0.100(rw,no_root_squash) 192.168.0.0/24(ro)
/media  192.168.0.100(rw,no_root_squash)

glass:~# /etc/init.d/nfs stop

glass:~# umount /media
umount: /media: device is busy

glass:~# umount /data
umount: /data: device is busy

glass:~# dmesg|tail
hdb: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdb: drive_cmd: error=0x04 { DriveStatusError }
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is
recommended
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,66), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
nfsd: last server has exited
nfsd: unexporting all filesystems
nfsd: last server has exited
nfsd: unexporting all filesystems

glass:~# umount -f /media
umount2: Device or resource busy
umount: /media: device is busy

glass:~# fuser -vu /media

                     USER        PID ACCESS COMMAND
/media               root     kernel mount  /media

glass:~# fuser -vu /data

                     USER        PID ACCESS COMMAND
/data                root     kernel mount  /data

glass:~# cat /etc/fstab
/dev/hda3               /data                   ext3   
defaults,noatime     1 2
/dev/hda2               /                       ext3   
defaults,noatime     1 1
/dev/hda1               /boot                   ext3   
defaults,noauto      0 0
/dev/hdb2               /media                  ext3   
defaults,noauto,noatime 0 0
none                    /dev/pts                devpts 
gid=5,mode=620       0 0
none                    /proc                   proc   
defaults             0 0
none                    /dev/shm                tmpfs  
defaults             0 0
#/dev/hdb1               swap                    swap   
defaults             0 0
/dev/cdrw               /mnt/cdrw           udf,iso9660
noauto,owner,ro      0 0
/dev/hdc                /cdrom                  auto   
ro,noauto,user,exec  0 0
/dev/scd0               /cdrecorder             auto   
ro,noauto,user,exec  0 0

Is this a bug? This didn't happen with 2.4.

Thanks!

________________________________________________________________________
        Felipe Alfaro Solana
   Linux Registered User #287198
http://counter.li.org

