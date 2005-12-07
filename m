Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbVLGMQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbVLGMQH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 07:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbVLGMQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 07:16:07 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:52208 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750899AbVLGMQG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 07:16:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=deQv4DZ+tM6LiTqs6K+TW4IVnNIO8dzEP1E3638xO9QPPpuoBMfFeEk1aQzsxXup7D8DQg986HibYcM/urTydPc1fa61d/fDhodGRprf7pi8Bh10regAHu3IDavWV8okXuBItJjbONPgSU0+OrjbsO+zvETkpkcwGbNgS77FmZg=
Message-ID: <e3e24c6a0512070416m3723cd73x20d2889d57c9160b@mail.gmail.com>
Date: Wed, 7 Dec 2005 12:16:05 +0000
From: Vishal Soni <vishal.linux@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Execution of kernel does not stop at the break point while doing remote debug (using kgdb).
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After setting up the testbed, to remotely (serially) debug the kernel
and then applying the breakpoints, kernel execution does not stop at
the breatpoint.

Below are the steps :

I compiled the kernel 2.6.8 after applying the kgdb patch and made a
set up to remotely debug the kernel mdule. I used gdbmod (available at
http://kgdb.linsyssoft.com) on development machine to connect to the
target machine as shown below.

/*********************************************************************/
[root@vishalsoni linux-2.6.8]# gdbmod vmlinux
GNU gdb 6.0
Copyright 2003 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i686-pc-linux-gnu"...
(gdb) target remote /dev/ttyS0
Remote debugging using /dev/ttyS0
breakpoint () at kernel/kgdb.c:1212
1212            atomic_set(&kgdb_setting_breakpoint, 0);
(gdb)
/*********************************************************************/

To let GDB know where module files are located, i set GDB variable
solib-search-path

/*********************************************************************/
(gdb) set solib-search-path /home/vishal/products/tot_driver/
/*********************************************************************/
and then i did insmod on target to load the kernel module and checked
the output of /proc/modules

/*********************************************************************/
[root@localhost mon_drv]# insmod ./tot.ko
[root@localhost mon_drv]# cat /proc/modules
tot     17428  0  - Live 0xe028e000
nfsd 194976  9  - Live 0xe0219000

<snip>
/*********************************************************************/
#### my module name is "tot"
I Cross-checked if the symbols are loaded in gdb on development machine
/*********************************************************************/
(gdb) info sharedlibrary
>From        To          Syms Read   Shared Object Library
0xe028e000  0xe028fd6c  Yes         /home/vishal/products/tot_driver/tot.ko
                        No          nfsd.ko
                        No          exportfs.ko
                        No          lockd.ko
                        No          md5.ko
                        No          ata_piix.ko
                        No          libata.ko
                        No          sd_mod.ko
                        No          scsi_mod.ko
(gdb)
/*********************************************************************/

this clearly shows that the symbol information is available to gdb and
i was successfully able to put a breakpoint too

(gdb) break f_mmap
Breakpoint 1 at 0xe028ec60: file
/home/vishal/products/tot_driver/tot..c, line 108.

Now, the issue is that the execution of the kernel does not stop when
this function is being called.
I am sure that this function is being used as i have some printks in
the function and their output is shown in dmesg.

Is there any think which i am missing. Your inputs on this would be
highly appreciated.

regards,
Vishal.
