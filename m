Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262641AbSJ3Duw>; Tue, 29 Oct 2002 22:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263366AbSJ3Duw>; Tue, 29 Oct 2002 22:50:52 -0500
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:15880 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id <S262641AbSJ3Duv>; Tue, 29 Oct 2002 22:50:51 -0500
Message-ID: <3DBF5756.2010702@lougher.demon.co.uk>
Date: Wed, 30 Oct 2002 03:51:50 +0000
From: Phillip Lougher <phillip@lougher.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020604
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Samuel Flory <sflory@rackable.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ANNOUNCEMENT: Squashfs released (a highly compressed filesystem)
References: <3DBF43ED.70001@lougher.demon.co.uk> <3DBF4DBA.8060005@rackable.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Flory wrote:
> Phillip Lougher wrote:
> 
>> Hi,
>>
>> First release of squashfs.  Squashfs is a highly compressed read-only 
>> filesystem for Linux (kernel 2.4.x).  It uses zlib compression to 
>> compress both files, inodes and directories.  Inodes in the system are 
>> very small and all blocks are packed to minimise data overhead. Block 
>> sizes greater than 4K are supported up to a maximum of 32K.
>>
>> Squashfs is intended for general read-only filesystem use, for 
>> archival use, and in embedded systems where low overhead is needed.
>>
>> Squashfs is available from http://squashfs.sourceforge.net.
>>
>> The patch file is currently against 2.4.19.  There is further info on 
>> the filesystem design etc. in the README.
>>
>> I'l be interested in getting any feedback, advice etc. on it.
>>
> 
>  What are the advantages of squashfs vs cramfs?
> 
> 
> 

Cramfs was the inspiration for squashfs.  Squashfs basically gives 
better compression, bigger files/filesystem support, and more inode 
information.

1. Blocks upto 32K are supported - data is compressed in units of 32K 
which achieves better compression ratios than compressing in 4K blocks. 
  Generally using bigger than 4K blocks are a bad idea, because the VFS 
calls the filesystem in 4K pages.  Squashfs explictly pushes the extra 
block data into the page cache.

2. Squashfs compresses inode and directory information in addition to 
file data.  Inodes/directories generally compress down to 50%, or say on 
average 8 bytes or less per inode.

3. All fs data is packed on byte alignments, saving a couple of bytes 
per inode and directory.

4.  Full 32 bit uids/guids are stored (4 bits stored in inode, uses a 
lookup table, to give 48 uids/16 gids).  File sizes upto 2^32 are 
supported.  Timestamp info is stored. Cramfs truncates uids to 16 bits, 
uids to 8 bits.  Cramfs files sizes are upto 2^24.  No timestamp info. 
Squashfs takes advantage of metadata compression to have more info with 
smaller metadata overhead.

5 Symbolic link contents/file indexes are stored inside the inode table,
giving better compression than if they were compressed individually, or 
not compressed.

6. The mksquashfs program doesn't store/mmap the filesystem as it is 
created (it performs file duplicate checking against the partially 
written out compressed fs), and so allows larger filesystems to be created.


Further info on the fs is contained in the README...

Phillip

