Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266912AbUHDAhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266912AbUHDAhK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 20:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266905AbUHDAhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 20:37:09 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:12138 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266912AbUHDAhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 20:37:01 -0400
Message-ID: <41102FAB.40701@yahoo.com>
Date: Tue, 03 Aug 2004 20:36:59 -0400
From: "David N. Arnold" <dnarnold@yahoo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: David Ford <david+challenge-response@blue-labs.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       wiggly@wiggly.org, matt@mattcaron.net, seymour@astro.utoronto.ca
Subject: Re: cdrom: dropping to single frame dma
References: <41040A4B.6080703@blue-labs.org> <20040802132457.GT10496@suse.de>
In-Reply-To: <20040802132457.GT10496@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Sun, Jul 25 2004, David Ford wrote:
> 
>>I've been trying to rip my CDs onto my HD, and last night after about 7 
>>CDs I realized I was getting junk and it was taking forever to rip a 
>>CD.  I'm using 2.6.8-rc2 and I have two different CD-ROMs in my 
>>machine.  Both are burners.
>>
>>I got a single "cdrom: dropping to single frame dma" message which 
>>according to my research is part of the culprit.
>>
>>See the thread on LKML back on 5/15/2004 titled "dma ripping", and again 
>>on 6/15 titled "cdrom ripping / dropping to dingle frame dma" -- yes 
>>that's a "d".
>>
>>I'm guessing that Jens' patch for this didn't make it into the kernel.
> 
> 
> Try this.
> 
> --- linux-2.6.8-rc2-mm1/drivers/cdrom/cdrom.c~	2004-08-02 14:56:48.259992912 +0200
> +++ linux-2.6.8-rc2-mm1/drivers/cdrom/cdrom.c	2004-08-02 15:20:58.326549288 +0200
> @@ -2004,6 +2004,8 @@
>  	struct packet_command cgc;
>  	int nr, ret;
>  
> +	cdi->last_sense = 0;
> +
>  	memset(&cgc, 0, sizeof(cgc));
>  
>  	/*
> @@ -2055,6 +2057,8 @@
>  	if (!q)
>  		return -ENXIO;
>  
> +	cdi->last_sense = 0;
> +
>  	while (nframes) {
>  		nr = nframes;
>  		if (cdi->cdda_method == CDDA_BPC_SINGLE)
> @@ -2102,6 +2106,7 @@
>  
>  		nframes -= nr;
>  		lba += nr;
> +		ubuf += len;
>  	}
>  
>  	return ret;
> 

I don't know if it's a result of upgrading to 2.6.8-rc2 (from 2.6.5) or 
from the patch, but it has changed things.  I still get

hdd: DMA timeout retry
hdd: timeout waiting for DMA
hdd: status timeout: status=0xd0 { Busy }
hdd: status timeout: error=0x00
hdd: drive not ready for command
hdd: ATAPI reset complete
cdrom: dropping to single frame dma

but ripping stays at its normal speed (5.0x instead of 0.6x) and the 
file produced is correct instead of skipping/silence.

It doesn't fix the true issue of why I'm getting DMA timeouts, but it 
does make ripping useable.

P.S. Does anyone know why this:

gst-launch-0.8 cdparanoia ! vorbisenc ! filesink location="music.ogg"

would cause a DMA timeout but this:

gst-launch-0.8 cdparanoia ! queue ! { vorbisenc ! filesink 
location="music.ogg" }

wouldn't?

Thanks,
Dave Arnold
