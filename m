Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315598AbSEIDHs>; Wed, 8 May 2002 23:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315599AbSEIDHr>; Wed, 8 May 2002 23:07:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13063 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315598AbSEIDHq>;
	Wed, 8 May 2002 23:07:46 -0400
Message-ID: <3CD9E8A7.D524671D@zip.com.au>
Date: Wed, 08 May 2002 20:10:31 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Lincoln Dale <ltd@cisco.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <E175QmK-0001V8-00@the-village.bc.nu> <5.1.0.14.2.20020509122919.01645ff0@mira-sjcm-3.cisco.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lincoln Dale wrote:
> 
> At 01:42 PM 8/05/2002 +0100, Alan Cox wrote:
> >The SCSI layer is significant overhead even in 2.5.
> 
> i did some benchmarking on a high-end dual P3 Xeon (Serverworks chipset )
> with QLogic 2300 (2gbit/s) 64/66 Fibre Channel controllers.
> 
> using the '/dev/sgX' interface to issue scsi reads/writes allowed me to hit
> the magical limit of 200mbyte/sec throughput.  (basically just about
> linerate).  (simultaneous "sg_read if=/dev/sgX mmap=1 bs=512 count=35M";
> sg_read from the sg-tools package)
> 
> doing the same test thru the block-layer was basically capped at around
> 135mbyte/sec.  (simultaneous "dd if=/dev/sdX of=/dev/null bs=512 count=35M").
> 
> whether the bottleneck was copy-from-kernel-to-userspace (ie. exhaustion of
> Front-Side-Bus / memory bandwidth) or related to block-layer overhead and
> scsi layer overheads, i haven't yet validated, but at a ~35% performance
> difference is relatively significant nontheless.
> 
> cpu utlization on the sg interface was under 10%.  using 'dd' on the sd
> interface, both gigahertz P3 Xeons had 0% idle time.
> 


You need to be careful with this stuff.  Cache effects dominate.

I believe the /dev/sgX driver uses a fixed kernel-side buffer for
the transfer.  So the source of the copy_to_user() will always come
out of cache if the CPU is snooping the busmastering.  But not if
the CPU is performing cache invalidates in response to that busmastering.

But for `dd', which has to copy the data out of pagecache, the
copy_from_user() will get 100% misses on the source, guaranteed.

Also, the `sg_read' command reads everything into the same (small)
chunk of userspace memory.   So the destination of copy_to_user()
is always in cache.  Probably, the same is true with `dd bs=512',
but one would have to go read the dd source to verify.

This is also why the scsi_debug driver runs so much faster than normal
devices: it copies everything out of a fixed in-kernel buffer.  ie:
out of L1 cache.  Fast.

Similarly, `sg_dd' against scsi_debug is copying a fixed kernel buffer
into a fixed userspace buffer  But when `dd' tries to do the same thing
it incurs an additional copy into the pagecache.  If the pagecache
readahead window exceeds your L1 cache size (it does) then it will
appear to be a lot slower.

Summary: the block layer ain't slow - it's memory which is slow ;)

-
