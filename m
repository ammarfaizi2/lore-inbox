Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263486AbTLOKYZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 05:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263496AbTLOKYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 05:24:25 -0500
Received: from mail.epost.de ([193.28.100.165]:50915 "EHLO mail.epost.de")
	by vger.kernel.org with ESMTP id S263486AbTLOKYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 05:24:22 -0500
From: Marcus Blomenkamp <Marcus.Blomenkamp@epost.de>
To: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: r8169 GigE driver problem, locks up 2.4.23 NFS subsystem
Date: Mon, 15 Dec 2003 11:24:15 +0100
User-Agent: KMail/1.5.3
References: <20031213140106.A24017@electric-eye.fr.zoreil.com> <200312131440.28071.Marcus.Blomenkamp@epost.de> <20031214144055.A4664@electric-eye.fr.zoreil.com>
In-Reply-To: <20031214144055.A4664@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200312151124.15143.Marcus.Blomenkamp@epost.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 14. Dezember 2003 14:40 schrieben Sie:
>
> Ok, this one is merged into Jeff Garzik's patchset. If you try it and it
> does not work, please report if it does not work in a different manner
> (because it is still possible that I have broken something during the
> merge).

Hi.

First of all, i did not feel any difference in behaviour for the different 
ACPI options, so I ran all these tests with acpi=off explicitly. Mainboard is 
Asus P2B with recent ACPI beta bios.

Ok, from this patchset i extracted and updated the 8169.c diff only. And bad 
news: With this driver object built-in the kernel does not boot at all - 
locks up on configuring card 100% reproducible.

I enabled debug options in 8169 and got this output: (manually written...)

r8169 Gigabit Ethernet driver 1.2 loaded
mac_version == RTL_GIGA_MAC_VER_E (0002)
phy_version == RTL_GIGA_PHY_VER_E (0000)
eth0: RTL8169 at 0xd882a00, 00:08:54:d0:e4:70, IRQ 5
mac_version == RTL_GIGA_MAC_VER_E (0002)
phy_version == RTL_GIGA_PHY_VER_E (0000)
Do final_reg2.cfg

I added more dummy printks and intermediate result: it does not return from 
function 'rtl8169_hw_phy_config()' 

This routine messes up the card itself, as a reset/reboot into 2.4 does not 
revitalize it. I definitively have to power-cycle the machine.

>
> Is it possible to get an ethereal dump for a normal nfs operation as well
> as for a failed one on both sides of the link (client + server) ?
> The size of the dump should not be an issue on my side.

I tcpdump'ed both sides on transferring 1 Megabyte to the 8139 based machine 
for both low level transfers (UDP, TCP) and on filesystem level (NFS).

NFS: dd 1M to remote file
UDP/TCP: dd 1M trough netcat
TCP: scp 1M file

Very interestingly i could not reproduce the NFS lockup during this double 
monitoring setup. So i ran it twice - once for each machine in promiscious 
mode. And guess: If the 8169 NIC is in monitoring mode, NFS writes do not 
lock up. I can even recover the machine from stalling by explicitly entering 
promiscious mode and SIGINT'ing the writing process.


>
> A /proc/interrupts of the working/failing client after the nfs operation
> as well as after a normal scp (if possible) could help too.

Everything normal - no interrupt storm visible. On NFS stalling NICs interrupt 
counter does not increase, however explicit pings work fine and do increment 
the counter.

>
> Some 'ifconfig' output will be welcome too.
>
> If the problem is more or less trivially related to the length of the
> frames, it should be possible to notice a change of behavior while
> increasing the size of simple ping (ping -n -c 1 -s _size 192.168.1.254
> where _size ~= 1460...1480). Do you notice something here ?

This one ist interesting too. After having found NFS locking above 
datagramsize==4k i tried to find the exact boundary in this range. And there 
is no. First impressions (will do a deeper analysis later):

send 4k		OK
send 5k		-

IIRC there is a region around 4750 bytes at which it seems to works like a 
Schmitt trigger. If i am coming from below (aka can ping) i can ping with 
dsize=X but if i am coming from above (aka no ping answer) i can not ping 
with the same dsize=X.

I'll copy-mail this to lk, so i'll send the logs to you in a separate mail.

Best regards, Marcus

