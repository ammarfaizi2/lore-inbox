Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289282AbSAIJLB>; Wed, 9 Jan 2002 04:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289279AbSAIJJ4>; Wed, 9 Jan 2002 04:09:56 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:35857 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S289285AbSAIJJU>; Wed, 9 Jan 2002 04:09:20 -0500
Message-ID: <3C3C077E.20A09A43@zip.com.au>
Date: Wed, 09 Jan 2002 01:04:01 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [problem captured] Re: cerberus on 2.4.17-rc2 UP
In-Reply-To: <3C3B6F65.F9226437@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> > Yes, I can generate it at will on two quite different IDE machines
> > with the run-bash-shared-mapping script from
> > http://www.zip.com.au/~akpm/ext3-tools.tar.gz
> 
> Could you apply the attached patch and try to reproduce it?

Nice patch.

> Enable CONFIG_DEBUG_SLAB.
> 
> The patch poisons all objects I could find that might have something
> to do with the bug. (all slab caches, struct request, struct page,
> struct filp, partially struct buffer_head).
> 
> My test box survives the run-bash_shared-mapping script (~30 min, 128
> MB memory).
> 

Mine survives only a few minutes.  Once it only lasted a second.
That's with mem=64m.  It lasts much, much longer with more memory.

The patch, alas, sheds no light.  I'll delve into it fairly soon,
I expect.

EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 212k freed
end_request: buffer-list destroyed
hda6: bad access: block=86256, count=-8
end_request: I/O error, dev 03:06 (hda), sector 86256
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hda: drive not ready for command
hda: lost interrupt

and:

end_request: buffer-list destroyed
hda6: bad access: block=93608, count=-8
end_request: I/O error, dev 03:06 (hda), sector 93608
hda6: bad access: block=93616, count=-16
end_request: I/O error, dev 03:06 (hda), sector 93616
hda6: bad access: block=93624, count=-24
end_request: I/O error, dev 03:06 (hda), sector 93624
hda6: bad access: block=93632, count=-32
end_request: I/O error, dev 03:06 (hda), sector 93632
hda6: bad access: block=93640, count=-40
end_request: I/O error, dev 03:06 (hda), sector 93640
hda6: bad access: block=93648, count=-48
end_request: I/O error, dev 03:06 (hda), sector 93648
hda6: bad access: block=93656, count=-56
end_request: I/O error, dev 03:06 (hda), sector 93656
hda6: bad access: block=93664, count=-64
end_request: I/O error, dev 03:06 (hda), sector 93664
hda6: bad access: block=93672, count=-72
end_request: I/O error, dev 03:06 (hda), sector 93672
hda6: bad access: block=93680, count=-80
end_request: I/O error, dev 03:06 (hda), sector 93680
hda6: bad access: block=93688, count=-88
end_request: I/O error, dev 03:06 (hda), sector 93688
hda6: bad access: block=93696, count=-96
end_request: I/O error, dev 03:06 (hda), sector 93696
hda6: bad access: block=93704, count=-104
end_request: I/O error, dev 03:06 (hda), sector 93704
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hda: drive not ready for command
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt

hmm..  hda6 is the root filesystem.  The test was hitting hda8
and hda5(swap).  The only activity happening on hda6 would be
a bit of pagein, maybe syslog.  hmm.  

Always hda6:

end_request: buffer-list destroyed
hda6: bad access: block=90704, count=-8
end_request: I/O error, dev 03:06 (hda), sector 90704
hda6: bad access: block=90712, count=-16
end_request: I/O error, dev 03:06 (hda), sector 90712
hda6: bad access: block=90720, count=-24
end_request: I/O error, dev 03:06 (hda), sector 90720
hda6: bad access: block=90728, count=-32

Interestingly, 2.4.13-ac8 doesn't fail.  Well, it eventually takes
oopses in do_IRQ()'s get_current() - %cr2 has value 0x4017a000.

That kernel has the new IDE drivers, but I've seen the problem with
Andre's latest patches on PIIX, on VIA, and there are reports of it
on SCSI.  And "buffer-list destroyed" is always the first message.
It doesn't feel like a driver problem.  I'll go do a binary search
through some kernel revs.

-
