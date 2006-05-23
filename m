Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWEWB75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWEWB75 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 21:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWEWB75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 21:59:57 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:55186 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751239AbWEWB74 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 21:59:56 -0400
Date: Tue, 23 May 2006 11:59:38 +1000
From: Nathan Scott <nathans@sgi.com>
To: fitzboy <fitzboy@iparadigms.com>
Cc: linux-kernel@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: tuning for large files in xfs
Message-ID: <20060523115938.A242207@wobbly.melbourne.sgi.com>
References: <447209A8.2040704@iparadigms.com> <20060523085116.B239136@wobbly.melbourne.sgi.com> <44725C27.90601@iparadigms.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <44725C27.90601@iparadigms.com>; from fitzboy@iparadigms.com on Mon, May 22, 2006 at 05:49:43PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

On Mon, May 22, 2006 at 05:49:43PM -0700, fitzboy wrote:
> Nathan Scott wrote:
> > Can you send xfs_info output for the filesystem and the output
> > from xfs_bmap -vvp on this file?
> xfs_info:
> meta-data=/mnt/array/disk1       isize=2048   agcount=410, agsize=524288 

Thats odd - why such a large number of allocation groups?

> blks
>           =                       sectsz=512
> data     =                       bsize=4096   blocks=214670562, imaxpct=25
>           =                       sunit=16     swidth=192 blks, unwritten=1
> naming   =version 2              bsize=4096
> log      =internal               bsize=4096   blocks=8192, version=1
>           =                       sectsz=512   sunit=0 blks
> realtime =none                   extsz=65536  blocks=0, rtextents=0
> 
> it is mounted rw,noatime,nodiratime
> generally I am doing 32k reads from the application, so I would like 
> larger blocksize (32k would be ideal), but can't go above 2k on intel...

4K you mean (thats what you've got above, and thats your max with
a 4K pagesize).

I thought you said you had a 2TB file?  The filesystem above is
4096 * 214670562 blocks, i.e. 818GB.  Perhaps its a sparse file?
I guess I could look closer at the bmap and figure that out for
myself. ;)

> I made the file my copying it over via dd from another machine onto a 
> clean partition... then from that point we just append to the end of it, 
> or modify existing data...

> I am attaching the extent map

Interesting.  So, the allocator did an OK job for you, at least
initially - everything is contiguous (within the bounds of the
small agsize you set) until extent #475, and I guess that'd have
been the end of the initial copied file.  After that it chops
about a bit (goes back to earlier AGs and uses the small amounts
of space in each I'm guessing), then gets back into nice long
contiguous extent allocations in the high AGs.

Anyway, you should be able to alleviate the problem by:

- Using a small number of larger AGs (say 32 or so) instead of
a large number of small AGs.  this'll give you most bang for
your buck I expect.
[ If you use a mkfs.xfs binary from an xfsprogs anytime since
November 2003, this will automatically scale for you - did you
use a very old mkfs?  Or set the agcount/size values by hand?
Current mkfs would give you this:
# mkfs.xfs -isize=2k -dfile,name=/dev/null,size=214670562b -N
meta-data=/dev/null    isize=2048  agcount=32, agsize=6708455 blks
...which is just what you want here. ]

- Preallocate the space in the file - i.e. before running the
dd you can do an "xfs_io -c 'resvsp 0 2t' /mnt/array/disk1/xxx"
(preallocates 2 terabytes) and then overwrite that.  Yhis will
give you an optimal layout.

- Not sure about your stripe unit/width settings, I would need
to know details about your RAID.  But maybe theres tweaking that
could be done there too.

- Your extent map is fairly large, the 2.6.17 kernel will have
some improvements in the way the memory management is done here
which may help you a bit too.

Have fun!

cheers.

-- 
Nathan
