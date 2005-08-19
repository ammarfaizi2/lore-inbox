Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932621AbVHSNVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932621AbVHSNVO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 09:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932658AbVHSNVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 09:21:14 -0400
Received: from tornado.reub.net ([202.89.145.182]:23012 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S932621AbVHSNVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 09:21:14 -0400
Message-ID: <4305DCC6.70906@reub.net>
Date: Sat, 20 Aug 2005 01:21:10 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.0+ (Windows/20050813)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-mm1
References: <20050819043331.7bc1f9a9.akpm@osdl.org>
In-Reply-To: <20050819043331.7bc1f9a9.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19/08/2005 11:33 p.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc6/2.6.13-rc6-mm1/
> 
> - Lots of fixes, updates and cleanups all over the place.
> 
> - If you have the right debugging options set, this kernel will generate
>   a storm of sleeping-in-atomic-code warnings at boot, from the scsi code.
>   It is being worked on.

A few new problems cropped up with this kernel..

1. NFS seems to be unstable, oopsing when shutting down:

Aug 20 12:26:09 tornado shutdown: shutting down for system reboot
Aug 20 12:26:10 tornado init: Switching to runlevel: 6
Aug 20 12:26:10 tornado kernel: Device  not ready.
Aug 20 12:26:10 tornado last message repeated 4 times
Aug 20 12:26:11 tornado smokeping[2524]: Got TERM signal, terminating.
Aug 20 12:26:16 tornado rpc.mountd: Caught signal 15, un-registering and exiting.
Aug 20 12:26:20 tornado kernel: ------------[ cut here ]------------
Aug 20 12:26:20 tornado kernel: kernel BUG at lib/kernel_lock.c:83!
Aug 20 12:26:20 tornado kernel: invalid operand: 0000 [#1]
Aug 20 12:26:20 tornado kernel: SMP
Aug 20 12:26:20 tornado kernel: last sysfs file: 
/devices/pci0000:00/0000:00:1d.3/usb5/5-2/5-2.2/5-2.2.1/5-2.2.1.1/5-2.2.1.1:1.1/mod
alias
Aug 20 12:26:20 tornado kernel: Modules linked in: nfsd exportfs lockd eeprom 
sunrpc ipv6 iptable_filter binfmt_misc reiser4 zlib_de
flate zlib_inflate dm_mod video thermal processor fan button ac i8xx_tco 
i2c_i801 sky2 sr_mod
Aug 20 12:26:20 tornado kernel: CPU:    1
Aug 20 12:26:20 tornado kernel: EIP:    0060:[<c0310845>]    Not tainted VLI
Aug 20 12:26:20 tornado kernel: EFLAGS: 00010286   (2.6.13-rc6-mm1)
Aug 20 12:26:20 tornado kernel: EIP is at unlock_kernel+0x28/0x32
Aug 20 12:26:20 tornado kernel: eax: ffffffff   ebx: 00000009   ecx: f6a23f90 
   edx: f6adaa50
Aug 20 12:26:20 tornado kernel: esi: f6a23f54   edi: c191d2fc   ebp: f6b3ffa8 
   esp: f6b3ffa8
Aug 20 12:26:20 tornado kernel: ds: 007b   es: 007b   ss: 0068
Aug 20 12:26:20 tornado kernel: Process nfsd (pid: 2034, threadinfo=f6b3e000 
task=f6adaa50)
Aug 20 12:26:20 tornado kernel: Stack: f6b3ffe4 f8e0e4c2 f8e2d648 f6b3e000 
f6f9103c 00100100 00200200 f6adaa50
Aug 20 12:26:20 tornado kernel:        fffffeff ffffffff fffffef8 ffffffff 
f8e0e231 00000000 00000000 00000000
Aug 20 12:26:20 tornado kernel:        c01010b5 f6f9103c 00000000 00000000 
5a5a5a5a a55a5a5a
Aug 20 12:26:20 tornado kernel: Call Trace:
Aug 20 12:26:20 tornado kernel:  [<c01039c3>] show_stack+0x94/0xca
Aug 20 12:26:20 tornado kernel:  [<c0103b6c>] show_registers+0x15a/0x1ea
Aug 20 12:26:20 tornado kernel:  [<c0103d8a>] die+0x108/0x183
Aug 20 12:26:20 tornado kernel:  [<c0310986>] do_trap+0x76/0xa1
Aug 20 12:26:20 tornado kernel:  [<c0104090>] do_invalid_op+0x97/0xa1
Aug 20 12:26:20 tornado kernel:  [<c0103693>] error_code+0x4f/0x54
Aug 20 12:26:20 tornado kernel:  [<f8e0e4c2>] nfsd+0x291/0x341 [nfsd]
Aug 20 12:26:20 tornado kernel:  [<c01010b5>] kernel_thread_helper+0x5/0xb
Aug 20 12:26:20 tornado kernel: Code: 5e 5d c3 55 89 e5 b8 00 e0 ff ff 21 e0 
8b 10 8b 42 14 85 c0 78 15 83 e8 01 89 42 14 85 c0 79 0
9 f0 ff 05 40 e7 36 c0 7e 39 5d c3 <0f> 0b 53 00 37 e1 32 c0 eb e1 8d 05 40 e7 
36 c0 e8 fe dd ff ff
Aug 20 12:26:20 tornado kernel:  ------------[ cut here ]------------


2.  That message on the third line of the trace above: "kernel: Device  not 
ready." is being logged every few mins or so, I believe it is my SCSI CDROM 
that is causing it.  It also logs something similar after the SCSI driver has 
probed the device on boot:

Aug 20 12:24:36 tornado kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA 
DRIVER, Rev 7.0
Aug 20 12:24:36 tornado kernel:         <Adaptec 2940 Ultra SCSI adapter>
Aug 20 12:24:36 tornado kernel:         aic7880: Ultra Wide Channel A, SCSI 
Id=7, 16/253 SCBs
Aug 20 12:24:36 tornado kernel:
Aug 20 12:24:36 tornado kernel:   Vendor: SONY      Model: CD-RW  CRX145S 
Rev: 1.0b
Aug 20 12:24:36 tornado kernel:   Type:   CD-ROM 
ANSI SCSI revision: 04
Aug 20 12:24:36 tornado kernel:  target0:0:6: Beginning Domain Validation
Aug 20 12:24:36 tornado kernel:  target0:0:6: Domain Validation skipping write 
tests
Aug 20 12:24:36 tornado kernel:  target0:0:6: FAST-10 SCSI 10.0 MB/s ST (100 
ns, offset 15)
Aug 20 12:24:36 tornado kernel:  target0:0:6: Ending Domain Validation
Aug 20 12:24:36 tornado kernel: Device  not ready.

This has been a problem for quite a few weeks now, albeit I believe, only a 
cosmetic one.

3. As I have a Marvell Yukon 2 chipset, I was _delighted_ to see a new driver 
from Stephen Hemmingway appear in the netdev tree for it.  However it seems to 
be a bit broken, I get link up and a bit of traffic before it just stops 
passing traffic of any sort and requires an rmmod/modprobe to get going again. 
  I've emailed him directly about this.

4. PAM is complaining about "PAM audit_open() failed: Protocol not suppor
ted" and I can't log in as any user including root.  I would have picked this 
was a userspace problem, but it doesn't break with -rc5-mm1, yet reproduceably 
breaks with -rc6-mm1.  Weird.

reuben

