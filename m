Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289044AbSAFVnc>; Sun, 6 Jan 2002 16:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289046AbSAFVnM>; Sun, 6 Jan 2002 16:43:12 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:22541 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S289044AbSAFVnK>; Sun, 6 Jan 2002 16:43:10 -0500
Message-ID: <3C38C351.1FCA434A@zip.com.au>
Date: Sun, 06 Jan 2002 13:36:17 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: elim <elim@warthog.ern-e.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: slow scsi disk perf (sym53c875 and IBM drives)
In-Reply-To: <Pine.LNX.4.33L2.0201061159330.23448-100000@warthog.ern-e.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

elim wrote:
> 
> Hiya,
> 
> I've been having relatively poor scsi disk performance for as long as I
> can remember now. I've experienced this with ~2.2.12 all the way up to
> 2.4.17.
> 
> I'm not much of a scsi buff but I've read some suggestions such as proper
> termination, queue depths, etc but nothing seems to have helped. My
> understanding is that I should be getting better performance than I'm
> getting with these drives.
> 
> Any suggestions would be appreciated and if this is not the right forum to
> ask.. please direct me to the proper place.
> 
> Thanks and regards.
> 
> PS: kindly cc me on replies.
> 
> hdparm output:
> 
> /dev/sda:
>  Timing buffered disk reads:  64 MB in 10.94 seconds =  5.85 MB/sec

I've noticed that the blockdev-in-pagecache patch in 2.4.10-pre10 somehow
screwed up performance with 1k blocksize on some SCSI devices.  I spent a couple
of hours poking at it and couldn't find out why.  I suspect that the
SCSI-layer request merging has broken.   I intend to revisit this later.

Please do this test for me:

1: Find a SCSI partition which has a 4k blocksize ext2/ext3 filesystem
   on it which has never been mounted.  Let's pretend that's /dev/sda5

2: Run hdparm -t /dev/sda5       If /dev/sda5 has not been mounted since
   boot, this will use 1k blocksizes.

3: Now mount the filesystem: mount /dev/sda5 /mnt/wherever.

4: umount /devc/sda5

5: hdparm -t /dev/sda5            This will now use 4k blocksize.

The mount and unmount of the 4k blocksize filesystem will change the
softblocksize of the underlying device to 4k.  Permanently.

In my testing on a 1394 disk, the 1k blocksize hdparm throughput is
1.5 megabytes/sec.  The 4k blocksize throughput is 27 megs/sec.
