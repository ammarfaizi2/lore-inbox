Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262010AbUJYXgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbUJYXgW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 19:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbUJYXdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 19:33:05 -0400
Received: from zeus.kernel.org ([204.152.189.113]:7868 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262041AbUJYX2i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 19:28:38 -0400
Date: Mon, 25 Oct 2004 15:29:13 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.9 SMP: via-rhine cannot be upped.
Message-Id: <20041025152913.1f003eb4@zqx3.pdx.osdl.net>
In-Reply-To: <200410231559.28215.vda@port.imtp.ilyichevsk.odessa.ua>
References: <200410231559.28215.vda@port.imtp.ilyichevsk.odessa.ua>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i686-suse-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Oct 2004 15:59:28 +0300
Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:

> I reported this yesterday but somehow managed to mess up configs
> and accidentally compiled 2.6.9 for SMP! :(
> 
> I just checked that it does not happen on non-SMP 2.6.9.
> 2.6.9-preempt is working too.
> 
> Here goes a problem description again.
> 
> I have an onboard VIA eth:
> 
> # lspci
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP]
> 00:0a.0 Network controller: Texas Instruments ACX 111 54Mbps Wireless Interface
> 00:0c.0 Network controller: Harris Semiconductor D-Links DWL-g650 A1 (rev 01)
> 00:10.0 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 80)
> 00:10.1 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 80)
> 00:10.2 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 80)
> 00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
> 00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
> 00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 06)
> 00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
> 00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
> 01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX 400] (rev a1)
> 
> It cannot be upped:
> 
> # ip l set dev if up
> SIOCSIFFLAGS: Function not implemented
> # ifconfig if up
> SIOCSIFFLAGS: Function not implemented
> # busybox ip l set dev if up
> SIOCSIFFLAGS: Function not implemented
> 
> (NB: ip and ifconfig are not busyboxed, they are "standard" ones)
> 
> Strace (busybox one is smallest):
> 
> execve("/usr/bin/busybox", ["busybox", "ip", "l", "set", "dev", "if", "up"], [/* 28 vars */]) = 0
> fcntl64(0, F_GETFD)                     = 0
> fcntl64(1, F_GETFD)                     = 0
> fcntl64(2, F_GETFD)                     = 0
> uname({sys="Linux", node="shadow", ...}) = 0
> geteuid32()                             = 0
> getuid32()                              = 0
> getegid32()                             = 0
> getgid32()                              = 0
> brk(0)                                  = 0x81ab000
> brk(0x81ac000)                          = 0x81ac000
> socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 4
> ioctl(4, 0x8913, 0xbffff9e0)            = 0
> ioctl(4, 0x8914, 0xbffff9e0)            = -1 ENOSYS (Function not implemented)
> dup(2)                                  = 5
> fcntl64(5, F_GETFL)                     = 0x2 (flags O_RDWR)
> fstat64(5, {st_mode=S_IFCHR|0600, st_rdev=makedev(136, 2), ...}) = 0
> old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40000000
> _llseek(5, 0, 0xbffff830, SEEK_CUR)     = -1 ESPIPE (Illegal seek)
> write(5, "SIOCSIFFLAGS: Function not imple"..., 39) = 39
> close(5)                                = 0
> munmap(0x40000000, 4096)                = 0
> close(4)                                = 0
> write(2, "BusyBox v1.00-pre8 (2004.03.31-2"..., 295) = 295
> _exit(1)
> 
> I booted with init=/bin/sh and ran 'ip l set dev eth0 up'
> - it fails under 2.6.9-smp. This rules out my userspace setup
> being somehow involved (for example, the fact that I rename iface
> from 'eth0' to 'if' does not contribute to the bug).
> 
> My 2.6.9-smp config is attached.

My suspicion is that the eth0 device is not actually the VIA driver
at all. Since your config builds many drivers directly into the kernel,
probably one of the others created an eth0 device.  There is no
guarantee of initialization order about which device gets created first
(at least the way network devices are done in 2.6). 

You should investigate if there are multiple devices present
(ifconfig -a or ls /sys/class/net).  Perhaps one of the other drivers
does not correctly handle the case of hardware not being present
and leaves a ghost behind..

One way to find out would be to look at:
	/sys/class/net/eth0/device/vendor
	/sys/class/net/eth0/device/device
	/sys/class/net/eth0/device/subsystem_vendor
	/sys/class/net/eth0/device/subsystem_device
