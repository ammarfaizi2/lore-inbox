Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131309AbRC0OXD>; Tue, 27 Mar 2001 09:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131316AbRC0OWx>; Tue, 27 Mar 2001 09:22:53 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:9430 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S131309AbRC0OWn>; Tue, 27 Mar 2001 09:22:43 -0500
Message-ID: <3AC0A1C7.3040408@AnteFacto.com>
Date: Tue, 27 Mar 2001 15:20:55 +0100
From: Padraig Brady <Padraig@AnteFacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-ac4 i686; en-US; 0.8.1) Gecko/20010326
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Smith <ras2@tant.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Compact flash disk and slave drives in 2.4.2
In-Reply-To: <E14hnqw-0006sU-00@c4.tant.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can I just confirm that I'm seeing the same thing.
I'm using a pcengines compact flash adapter which has
a master/slave jumper, and this seems to confirm what
I thought, I.E. slaves are OK. Note I also had trouble where
HD was master and flashdisk was slave, where again the
CF was silently ignored.

Padraig.

Richard Smith wrote:

> I spent most of the day today trying to track down why the embedded system I am working 
> on would not recognize hdb on boot.  It refused to show in the devices list even though I 
> specifically told the kernel it existed with the hdb=c,h,s option.
> 
> After working on what seemed like a hardware problem for quite a while I finally decided 
> that there must be something flaky in the ide driver code and began to add some debug 
> printk's
> 
> In which I found the following in ide.c:
> 
> /*
>  * CompactFlash cards and their brethern pretend to be removable hard disks,
>  * except:
>  *      (1) they never have a slave unit, and
>  *      (2) they don't have doorlock mechanisms.
>  * This test catches them, and is invoked elsewhere when setting appropriate
>  * config bits.
>  *
> */
> 
> Since hda in my system is a CompactFlash card I began to look further and then with some 
> discovered the following in ide-probe.c
> 
>         /*
>          * Prevent long system lockup probing later for non-existant
>          * slave drive if the hwif is actually a flash memory card of some variety:
>          */
>         if (drive_is_flashcard(drive)) {
>                 ide_drive_t *mate = &HWIF(drive)->drives[1^drive->select.b.unit];
>                 if (!mate->ata_flash) {
>                         mate->present = 0;
>                 ide_drive_t *mate = &HWIF(drive)->drives[1^drive->select.b.unit]
>                         mate->noprobe = 1;
>                 }
>         }
> 
> Now perhaps I am just way out on the wacky edge of things but I don't agree with the 
> above in the slightest.  We use CF's in conjunction with slaves all the time.  Almost all 
> of our embedded devices boot from CF's and I routinely add a HD as a slave to the system 
> to do developement with but it's always been under DOS.  
> 
> I comment out the check above and all is well... hdb shows up as expected.   
> 
> Can someone explain to me why the above check was added and if its continued existence is 
> necessary?  Whats this long system lockup thing mentioned?
> 
> Even if there is some danger of a long lockup I suggest that at least a message that its 
> ignoring hdb is the least it could do rather than sliently ignoreing it.  Especially when 
> I specifically told it a hdb existed via the command line.  Shouldn't command line 
> parameters take precidence?  
> 
> I not subscribed to the kernel-list so please copy me in the response.
> 
> Thanks.
> 
> 
> --
> Richard A. Smith    ras2@tant.com 
> "I'd hang out with science kids - they can blow things up!
>  I mean, what's cooler than that?"
>                                                    - Tori Amos
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

