Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268182AbUHQLPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268182AbUHQLPJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 07:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265410AbUHQLPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 07:15:08 -0400
Received: from fep01fe.ttnet.net.tr ([212.156.4.130]:57821 "EHLO
	fep01.ttnet.net.tr") by vger.kernel.org with ESMTP id S268184AbUHQLNk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 07:13:40 -0400
Message-ID: <4121E829.4090801@ttnet.net.tr>
Date: Tue, 17 Aug 2004 14:12:41 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 2.4] blacklist a device in usb-storage
References: <mailman.1092508141.32379.linux-kernel2news@redhat.com><20040815235204.0e9ec874@lembas.zaitcev.lan><412066BC.9040503@ttnet.net.tr><20040816080751.733c188d@lembas.zaitcev.lan><4120D8B1.6040000@ttnet.net.tr>
	 <20040816153243.7e050372@lembas.zaitcev.lan>
In-Reply-To: <20040816153243.7e050372@lembas.zaitcev.lan>
Content-Type: multipart/mixed;
	boundary="------------010903020606070507060808"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010903020606070507060808
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit

Pete Zaitcev wrote:
[...]
>> >>EIP; e0d24da0 <[sr_mod]sr_registered+22deec/22e1ac>   <=====
> 
> 
>>Trace; e0a3b9cf <[usb-uhci]process_interrupt+21f/260>
>>Trace; e0a3bde4 <[usb-uhci]process_urb+254/260>
>>Trace; e0207ee9 <_end+1fe721a5/2064e31c>
>>Trace; e0a3be87 <[usb-uhci]uhci_interrupt+97/170>
>>Trace; c010a848 <handle_IRQ_event+48/80>
>>Trace; c010aa33 <do_IRQ+83/f0>
>>Trace; c0107150 <default_idle+0/40>
>>Trace; c01071f4 <cpu_idle+34/40>
> 
> 
> Hmm. This looks fishy, because sr_registered is not a function.

Yeah it's not reliable :/  How about [snd-seq-midi].data.end
(the finding if don't I don't unload any modules. After every
module unload the finding changes.)

> Does the same happen after "echo /bin/true > /proc/sys/kernel/hotplug"?

Doesn't change anything:
Do the "echo /bin/true > /proc/sys/kernel/hotplug", plug the
disk, manually do "/sbin/modprobe usb-storage", watch the same
scene about interrupts etc, unplug the disk (this time no
hotplug magic is in effect), "/sbin/modprobe -r usb-storage"
and panic. I guess the device is never released from the scsi
layer??? The attached file has the panic info (unreliable as
before; and yes it's nvidia-tainted, but nvidia is irrelevant
it happens reliably all the time).

 > Maybe your hotplug setup yanks a module. I heard some crazy distro
 > did that on unplug.

This is Redhat-9, using hotplug-2004_04_01-4 from rawhide.
I remember the very same failures when I was using Mandrake9.0,
so the distro change doesn't seem to make a difference (yet).

I still strongly beleive that we need a blacklisting mechanism
for crazy cases like this.

Regards,
Ozkan Sezer

--------------010903020606070507060808
Content-Type: text/plain;
	name="panic-2.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="panic-2.log"

ksymoops 2.4.5 on i686 2.4.27-acx2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.27-acx2 (specified)
     -m /boot/System.map-2.4.27-acx2 (default)

Warning (compare_maps): mismatch on symbol _nv000173rm  , nvidia says e0f24100, /lib/modules/2.4.27-acx2/nvidia/nvidia.o says e0f23ee0.  Ignoring /lib/modules/2.4.27-acx2/nvidia/nvidia.o entry
CPU: 0
EIP: 0010: [<e0f4ada0>]  Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: db949164   ebx: ffffffac   ecx: 00000003   edx: ffffffac
esi: 00000000   edi: de6a9c74   ebp: db6fbf18   esp: db6fbef4
ds: 0018   es: 0018   ss: 0018
Process swapper: (pid: 9027, stackpage= db6f6000)
Stack:  e0a3b9cf  de6a9c74  de6a9c74  db949164
        c17593c0  db949164  c1617ef0  c1617ed4
        de6a9c74  db6fbf48  e0a3bde4  c1617ed4
        de6a9c74  0000b708  c12551a0  00000286
        00000000  00000000  c1617ef0  00000001
        c1617ed4  db6fbf78  e0a3be87  c1617ed4
Call Trace: [<e0a3b9cf>]  [<e0a3bde4>]  [<e0a3be87>]
        [<c010a848>]   [<c010aa33>]
Code: Bad EIP value


>>EIP; e0f4ada0 <[nvidia].data.end+3e69/1016129>   <=====

>>eax; db949164 <_end+1b5b3420/2064e31c>
>>ebx; ffffffac <END_OF_CODE+1e0436ac/????>
>>edx; ffffffac <END_OF_CODE+1e0436ac/????>
>>edi; de6a9c74 <_end+1e313f30/2064e31c>
>>ebp; db6fbf18 <_end+1b3661d4/2064e31c>
>>esp; db6fbef4 <_end+1b3661b0/2064e31c>

Trace; e0a3b9cf <[usb-uhci]process_interrupt+21f/260>
Trace; e0a3bde4 <[usb-uhci]process_urb+254/260>
Trace; e0a3be87 <[usb-uhci]uhci_interrupt+97/170>
Trace; c010a848 <handle_IRQ_event+48/80>
Trace; c010aa33 <do_IRQ+83/f0>

<0>Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.

--------------010903020606070507060808--
