Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311670AbSC2Tnc>; Fri, 29 Mar 2002 14:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311701AbSC2TnX>; Fri, 29 Mar 2002 14:43:23 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:57607
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S311670AbSC2TnD>; Fri, 29 Mar 2002 14:43:03 -0500
Date: Fri, 29 Mar 2002 11:42:04 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre4-ac[23] do not boot
In-Reply-To: <E16qz6l-0001Ud-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10203291137220.10681-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2002, Alan Cox wrote:

> > 2.4.19-pre4-ac[23] does not boot. I've not tested ac1 but vanilla pre4
> > works.
> 
> Can you try backing out the following two changes, one at a time. These are
> the only ALi specific changes. So firstly I want to see if its an ALi or
> core IDE bug
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.19p4/drivers/ide/alim15x3.c linux.19pre4-ac3/drivers/ide/alim15x3.c
> --- linux.19p4/drivers/ide/alim15x3.c	Mon Mar 25 17:47:11 2002
> +++ linux.19pre4-ac3/drivers/ide/alim15x3.c	Tue Mar 26 18:36:23 2002
> @@ -248,7 +248,7 @@
>  	byte s_clc, a_clc, r_clc;
>  	unsigned long flags;
>  	int bus_speed = system_bus_clock();
> -	int port = hwif->index ? 0x5c : 0x58;
> +	int port = hwif->channel ? 0x5c : 0x58;
>  	int portFIFO = hwif->channel ? 0x55 : 0x54;
>  	byte cd_dma_fifo = 0;
>  
> @@ -442,6 +442,8 @@
>  	ide_dma_action_t dma_func	= ide_dma_on;
>  	byte can_ultra_dma		= ali15x3_can_ultra(drive);
>  
> +	(void) config_chipset_for_pio(drive);
> +	

This is possible, however one of the problems encountered is the
following under several chipsets.  If there is no pio timing set at all,
then we can run into host lock issues if the driver drops out of dma.
Thus, if it is going to lockup here it would/could lock up in other
places when one trys to program the host for PIO.

Regardsless this is bad, in one direction or another.

>  	if ((m5229_revision<=0x20) && (drive->media!=ide_disk))
>  		return hwif->dmaproc(ide_dma_off_quietly, drive);
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

