Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144345AbRA2BAT>; Sun, 28 Jan 2001 20:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144680AbRA2BAA>; Sun, 28 Jan 2001 20:00:00 -0500
Received: from platan.vc.cvut.cz ([147.32.240.81]:41990 "EHLO
	platan.vc.cvut.cz") by vger.kernel.org with ESMTP
	id <S135189AbRA2A7v>; Sun, 28 Jan 2001 19:59:51 -0500
Date: Mon, 29 Jan 2001 01:58:43 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
Subject: PDC20265, disk corruption and NMI watchdog...
Message-ID: <20010129015843.B16593@platan.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Short story:

Hi Andre,
  why on Earth ide_delay_50ms uses jiffies instead of mdelay(50) ?!
It is invoked with interrupts disabled, causing NMI watchdog detected
on my system, leading to complete crash of system.

Long story:

At home I have Asus A7V motherboard with 1G Athlon, and onboard
PDC20265 and VIA KT133. Only CDROM is connected to VIA (as I was
not able to get any ATAPI device with Promise under Linux).
To primary master of PDC (hde) there is IBM-DTLA-307045, happilly
running in UDMA5 mode. As secondary slave (hdh) there is removable
hdd TOSHIBA MK6409MAV - I use this hdd to transport data between
work, home and grandparents.

On every weekend I bring debian packages on this hdd home, as downloading
couple of MBs each weekend is not acceptable for dialup connection.
But data are never copied OK from one hdd (hdh) to another (hde) -
- hdh runs in UDMA2, hde in UDMA5. There are always 4 different bytes
in couple of files - corrupted bytes are always on word boundary, but
sometime they are on dword, sometime they are not. Data are never
moved, they are just random bytes... It looks like that
problem is with removable HDD (source), not with UDMA5 destination.

So I decided to 'hdparm -d1 -X 65 /dev/hdh' to switch it to UDMA1.
i was awarded by (4 times):

hde: dma_intr: bad DMA status
hde: dma_intr: status = 0x50 { DriveReady SeekComplete }

and

hde: DMA disabled
NMI watchdog detected lockup on CPU0, registers:
...
Dump says that ide_delay_50ms was invoked with interrupts disabled
in swapper task, through pdc202xx_reset -> do_reset1 -> ide_do_reset -> 
ide_error -> ide_dma_intr -> ide_intr -> handle_IRQ_event -> do_IRQ -> 
(interrupt) -> default_idle -> cpu_idle.

I have no idea why it compalined on hde, when I hdparm-ed hdh...
So I rebooted - and after reboot fsck of hde* passed ok, but on
hdh* it was not able to find debian tree - directory tree was cut to about
7 parts which were reconnected to /lost+found. Probably someone took
deep look at some inodes, as fsck found about 1000 errors - it is too
much from filesystem which could be modified only due to atime changes...

So I my questions are: 
Is it ok to use pdc202xx driver at all? It does not complain about UDMA CRC 
  errors, but data are (always) corrupted.
Should I return back to UDMA66 VIA instead of UDMA100 promise? 
Should I rejumper my removable HDD to be master, and not slave?
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz  


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
