Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268391AbTGLU1X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 16:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268419AbTGLU1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 16:27:23 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:9747 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268391AbTGLU1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 16:27:20 -0400
Message-ID: <3F10729F.7070701@sbcglobal.net>
Date: Sat, 12 Jul 2003 15:42:07 -0500
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: reiserfs-list@namesys.com
Subject: Re: FS Corruption with VIA MVP3 + UDMA/DMA
References: <16128.19218.139117.293393@charged.uio.no> <3F007EBF.9020506@sbcglobal.net>
In-Reply-To: <3F007EBF.9020506@sbcglobal.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the suggestions, here's what I've tried to solve the problem:
-->Tested system memory for 4 consecutive days with memtest86
-->Replaced SDRAM with new modules tested in every DIMM slot
-->Tried the ac patch on 2.5.69
-->Clocked K6-2 back to 350 from 400 (FSB still 100Mhz)
-->Played with PCI settings in the BIOS
-->Removed all other cards except AGP video card
-->Disabled all other integrated peripherals in the BIOS (only serial 
and parallel in this case).
-->Reverted to BIOS defaults.

None of this has solved the problem so I've disabled the onboard IDE and 
replaced it with another promise card.  I have not changed anything but 
adding another card and moving the drives over using the same cables.  
Yet my corruption problems are gone.  My other PCI cards work fine, so I 
don't think it's a PCI busmaster problem (that would affect my promise, 
3com, and NEC PCI cards too, correct?).  I can't see any other cause 
except for a defective IDE controller implementation (either by VIA or 
board design).

I've received one response from a person with an FIC VA503+ that worked 
and another (same chipset, unknown model) who has the same problem.  I 
imagine there are quite a few people that have fallen victim to this 
problem but they just didn't know the cause of the instability.

I don't know what the solution is (if there is one), but something 
should be done to at least warn people of the chance of problems...IMO.

At least someone trying Linux for the first time won't get too bad an 
impression since reiserfs at least seems to endure the damage much 
better (and longer) than NTFS or FAT32.  Still, sucks to have to rebuild 
the tree and restore corrupted files every couple weeks.

-Wes-

Wes Janzen wrote:

> I was wondering if anyone knows about this issue or has had this problem?
>
> I've been fighting FS corruption since switching to a UDMA hard drive 
> (Maxtor) on my FIC PA2013 with the VIA MVP3, but I didn't really know 
> that since the change was a result of a dying drive.  Finally, through 
> the chance of having installed an older Quantum drive that only 
> allowed DMA MultiMode 2 as the fastest mode, I found the problem.
> At least on my board, the IDE UDMA/DMA implementation appears flawed 
> [lspci gives: "VT82C586/B/686A/B PI (rev 6)"].  I've had the same 
> problem with three UDMA DVD drives -- two Toshibas and a Pioneer.  
> They would all lock-up installing software or corrupt the data being 
> installed causing the installation to fail.  I've also had four other 
> Maxtor hard drives (3 factory certified, one retail) randomly corrupt 
> content on the drives (fs type doesn't matter [NTFS, FAT, FAT32, EXT2, 
> REISERFS have been tried]).  That means that every UDMA drive I've 
> plugged in has had data corruption issues (trying no less than 10 IDE 
> cables, which I confirmed good on the Promise and I've tried both IDE 
> channels on the MVP3).  I started with Linux kernel version 2.2 and 
> the problem remains up to 2.5.73.  I've also confirmed the issue in 
> Windows 98SE, Windows XP and Windows 2003 RC2.  At this point, one 
> might as well stick in a PCI adapter, since with "hdparm -t" I get 
> between 5.5-8.5 MB/s.  With the same mode on my Promise 20269 I get 12 
> MB/s , so clearly something is odd.  I know the hard drive can do 
> better since I can get 20MB/s in UDMA 2 on the MVP3, but of course 
> that's not safe.
>
> Even at DMA multiword 2, I can force r/w errors by heavy io.  Moving 
> to DMA mode 1 clears up the errors, but performance degrades to a 
> consistent 5.49 MB/s (all the higher modes actually vary 2-6 MB/s 
> between runs of hdparm) while the Promise in the same mode still gets 
> 12 MB/s consistently.  I've found that copying a 300 MB file to my 
> drive on the Promise, making 12 new files while making 12 duplicates 
> to the drive on the MVP3 can still force errors in dma multiword 2.  I 
> check for write errors by comparing the copied files to the source 
> file.  It's much easier to create errors in any of the UDMA modes.  
> Errors actually seem more likely to occur during actual use of the 
> system since they are fairly common even in multiword 2, but the 
> copying method makes it extremely repeatable (though not all the files 
> are corrupted, that part's random).
>
> My current configuration has the Promise as the boot device with a 
> single drive on the primary.  I have my DVD (UDMA) on the secondary of 
> the Promise.  My other Maxtor hard drive is on the primary channel 
> (alone) of the MVP3 with UDMA disabled in the bios (and thus not used 
> by WinXP/2003 or Linux).  Finally my cd writer and IDE Zip are on the 
> secondary channel of the MVP3.  I'd put my hard drive on the secondary 
> channel of the Promise, but for some reason the computer won't boot 
> with both hard drives on the Promise (even though they're on different 
> cables)...  I don't remember right now if it just locks up during OS 
> loading or if it won't post.  I can test it if that information is 
> required.
>
> Otherwise my machine is fairly stable (3+weeks, but I usually have to 
> boot to Windows for Illustrator and such before then) and I don't get 
> any corruption when copying files around on my Promise controller.  I 
> can get errors even copying from my MVP3 drive to itself (making 
> defragging dangerous on my shared FAT32 partition) even in DMA 
> multiword 2.
>
> Is there anything that can be done with the IDE drivers for this 
> chipset to make it "safe" without resorting to forcing DMA mode 1?
>
> Thanks,
> Wes Janzen
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

