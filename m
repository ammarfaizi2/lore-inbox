Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313657AbSDPJXv>; Tue, 16 Apr 2002 05:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313658AbSDPJXu>; Tue, 16 Apr 2002 05:23:50 -0400
Received: from [195.63.194.11] ([195.63.194.11]:62215 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313657AbSDPJXs>; Tue, 16 Apr 2002 05:23:48 -0400
Message-ID: <3CBBDF0E.4050605@evision-ventures.com>
Date: Tue, 16 Apr 2002 10:21:34 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Norbert Kiesel <nkiesel@tbdnetworks.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.8 IDE 36
In-Reply-To: <200204160909.g3G99vEK025678@enterprise.tbdnetworks.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norbert Kiesel wrote:
> Hi,
> 
> while trying to understand recent kernel changes I stumbled over
> the following patch to
>  
> diff -urN linux-2.5.8/drivers/ide/ide.c linux/drivers/ide/ide.c
> --- linux-2.5.8/drivers/ide/ide.c	Tue Apr 16 06:01:07 2002
> +++ linux/drivers/ide/ide.c	Tue Apr 16 05:38:37 2002
> 
> ...
>  while (i > 0) {
> -		u32 buffer[16];
> -		unsigned int wcount = (i > 16) ? 16 : i;
> -		i -= wcount;
> -		ata_input_data (drive, buffer, wcount);
> +		u32 buffer[SECTOR_WORDS];
> +		unsigned int count = (i > 1) ? 1 : i;
> +
> +		ata_read(drive, buffer, count * SECTOR_WORDS);
> +		i -= count;
>  	}
>  }
> ...
> 
> While the old code called ata_input_read() with [0:16] as last param,
> the new code calls the (renamed) ata_read() with either 0 or 16. Also,
> the new code loops "i" times while the old code looped "i/16+1" times.
> Was this intended or should the patch better read like:
> 
> ...
>  while (i > 0) {
> -               u32 buffer[16];
> -               unsigned int wcount = (i > 16) ? 16 : i;
> -               i -= wcount;
> -               ata_input_data (drive, buffer, wcount);
> +               u32 buffer[SECTOR_WORDS];
> +               unsigned int count = max(i, SECTOR_WORDS);
> +
> +               ata_read(drive, buffer, count);
> +               i -= count;
>         }
>  }
> ...
> 
> so long

It's fine as it is I think. Please look up at the initialization of i.
I have just divded the SECTROT_WORDS (== 16) factor out
of all the places above ata_read.

