Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287731AbSAAD7e>; Mon, 31 Dec 2001 22:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287729AbSAAD7Z>; Mon, 31 Dec 2001 22:59:25 -0500
Received: from cm61-15-169-117.hkcable.com.hk ([61.15.169.117]:22400 "EHLO
	cm61-15-169-117.hkcable.com.hk") by vger.kernel.org with ESMTP
	id <S287727AbSAAD7Q>; Mon, 31 Dec 2001 22:59:16 -0500
Message-ID: <3C313324.3010504@rcn.com.hk>
Date: Tue, 01 Jan 2002 11:55:16 +0800
From: David Chow <davidchow@rcn.com.hk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@math.psu.edu>,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] [WIP] Unbork fs.h, 3 of 3
In-Reply-To: <Pine.LNX.4.33.0112311004580.1404-100000@penguin.transmeta.com> <E16L8JK-0000ao-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just some comments and questions about the new fs.h .. its great to hear 
improvements in the new year!

Are you people going to put this on the 2.5? It seems you are keeping 
the generic_ip pointer for compatibility. And I guess this is what other 
file systems (those not included in the standardkernel sources) are 
using, at least I am the one.

Daniel Phillips wrote:

>On December 31, 2001 07:16 pm, Linus Torvalds wrote:
>
>>How about using a descriptor structure instead of the macro, and making
>>the filesystem declaration syntax look more like
>>
>>	static struct file_system_type ext2_descriptor = {
>>		owner:		THIS_MODULE,
>>		fs_flags:	FS_REQUIRES_DEV,
>>		name:		"ext2",
>>		read_super:	ext2_read_super,
>>		super_size:	sizeof(ext2_sb_info),
>>
>		^^^^^---> changed sb to super, lines up better
>
>>		inode_size:	sizeof(struct ext2_inode_info)
>>	};
>>
I am using the generic_ip to hold my fs inode data pointer. During the 
implementation, I tested both approaches... but it seems not sigficant 
in detection of inode cache allocation overheads in read_inode(). Its 
worth to talk about memory consumptions because it is silly to allocate 
the largest possible inode cache sizes. I strongly agree with the new fs 
declaration interface becuase of higher efficiency and less overhead, 
but it seems more and more fs are supported in Linux, the effort to 
patch all fs'es is a lot of work.

I am working on a compression file systmes, many thing varies such that 
I have to use dynamically link allocated structures in the inode cache.

>>
>>which is more readable, and inherently documents _what_ those things are.
>>
>>[snip halfway macro format]
>>
>>What do you think?
>>
>
>It's much nicer, here's (1 of 3) again, with the Linus-style ext2_fs
>declaration.
>
>--
>Daniel
>
For the remount issue, I don't think its just affect the root 
filesystem, for me I also reload other settings during a remount. For 
feature oriented filesystems, remount may be use more frequent then 
umount and mount. Other admins may also remount their /usr fs and other 
protected fs to read-only for safe after altering their fs. Why not 
changing the remount behaviour in VFS not to call module_exit()? I also 
can't see why VFS has to call module_exit() in remount if we have 
remount() in super_operations ... I think remount operations are fs 
specific and shuold pass this job to super_operations->remount . I think 
it is a better way to solve the root fs problem. But it would require 
even more work to get all fs to obey the new standard. If you want nice 
and clean efficient solutions, work is must anyway... good luck.

David Chow

