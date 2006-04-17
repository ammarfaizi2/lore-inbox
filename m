Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbWDQW3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWDQW3s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 18:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWDQW3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 18:29:48 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:14507 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751327AbWDQW3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 18:29:47 -0400
Date: Tue, 18 Apr 2006 08:29:31 +1000
From: Nathan Scott <nathans@sgi.com>
To: Gyorgy Szekely <hoditohod@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ramdisk driver strange behaviour
Message-ID: <20060418082931.A1478752@wobbly.melbourne.sgi.com>
References: <940be6070604140659q31c45599wf729a47ef25103ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <940be6070604140659q31c45599wf729a47ef25103ee@mail.gmail.com>; from hoditohod@gmail.com on Fri, Apr 14, 2006 at 03:59:07PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2006 at 03:59:07PM +0200, Gyorgy Szekely wrote:
> hi,
> i'm trying to use a ramdisk driver (block/rd.c) and experienced some
> very strnage behaviour. In brief:
> If I set ramdisk_blocksize=512 on the kernel command line, the driver
> operates oddly. I execute the following commands in a shell:
> 
> mkfs.ext2 /dev/ram0     ~runs fine, no errors
> mount /dev/ram0 /mnt/disk    ~doesn't mount the filesystem, can't find
> it on device
> mkfs.ext2 /dev/ram0     ~runs fine, same as above
> mount /dev/ram0 /mnt/disk    ~mounts fine
> 
> I have to make exactly this command sequence, to make the fs usable,
> eg: mkfs.ext2 twice without trying to mount doesn't work. Once the
> mount succeeds everything works fine, i can read/write files,
> unmount/remount everything as expected.
> I copied the ramdisk contents with dd into a file, and after the first
> pass it's all zeros nothing else. Like the first mkfs didn't do
> anything.
> 
> If I remove the ramdisk_blocksize option from the kernel command line
> (defaults to 1024) then all is ok.

I wonder if this is a strange artifact of the supported blocksizes
for the filesystem you're using...

mkfs.ext2 ...
	-b block-size
		Specify the size of blocks in bytes.  Valid block size
		vales are 1024, 2048 and 4096 bytes per block.  ...

During mount the filesystem will tell the driver what its minimum
block size is, and the driver is meant to validate that, and return
an error if its too small.  Whats probably happening in your case
is a failure to handle the too-small case correctly... oh, hmm, yes,
look at the callers of set_blocksize -- in ext3 its return value is
not being checked afaict, and in ext2 I'm not sure where this setup
is done (doesn't seem to be a set_blocksize call there at all - hmm).

You might try XFS too as a data point - XFS will permit a 512 byte
filesystem blocksize - so try mkfs.xfs -bsize=512 /dev/ram0 and see
if that mounts OK first go... that'd backup the above theory if it
does.

cheers.

-- 
Nathan
