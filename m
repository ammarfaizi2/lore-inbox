Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285393AbRLYFzO>; Tue, 25 Dec 2001 00:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285385AbRLYFzF>; Tue, 25 Dec 2001 00:55:05 -0500
Received: from cn129399-a.wall1.pa.home.com ([24.40.41.32]:36993 "EHLO dysonwi")
	by vger.kernel.org with ESMTP id <S285384AbRLYFyy>;
	Tue, 25 Dec 2001 00:54:54 -0500
Message-ID: <3C2814AB.9060700@pobox.com>
Date: Tue, 25 Dec 2001 00:54:51 -0500
From: Will Dyson <will_dyson@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011213
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [CFT] BeFS filesystem 0.6
In-Reply-To: <Pine.GSO.4.21.0112241625120.28049-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:

 
> Umm...  Obvious comments:
> 
> a) typedef struct super_block vfs_sb;  Please don't.
> 
> b) in inode.c:
> 	inode->i_mode = (umode_t) raw_inode->mode;
> is wrong.  It's guaranteed bug either on big- or little-endian boxen.
> Same for mtime, uid and gid.  befs_count_blocks() also needs cleanup.
> 
> c) befs_read_block()...  Erm.  Why bother with extra layer of abstraction?
> 
> d) befs_readdir().  You _are_ guaranteed that inode is non-NULL, you put
> pointer to befs_dir_operations only is S_ISDIR is true and S_ISDIR is
> mutually exclusive with S_ISLNK.
> 
> e) are there sparse files on BeFS?  If yes - you want to make BH_Mapped
> conditional in get_block() (set it if block is present, don't if it's a
> hole in file).
> 
> f) befs_arch().  You probably want to make that an option...
> 
> g) endianness problems in read_super()...
> 
> h) TODO: use line breaks ;-)



Hi Al. Thanks for taking the time to respond.


A & B) I originaly had plans to make the driver work under a variety of 
different VFSs (maybe freebsd and atheos) and to have user-space tools 
(like the old mtools for DOS) for people on other OSs. That was the 
motivation behind those extra abstractions, but I've actually kinda lost 
interest in the idea. I'll just take 'em out if it really offends 
people's asthetic sense. Perhaps kernel drivers just weren't meant to be 
portable.

B) The PPC and x86 versions of BeOS each write their filesystem metadata 
in native byte-order. So this would only be a problem with disks that 
were formatted on a big-endian system and read on a little-endian (or 
the other way around, of course). I've been meaning to handle that case 
"someday".

D) Ok. I killed that test.

E) To my knowledge, there are not sparse files on BeFS.

F) Ideally, I would detect both the endianness of the filesystem and the 
host, and refuse to mount if they differ (or byte-swap the metadata). 
Can I rely on #ifdef __LITTLE_ENDIAN to detect the endianness I am 
running on?

G) Same thing as B, I think.

H) Yeah. I despise editors that won't line-wrap for you. But this is 
unix, so I guess I gotta accomodate them. Is makeing sure they don't 
overflow 80 columns enough? Or should that be 78?

 > befs_count_blocks() also needs cleanup.

How so, please?

-- 
Will Dyson

