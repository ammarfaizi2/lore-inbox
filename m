Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269619AbTGVGR2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 02:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269623AbTGVGR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 02:17:28 -0400
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:47632 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id S269619AbTGVGR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 02:17:26 -0400
Message-Id: <200307220622.h6M6MTj20460@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Rene Mayrhofer <rene.mayrhofer@gibraltar.at>, linux-kernel@vger.kernel.org
Subject: Re: pivot_root seems to be broken in 2.4.21-ac4
Date: Tue, 22 Jul 2003 09:24:47 +0300
X-Mailer: KMail [version 1.3.2]
References: <3F1C52B7.3040308@gibraltar.at>
In-Reply-To: <3F1C52B7.3040308@gibraltar.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 July 2003 23:53, Rene Mayrhofer wrote:
> Hi all,
> 
> [Please CC me in replies, I am currently not subsribed to this list.]
> 
> I am currently using 2.4.21-ac4 (with a few other patches, but none of 
> them seems to touch pivot_root in any way) on a VIA EPIA M6000 board, 
> with works pretty fine and seems more stable than the previsouly used 
> 2.4.21-rc2. However, there is one problem that I am unable to solve:
> 
> When switching the root filesystem on the fly basically with:
> 
> <prepare the new root fs, which is in fact a cramfs>
> mount -t cramfs /dev/rd/0 $mntpoint
> cd $mntpoint
> mount -nt proc none proc/
> mount -nt devfs none dev/
> /sbin/pivot_root . mnt <dev/console >dev/console 2>&1
> <snip, some further preparations on the new root fs>
> /usr/sbin/chroot . /sbin/telinit u <dev/console >/dev/console 2>&1
        btw you probably have to remove leading / ^^^
> <snip>
> exit 0

Hm... I thought you are running with pid 1 and have to do

exec chroot . /sbin/init <dev/console >/dev/console 2>&1

or the like as a final command.

> it no longer works as expected. I should probably note that the 
> redirections to /dev/console were not necessary for 2.4.21-rc2, I tried 
> them with 2.4.21-ac4. While the above commands did the trick for 
> 2.4.21-rc2, with 2.4.21-ac4 the kernel processes leave the console on 
> the old root fs open:
> 
> lsof -n | grep mnt
> keventd     2   root    0u   CHR        5,1               16  /mnt/dev/console
> keventd     2   root    1u   CHR        5,1               16  /mnt/dev/console
> keventd     2   root    2u   CHR        5,1               16  /mnt/dev/console
> ksoftirqd   3   root    0u   CHR        5,1               16  /mnt/dev/console
> ksoftirqd   3   root    1u   CHR        5,1               16  /mnt/dev/console
> ksoftirqd   3   root    2u   CHR        5,1               16  /mnt/dev/console
> kswapd      4   root    0u   CHR        5,1               16  /mnt/dev/console
> kswapd      4   root    1u   CHR        5,1               16  /mnt/dev/console
> kswapd      4   root    2u   CHR        5,1               16  /mnt/dev/console
> bdflush     5   root    0u   CHR        5,1               16  /mnt/dev/console
> bdflush     5   root    1u   CHR        5,1               16  /mnt/dev/console
> bdflush     5   root    2u   CHR        5,1               16  /mnt/dev/console
> kupdated    6   root    0u   CHR        5,1               16  /mnt/dev/console
> kupdated    6   root    1u   CHR        5,1               16  /mnt/dev/console
> kupdated    6   root    2u   CHR        5,1               16  /mnt/dev/console
> kjournald   7   root    0u   CHR        5,1               16  /mnt/dev/console
> kjournald   7   root    1u   CHR        5,1               16  /mnt/dev/console
> kjournald   7   root    2u   CHR        5,1               16  /mnt/dev/console
> scsi_eh_0  81   root    0u   CHR        5,1               16  /mnt/dev/console
> scsi_eh_0  81   root    1u   CHR        5,1               16  /mnt/dev/console
> scsi_eh_0  81   root    2u   CHR        5,1               16  /mnt/dev/console
> 
> Does anybody have an idea what might be wrong here ?

I don't know for sure but it seems like kernel daemons share fds with pid 1.
On my system:

COMMAND    PID  USER   FD   TYPE     DEVICE     SIZE      NODE NAME
init         1  root  cwd    DIR        0,8     1024     65282 / (172.16.42.75:/.rootfs/.std)
init         1  root  rtd    DIR        0,8     1024     65282 / (172.16.42.75:/.rootfs/.std)
init         1  root  txt    REG        0,8    19688     77715 /app/util-linux-2.11p/sbin/init (172.16.42.75:/.rootfs/.std)
init         1  root  mem    REG        0,8   832636      8248 /app/glibc-2.3/lib/ld-2.3.so (172.16.42.75:/.rootfs/.std)
init         1  root  mem    REG        0,8    69355      8254 /app/glibc-2.3/lib/libcrypt-2.3.so (172.16.42.75:/.rootfs/.std)
init         1  root  mem    REG        0,8 16153080      8249 /app/glibc-2.3/lib/libc-2.3.so (172.16.42.75:/.rootfs/.std)
init         1  root    3u  FIFO        0,6                405 /dev/initctl
keventd      2  root  cwd    DIR        0,8     1024     65282 / (172.16.42.75:/.rootfs/.std)
keventd      2  root  rtd    DIR        0,8     1024     65282 / (172.16.42.75:/.rootfs/.std)
keventd      2  root    3u  FIFO        0,6                405 /dev/initctl
ksoftirqd    3  root  cwd    DIR        0,8     1024     65282 / (172.16.42.75:/.rootfs/.std)
ksoftirqd    3  root  rtd    DIR        0,8     1024     65282 / (172.16.42.75:/.rootfs/.std)
ksoftirqd    3  root    3u  FIFO        0,6                405 /dev/initctl
kswapd       4  root  cwd    DIR        0,8     1024     65282 / (172.16.42.75:/.rootfs/.std)
kswapd       4  root  rtd    DIR        0,8     1024     65282 / (172.16.42.75:/.rootfs/.std)
kswapd       4  root    3u  FIFO        0,6                405 /dev/initctl
bdflush      5  root  cwd    DIR        0,8     1024     65282 / (172.16.42.75:/.rootfs/.std)
bdflush      5  root  rtd    DIR        0,8     1024     65282 / (172.16.42.75:/.rootfs/.std)
bdflush      5  root    3u  FIFO        0,6                405 /dev/initctl
kupdated     6  root  cwd    DIR        0,8     1024     65282 / (172.16.42.75:/.rootfs/.std)
kupdated     6  root  rtd    DIR        0,8     1024     65282 / (172.16.42.75:/.rootfs/.std)
kupdated     6  root    3u  FIFO        0,6                405 /dev/initctl
rpciod      16  root  cwd    DIR        0,8     1024     65282 / (172.16.42.75:/.rootfs/.std)
rpciod      16  root  rtd    DIR        0,8     1024     65282 / (172.16.42.75:/.rootfs/.std)
rpciod      16  root    3u  FIFO        0,6                405 /dev/initctl

See? fd 3 is open to /dev/initctl in init AND in kernel daemons.
I conclude that daemons simply share fd table with init.

So you might try to do the exec chroot . /sbin/init trick
and see whether that works.
--
vda
