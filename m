Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130442AbRC0Chq>; Mon, 26 Mar 2001 21:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130446AbRC0Chg>; Mon, 26 Mar 2001 21:37:36 -0500
Received: from asbestos.brocade.com ([63.121.140.244]:23777 "EHLO
	mail.brocade.com") by vger.kernel.org with ESMTP id <S130442AbRC0Ch3>;
	Mon, 26 Mar 2001 21:37:29 -0500
Message-ID: <3ABFFDCD.3000803@muppetlabs.com>
Date: Mon, 26 Mar 2001 18:41:17 -0800
From: Amit D Chaudhary <amit@muppetlabs.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-8 i686; en-US; 0.8) Gecko/20010215
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, werner.almesberger@epfl.ch
Subject: question \ information request on init \ boot sequence when using initrd
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We(my team) had some questions regarding booting from initrd and using 
/linuxrc. It will help someone(David, Werner,...) can give their 
thoughts on this.

To put it in brief, since running sbin/init from /linuxrc as resulting 
in init not having PID 1 and thereby not doing some initialization as 
expected.

Thereby instead of loading running /sbin/init, we just set 
/proc/sys/kernel/real-root-dev to /dev/ram0's value which then does the 
following
runs 2 statements in init/main.c to unlock_kernel and free init memory 
and then run sbin/init.
This results in /sbin/init running fine.

Is this ok or should be modify /sbin/init to run properly inspite of PID 
<> 1 or is there a 3rd way of doing this?

Thanks
Amit



This is on linux-2.4.1 kernel running on PPC.
/linuxrc is as follow:

../bin/mount -t ramfs none tmp_rootfs

#untar'ing the new root.
../bin/tar -b 512 -zxf /dev/mtd1

mkdir initrd
../bin/pivot_root . initrd

exec sbin/chroot . sbin/init.new 3 <dev/console >dev/console 2>&1


The above results in init running with PID != 1 and thereby skipping 
some relevant processing my default. see ps output below:

Instead of the "chroot" above is changed to following
exec sbin/chroot . sh -c 'bin/mount proc proc -t proc; echo 0x01000000 > 
proc/sys/kernel/real-root-dev'
And linuxrc exits



(none):root> ps -e
   PID TTY          TIME CMD
     1 ?        00:00:04 swapper
     2 ?        00:00:00 keventd
     3 ?        00:00:00 kswapd
     4 ?        00:00:00 kreclaimd
     5 ?        00:00:00 bdflush
     6 ?        00:00:00 kupdate
     7 ?        00:00:00 mtdblockd
     8 ?        00:00:00 init
    26 ?        00:00:00 sh
    39 ?        00:00:00 portmap
    50 ?        00:00:00 ypbind
    51 ?        00:00:00 ypbind
    84 ?        00:00:00 inetd
    93 ?        00:00:00 syslogd
   100 ?        00:00:00 klogd
   119 ?        00:00:00 ps


