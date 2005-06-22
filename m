Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbVFVREY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbVFVREY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 13:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbVFVRBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 13:01:55 -0400
Received: from [202.136.32.45] ([202.136.32.45]:24292 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S261657AbVFVQ5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 12:57:09 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-mm1 breaks Toshiba laptop yenta cardbus
Date: Thu, 23 Jun 2005 02:56:49 +1000
Organization: <http://scatter.mine.nu/>
Message-ID: <j34jb155ndmakorjm1m7f0g8mr6rrla5l0@4ax.com>
References: <s32db1toatpgar8nun4m5rtqq97hkbk2ab@4ax.com> <20050622161142.A32391@jurassic.park.msu.ru>
In-Reply-To: <20050622161142.A32391@jurassic.park.msu.ru>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2005 16:11:42 +0400, Ivan Kokshaysky <ink@jurassic.park.msu.ru> wrote:
>
>Then yenta_allocate_res() tries to assign these resources again and,
>naturally, fails.
>
>This adds check for already assigned cardbus resources.
>
>Ivan.
>
>--- 2.6.12-mm1/drivers/pcmcia/yenta_socket.c	Wed Jun 22 15:56:20 2005
>+++ linux/drivers/pcmcia/yenta_socket.c	Wed Jun 22 16:01:40 2005
>@@ -553,6 +553,11 @@ static int yenta_try_allocate_res(struct
> 	unsigned offset;
> 	unsigned mask;
> 
>+	res = socket->dev->resource + PCI_BRIDGE_RESOURCES + nr;
>+	/* Already allocated? */
>+	if (res->parent)
>+		return 0;
>+
> 	/* The granularity of the memory limit is 4kB, on IO it's 4 bytes */
> 	mask = ~0xfff;
> 	if (type & IORESOURCE_IO)
>@@ -560,7 +565,6 @@ static int yenta_try_allocate_res(struct
> 
> 	offset = 0x1c + 8*nr;
> 	bus = socket->dev->subordinate;
>-	res = socket->dev->resource + PCI_BRIDGE_RESOURCES + nr;
> 	res->name = bus->name;
> 	res->flags = type;
> 	res->start = 0;

Ivan,
Thank you, it worked.

I have my cardbus + network connection back!  But I still get the 
swag of error messages in syslog.  From cardmgr?  So I mark rc.pcmcia 
non-execute (Slackware) and reboot, I still have cardbus NIC.  

Remove user-space cardmgr, that's what this work was about?  I'll try 
with 16-bit stuff daytime.

syslog:
Jun 23 02:46:52 tosh kernel: PCI: Probing PCI hardware (bus 00)
Jun 23 02:46:52 tosh kernel: PCI: Bus 2, cardbus bridge: 0000:00:0b.0
Jun 23 02:46:52 tosh kernel:   IO window: 00002000-00002fff
Jun 23 02:46:52 tosh kernel:   IO window: 00003000-00003fff
Jun 23 02:46:52 tosh kernel:   PREFETCH window: 12000000-13ffffff
Jun 23 02:46:52 tosh kernel:   MEM window: 14000000-15ffffff
Jun 23 02:46:52 tosh kernel: PCI: Enabling device 0000:00:0b.0 (0000 -> 0003)
Jun 23 02:46:52 tosh kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
Jun 23 02:46:52 tosh kernel: PCI: setting IRQ 11 as level-triggered
Jun 23 02:46:52 tosh kernel: Console: switching to colour frame buffer device 100x37
Jun 23 02:46:52 tosh kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jun 23 02:46:52 tosh kernel: hda: SAMSUNG MP0402H, ATA DISK drive
Jun 23 02:46:52 tosh kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jun 23 02:46:52 tosh kernel: hdc: CD-224E-B, ATAPI CD/DVD-ROM drive
Jun 23 02:46:52 tosh kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jun 23 02:46:52 tosh kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
Jun 23 02:46:52 tosh kernel: ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
Jun 23 02:46:52 tosh kernel: TCP established hash table entries: 8192 (order: 4, 65536 bytes)
Jun 23 02:46:52 tosh kernel: TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
Jun 23 02:46:52 tosh kernel: Using IPI Shortcut mode
Jun 23 02:46:52 tosh kernel: VFS: Mounted root (reiserfs filesystem) readonly.
Jun 23 02:46:52 tosh kernel: PCI: Enabling device 0000:02:00.0 (0000 -> 0003)

--Grant.

