Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264262AbTEZFRP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 01:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264264AbTEZFRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 01:17:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14741 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264262AbTEZFRN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 01:17:13 -0400
Message-ID: <3ED1A664.1020307@pobox.com>
Date: Mon, 26 May 2003 01:30:12 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCHES] add ata scsi driver
References: <Pine.LNX.4.44.0305252214290.6692-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0305252214290.6692-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Mon, 26 May 2003, Jeff Garzik wrote:
> 
>>Just to echo some comments I said in private, this driver is _not_
>>a replacement for drivers/ide.  This is not, and has never been,
>>the intention.  In fact, I need drivers/ide's continued existence,
>>so that I may have fewer boundaries on future development.
> 
> 
> Just out of interest, is there any _point_ to this driver? I can
> appreciate the approach, but I'd like to know if it does anything (at all)
> better than the native IDE driver? Faster? Anything?


Direction:  SATA is much more suited to SCSI, because otherwise you wind 
up re-creating all the queueing and error handling mess that SCSI 
already does for you.  The SATA2 host controllers coming out soon do 
full host-side TCQ, not the dain-bramaged ATA TCQ bus-release stuff. 
Doing SATA2 devel in drivers/ide will essentially be re-creating the 
SCSI mid-layer.

Modularity:  drivers/ide has come a long way.  It needed to be turned 
"inside out", and that's what Alan did.  But there's still a lot of code 
that needs to be factored out/about, before hotplugging and device model 
stuff is sane.

Legacy-free:  Because I don't have to worry about legacy host 
controllers, I can ignore limitations drivers/ide cannot.  In 
drivers/ide, each host IO (PIO/MMIO) is done via function pointer.  If 
your arch has a mach_vec, more function pointers.  Mine does direct 
calls to the asm/io.h functions in faster.  So, ATA command submission 
is measureably faster.

sysfs:  James and co are putting time into getting scsi sysfs right.  I 
would rather ride their coattails, and have my driver Just Work with 
sysfs and the driver model.

PIO data transfer is faster and more scheduler-friendly, since it polls 
from a kernel thread.

And for specifically Intel SATA, drivers/ide flat out doesn't work (even 
though it claims to).

So, I conclude:  faster, smaller, and better future direction.  IMO, of 
course :)

	Jeff



(the following is somewhat comparing apples to oranges, but I like doing 
it nonetheless)

bash-2.05b$ wc -l drivers/scsi/libata.c drivers/scsi/ata_piix.c 
include/linux/ata.h
    2247 drivers/scsi/libata.c
     322 drivers/scsi/ata_piix.c
     485 include/linux/ata.h
    3054 total

bash-2.05b$ wc -l drivers/ide/*.[ch] drivers/ide/pci/piix.[ch]
    3418 drivers/ide/ide-cd.c
     733 drivers/ide/ide-cd.h
      71 drivers/ide/ide-default.c
    1841 drivers/ide/ide-disk.c
    1145 drivers/ide/ide-dma.c
    2090 drivers/ide/ide-floppy.c
     135 drivers/ide/ide-geometry.c
    1330 drivers/ide/ide-io.c
    1322 drivers/ide/ide-iops.c
     437 drivers/ide/ide-lib.c
      97 drivers/ide/ide-pnp.c
    1466 drivers/ide/ide-probe.c
     930 drivers/ide/ide-proc.c
    6330 drivers/ide/ide-tape.c
    2006 drivers/ide/ide-taskfile.c
     798 drivers/ide/ide-tcq.c
     281 drivers/ide/ide-timing.h
    2539 drivers/ide/ide.c
      41 drivers/ide/ide_modes.h
     899 drivers/ide/setup-pci.c
     840 drivers/ide/pci/piix.c
     317 drivers/ide/pci/piix.h
   29066 total

