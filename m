Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265769AbUAKFhP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 00:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265775AbUAKFhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 00:37:15 -0500
Received: from smtpq3.home.nl ([213.51.128.198]:13539 "EHLO smtpq3.home.nl")
	by vger.kernel.org with ESMTP id S265769AbUAKFhH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 00:37:07 -0500
Message-ID: <4000E030.2020500@keyaccess.nl>
Date: Sun, 11 Jan 2004 06:33:36 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031029
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Santiago Garcia Mantinan <manty@manty.net>
CC: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org,
       Adam Belay <ambx1@neo.rr.com>
Subject: [PATCH] Re: ALSA in 2.6 failing to find the OPL chip of the sb cards
References: <20040107212916.GA978@man.manty.net> <s5hy8sixsor.wl@alsa2.suse.de> <20040109171715.GA933@man.manty.net> <s5hn08xgh06.wl@alsa2.suse.de> <20040109201423.GA1677@man.manty.net> <3FFFA8C3.6040609@keyaccess.nl>
In-Reply-To: <3FFFA8C3.6040609@keyaccess.nl>
Content-Type: multipart/mixed;
 boundary="------------060601040501000308090309"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060601040501000308090309
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Rene Herman wrote:

NOTE: I seem unable to contact Adam Belay; his ISP is not accepting mail 
from mine. Takashi, if you agree attached patch is a correct fix, could 
you relay it to Adam?

>> ALSA sound/drivers/opl3/opl3_lib.c:444: OPL2/3 chip not detected at 
>> 0x388/0x38a
>> ALSA sound/isa/sb/sb16.c:484: sb16: no OPL device at 0x388-0x38a
>>
>> I think I have already said that in 2.4 it works, and I have tested both
>> alsa in the kernel plus alsa sources downloaded from alsa-project, 
>> this last
>> one works in 2.4 but doesn't work in 2.6.
> 
> I'm seeing the same behaviour with a Sound Blaster AWE64 Gold. It seems 
> it's not an ALSA problem though, but ISA-PnP.

Assuming ALSA isn't misusing the PnP API, it's indeed not ALSA, but PnP.

It also isn't actually an OPL3 issue, but MPU401. Trouble is that sb16.c 
doesn't set mpu_port to SNDRV_DEFAULT_PORT, but hardcodes the values for 
the first two cards as 0x330 and 0x300 (Takashi: why is that, by the 
way? At least for ISA-PnP cards SNDRV_DEFAULT_PORT would seem better?). 
This causes the initialisation code to call pnp_resource_change() for 
the MPU port resource, which clears IORESOURCE_AUTO for that resource.

The rest of the PnP layer, seeing IORESOURCE_AUTO clear, then never 
touches that resource again, but at that point IORESOURCE_IO (indicating 
an I/O port resource) hasn't yet been set, so that when it later gets to 
isapnp_set_resources(), that function bails out believing it has reached 
the end of the I/O port resources for the device. Since SB is resource 
0, MPU401 resource 1 and OPL3 resource 2 for the device, only SB gets 
enabled, MPU401 and OPL3 do not.

Making sure IORESOURCE_IO gets set fixes it. Having 
pnp_init_resource_table() do this seems proper.

The attached patch works for me:

rene@7ixe4:~$ sbiload -l
  Port     Client name                       Port name
  64:0     Rawmidi 0 - MPU-401 (UART) 0-0    MPU-401 (UART) 0-0
  65:0     Emu8000 WaveTable                 Emu8000 Port 0
  65:1     Emu8000 WaveTable                 Emu8000 Port 1
  65:2     Emu8000 WaveTable                 Emu8000 Port 2
  65:3     Emu8000 WaveTable                 Emu8000 Port 3
  66:0     OPL3 FM synth                     OPL3 FM Port

Rene.

--------------060601040501000308090309
Content-Type: text/plain;
 name="linux-2.6.1_pnp_resource.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.1_pnp_resource.diff"

--- linux-2.6.1/drivers/pnp/manager.c.orig	2004-01-11 05:32:34.000000000 +0100
+++ linux-2.6.1/drivers/pnp/manager.c	2004-01-11 05:15:36.000000000 +0100
@@ -223,25 +223,25 @@
 		table->irq_resource[idx].name = NULL;
 		table->irq_resource[idx].start = -1;
 		table->irq_resource[idx].end = -1;
-		table->irq_resource[idx].flags = IORESOURCE_AUTO | IORESOURCE_UNSET;
+		table->irq_resource[idx].flags = IORESOURCE_AUTO | IORESOURCE_UNSET | IORESOURCE_IRQ;
 	}
 	for (idx = 0; idx < PNP_MAX_DMA; idx++) {
 		table->dma_resource[idx].name = NULL;
 		table->dma_resource[idx].start = -1;
 		table->dma_resource[idx].end = -1;
-		table->dma_resource[idx].flags = IORESOURCE_AUTO | IORESOURCE_UNSET;
+		table->dma_resource[idx].flags = IORESOURCE_AUTO | IORESOURCE_UNSET | IORESOURCE_DMA;
 	}
 	for (idx = 0; idx < PNP_MAX_PORT; idx++) {
 		table->port_resource[idx].name = NULL;
 		table->port_resource[idx].start = 0;
 		table->port_resource[idx].end = 0;
-		table->port_resource[idx].flags = IORESOURCE_AUTO | IORESOURCE_UNSET;
+		table->port_resource[idx].flags = IORESOURCE_AUTO | IORESOURCE_UNSET | IORESOURCE_IO;
 	}
 	for (idx = 0; idx < PNP_MAX_MEM; idx++) {
 		table->mem_resource[idx].name = NULL;
 		table->mem_resource[idx].start = 0;
 		table->mem_resource[idx].end = 0;
-		table->mem_resource[idx].flags = IORESOURCE_AUTO | IORESOURCE_UNSET;
+		table->mem_resource[idx].flags = IORESOURCE_AUTO | IORESOURCE_UNSET | IORESOURCE_MEM;
 	}
 }
 

--------------060601040501000308090309--

