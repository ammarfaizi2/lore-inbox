Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283409AbRK2Vnz>; Thu, 29 Nov 2001 16:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283410AbRK2Vnp>; Thu, 29 Nov 2001 16:43:45 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:2211 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S283409AbRK2Vni>;
	Thu, 29 Nov 2001 16:43:38 -0500
Date: Thu, 29 Nov 2001 22:42:57 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Andrew Morton <akpm@zip.com.au>
cc: war war <war@starband.net>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.16 & Heavy I/O
In-Reply-To: <3C0677FB.88AE4196@zip.com.au>
Message-ID: <Pine.LNX.4.21.0111292229270.26505-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2001, Andrew Morton wrote:

[snip]
> In current kernels, with your sort of workload, it appears that
> all IO is being initiated by method 2.  It also appears that
> method 2 simply doesn't do it very well - I've earlier observed
> that simply writing a 650 megabyte chunk of /dev/zero into a
> file runs 30% faster on ext3 than on ext2.  Because ext2 uses
> method 2, and it should be using method 1, and ext3 uses, err,
> method 4.

I too are seeing this and can't remember seeing it so clearly in the past
as I do now. I've seen it in 2.4.10-ac12 and 2.4.15-pre7 and
2.4.16+your_patch_for_reads_while_writing.

I recently backuped my /home on a friends machine and then reformatted my
partition from reiserfs to ext3 and then put all the data back.
When I did this I saw this behaviour very clearly. I have quite a lot of
'vmstat 1' output that shows that the machine is recieving a lot of data
but not writing anything out, this is completely fine, but when the
diskoutput begins the networkinput stops and only continues after the
writeout is complete. There are variations to how much it stalls but it
always stalls for some time, sometimes a short while and sometimes until
the buffer is empty and then the story begins all over again.

the disk can sustain >30MB/s output and the network is 100Mbit/s so it a
maximum of 10-11MB/s in.

I sent the 'vmstat 1' output to Rik van Riel and the response I got on irc
was something like "ouch! Spikey!". he didn't think it should work like
this either. To me it seems that the writeout starts to late or that no
new data is put into the buffer while it's beeing emptied.

> Are you inclined to try a patch, and let us know if the result
> is better? (coz if you don't nothing will happen!)

I'll try this tomorrow and give you a full report with vmstat output and
slabinfo/meminfo and whatever more you might want.

> http://www.zip.com.au/~akpm/linux/2.4/2.4.17-pre1/vm-fixes.patch
> 
> It causes writeout to be initiated via the dirty buffer LRU, not the
> inactive list.
> 
> Also,
> 
> http://www.zip.com.au/~akpm/linux/2.4/2.4.17-pre1/elevator.patch
> 
> It lets you read data from the disk when writes are happening.

I'll try with 2.4.17-pre1 + your patches.

All my tests will be done on ext3 filesystems.

/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.

