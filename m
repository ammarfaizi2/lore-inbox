Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290738AbSA3XZu>; Wed, 30 Jan 2002 18:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290741AbSA3XZk>; Wed, 30 Jan 2002 18:25:40 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:58862 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S290738AbSA3XZg>;
	Wed, 30 Jan 2002 18:25:36 -0500
Date: Wed, 30 Jan 2002 16:24:52 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: "Jeffrey W. Baker" <jwbaker@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17: pwrite destroys block I/O throughput
Message-ID: <20020130162452.M763@lynx.adilger.int>
Mail-Followup-To: "Jeffrey W. Baker" <jwbaker@acm.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1012431302.17074.10.camel@heat>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1012431302.17074.10.camel@heat>; from jwbaker@acm.org on Wed, Jan 30, 2002 at 02:55:00PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 30, 2002  14:55 -0800, Jeffrey W. Baker wrote:
> I've never heard of pwrite and pread before, but htdig apparently makes
> very heavy use of it.

Me neither, but always something new to learn.  The man page says they
are "read/write without changing the offset of the file descriptor".

> On my 2.4.17 SMP 2GB HIGHMEM + ext3 system, running htdig destroys
> input rates for every other process.
> 
> Is linux's pwrite() just horribly broken?  Is htdig the only program 
> that uses it?

Well, the sys_read() and sys_pread() code is functionally identical,
with the exception that the latter uses the passed in offset instead
of the file->f_pos.  The same is true for sys_write() and sys_pwrite().

> Here's a little snapshot of htdig's syscalls, strace -s 0:
> 
> pwrite(6, ""..., 8192, 20717568)        = 8192
> pread(6, ""..., 8192, 138395648)        = 8192
> pwrite(6, ""..., 8192, 127918080)       = 8192
> pread(6, ""..., 8192, 179281920)        = 8192
> pwrite(6, ""..., 8192, 79732736)        = 8192
> pread(6, ""..., 8192, 137633792)        = 8192
> pwrite(6, ""..., 8192, 28409856)        = 8192
> pread(6, ""..., 8192, 157958144)        = 8192
> pwrite(6, ""..., 8192, 96583680)        = 8192
> pread(6, ""..., 8192, 141254656)        = 8192
> pwrite(6, ""..., 8192, 131031040)       = 8192
> pread(6, ""..., 8192, 19095552)         = 8192
> pwrite(6, ""..., 8192, 82698240)        = 8192
> pread(6, ""..., 8192, 170573824)        = 8192
> pwrite(6, ""..., 8192, 152616960)       = 8192
> pread(6, ""..., 8192, 207298560)        = 8192
> pwrite(6, ""..., 8192, 148635648)       = 8192
> pread(6, ""..., 8192, 202768384)        = 8192
> pwrite(6, ""..., 8192, 174055424)       = 8192
> 
> It's seeking all over the place.  Maybe pwrite/pread bypass the elevator
> and proper I/O scheduling.

No, it appears that htdig is just a stupidly coded program, randomly
reading and writing all over this huge file.  It is basically impossible
for the kernel to deal with this intelligently (i.e. readahead doesn't
work at all), and given that the file is 200MB in size it is probably
thrashing the disk to death with seeks.

Granted, you _should_ get some benefit to write buffering, but it is
possible that the file is opened in O_SYNC mode, which will kill you.
Maybe you can fix that a bit by using the ext3 "data=journal" mode
for that filesystem, if it is really important to you, because that
will make all of the sync writes one nice contiguous write (avoiding
most seeks), at the expense of halving your write performance.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

