Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265537AbSKTCD6>; Tue, 19 Nov 2002 21:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265567AbSKTCD6>; Tue, 19 Nov 2002 21:03:58 -0500
Received: from imrelay-2.zambeel.com ([209.240.48.8]:45580 "EHLO
	imrelay-2.zambeel.com") by vger.kernel.org with ESMTP
	id <S265537AbSKTCD5>; Tue, 19 Nov 2002 21:03:57 -0500
Message-ID: <233C89823A37714D95B1A891DE3BCE5202AB1958@xch-a.win.zambeel.com>
From: Manish Lachwani <manish@Zambeel.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       Miguel S Filipe <m3thos@netcabo.pt>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Disk Performance Issues [AMD Viper plus IDE chipset problems.
	 (wrong udma "autodetection")]
Date: Tue, 19 Nov 2002 18:10:46 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have noticed something with the IDE drivers especially with the Seagate
drives. The promise driver (eg 20277) detects the UDMA 5 mode correctly.

This is what it does:

        byte ultra_66           = ((id->dma_ultra & 0x0010) ||
                                   (id->dma_ultra & 0x0008)) ? 1 : 0;
        byte ultra_100          = ((id->dma_ultra & 0x0020) ||
                                   (ultra_66)) ? 1 : 0;
        byte ultra_133          = ((id->dma_ultra & 0x0040) ||
                                   (ultra_100)) ? 1 : 0;

Now, lets take a PIIX driver

	 int ultra100            = ((dev->device ==
PCI_DEVICE_ID_INTEL_82801BA_8) ||
                                   (dev->device ==
PCI_DEVICE_ID_INTEL_82801BA_9) ||
                                   (dev->device ==
PCI_DEVICE_ID_INTEL_82801CA_10)) ? 1 : 0;
        int ultra66             = ((ultra100) ||
                                   (dev->device ==
PCI_DEVICE_ID_INTEL_82801AA_1) ||
                                   (dev->device ==
PCI_DEVICE_ID_INTEL_82372FB_1)) ? 1 : 0;

        if ((id->dma_ultra & 0x0020) && (udma_66) && (ultra100)) {
                speed = XFER_UDMA_5;

where ultra100 and ultra66 is not or'ed with 0x0010 and 0x0008. The final
check is only with 0x0020. I have found this issues with other IDE drivers
like amd74xx.c, serverworks.c etc. SO, make the above changes in the drivers
and u should see UDMA 5 on those seagate drives on startup ...

Thanks
Manish


-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Saturday, November 16, 2002 3:34 PM
To: Miguel S Filipe
Cc: Linux Kernel Mailing List
Subject: Re: Disk Performance Issues [AMD Viper plus IDE chipset
problems. (wrong udma "autodetection")]


On Sat, 2002-11-16 at 20:19, Miguel S Filipe wrote:
> Hello there,
> 
>   I'm sending this email about a problem with udma settings
> in a TigerMP motherboard, wich supports UDMA 100.
>   I've send it to my distribution mailing list, and several others, to no
> avail, so, has a last resort I send it now to the Linux ML.
>   I'm using pure vanilla linux-2.4.19, and I tried all possible configs
> settings that I though that could affect this problem.

If I remember rightly 2.4.19 doesnt have full support for the AMD
760MP/X although 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
