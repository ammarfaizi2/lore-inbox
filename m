Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267594AbRGNInM>; Sat, 14 Jul 2001 04:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267597AbRGNInA>; Sat, 14 Jul 2001 04:43:00 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:43532 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S267594AbRGNImr>; Sat, 14 Jul 2001 04:42:47 -0400
Date: Sat, 14 Jul 2001 04:11:21 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Rik van Riel <riel@conectiva.com.br>, Dirk Wetter <dirkw@rentec.com>,
        Mike Galbraith <mikeg@wen-online.de>, linux-mm@kvack.org,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [PATCH] Separate global/perzone inactive/free shortage 
In-Reply-To: <Pine.LNX.4.21.0107140204110.4153-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0107140409200.4446-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



There is a silly typo on the patch. 


On Sat, 14 Jul 2001, Marcelo Tosatti wrote:

> 
> Hi,
> 
> As well known, the VM does not make a distiction between global and
> per-zone shortages when trying to free memory. That means if only a given
> memory zone is under shortage, the kernel will scan pages from all zones. 
> 
> The following patch (against 2.4.6-ac2), changes the kernel behaviour to
> avoid freeing pages from zones which do not have an inactive and/or
> free shortage.
> 
> Now I'm able to run memory hogs allocating 4GB of memory (on 4GB machine)
> without getting real long hangs on my ssh session. (which used to happen
> on stock -ac2 due to exhaustion of DMA pages for networking).
> 
> Comments ? 
> 
> Dirk, Can you please try the patch and tell us if it fixes your problem ? 
> 
> 

mm/vmscan.c diff 

> @@ -574,8 +593,13 @@
>  			 * If we're freeing buffer cache pages, stop when
>  			 * we've got enough free memory.
>  			 */
> -			if (freed_page && !free_shortage())
> -				break;
> +			if (freed_page) {
> +				if (zone) {
> +					if (!zone_free_shortage(zone))
> +						break;
> +				} else if (free_shortage()) 
					  ^^^^^^^^ ^^^^^^ 
Should be 
				} else if (!free_shortage())


> +					break;
> +			}
>  			continue;


Well, updated patch at
http://bazar.conectiva.com.br/~marcelo/patches/v2.4/2.4.6ac2/zoned.patch

