Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136103AbRD0QUd>; Fri, 27 Apr 2001 12:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136107AbRD0QUY>; Fri, 27 Apr 2001 12:20:24 -0400
Received: from mail2.bonn-fries.net ([62.140.6.78]:24588 "HELO
	mail2.bonn-fries.net") by vger.kernel.org with SMTP
	id <S136103AbRD0QUR>; Fri, 27 Apr 2001 12:20:17 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Goswin Brederlow <goswin.brederlow@student.uni-tuebingen.de>,
        Pavel Machek <pavel@suse.cz>
Subject: Re: Hashing and directories
Date: Fri, 27 Apr 2001 18:20:19 +0200
X-Mailer: KMail [version 1.2]
Cc: Bill Crawford <billc@netcomuk.co.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Daniel Phillips <phillips@innominate.de>
In-Reply-To: <3A959BFD.B18F833@netcomuk.co.uk> <20000101020213.D28@(none)> <87ofvcv3dj.fsf@mose.informatik.uni-tuebingen.de>
In-Reply-To: <87ofvcv3dj.fsf@mose.informatik.uni-tuebingen.de>
MIME-Version: 1.0
Message-Id: <01042718201900.01336@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 March 2001 13:42, Goswin Brederlow wrote:
> >>>>> " " == Pavel Machek <pavel@suse.cz> writes:
>      > Hi!
>      >
>     >> I was hoping to point out that in real life, most systems that
>     >> need to access large numbers of files are already designed to
>     >> do some kind of hashing, or at least to divide-and-conquer by
>     >> using multi-level directory structures.
>     >>
>      > Yes -- because their workaround kernel slowness.
>      >
>      > I had to do this kind of hashing because kernel disliked 70000
>      > html files (copy of train time tables).
>      >
>      > BTW try rm * with 70000 files in directory -- command line will
>      > overflow.
>
> There are filesystems that use btrees (reiserfs) or hashing (affs) for
> directories.
>
> That way you get a O(log(n)) or even O(1) access time for
> files. Saddly the hashtable for affs depends on the blocksize and
> linux AFAIK only allows far too small block sizes (512 byte) for affs.
> It was designed for floppies, so the lack of dynamically resizing hash
> tables is excused.
>
> What also could be done is to keed directories sorted. Creating of
> files would cost O(N) time but a lookup could be done in
> O(log(log(n))) most of the time with reasonable name distribution.
> This could be done with ext2 without breaking any compatibility. One
> would need to convert (sort all directories) every time the FS was
> mounted RW by an older ext2, but otherwise nothing changes.
>
> Would you like to write support for this?

Hi, I missed this whole thread at the time, ironically, because I was 
too busy working on my hash-keyed directory index.

How do you get log(log(n))?  The best I can do is logb(n), with
b=large.  For practical purposes this is O(1).

The only problem I ran into is the mismatch between the storage order
of the sorted directory and that of the inodes, which causes thrashing
in the inode table.  I was able to eliminate this thrashing completely
from user space by processing the files in inode order.  I went on to 
examine ways of eliminating the thrashing without help from user space,
and eventually came up with a good way of doing that that relies on
setting an inode allocation target that corresponds loosely to the sort
order.

The thrashing doesn't hurt much anyway compared to the current N**2
behaviour.  For a million files I saw a 4X slowdown for delete vs
create.  Create shows no thrashing because it works in storage order
in the inodes, with the directory blocks themselves being smaller by
a factor of 6-7, so not contributing significantly to the cache
pressure.  Compare this to the 150 times slowdown you see with normal
Ext2, creating 100,000 files.

--
Daniel
