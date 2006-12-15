Return-Path: <linux-kernel-owner+w=401wt.eu-S1753269AbWLOTYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269AbWLOTYi (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 14:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753268AbWLOTYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 14:24:38 -0500
Received: from smtp.osdl.org ([65.172.181.25]:37264 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753265AbWLOTYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 14:24:37 -0500
Date: Fri, 15 Dec 2006 11:24:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       linux-ide@vger.kernel.org, Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: OOPS: deref 0x14 at pdc_port_start+0x82 [Was: 2.6.20-rc1-mm1]
Message-Id: <20061215112412.d92dfceb.akpm@osdl.org>
In-Reply-To: <4582B53A.8010809@gmail.com>
References: <20061214225913.3338f677.akpm@osdl.org>
	<4582B53A.8010809@gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Dec 2006 15:45:55 +0059
Jiri Slaby <jirislaby@gmail.com> wrote:

> Andrew Morton wrote:
> > Temporarily at
> > 
> > 	http://userweb.kernel.org/~akpm/2.6.20-rc1-mm1/
> > 
> > Will appear later at
> > 
> > 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc1/2.6.20-rc1-mm1/
> 
> The kernel panics at boot in pdc_port_start+0x82 with deref of 0x14:
> http://www.fi.muni.cz/~xslaby/sklad/pdc_oops.png
> 
> ATA port is not connected, only 2 SATA disks on my
> # lspci -vvxs 02:01.0
> 02:01.0 Mass storage controller: Promise Technology, Inc. PDC40775 (SATA 300
> TX2plus) (rev 02)
>         Subsystem: Promise Technology, Inc. PDC40775 (SATA 300 TX2plus)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 72 (1000ns min, 4500ns max), Cache Line Size: 4 bytes
>         Interrupt: pin A routed to IRQ 19
>         Region 0: I/O ports at 8000 [size=128]
>         Region 2: I/O ports at 8400 [size=256]
>         Region 3: Memory at fb025000 (32-bit, non-prefetchable) [size=4K]
>         Region 4: Memory at fb000000 (32-bit, non-prefetchable) [size=128K]
>         [virtual] Expansion ROM at 50000000 [disabled] [size=32K]
>         Capabilities: [60] Power Management version 2
>                 Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 00: 5a 10 73 3d 07 00 30 02 02 00 80 01 01 48 00 00
> 10: 01 80 00 00 00 00 00 00 01 84 00 00 00 50 02 fb
> 20: 00 00 00 fb 00 00 00 00 00 00 00 00 5a 10 73 3d
> 30: 00 00 00 00 60 00 00 00 00 00 00 00 0a 01 04 12
> 

Presumably

                void __iomem *mmio = (void __iomem *) ap->ioaddr.scr_addr;

gave us a null pointer.

Something like this:

diff -puN drivers/ata/sata_promise.c~a drivers/ata/sata_promise.c
--- a/drivers/ata/sata_promise.c~a
+++ a/drivers/ata/sata_promise.c
@@ -294,6 +294,10 @@ static int pdc_port_start(struct ata_por
 		void __iomem *mmio = (void __iomem *) ap->ioaddr.scr_addr;
 		unsigned int tmp;
 
+		if (!mmio) {
+			rc = -EDOM;
+			goto out_kfree;
+		}
 		tmp = readl(mmio + 0x014);
 		tmp = (tmp & ~3) | 1;	/* set bits 1:0 = 0:1 */
 		writel(tmp, mmio + 0x014);
_

should perhaps let you wobble to a state where you can get us the full
dmesg output, please.

Actually, that should already be possible simply using netconsole.

