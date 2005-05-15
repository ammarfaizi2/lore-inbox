Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVEOTA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVEOTA4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 15:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVEOTA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 15:00:56 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:2177 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261201AbVEOTAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 15:00:45 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: mhw@wittsend.com, linux-kernel@vger.kernel.org
Subject: Re: Sync option destroys flash!
Date: Sun, 15 May 2005 22:00:26 +0300
User-Agent: KMail/1.5.4
References: <1116001207.5239.38.camel@localhost.localdomain>
In-Reply-To: <1116001207.5239.38.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505152200.26432.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 May 2005 19:20, Michael H. Warfield wrote:
> 	Under the right circumstances, even copying a single file to a flash
> drive mounted with the "sync" option can destroy the entire drive!
> 
> 	Now that I have your attention!
> 
> 	I found this out the hard way.  (Kissed one brand new $70 USD 1GB flash
> drive good-bye.)  According to the man pages for mount, FAT and VFAT
> file systems ignore the "sync" option.  It lies.  Maybe it use to be
> true, but it certainly lies now.  A simple test can verify this.  Mount
> a flash drive with a FAT/VFAT file system without the sync option and
> writes to the drive go very fast.  Typing "sync" or unmounting the drive
> afterwards, takes time as the buffered data is written to the flash
> drive.  This is as it should be.  Mount it with the sync option and
> writes are really REALLY slow (worse than they should be just from
> copying the data through USB) but sync and umount come back immediately
> and result in no additional writing to the drive.  [Do the preceding
> with only a few files and less than a few meg of data if you value that
> flash.]  So...  FAT and VFAT are honoring the sync option.  This is very
> VERY bad.  It's bad for floppies, it's bad for hard drives, it's FATAL
> for flash drives.
> 
> 	Flash drives have a limited number of write cycles.  Many many
> thousands of write cycles, but limited, none the less.  They are also
> written in blocks which are much larger than the "sector" size report
> (several K in a physical nand flash block, IRC).
> 
> 	What happens, with the sync option on a VFAT file system, is that the
> FAT tables are getting pounded and over-written over and over and over
> again as each and every block/cluster is allocated while a new file is
> written out.  This constant overwriting eventually wears out the first
> block or two of the flash drive.

What we really need, is a less thorough version of O_SYNC.
O_SYNC currently guarantees that when syscall returns, data
is on media (or at least in disk drive's internal cache :).

This is exactly what really paranoid people want.
Journalling labels, all that good stuff.

But there are many cases where people just want to say
'write out dirty data asap for this device', so that
I can copy files to floppy, wait till it stops making
noise, and eject a disk. Samr for flash if it has write
indicator (mine has a diode).

The difference from O_SYNC is that in this O_LAZY_SYNC mode
writes return early, just filling pagecache, but writeout
is started immediately and continues until there is no dirty
O_LAZY_SYNC data.

This mode won't eat flash as fast as O_SYNC does.
--
vda

