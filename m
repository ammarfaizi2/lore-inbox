Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130683AbRC0H0x>; Tue, 27 Mar 2001 02:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130685AbRC0H0n>; Tue, 27 Mar 2001 02:26:43 -0500
Received: from [12.14.232.16] ([12.14.232.16]:15432 "EHLO c4.tant.com")
	by vger.kernel.org with ESMTP id <S130683AbRC0H0b>;
	Tue, 27 Mar 2001 02:26:31 -0500
From: "Richard Smith" <ras2@tant.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Tue, 27 Mar 2001 01:25:18 -0600
Reply-To: "Richard Smith" <ras2@tant.com>
X-Mailer: PMMail 2000 Professional (2.10.2010) For Windows 95 (4.0.1212)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Compact flash disk and slave drives in 2.4.2
Message-Id: <E14hnqw-0006sU-00@c4.tant.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I spent most of the day today trying to track down why the embedded system I am working 
on would not recognize hdb on boot.  It refused to show in the devices list even though I 
specifically told the kernel it existed with the hdb=c,h,s option.

After working on what seemed like a hardware problem for quite a while I finally decided 
that there must be something flaky in the ide driver code and began to add some debug 
printk's

In which I found the following in ide.c:

/*
 * CompactFlash cards and their brethern pretend to be removable hard disks,
 * except:
 *      (1) they never have a slave unit, and
 *      (2) they don't have doorlock mechanisms.
 * This test catches them, and is invoked elsewhere when setting appropriate
 * config bits.
 *
*/

Since hda in my system is a CompactFlash card I began to look further and then with some 
discovered the following in ide-probe.c

        /*
         * Prevent long system lockup probing later for non-existant
         * slave drive if the hwif is actually a flash memory card of some variety:
         */
        if (drive_is_flashcard(drive)) {
                ide_drive_t *mate = &HWIF(drive)->drives[1^drive->select.b.unit];
                if (!mate->ata_flash) {
                        mate->present = 0;
                ide_drive_t *mate = &HWIF(drive)->drives[1^drive->select.b.unit]
                        mate->noprobe = 1;
                }
        }

Now perhaps I am just way out on the wacky edge of things but I don't agree with the 
above in the slightest.  We use CF's in conjunction with slaves all the time.  Almost all 
of our embedded devices boot from CF's and I routinely add a HD as a slave to the system 
to do developement with but it's always been under DOS.  

I comment out the check above and all is well... hdb shows up as expected.   

Can someone explain to me why the above check was added and if its continued existence is 
necessary?  Whats this long system lockup thing mentioned?

Even if there is some danger of a long lockup I suggest that at least a message that its 
ignoring hdb is the least it could do rather than sliently ignoreing it.  Especially when 
I specifically told it a hdb existed via the command line.  Shouldn't command line 
parameters take precidence?  

I not subscribed to the kernel-list so please copy me in the response.

Thanks.


--
Richard A. Smith    ras2@tant.com 
"I'd hang out with science kids - they can blow things up!
 I mean, what's cooler than that?"
                                                   - Tori Amos


