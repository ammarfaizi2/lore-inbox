Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278506AbRJPDC1>; Mon, 15 Oct 2001 23:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278509AbRJPDCR>; Mon, 15 Oct 2001 23:02:17 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55300 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278506AbRJPDCI>; Mon, 15 Oct 2001 23:02:08 -0400
Date: Mon, 15 Oct 2001 20:01:56 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][PATCH] large /proc/mounts and friends
In-Reply-To: <Pine.GSO.4.21.0110152050010.11608-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0110151936580.4179-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 15 Oct 2001, Alexander Viro wrote:
>
> 	See comments in fs/seq_file.c for description of interface - I
> hope they are clear enough.

Al, I understand why you'd like the seq interface, but quite frankly, I
would personally much prefer a different approach: namely making the file
position be a "structured" thing instead, and have (for example) the low
12 bits be the character index, and the upper 52 bits be various "field
indexes" depending on what file it is.

If you have a character sequence number, that means that you _always_ have
to re-generate the whole file up to the new read-point. That simply does
not scale. Sure, it works well enough when the user usually reads the
whole file, but it's still a silly design.

File positions do not have to be consecutive, especially for /proc files
that already confuse things like "less" by not having a well-defined
length etc.

You have 64 bits to play with, and you can pretty much organize them any
way you want. For example, for many things it might be:

 - low 12 bits are "offset in entry string"
 - next X bits are "hash index"
 - next Y bits are "position on hash chain"

which tends to work pretty well with things that are hashed (it mounts,
sockets, etc) and that don't necessarily have a good cardinal ordering.

Can it get confused when people insert/remove entries at the same time we
read /proc? Sure. That's pretty much unavoidable with the /proc interface,
as we can't hold any locks across user-mode system calls. But using a
structured approach may make it _much_ more likely that the user doesn't
get data where a entry is cut off in the middle, though - especially if
you make the read routine be eager to return partial reads rather than
cutting things off in the middle..

(In other words: with a structured approach you can make guarantees about
the stability of each entry - you just can't necessarily guarantee that
all entries are shown or that some entries might not be duplicated..)

This approach is actually already used for some things - the "readdir()"
thing with "FIRST_PROCESS_ENTRY", for example. But also see a better
example in "proc_pid_read_maps()" with the high bits being the "line
number", and the low bits being the offset within the line.

Final note: another _extremely_ useful thing for performance is to have a
special "EOF" value for f_pos, because all normal applications end up
having to always do at least two reads: first to get the data (usually
the user buffer is larger than the amounf of data generated), the second
to just get the "0" for EOF. If the second read can be done without any
data generation or lock handling, that often speeds up /proc accesses by
a noticeable amount.

The special EOF value fits very well with the "structure" approach.

For example, it's quite common to know that each individual entry is
limited in size (with PAGE_SIZE being a nice common max size for any
entry), and the thing that makes the whole /proc file potentially large is
that there are many entries. I'd rather have that kind of helper routines:
a helper routine where there would be a "print out entry X" routine, and
then common routines to turn that "print out entry X" into a full
proc_xxx_read() function.

Al?

		Linus


