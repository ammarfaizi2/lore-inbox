Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbWATMkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbWATMkF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 07:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWATMkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 07:40:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:4053 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750884AbWATMkD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 07:40:03 -0500
Message-ID: <43D0D998.4090605@redhat.com>
Date: Fri, 20 Jan 2006 07:37:44 -0500
From: Larry Woodman <lwoodman@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andy Chittenden <AChittenden@bluearc.com>
CC: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Out of Memory: Killed process 16498 (java).
References: <89E85E0168AD994693B574C80EDB9C27035560E4@uk-email.terastack.bluearc.com>
In-Reply-To: <89E85E0168AD994693B574C80EDB9C27035560E4@uk-email.terastack.bluearc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Chittenden wrote:

>>Andy, what are
>>you running that uses SG_IO - cd ripping, burning, something else?
>>    
>>
>
>I'm sorry but I haven't a clue what uses SG_IO! All I did was boot up a
>debian unstable machine on my amd64 machine that uses 2.6.15. I log in
>via gdm and get a gnome session so I guess that's using nautilus (I've
>seen that killed in the past). I use the sawfish window manager and
>start up 7 rxvt windows and that java app I mentioned (terminator) (I
>suspect that's a red herring as other processes have been killed).
>
>  
>
for starters you should probably change build_zonelists so that the DMA 
zone is
not included in any of the zone lists except the DMA.  This will prevent 
__alloc_pages()
from exhausting the hignmem/normal zones then falling into the DMA zone 
and exhausting
that with non-reclamable memory like the slabcache.

--- linux-2.6.9/mm/page_alloc.c.orig
+++ linux-2.6.9/mm/page_alloc.c
@@ -1170,6 +1170,9 @@ static int __init build_zonelists_node(p
                zone = pgdat->node_zones + ZONE_NORMAL;
                if (zone->present_pages)
                        zonelist->zones[j++] = zone;
+#if defined(CONFIG_HIGHMEM64G) || defined(CONFIG_X86_64)
+               break;
+#endif
        case ZONE_DMA:
                zone = pgdat->node_zones + ZONE_DMA;
                if (zone->present_pages)
~



