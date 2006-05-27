Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751455AbWE0JfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbWE0JfN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 05:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWE0JfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 05:35:13 -0400
Received: from fep01-0.kolumbus.fi ([193.229.0.41]:9602 "EHLO
	fep01-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S1750745AbWE0JfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 05:35:11 -0400
Date: Sat, 27 May 2006 12:34:54 +0300 (EEST)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: James Lamanna <jlamanna@gmail.com>
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       Mike Christie <michaelc@cs.wisc.edu>,
       Bryan Holty <lgeek@frontiernet.net>
Subject: Re: [OOPS] amrestore dies in kmem_cache_free 2.6.16.18 - cannot
 restore backups!
In-Reply-To: <Pine.LNX.4.63.0605252224450.4178@kai.makisara.local>
Message-ID: <Pine.LNX.4.63.0605271202110.10358@kai.makisara.local>
References: <aa4c40ff0605231824j55c998c3oe427dec2404afba0@mail.gmail.com>
 <Pine.LNX.4.63.0605252224450.4178@kai.makisara.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2006, Kai Makisara wrote:

> I am adding linux-scsi to recipients (and quoting the whole message for 
> readers of that list).
> 
> On Tue, 23 May 2006, James Lamanna wrote:
> 
> > So I was able to recreate this problem on a vanilla 2.6.16.18 with the
> > following oops..
> > I'd say this is a serious regression since I cannot restore backups
> > anymore (I could with 2.6.14.x, but that kernel series had other
> > issues...)
> > 
> > amrestore does manage to read 1 32k block from tape before dying.
> > 
> > Any help would be greatly appreciated.
> > 
> I have tried 'amrestore' on my machine with 2.6.16.18 but was not able to 
> reproduce the problem.

OK. Now I think I have found something, thanks to Mike Christie's reminder 
yesterday in another thread that the patch at the end of this message has 
not been merged into 2.6.16 (and 2.6.17-rcx) ;-)

I did strace amrestore here and found out that the tape buffer addresses 
were not aligned at 512 byte boundaries:

read(0x3, 0x523380, 0x8000)             = 0x8000
read(0x3, 0x51b370, 0x8000)             = 0x8000

This meant that st used the internal driver buffer aligned at page 
boundary as input to scsi_execute_async and the problem fixed by the patch 
did not occur.

(BTW, I hate this. The SCSI HBA would be perfectly capable to do direct 
transfers from/to these addresses but the default alignment restrictions 
prevent this and the HBA driver does not modify the defaults.)

Next I made a test program reading to a buffer with start address I could 
control. When the offset from page boundary was 0 or not a multiple of 
512, no errors occurred. When I set the offset to 512, I got the following 
OOPS (this is from 2.6.17-rc5 with CONFIG_DEBUG_SLAB set but the 
similarity is obvious):

kfree_debugcheck: out of range ptr fffffffffffffff8h.
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at mm/slab.c:2590
invalid opcode: 0000 [1] 
CPU 0 
Modules linked in: st snd_seq snd_pcm_oss snd_mixer_oss w83627hf hwmon_vid 
i2c_isa snd_via82xx snd_ac97_codec snd_ac97_bus snd_pcm snd_timer 
snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd i2c_viapro 
i2c_core ohci1394 ieee1394
Pid: 11174, comm: talign Not tainted 2.6.17-rc5-g705af309 #7
RIP: 0010:[<ffffffff8025dd2a>] <ffffffff8025dd2a>{kfree_debugcheck+70}
RSP: 0018:ffff810011057c68  EFLAGS: 00010096
RAX: 0000000000000039 RBX: fffffffffffffff8 RCX: ffffffff80558f98
RDX: ffff810039dbae60 RSI: 0000000000000046 RDI: ffffffff80558f80
RBP: ffff81003ff991c0 R08: ffffffff80558f98 R09: 0000000000000020
R10: 0000000000000010 R11: 0000000000000010 R12: fffffffffffffff8
R13: 0000000000000246 R14: ffffffff80266d70 R15: ffff8100390f28e0
FS:  00002ba29f0aeb00(0000) GS:ffffffff806c8000(0000) 
knlGS:00000000563b80c0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002ba29eed407b CR3: 000000000cdbb000 CR4: 00000000000006e0
Process talign (pid: 11174, threadinfo ffff810011056000, task 
ffff810039dbae60)
Stack: 0000000000000000 ffffffff8025e634 0000000000000000 ffff81003ff991c0 
       ffff810001fee098 0000000000000246 0000000000000200 ffffffff8025f2a8 
       ffff81003ff991c0 ffff81000b94e8b0 
Call Trace: <ffffffff8025e634>{cache_free_debugcheck+35}
       <ffffffff8025f2a8>{kmem_cache_free+41} 
<ffffffff80266d70>{bio_free+48}
       <ffffffff803fa0e5>{scsi_execute_async+374} 
<ffffffff880edec7>{:st:st_do_scsi+504}
       <ffffffff880ed045>{:st:st_sleep_done+0} 
<ffffffff880ed89e>{:st:setup_buffering+516}
       <ffffffff880f17cd>{:st:st_read+845} 
<ffffffff8022381d>{__wake_up+54}
       <ffffffff80262af3>{vfs_read+168} <ffffffff802634b0>{sys_read+69}
       <ffffffff802095de>{system_call+126}

Code: 0f 0b 68 37 bd 4e 80 c2 1e 0a 48 b8 ff ff ff 7f ff ff ff ff 
RIP <ffffffff8025dd2a>{kfree_debugcheck+70} RSP <ffff810011057c68>


Next thing was to patch 2.6.16.18 with the patch at the end: No more 
oopses with any alignment.

James, does this fix your problem ?

Kai

--------------------------------8<------------------------------------------

Excerpt from a message from Brian Holty to linux-scsi and linux-kernel on
Wed, 22 Mar 2006 06:35:39:

...
Based on above, I think the most intuitive fix would be the offset addition of 
the first entry to the initialization of nr_pages.  

Without this change, for instance, with 4K io's every sg io that is 
dma_aligned for direct io, but not page aligned will cause slab corruption 
and an oops

I am able to run a number of tests with sg that cause the boundary to be 
crossed, and with this fix there is no slab corruption or data corruption.

Thanks Dan, I had been hunting for this for a couple of days!!

Thoughts??

Signed-off-by: Bryan Holty <lgeek@frontiernet.net>

 --- a/drivers/scsi/scsi_lib.c	2006-03-03 13:17:22.000000000 -0600
+++ b/drivers/scsi/scsi_lib.c	2006-03-22 06:09:09.669599539 -0600
@@ -368,7 +368,7 @@
 			   int nsegs, unsigned bufflen, gfp_t gfp)
 {
 	struct request_queue *q = rq->q;
-	int nr_pages = (bufflen + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	int nr_pages = (bufflen + sgl[0].offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	unsigned int data_len = 0, len, bytes, off;
 	struct page *page;
 	struct bio *bio = NULL;
