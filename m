Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271008AbTGPRY6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 13:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271004AbTGPRYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 13:24:01 -0400
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:2059 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S270991AbTGPRV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 13:21:57 -0400
Date: Wed, 16 Jul 2003 12:36:45 -0500
From: Art Haas <ahaas@airmail.net>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Trying to get DMA working with IDE alim15x3 controller
Message-ID: <20030716173645.GA671@artsapartment.org>
References: <20030715233202.GB17444@artsapartment.org> <Pine.SOL.4.30.0307160212040.27735-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0307160212040.27735-100000@mion.elka.pw.edu.pl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 02:20:36AM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> I spotted following difference between old (<=2.4.20) and new
> (>=2.4.21 and 2.6) code.  Just a guess...
> 
> --- alim15x3.c.orig	2003-04-20 04:49:10.000000000 +0200
> +++ alim15x3.c	2003-07-16 02:09:05.411225464 +0200
> @@ -595,6 +595,26 @@
> 
>  	local_irq_save(flags);
> 
> +	/*
> +	 * CD_ROM DMA on (m5229, 0x53, bit0)
> +	 *      Enable this bit even if we want to use PIO
> +	 * PIO FIFO off (m5229, 0x53, bit1)
> +	 *      The hardware will use 0x54h and 0x55h to control PIO FIFO
> +	 *	(Not on later devices it seems)
> +	 *
> +	 *	0x53 changes meaning on later revs - we must no touch
> +	 *	bit 1 on them. Need to check if 0x20 is the right break
> +	 */
> +
> +	pci_read_config_byte(dev, 0x53, &tmpbyte);
> +
> +	if (m5229_revision <= 0x20)
> +		tmpbyte = (tmpbyte & (~0x02)) | 0x01;
> +	else
> +		tmpbyte |= 0x01;
> +
> +	pci_write_config_byte(dev, 0x53, tmpbyte);
> +
>  	if (m5229_revision < 0xC2) {
>  		/*
>  		 * revision 0x20 (1543-E, 1543-F)
> @@ -706,26 +726,6 @@
>  		chip_is_1543c_e = ((tmpbyte & 0x1e) == 0x12) ? 1: 0;
>  	}
> 
> -	/*
> -	 * CD_ROM DMA on (m5229, 0x53, bit0)
> -	 *      Enable this bit even if we want to use PIO
> -	 * PIO FIFO off (m5229, 0x53, bit1)
> -	 *      The hardware will use 0x54h and 0x55h to control PIO FIFO
> -	 *	(Not on later devices it seems)
> -	 *
> -	 *	0x53 changes meaning on later revs - we must no touch
> -	 *	bit 1 on them. Need to check if 0x20 is the right break
> -	 */
> -
> -	pci_read_config_byte(dev, 0x53, &tmpbyte);
> -
> -	if(m5229_revision <= 0x20)
> -		tmpbyte = (tmpbyte & (~0x02)) | 0x01;
> -	else
> -		tmpbyte |= 0x01;
> -
> -	pci_write_config_byte(dev, 0x53, tmpbyte);
> -
>  	local_irq_restore(flags);
> 
>  	return(ata66);
> 

Apply this patch and rebooting with this new kernel made no difference.
I tried a few more things as well:

Disconnect CD-ROM: Same problem as before.
Boot with 'ide0=autotune': Same problem as before

I was e-mailed a suggestion to try booting with 'noapic', and that
didn't help either. I'm currently running the patched kernel booted with
the 'ide=nodma' argument.

As things just go to pieces when reading the hard drive, maybe someone
knows if this hard drive model has known DMA issues. When starting the
machine the screens before my lilo prompt print out that the hard drive
should do UDMA. The hard drive on the ide1 channel seems to present no
problem to the ALi controller. Here is agin the hdparm info on my
troublesome drive:

$ hdparm -I /dev/hda

/dev/hda:

ATA device, with non-removable media
	Model Number:       ST33232A                                
	Serial Number:      GH593339
	Firmware Revision:  3.02    
Standards:
	Supported: 2 1 
	Likely used: 4
Configuration:
	Logical		max	current
	cylinders	6253	6253
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:    6303024
	LBA    user addressable sectors:    6303024
	device size with M = 1024*1024:        3077 MBytes
	device size with M = 1000*1000:        3227 MBytes (3 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	Buffer size: 128.0kB	bytes avail on r/w long: 4	Queue depth: 1
	Standby timer values: spec'd by Vendor
	R/W multiple sector transfer: Max = 16	Current = 0
	DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=383ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
		Power Management feature set
		SMART feature set


This hard drive is from 1996/1997; it is the original hard drive I built
this machine with. The 'Standards' line above looks odd - a clue
perhaps?

The second hard drive I added about 3 years ago. Here is info on it:

$ hdparm -I /dev/hdc

/dev/hdc:

ATA device, with non-removable media
	Model Number:       FUJITSU MPD3084AT                       
	Serial Number:      05043987
	Firmware Revision:  DD-03-47
Standards:
	Supported: 4 3 2 1 
	Likely used: 4
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:   16514064
	device size with M = 1024*1024:        8063 MBytes
	device size with M = 1000*1000:        8455 MBytes (8 GB)
Capabilities:
	LBA, IORDY(cannot be disabled)
	Buffer size: 512.0kB	bytes avail on r/w long: 4	Queue depth: 1
	Standby timer values: spec'd by Vendor
	R/W multiple sector transfer: Max = 16	Current = ?
	Advanced power management level: unknown setting (0x0000)
	DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
		READ BUFFER cmd
		WRITE BUFFER cmd
		Host Protected Area feature set
	   *	Look-ahead
	   *	Write cache
		Power Management feature set
		Security Mode feature set
	   *	SMART feature set
		Advanced Power Management feature set
Security: 
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
	not	supported: enhanced erase
	24min for SECURITY ERASE UNIT. 

If the hard drives seem to be alright, maybe there is some sort of BIOS
thing I should try? I've poked around in the BIOS setup numerous times
but never found anything that I could change and make things work.

Art Haas

-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
