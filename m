Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266812AbUHOPqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266812AbUHOPqU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 11:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266813AbUHOPqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 11:46:20 -0400
Received: from pD9FF4C30.dip.t-dialin.net ([217.255.76.48]:17418 "EHLO
	sigma.witten.lan") by vger.kernel.org with ESMTP id S266812AbUHOPqP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 11:46:15 -0400
Message-ID: <411F85E0.70707@gentoo.org>
Date: Sun, 15 Aug 2004 17:48:48 +0200
From: Danny van Dyk <kugelfang@gentoo.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de-AT; rv:1.7) Gecko/20040625
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC] Microcode Update Driver for AMD K8 CPUs
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi @ all!

[First of all, please CC me on all responses as I am not subscribed to 
lkml. Thanx in advance.]

I recently found some piece of code [1] to perform a microcode update on 
AMD's K8 CPUs. It included some update blocks hardcoded into the module.

gregkh pointed out that this is no good style and that the module should 
rather use /dev/microcode to provide the kernel with the latest ucode block.


Therefore I rewrote the module to do it similar to the i386 Intel 
microcode update code. The update block gets written to /dev/microcode. 
The k8_ucode_write() function does nothing but copying the data from 
userspace to kernelspace, using means to avoid multiple concurrent 
writes. After that, the userspace application performs the 
K8_IOCTL_UCODE_UPDATE ioctl(). This starts the update process for each 
cpu, checking that the update block is valid and checks for all cpus if 
their cpuid matches the header's cpuid.

You will find the latest version of the module here [2]. Further it 
_should_ now be SMP safe; should meaning that I had no chance/no 
hardware to test it on.


However, I still experience one bug concerning the first update to be 
performed after loading the module:

The module holds a pointer to a 960 bytes large buffer, holding the 
actual update block. This buffer gets memset'ed with the pattern 
0xA0A0A0A0. When the module's write operation gets used the first time, 
copy_from_user _definitely_ returns 0, telling me that all the 960 bytes 
have been written to the buffer. On the other side, when performing the 
ioctl to start the update, the module tells me that the signature is not 
0x00aaaaaa as expected for a valid update, but rather the same pattern 
which was written into the empty buffer at the beginning. Even stranger 
is, that the same thing then works for all the following calls to the 
update application. Have I misunderstood the copy_from_user() function 
and its return value ? Or is that a bug ?


The process of updating the microcode is rather simple - at least 
compared to the things the i386 driver does. To start it, you need
a block of 960 bytes containing the update block (I extracted 2 blocks 
from the bios update for my ASUS K8V MoBo). This block consists of a 64 
byte long header and a 896 byte long data block. The header contains - 
among other things - the signature 0x00AAAAAA and a 32bit checksum. That 
checksum gets computed by just makeing a sum of all words in the data block.
Performing a msr call with the adress of this updata block in edx:eax 
and the magic 0xC0010020 in ecx starts the actual update.


Please tell me what you think about this. Ah, and Greg mentioned some 
problems with my coding style. Would someone please tell me what I did 
wrong ? ;-)

Danny

[1] 
http://www.realworldtech.com/forums/index.cfm?action=detail&PostNum=2527&Thread=1&entryID=35446&roomID=11
[2] http://dev.gentoo.org/~kugelfang/k8-ucode/

-- 
Danny van Dyk
Gentoo/AMD64 Developer
kugelfang@gentoo.org
