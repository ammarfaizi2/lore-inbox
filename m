Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932775AbVLJLXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932775AbVLJLXJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 06:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932780AbVLJLXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 06:23:08 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:16080 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S932775AbVLJLXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 06:23:06 -0500
Message-ID: <025c01c5fd7c$147f0d50$4168010a@bsd.tnes.nec.co.jp>
From: "Takashi Sato" <sho@bsd.tnes.nec.co.jp>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>
Cc: "Dave Kleikamp" <shaggy@austin.ibm.com>,
       "'Andreas Dilger'" <adilger@clusterfs.com>,
       <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <000001c5fb1d$0a27c8d0$4168010a@bsd.tnes.nec.co.jp> <1133963528.27373.4.camel@lade.trondhjem.org> <1133967716.8910.5.camel@kleikamp.austin.ibm.com> <1133969671.27373.47.camel@lade.trondhjem.org> <1133973247.8907.33.camel@kleikamp.austin.ibm.com> <02ab01c5fbeb$faf7d740$4168010a@bsd.tnes.nec.co.jp> <1134052043.7998.26.camel@lade.trondhjem.org>
Subject: Re: stat64 for over 2TB file returned invalid st_blocks
Date: Sat, 10 Dec 2005 20:22:56 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-2";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> I prefer sector_t for i_blocks rather than newly defined blkcnt_t.
>> The reasons are:
>> 
>>   - Both i_blocks and common sector_t are for on-disk 512-byte unit.
>>     In this point of view, they have the same character.
> 
> One is a count of the number of blocks used by a file, and exists only
> in order to help filesystems cache this value. The other is a handle to
> a block. How is that the same?

Both i_blocks and sector_t handle on-disk blocks in a certain unit.

But their relation seems to be similar to the relation between off_t
and size_t of POSIX.  So adding blkcnt_t makes sense too.  I'll think
of this point further.

By the way, I think there is a kind of confusions on sector_t.  Its
unit is 512 bytes on block/ and driver/ tree, but it is filesystem
block on fs/ tree.  Does anyone think the latter should be fsblock_t
or something?

>>   - If we created the type blkcnt_t newly, the patch would have to
>>     touch a lot of files as follows, like sector_t does.
>>         block/Kconfig, asm-i386/types.h, asm-x86_64/types.h,
>>         asm-ppc/types.h, asm-s390/types.h, asm-sh/types.h,
>>         asm-h8300/types.h, asm-mips/types.h
>>     It will be simple if we use sector_t for i_blocks.
> 
> That is not a particularly good reason.
> 
>> Also, I cannot imagine the situation that > 2TB files are used over
>> network with CONFIG_LBD disabled kernel.  Is there such a thing
>> realistically?

CONFIG_LBD is enabled not only on HPC but on all major distribution for
server and desktop.  The only exception is embedded system, isn't it?

> Apart from this and the kstat wart, there is no reason to set CONFIG_LBD
> for a networked filesystem. Why would you want to buy a > 2TB local disk
> on an HPC cluster node if you already have a server?
> 
> I suppose we can make NFS use a private field instead, and just set
> i_blocks to 0, but that's unnecessarily wasteful too.

I think your suggestion is effective only for the problem of stat64,
but other problems would be left on code which handles inode.i_blocks.
For example, ioctl with FIOQSIZE command returns the size of file's
data calculated from inode.i_blocks.  If inode.i_blocks is 0, ioctl
with FIOQSIZE always returns 0 even if the file data exists.

-- Takashi Sato
