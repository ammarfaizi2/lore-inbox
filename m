Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317884AbSGPQiL>; Tue, 16 Jul 2002 12:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317885AbSGPQiK>; Tue, 16 Jul 2002 12:38:10 -0400
Received: from chaos.analogic.com ([204.178.40.224]:4993 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317884AbSGPQiI>; Tue, 16 Jul 2002 12:38:08 -0400
Date: Tue, 16 Jul 2002 12:43:24 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Maurice Volaski <mvolaski@aecom.yu.edu>
cc: linux-kernel@vger.kernel.org, akpm@zip.com.au, raul@pleyades.net
Subject: Re: Mount corrupts an ext2 filesystem on a RAM disk
In-Reply-To: <a05111609b958efe305c4@[129.98.90.227]>
Message-ID: <Pine.LNX.3.95.1020716123118.15077A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jul 2002, Maurice Volaski wrote:

> >It also works okay here. Maybe, just maybe, you booted with initrd,
> >but did't unmount it before you started mucking with it `umount /initrd`
> >in the script below.
> >
> 
> I retested the ramdisk without executing the initial umount 
> instructions you proposed and saw the problem as I expected, but when 
> I first ran your umount instructions and then tested again, the fsck 
> problem didn't show up!
> 
> I tested this on all three of my boxes and they all behave the same.
> 
> So I guess this means there is a problem somewhere else, but I don't
> know what:
> 
> 1) initrd really had still been mounted though df does not detect it.
> 
> 2) there is no ghost initrd mounted, but merely executing bogus 
> umount instructions in some unknown way prevents the problem.
> 
> If it is the first one, there are two questions: why is initrd not 
> getting unmounted and why doesn't it show up in df?
> If it is the second one, then what could be going on?
> -- 

Depending upon the distribution, initrd may not be unmounted.
It would normally be 'transferred' to /initrd on the new root-
filesystem when that is mounted, and just left alone. It's not
going to show up in 'df' because it got mounted before /etc/mtab
existed and `df` (most versions I've seen) reads /etc/mtab. To
fix that problem, as root do:

rm /etc/mtab
ln -s /proc/mounts /etc/mtab

That will substitute /proc/mounts, which has the real information
about what actually got mounted.


Script started on Tue Jul 16 12:38:07 2002
# cat /etc/mtab
/dev/sdb1 / ext2 rw,noatime 0 0
/dev/sdc1 /alt ext2 rw,noatime 0 0
/dev/sdc3 /home/users ext2 rw,noatime 0 0
none /proc proc rw 0 0
/dev/sda1 /dos/drive_C msdos rw 0 0
/dev/sda5 /dos/drive_D msdos rw 0 0
# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sdb1             16603376   5906288   9853680  37% /
/dev/sdc1              6356624   1198700   4835020  20% /alt
/dev/sdc3              2253284   1768524    370300  83% /home/users
/dev/sda1              1048272    281840    766432  27% /dos/drive_C
/dev/sda5              1046224    181280    864944  17% /dos/drive_D
# rm /etc/mtab
# ln -s /proc/mounts /etc/mtab
# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/root.old             1766      1723         0 100% /initrd
/dev/root             16603376   5906284   9853684  37% /
/dev/sdc1              6356624   1198700   4835020  20% /alt
/dev/sdc3              2253284   1768524    370300  83% /home/users
/dev/sda1              1048272    281840    766432  27% /dos/drive_C
/dev/sda5              1046224    181280    864944  17% /dos/drive_D
# ls /initrd
bin  dev  etc  lib  linuxrc  sbin
# umount /initrd
# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/root             16603376   5906284   9853684  37% /
/dev/sdc1              6356624   1198700   4835020  20% /alt
/dev/sdc3              2253284   1768524    370300  83% /home/users
/dev/sda1              1048272    281840    766432  27% /dos/drive_C
/dev/sda5              1046224    181280    864944  17% /dos/drive_D
# exit
exit
Script done on Tue Jul 16 12:39:28 2002

I don't normally set the link I demonstrated because the actual
drive name of my root file-system gets lost, it becomes /dev/root.
If I run lilo under this configuration, with the parameters
"root=current", I get something strange, failing to find the
root file-system upon boot.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

