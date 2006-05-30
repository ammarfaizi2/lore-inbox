Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbWE3Tzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbWE3Tzx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 15:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWE3Tzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 15:55:53 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:43989 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932452AbWE3Tzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 15:55:52 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <447CA301.5000802@s5r6.in-berlin.de>
Date: Tue, 30 May 2006 21:54:41 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] Fix broken suspend/resume in ohci1394 (Was: ACPI
 suspend problems revisited)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.885) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote to lkml on 2006-05-22:
(full quote for linux1394-devel)
> I've been experimenting to track down the cause of suspend/resume
> problems on my Compaq Presario X1050 laptop:
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=6075
> 
> Essentially the ACPI Embedded Controller and keyboard controller would
> get into a bizarre, confused state after resume.
> 
> I found that unloading the ohci1394 module before suspend and reloading
> it after resume made the problem go away. Diffing the dmesg output from
> resume, with and without the module loaded, I found that with the module
> loaded I was missing these:
> 
> PM: Writing back config space on device 0000:02:00.0 at offset 1. (Was 2100080, writing 2100007)
> PM: Writing back config space on device 0000:02:00.0 at offset 3. (Was 0, writing 8008)
> PM: Writing back config space on device 0000:02:00.0 at offset 4. (Was 0, writing 90200000)
> PM: Writing back config space on device 0000:02:00.0 at offset 5. (Was 1, writing 2401)
> PM: Writing back config space on device 0000:02:00.0 at offset f. (Was 20000100, writing 2000010a)
> The default PCI driver performs the pci_restore_state when no driver is
> loaded for the device. When the ohci1394 driver is loaded, it is
> supposed to do this, however it appears not to do so.
> 
> I created the patch below and tested it, and it appears to resolve the
> suspend problems I was having with the module loaded. I only added in
> the pci_save_state and pci_restore_state - however, though I know little
> of this hardware, surely the driver should really be doing more than
> this when suspending and resuming? Currently it does almost nothing,
> what if there are commands in progress, etc? As such this is just an RFC.

Thanks, this is at least a start. Apart from the code for PPC 
Macintoshs, ohci1394 does indeed lack any suspend/resume handling. I 
don't know anything about this matter, however the OHCI spec (gratis 
available, linked from www.linux1394.org) table A-11 on page 168 says 
which losses of configuration result from what power state transitions: 
Interrupts are masked when going into D1. IEEE 1394 configuration is 
lost when going into D2. PCI configuration is lost when going into D3. 
Since we don't handle this yet, a suspend/resume cycle results at least 
in loss of FireWire connectivity.

As you may have guessed, this problem is basically as old as the driver. 
Nobody is actively working on it AFAIK. (Except that I dusted off an old 
notebook and put a fresh Linux distro on it --- with the plan check 
power management and hot ejection handling by ohci1394... later this 
year...)

> Don't ask me why the failure to save/restore the state of the 1394
> controller messes with the keyboard/EC controller, but it apparently does..
> 
> Signed-off-by: Robert Hancock <hancockr@shaw.ca>
> 
> (Patch attached to stop Thunderbird from destroying it..)
> 
> -- 
> Robert Hancock      Saskatoon, SK, Canada
> To email, remove "nospam" from hancockr@nospamshaw.ca
> Home Page: http://www.roberthancock.com/
> 
> 
> 
> 
> --- linux-2.6.16-1.2208_FC6/drivers/ieee1394/ohci1394.c	2006-05-22 12:34:30.000000000 -0600
> +++ linux-2.6.16-1.2208_FC6ide/drivers/ieee1394/ohci1394.c	2006-05-22 14:56:53.000000000 -0600
> @@ -3539,6 +3539,7 @@ static int ohci1394_pci_resume (struct p
>  	}
>  #endif /* CONFIG_PPC_PMAC */
>  
> +	pci_restore_state(pdev);
>  	pci_enable_device(pdev);
>  
>  	return 0;
> @@ -3558,6 +3559,8 @@ static int ohci1394_pci_suspend (struct 
>  	}
>  #endif
>  
> +	pci_save_state(pdev);
> +
>  	return 0;
>  }
>  

-- 
Stefan Richter
-=====-=-==- -=-= ====-
http://arcgraph.de/sr/
