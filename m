Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283481AbRLXWA1>; Mon, 24 Dec 2001 17:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285383AbRLXWAM>; Mon, 24 Dec 2001 17:00:12 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:20435 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S285377AbRLXV7w>;
	Mon, 24 Dec 2001 16:59:52 -0500
Date: Mon, 24 Dec 2001 16:59:51 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Will Dyson <will_dyson@pobox.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [CFT] BeFS filesystem 0.6
In-Reply-To: <3C2796EC.9050008@pobox.com>
Message-ID: <Pine.GSO.4.21.0112241625120.28049-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 Dec 2001, Will Dyson wrote:

> Hi,
> 
> For some months now, I have been working on a read-only implementation 
> of the BeOS's native filesystem (BeFS). I just released version 0.6, and 
> I think it works pretty darn well. <http://befs-driver.sourceforge.net/>
> 
> I've had some reports of it working well on other peoples' machines as 
> well. So what I'd really like now is for more people to try and break 
> it. If you have a Be filesystem partition, please try it out. If you 
> don't (but still feel like testing anyway), the download page has a 
> filesystem image you can try it out on.
> 
> I'd also appreciate anyone who wants to critique the code itself. Thanks!

Umm...  Obvious comments:

a) typedef struct super_block vfs_sb;  Please don't.

b) in inode.c:
	inode->i_mode = (umode_t) raw_inode->mode;
is wrong.  It's guaranteed bug either on big- or little-endian boxen.
Same for mtime, uid and gid.  befs_count_blocks() also needs cleanup.

c) befs_read_block()...  Erm.  Why bother with extra layer of abstraction?

d) befs_readdir().  You _are_ guaranteed that inode is non-NULL, you put
pointer to befs_dir_operations only is S_ISDIR is true and S_ISDIR is
mutually exclusive with S_ISLNK.

e) are there sparse files on BeFS?  If yes - you want to make BH_Mapped
conditional in get_block() (set it if block is present, don't if it's a
hole in file).

f) befs_arch().  You probably want to make that an option...

g) endianness problems in read_super()...

h) TODO: use line breaks ;-)

