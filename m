Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265773AbUFIKET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265773AbUFIKET (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 06:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266074AbUFIKES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 06:04:18 -0400
Received: from cmlapp16.siteprotect.com ([64.41.126.229]:41197 "EHLO
	cmlapp16.siteprotect.com") by vger.kernel.org with ESMTP
	id S265773AbUFIKEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 06:04:06 -0400
Message-ID: <40C6E07C.6060609@serice.net>
Date: Wed, 09 Jun 2004 05:03:40 -0500
From: Paul Serice <paul@serice.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040127
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric Lammerts <eric@lammerts.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iso9660 Inodes Anywhere and NFS
References: <40BD2841.2050509@serice.net> <54574.67.8.218.172.1086758675.squirrel@webmail.krabbendam.net>
In-Reply-To: <54574.67.8.218.172.1086758675.squirrel@webmail.krabbendam.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > But what about 0-byte files? The block offset could be the same for
 > all 0-byte files, or worse, it could be the same as the block offset
 > of a non-0-byte file.

For my latest patch, the only complaints (so far) have been regarding
my inode numbering scheme.  So, I would like to keep the switch from
iget() to iget5_locked() to allow the NFS get_parent() method to work
which has always been missing.

So basically, I think we are talking about a one line change to the
isofs_get_ino() function in include/linux/iso_fs.h.  I only mention
this because I don't want to seem too defensive about my choice of
inode numbers.  I'm more than happy to make the change to another
inode numbering scheme, but before doing that I would like to defend
the one I chose.



 > I don't know if this has been mentioned before, but since a
 > directory record is always 34 bytes or bigger, why not simply divide
 > the directory record byte offset by 32? I.e.,
 >
 > -   inode_number = (bh->b_blocknr << bufbits) + offset;
 > +   inode_number = (bh->b_blocknr << (bufbits - 5)) + (offset >> 5);

There was a previous e-mail from Sergey Vlasov that suggested this,
and the second patch I posted (which was buggy) tried to implement
this.  I posted the patch to the cdwrite mailing list, and J"org
Schilling told me that "the assumptions were correct but that the
conclusions were wrong" and that because of this I was assigning
duplicate inode numbers.  I get the feeling that carving out 6 bits
(11 - 5) for the offset is not sufficient.  I was never able to get
to the bottom of it, and he never really elaborated further.  Your
math is somewhat different so maybe you don't have the problem.

So there's that degree of uncertainty, and there's the problem that
this approach also assigns duplicate inode numbers starting at block
67108864.

I think the next generation of storage media will come close to
reaching this block count.  So, I decided to abandon my second patch
in order to find a solution that can handle the maximum block count
allowed by the ISO 9660 standard.  If not now, it is going to have to
be done in a number of years anyway.

So my thoughts on what would make a good inode number ran down two
lines.  The first line of reasoning is that I know "ls" and "find"
required inode numbers to be unique among directories, or they will
not recurse down some directories.  I think my patch provides "ls" and
"find" with what they need.

The second line of reasoning is that I do not know of any other common
use of inode numbers in user space, and while posix says inode numbers
shall be unique, BSD (at least NetBSD) appears to me to assign
non-unique inode numbers for files by returning the lower 32 bits of
the byte offset.

I did have another idea, but it has limitations too.  We could use the
upper 16 bits of the inode number to store the index into the Path
Table and use the lower 16 bits to store the index into the directory.
This would limit the number of directories and the number of directory
entries per directory to 65535 each.  I have never been able to figure
out what the Optional Occurrence of the Path Table is used for so I
have never pursued this approach, and I'm not sure that the arbitrary
limitation on the number of directories and directory entries is worth
a few duplicate inode numbers in cases where two files actually do
point to the same block on disc.

In conclusion, I just don't see much long-term difference in any of
the inode numbering schemes, and the advantage of the scheme in my
patch is that directories should always have unique inode numbers
which to me is the important case.  So, that's my reasoning, but I'm
not married to it.

