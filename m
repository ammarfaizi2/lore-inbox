Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317637AbSHYWo6>; Sun, 25 Aug 2002 18:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317641AbSHYWo6>; Sun, 25 Aug 2002 18:44:58 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:11019
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317637AbSHYWo4>; Sun, 25 Aug 2002 18:44:56 -0400
Date: Sun, 25 Aug 2002 15:47:47 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Hans Verkuil <hverkuil@xs4all.nl>
cc: kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: ataraid and mount -l causes IDE errors
In-Reply-To: <200208260004.26839.hverkuil@xs4all.nl>
Message-ID: <Pine.LNX.4.10.10208251544360.20423-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


That is the generic BUG in the legacy data path in ide-disk.c.
It is the reason I have been working to migrate to taskfile io but until
there are updates forward from AC to Marcelo, I do not see it being fixed.

It is hard to hit but messy when you get there.

Also it may have something to do w/ changes to the chipset driver made by
Promise and not me.

Sorry,

Andre Hedrick
LAD Storage Consulting Group

On Mon, 26 Aug 2002, Hans Verkuil wrote:

> I've recently updated the util-linux package from version 2.11r to 2.11u and 
> discovered that running 'mount -l' results in a large number of IDE errors 
> and that afterwards the harddisk DMA was turned off (running a vanilla 2.4.19 
> kernel).
> 
> After some research I discovered that in 2.11s a test was added to check for 
> raid disks. Checking for a disk label should only be done on the full raid, 
> not on the disks that form the raid array. However, this test causes a lot of 
> problems when run on my striped promise fasttrak 100 array.
> 
> I've created a simple test program to illustrate the problem:
> 
> >>>>>>> cut
> #include <stdio.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <errno.h>
> 
> int main(int argc, char **argv)
> {
>   int fd, rv;
>   char buf[4096];
> 
>   fd = open(argv[1], O_RDONLY);
>   if (fd < 0) {
>     printf("fail\n");
>     return 1;
>   }
>   errno = 0;
>   rv = lseek(fd, -4096, SEEK_END);
>   printf("lseek: %d %s\n", rv, strerror(errno));
>   errno = 0;
>   rv = read(fd, buf, 4096);
>   printf("read: %d %s\n", rv, strerror(errno));
>   close(fd);
>   return 0;
> }
> >>>>>>> cut
> 
> When run with '/dev/ide/host2/bus0/target0/lun0/part4' (this is the last 
> partition of my striped raid array /dev/ataraid/disc0/disc consisting of 
> disks /dev/ide/host2/bus0/target0/lun0/disc and 
> /dev/ide/host2/bus0/target1/lun0/disc) the following kernel messages appear:
> 
> >>>>>>> start messages
> hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hde: dma_intr: error=0x04 { DriveStatusError }
> hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hde: dma_intr: error=0x04 { DriveStatusError }
> hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hde: dma_intr: error=0x04 { DriveStatusError }
> hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hde: dma_intr: error=0x04 { DriveStatusError }
> hde: DMA disabled
> hdf: DMA disabled
> PDC202XX: Primary channel reset.
> ide2: reset: success
> hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hde: read_intr: error=0x04 { DriveStatusError }
> hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hde: read_intr: error=0x04 { DriveStatusError }
> hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hde: read_intr: error=0x04 { DriveStatusError }
> hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hde: read_intr: error=0x04 { DriveStatusError }
> PDC202XX: Primary channel reset.
> ide2: reset: success
> hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hde: read_intr: error=0x04 { DriveStatusError }
> end_request: I/O error, dev 21:04 (hde), sector 188410312
> hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hde: read_intr: error=0x04 { DriveStatusError }
> hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hde: read_intr: error=0x04 { DriveStatusError }
> hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hde: read_intr: error=0x04 { DriveStatusError }
> hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hde: read_intr: error=0x04 { DriveStatusError }
> PDC202XX: Primary channel reset.
> ide2: reset: success
> hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hde: read_intr: error=0x04 { DriveStatusError }
> hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hde: read_intr: error=0x04 { DriveStatusError }
> hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hde: read_intr: error=0x04 { DriveStatusError }
> hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hde: read_intr: error=0x04 { DriveStatusError }
> PDC202XX: Primary channel reset.
> ide2: reset: success
> hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hde: read_intr: error=0x04 { DriveStatusError }
> end_request: I/O error, dev 21:04 (hde), sector 188410314
> hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hde: read_intr: error=0x04 { DriveStatusError }
> hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hde: read_intr: error=0x04 { DriveStatusError }
> hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hde: read_intr: error=0x04 { DriveStatusError }
> hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hde: read_intr: error=0x04 { DriveStatusError }
> PDC202XX: Primary channel reset.
> ide2: reset: success
> hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hde: read_intr: error=0x04 { DriveStatusError }
> hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hde: read_intr: error=0x04 { DriveStatusError }
> hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hde: read_intr: error=0x04 { DriveStatusError }
> hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hde: read_intr: error=0x04 { DriveStatusError }
> PDC202XX: Primary channel reset.
> ide2: reset: success
> hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hde: read_intr: error=0x04 { DriveStatusError }
> end_request: I/O error, dev 21:04 (hde), sector 188410316
> hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hde: read_intr: error=0x04 { DriveStatusError }
> hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hde: read_intr: error=0x04 { DriveStatusError }
> hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hde: read_intr: error=0x04 { DriveStatusError }
> hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hde: read_intr: error=0x04 { DriveStatusError }
> PDC202XX: Primary channel reset.
> ide2: reset: success
> hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hde: read_intr: error=0x04 { DriveStatusError }
> hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hde: read_intr: error=0x04 { DriveStatusError }
> hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hde: read_intr: error=0x04 { DriveStatusError }
> hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hde: read_intr: error=0x04 { DriveStatusError }
> PDC202XX: Primary channel reset.
> ide2: reset: success
> hde: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hde: read_intr: error=0x04 { DriveStatusError }
> end_request: I/O error, dev 21:04 (hde), sector 188410318
> >>>>>>>>>> end messages
> 
> I suspect some sanity check is missing in the Promise driver or elsewhere. 
> These messages appear while trying to read the last 4096 bytes of a partition 
> that extends way beyond the physical size of the disc as the partition is 
> actually the partition of the whole raid array.
> 
> Is this a known problem? Does anyone have a fix?
> 
> Regards,
> 
> 		Hans Verkuil
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

