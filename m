Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S157176AbQGQEbI>; Mon, 17 Jul 2000 00:31:08 -0400
Received: by vger.rutgers.edu id <S157406AbQGQEbC>; Mon, 17 Jul 2000 00:31:02 -0400
Received: from QWE4.MATH.CMU.EDU ([128.2.32.156]:4950 "EHLO qwe4.math.cmu.edu") by vger.rutgers.edu with ESMTP id <S157107AbQGQEar>; Mon, 17 Jul 2000 00:30:47 -0400
Date: Mon, 17 Jul 2000 00:45:22 -0400 (EDT)
From: Scott A Crosby <crosby@qwes.math.cmu.edu>
To: linux-kernel@vger.rutgers.edu, video4linux@redhat.com, linuxperf@nl.linux.org
Cc: Jean-Michel Smith <jean-michel@kcco2.com>, Doug Schafer <doug@schafers.com>
Subject: Mini-howto: High performance large Ext2fs filesystems  [[BETA]]
In-Reply-To: <20000710043112.B296@fuchs.offl.uni-jena.de>
Message-ID: <Pine.LNX.4.10.10007170013580.28180-100000@qwe4.math.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

Summary: How to save 2% more space, and do a full fsck on 70 gb of
diskspace. (3 drives) in 6 minutes. And other tricks and tips for making
ext2fs much more pleasant on large filesystems... Forward where you think
they want to know.

It started as a slashdot post 6 months ago, but I've done nothing since,
so I'm sending it out as-is.. You have been warned..

-----

How to have high performance large Ext2fs filesystems (mini-howto)

OK.. This thing is beta, it's fairly accurate, but I've done nothing in
the last 6 months. Time to post it as-is. (BTW, if anyone wants to
maintain it, send me some email.) Otherwise, right now, this is free
to post and spread it all ya want. (You can reformat if you wish, but
please leave the contents unchanged.) PS: I'm looking for a maintainer, if
you want it, it's yours to do as you wish.


Origional version by: Scott Crosby  crosby@qwe4.math.cmu.edu
With Feedback and suggestions from: 
From: Jean-Michel Smith <jean-michel@kcco2.com>

Reformatting his drives with the tips, and raving about the difference in
speed and video-capture.

(FYI: he used)

/usr/mp3 and /usr/iso-images I built with 4k blocks and 1 inode/128k.
/usr/local with 4k blocks and 1 inode/64k
/home with 2k blocks and 1 inode/16k


From: "Doug Schafer" <doug@schafers.com>

For suggesting that I look for spelling mistakes. (Which I haven't done.)


--

Todo:
  Finish editing it.

  Should submit draft to:  doug@schafers.com, jean-michel@kcco2.com, and
Theodore  Ts'o <tytso@mit.edu> for accuracy and other opinions.

  Fix it up from those suggestions.
  
  Contact the LDP (or who else?) for information for fixing it up for
submission, copyright junk and that sort of stuff.

  Resubmit to video-4-linux, linux-kernel, and linux-tuning mailing lists
to reach interested parties who probably want to know about it. 



--

History:
 
  2000-07-17 Add in the 'nocheck' tip.
  2000-04-05 Some editing.
  2000-02-?? Slashdot post (as Convergence:
convergence@hypercube.res.cmu.edu)


--

I have a 46gb system, I run stock ext2fs filesystems. I have a
configuration which lets me do a full filesystem check on in under 7
minutes.

Among the other partitians, I have a 23, 16, and 20gb partitians. (on
seperate
drives). I have about 75gb of disk space total, with 46gb of that
currently
in use (723484 files/directories). My trick is twofold:

First, the default inode allocation is a bit insane.. Inodes are 128 bytes
each and there's one inode for every 4kb of diskspace. So for every 10gb
of disk, the default format uses 320mb of inodes, capable of storing over
2.5 million files! And e2fsck has to scan each and every byte in each and
every one of these inodes. So why not drop that to 1/4, or one inode for
every 16kb? Then for every 10gb of diskspace e2fsck only has to scan
625,000
inodes or 80mb worth. Can you say 4 times faster? :)

Some might claim that they could run out of inodes with an allocation that
small?  Unless the server has lots of small files (mail, news, proxy), its
highly unlikely that you'll have even 500,000 files on the whole thing.
You
can get this info very quickly by using 'tune2fs -l /dev/foo'.

If you're like me and you notice that you're using only 1/8 or even 1/15
the
total number of inodes, and you don't expect the file charactaristics
[number of files, directories, average size, ...] that you're going to
store on that
partitian to change radically, then there's little risk in getting rid of
3/4 
of those inodes and speed up the fsck.

In my case, I've got a total of 4.2 million inodes, with only 700k used,
had I formatted normally, I would have had around 19 million. (multiply by
128 bytes/inode to see how much storage they need, and how many hundreds
of megabytes e2fsck would need to scan.) I also tuned each partitian
seperately, based on how they were currently used, and the risk of the
usage properties changing radically. (For instance, I've left /tmp with
the stock 4kb/inode.. I never know if I'll suddenly stuff lots of small
files in there.)

Ok.. That's trick #1.. The second trick is to modify the default
blocksize.

Normally, ext2fs allocates storage in 1kb blocks. But changing that to 2kb
has many advantages.

---------------------------------------------------------------------------

These are stock ext2fs filesystems.. Even despite the fact that e2fsck
isn't
fully parellelizing the checks, I have clocked a full bootup at 7 minutes.

Among the other partitians, I have a 23, 16, and 20gb partitians. (on
seperate
drives). I have about 75gb of disk space total, with 46gb of that
currently
in use (723484 files/directories). My trick is twofold:

First, the default inode allocation is a bit insane.. Inodes are 128 bytes
each and there's one inode for every 4kb of diskspace. So for every 10gb
of disk, the default format uses 320mb of inodes, capable of storing over
2.5 million files! And e2fsck has to scan each and every byte in each and
every one of these inodes. So why not drop that to 1/4, or one inode for
every 16kb? Then for every 10gb of diskspace e2fsck only has to scan
625,000
inodes or 80mb worth. Can you say 4 times faster? :)

Some might claim that they could run out of inodes with an allocation that
small?  Unless the server has lots of small files (mail, news, proxy), its
highly unlikely that you'll have even 500,000 files on the whole thing.
You
can get this info very quickly by using 'tune2fs -l /dev/foo'.

If you're like me and you notice that you're using only 1/8 or even 1/15
the
total number of inodes, and you don't the file charactaristics [number of
files, directories, average size, ...] that you're going to store on that
partitian to change radically. Then get rid of 3/4 of them and speed up
the fsck.

In my case, I've got a total of 4.2 million inodes, with only 700k used,
had I formatted normally, I would have had around 19 million. (multiply by
128 bytes/inode to see how much storage they need, and how many hundreds
of megabytes e2fsck would need to scan.) I also tuned my partitians
seperately. Based on how they were currently being used and on the risk of
that changing radically. (For instance, /tmp has the stock 4kb/inode.. I
never know if I'll suddenly stuff lots of small files in there.)

Ok.. That's trick #1.. The second trick is the default blocksize. Changing
this speeds up every filesystem operation, from allocation to fsck to
reading
to writing to unlinking.  This trick does waste more diskspace.

Normally, ext2fs allocates storage in 1kb blocks. But changing that to 2kb
has many advantages. First, a file requires only half the number of drive
transactions, which will improve speed. Second, since all allocations are
now done in 2kb sizes, I can allocate (and remove) twice as fast. Finally,
due to the subtletly in I, II, III blocks that form the allocation BTREE,
(These are diskblocks which point to diskblocks that point to diskblocks
containing data.) Having twice the size of allocation means that the btree
has twice the fanout AND each leaf holds twice the data. I'm not sure how
much impact this factor has on speed.

For those of you who don't know how ext2fs inodes are layed out.. They're
actually curious.. The inode itself points to the first 12 blocks of the
file directly (normally the first 12*1024). Then it points to an I block
that contains pointers to the next blocks in the file. (normally, the next
1024/4 = 256 blocks, or 256kb).  Then there's the II block, which contains
pointers to I blocks. Finally, there's the III block that contains
pointers
to II blocks. You don't need an IIII block because with only an III block,
you can handle files up to about 16tb, which is larger than the maximum
possible filesystem size.

Now, the reason to get into this big long explanation is to make a
fascinating
point about diskspace usage.. If you have a blocksize of 1kb, then files
less
than 12kb in size don't require any I blocks. While if you have a
blocksize
of 2kb, files less than 24kb in size don't require any I blocks.

So, if your filesystem has files between 12kb and 24kb in size, if you
compare
the disk usage between a filesystem of 1kb blocksize and 2kb blocksize,
The
worst you could do is waste an extra kilobyte in the last block, but that
wasted diskblock is made up for the fact that you don't have an I block.
:)

And that's the worst you could do. In fact if you have luck, you can
actually
come out pretty far ahead! Formatting with a blocksize of 2kb may actually
waste LESS space AND require fewer seeks! :)

Now combine this with the tidbit that the average file tends to be around
13kb. If the majority of the files on the partitian are between 12 and
24kb
in size, you can't lose with this!

As files get bigger than 24kb, the relative size of wasted space in the
last block becomes much less relevant, (for files around 24kb, the maximum
percentage of wasted space is 2kb/24kb ~~ 8%.) So a 2kb blocksize has a
decreasing affect on wasted space, while at the same time increasing the
bandwidth and speed of handling large files. So at files >24kb in size,
you start winning, for files >1mb, you start winning a whole lot.

Those are just a few characteristics of ext2fs and allocation.  There's no
magic bullet for speeding up ext2fs, but depending on how the filesystem
is
used, you can frequently speed it up. Look at your drive, the average file
size, and the filesize distribution. `find /foo -size +12k -size -24k | wc
; find /foo | wc ; find /foo -size +24k | wc ; find / -size +128k | wc''.
Then
decide which

--------------------------------------------------------------------

These are stock ext2fs filesystems.. Even despite the fact that e2fsck
isn't
fully parellelizing the checks, I have clocked a full bootup at 7 minutes.

Among the other partitians, I have a 23, 16, and 20gb partitians. (on
seperate
drives). I have about 75gb of disk space total, with 46gb of that
currently
in use (723484 files/directories). My trick is twofold:

First, the default inode allocation is a bit insane.. Inodes are 128 bytes
each and there's one inode for every 4kb of diskspace. So for every 10gb
of disk, the default format uses 320mb of inodes, capable of storing over
2.5 million files! And e2fsck has to scan each and every byte in each and
every one of these inodes. So why not drop that to 1/4, or one inode for
every 16kb? Then for every 10gb of diskspace e2fsck only has to scan
625,000
inodes or 80mb worth. Can you say 4 times faster? :)

Some might claim that they could run out of inodes with an allocation that
small?  Unless the server has lots of small files (mail, news, proxy), its
highly unlikely that you'll have even 500,000 files on the whole thing.
You
can get this info very quickly by using 'tune2fs -l /dev/foo'.

If you're like me and you notice that you're using only 1/8 or even 1/15
the
total number of inodes, and you don't the file charactaristics [number of
files, directories, average size, ...] that you're going to store on that
partitian to change radically. Then get rid of 3/4 of them and speed up
the fsck.

In my case, I've got a total of 4.2 million inodes, with only 700k used,
had I formatted normally, I would have had around 19 million. (multiply by
128 bytes/inode to see how much storage they need, and how many hundreds
of megabytes e2fsck would need to scan.) I also tuned my partitians
seperately. Based on how they were currently being used and on the risk of
that changing radically. (For instance, /tmp has the stock 4kb/inode.. I
never know if I'll suddenly stuff lots of small files in there.)

Ok.. That's trick #1.. The second trick is the default blocksize. Changing
this speeds up every filesystem operation, from allocation to fsck to
reading
to writing to unlinking.  This trick does waste more diskspace.

Normally, ext2fs allocates storage in 1kb blocks. But changing that to 2kb
has many advantages. First, a file requires only half the number of drive
transactions, which will improve speed. Second, since all allocations are
now done in 2kb sizes, I can allocate (and remove) twice as fast. Finally,
due to the subtletly in I, II, III blocks that form the allocation BTREE,
(These are diskblocks which point to diskblocks that point to diskblocks
containing data.) Having twice the size of allocation means that the btree
has twice the fanout AND each leaf holds twice the data. I'm not sure how
much impact this factor has on speed.

For those of you who don't know how ext2fs inodes are layed out.. They're
actually curious.. The inode itself points to the first 12 blocks of the
file directly (normally the first 12*1024). Then it points to an I block
that contains pointers to the next blocks in the file. (normally, the next
1024/4 = 256 blocks, or 256kb).  Then there's the II block, which contains
pointers to I blocks. Finally, there's the III block that contains
pointers
to II blocks. You don't need an IIII block because with only an III block,
you can handle files up to about 16tb, which is larger than the maximum
possible filesystem size.

Now, the reason to get into this big long explanation is to make a
fascinating
point about diskspace usage.. If you have a blocksize of 1kb, then files
less
than 12kb in size don't require any I blocks. While if you have a
blocksize
of 2kb, files less than 24kb in size don't require any I blocks.

So, if your filesystem has files between 12kb and 24kb in size, if you
compare
the disk usage between a filesystem of 1kb blocksize and 2kb blocksize,
The
worst you could do is waste an extra kilobyte in the last block, but that
wasted diskblock is made up for the fact that you don't have an I block.
:)

And that's the worst you could do. In fact if you have luck, you can
actually
come out pretty far ahead! Formatting with a blocksize of 2kb may actually
waste LESS space AND require fewer seeks! :)

Now combine this with the tidbit that the average file tends to be around
13kb. If the majority of the files on the partitian are between 12 and
24kb
in size, you can't lose with this!

As files get bigger than 24kb, the relative size of wasted space in the
last block becomes much less relevant, (for files around 24kb, the maximum
percentage of wasted space is 2kb/24kb ~~ 8%. For 128kb, its 2kb/128kb ~~
1.6%) So a 2kb blocksize has a decreasing affect on wasted space, while at
the same time increasing the bandwidth and speed of handling large files.
So
at files >24kb in size, you start winning, for files >1mb, you start
winning
a whole lot.

If the partitian is only intended for very large files, (Ones where any
wasted space in the last block is irrelevant with respect to the total
size.), then a 4kb blocksize makes perfect sense. I don't suggest this
idea
too strongly because its not as applicable as a 2kb blocksize.

Those are just a few characteristics of ext2fs with regard to
blocksize. There's no magic bullet for speeding up ext2fs, but depending
on
how the filesystem is used, you can frequently speed it up. Look at your
drive, the average file size, and the filesize distribution. `find /foo
-size +12k -size -24k | wc ; find /foo | wc ; find /foo -size +24k | wc ;
find /foo -size +128k''. Then decide if changing the blocksize makes
sense.


For my personal system, the overhead of increasing the blocksize to 2kb is
around 3-7%, 3% in most places and 7% where there tend to be many small
files
(/home/http).

Closing remarks:

If you use both tricks together, they almost cancel themselves out. The
overhead of having 1 inode for every 4kb is 128b/4kb, or about 3%, if you
format with 16kb/inode, the overhead drops to .75%. You save 2.25%. And as
it just so happens, the overhead of the bigger blocksize is around 3%. So
overall, you break even, within one or two percent of the origional disk
usage.


----------------------------------------------------------------------------



These are stock ext2fs filesystems.. Even despite the fact that e2fsck
isn't
fully parellelizing the checks, I have clocked a full bootup at 7 minutes.

Among the other partitians, I have a 23, 16, and 20gb partitians. (on
seperate
drives). I have about 75gb of disk space total, with 46gb of that
currently
in use (723484 files/directories). My trick is twofold:

First, the default inode allocation is a bit insane.. Inodes are 128 bytes
each and there's one inode for every 4kb of diskspace. So for every 10gb
of disk, the default format uses 320mb of inodes, capable of storing over
2.5 million files! And e2fsck has to scan each and every byte in each and
every one of these inodes. So why not drop that to 1/4, or one inode for
every 16kb? Then for every 10gb of diskspace e2fsck only has to scan
625,000
inodes or 80mb worth. Can you say 4 times faster? :)

Some might claim that they could run out of inodes with an allocation that
small?  Unless the server has lots of small files (mail, news, proxy), its
highly unlikely that you'll have even 500,000 files on the whole thing.
You
can get this info very quickly by using 'tune2fs -l /dev/foo'.

If you're like me and you notice that you're using only 1/8 or even 1/15
the
total number of inodes, and you don't the file charactaristics [number of
files, directories, average size, ...] that you're going to store on that
partitian to change radically. Then get rid of 3/4 of them and speed up
the fsck.

In my case, I've got a total of 4.2 million inodes, with only 700k used,
had I formatted normally, I would have had around 19 million. (multiply by
128 bytes/inode to see how much storage they need, and how many hundreds
of megabytes e2fsck would need to scan.) I also tuned my partitians
seperately. Based on how they were currently being used and on the risk of
that changing radically. (For instance, /tmp has the stock 4kb/inode.. I
never know if I'll suddenly stuff lots of small files in there.)

Ok.. That's trick #1.. The second trick is the default blocksize. Changing
this speeds up every filesystem operation, from allocation to fsck to
reading
to writing to unlinking.  This trick does waste more diskspace.

Normally, ext2fs allocates storage in 1kb blocks. But changing that to 2kb
has many advantages. First, a file requires only half the number of drive
transactions, which will improve speed. Second, since all allocations are
now done in 2kb sizes, I can allocate (and remove) twice as fast. Finally,
due to the subtletly in I, II, III blocks that form the allocation BTREE,
(These are diskblocks which point to diskblocks that point to diskblocks
containing data.) Having twice the size of allocation means that the btree
has twice the fanout AND each leaf holds twice the data. I'm not sure how
much impact this factor has on speed.

For those of you who don't know how ext2fs inodes are layed out.. They're
actually curious.. The inode itself points to the first 12 blocks of the
file directly (normally the first 12*1024). Then it points to an I block
that contains pointers to the next blocks in the file. (normally, the next
1024/4 = 256 blocks, or 256kb).  Then there's the II block, which contains
pointers to I blocks. Finally, there's the III block that contains
pointers
to II blocks. You don't need an IIII block because with only an III block,
you can handle files up to about 16tb, which is larger than the maximum
possible filesystem size.

Now, the reason to get into this big long explanation is to make a
fascinating
point about diskspace usage.. If you have a blocksize of 1kb, then files
less
than 12kb in size don't require any I blocks. While if you have a
blocksize
of 2kb, files less than 24kb in size don't require any I blocks.

So, if your filesystem has files between 12kb and 24kb in size, if you
compare
the disk usage between a filesystem of 1kb blocksize and 2kb blocksize,
The
worst you could do is waste an extra kilobyte in the last block, but that
wasted diskblock is made up for the fact that you don't have an I block.
:)

And that's the worst you could do. In fact if you have luck, you can
actually
come out pretty far ahead! Formatting with a blocksize of 2kb may actually
waste LESS space AND require fewer seeks! :)

Now combine this with the tidbit that the average file tends to be around
13kb. If the majority of the files on the partitian are between 12 and
24kb
in size, you can't lose with this!

As files get bigger than 24kb, the relative size of wasted space in the
last block becomes much less relevant, (for files around 24kb, the maximum
percentage of wasted space is 2kb/24kb ~~ 8%. For 128kb, its 2kb/128kb ~~
1.6%) So a 2kb blocksize has a decreasing affect on wasted space, while at
the same time increasing the bandwidth and speed of handling large files.
So
at files >24kb in size, you start winning, for files >1mb, you start
winning
a whole lot.

If the partitian is only intended for very large files, (Ones where any
wasted space in the last block is irrelevant with respect to the total
size.), then a 4kb blocksize makes perfect sense. I don't suggest this
idea
too strongly because its not as applicable as a 2kb blocksize.

Those are just a few characteristics of ext2fs with regard to
blocksize. There's no magic bullet for speeding up ext2fs, but depending
on
how the filesystem is used, you can frequently speed it up. Look at your
drive, the average file size, and the filesize distribution. `find /foo
-size +12k -size -24k | wc ; find /foo | wc ; find /foo -size +24k | wc ;
find /foo -size +128k''. Then decide if changing the blocksize makes
sense.


For my personal system, the overhead of increasing the blocksize to 2kb is
around 3-7%, 3% in most places and 7% where there tend to be many small
files
(/home/http).

Closing remarks:

If you use both tricks together, they almost cancel themselves out. The
overhead of having 1 inode for every 4kb is 128b/4kb, or about 3%, if you
format with 16kb/inode, the overhead drops to .75%. You save 2.25%. And as
it just so happens, the overhead of the bigger blocksize is loss of about
3%. So overall, you break even; within one or two percent of the origional
disk usage. This is how I formatted most of my system.

And if you actually need millions of 4kb files, well, unjourneled ext2fs
is
not the filesystem I would reccomend.

So, a quick summary. My system takes 7 minutes to boot. It has 723484 used
inodes, out of a total of 4.2 million inodes. I have 46gb of drivespace
used,
out of a total of 75gb. A boot with a full filesystem check takes 7
minutes
and requires reading about 500mb worth of inodes. A boot without a full
fsck
takes one minute (about 20 seconds of that just mounting).

Had I formatted it normally, I would have saved 500-1500mb (1-3%) of
drivespace, had 18 million inodes. Fsck times would probably take 4x-8x as
long and requrie reading about 2.3gb worth of inodes.

I considered the trade well worth it for me, and I
suspect that it would be well-worth it to many other
people. (Excluding those who's boxes have multi-year uptimes. :)
---------------------------------------------------------------------

These are normal ext2fs filesystems.. Even despite the fact that e2fsck
isn't
fully parellelizing the checks, I have clocked a full bootup at 7 minutes.

Among the other partitians, I have a 23, 16, and 20gb partitians. (on
seperate
drives). I have about 75gb of disk space total, with 46gb of that
currently
in use (723484 files/directories). My trick is twofold:

First, the default inode allocation is a bit insane.. Inodes are 128 bytes
each and there's one inode for every 4kb of diskspace. So for every 10gb
of disk, the default format uses 320mb of inodes, capable of storing over
2.5 million files! And e2fsck has to scan each and every byte in each and
every one of these inodes. So why not drop that to 1/4, or one inode for
every 16kb? Then for every 10gb of diskspace e2fsck only has to scan
625,000
inodes or 80mb worth. Can you say 4 times faster? :)

Some might claim that they could run out of inodes with an allocation that
small?  Unless the server has lots of small files (mail, news, proxy), its
highly unlikely that you'll have even 500,000 files on the whole thing.
You
can get this info very quickly by using 'tune2fs -l /dev/foo'.

If you're like me and you notice that you're using only 1/8 or even 1/15
the
total number of inodes, and you don't the file charactaristics [number of
files, directories, average size, ...] that you're going to store on that
partitian to change radically. Then get rid of 3/4 of them and speed up
the fsck.

In my case, I've got a total of 4.2 million inodes, with only 700k used,
had I formatted normally, I would have had around 19 million. (multiply by
128 bytes/inode to see how much storage they need, and how many hundreds
of megabytes e2fsck would need to scan.) I also tuned my partitians
seperately. Based on how they were currently being used and on the risk of
that changing radically. (For instance, /tmp has the stock 4kb/inode.. I
never know if I'll suddenly stuff lots of small files in there.)

Ok.. That's trick #1.. The second trick is the default blocksize. Changing
this speeds up every filesystem operation, from allocation to fsck to
reading
to writing to unlinking.  This trick does waste more diskspace.

Normally, ext2fs allocates storage in 1kb blocks. But changing that to 2kb
has many advantages. First, a file requires only half the number of drive
transactions, which will improve speed. Second, since all allocations are
now done in 2kb sizes, I can allocate (and remove) twice as fast. Finally,
due to the subtletly in I, II, III blocks that form the allocation BTREE,
(These are diskblocks which point to diskblocks that point to diskblocks
containing data.) Having twice the size of allocation means that the btree
has twice the fanout AND each leaf holds twice the data. I'm not sure how
much impact this factor has on speed.

For those of you who don't know how ext2fs inodes are layed out.. They're
actually curious.. The inode itself points to the first 12 blocks of the
file directly (normally the first 12*1024). Then it points to an I block
that contains pointers to the next blocks in the file. (normally, the next
1024/4 = 256 blocks, or 256kb).  Then there's the II block, which contains
pointers to I blocks. Finally, there's the III block that contains
pointers
to II blocks. You don't need an IIII block because with only an III block,
you can handle files up to about 16tb, which is larger than the maximum
possible filesystem size.

Now, the reason to get into this big long explanation is to make a
fascinating
point about diskspace usage.. If you have a blocksize of 1kb, then files
less
than 12kb in size don't require any I blocks. While if you have a
blocksize
of 2kb, files less than 24kb in size don't require any I blocks.

So, if your filesystem has files between 12kb and 24kb in size, if you
compare
the disk usage between a filesystem of 1kb blocksize and 2kb blocksize,
The
worst you could do is waste an extra kilobyte in the last block, but that
wasted diskblock is made up for the fact that you don't have an I block.
:)

And that's the worst you could do. In fact if you have luck, you can
actually
come out pretty far ahead! Formatting with a blocksize of 2kb may actually
waste LESS space AND require fewer seeks! :)

Now combine this with the tidbit that the average file tends to be around
13kb. If the majority of the files on the partitian are between 12 and
24kb
in size, you can't lose with this!

As files get bigger than 24kb, the relative size of wasted space in the
last block becomes much less relevant, (for files around 24kb, the maximum
percentage of wasted space is 2kb/24kb ~~ 8%. For 128kb, its 2kb/128kb ~~
1.6%) So a 2kb blocksize has a decreasing affect on wasted space, while at
the same time increasing the bandwidth and speed of handling large files.
So
at files >24kb in size, you start winning, for files >1mb, you start
winning
a whole lot.

If the partitian is only intended for very large files, (Ones where any
wasted space in the last block is irrelevant with respect to the total
size.), then a 4kb blocksize makes perfect sense. I don't suggest this
idea
too strongly because its not as applicable as a 2kb blocksize.

Those are just a few characteristics of ext2fs with regard to
blocksize. There's no magic bullet for speeding up ext2fs, but depending
on
how the filesystem is used, you can frequently speed it up. Look at your
drive, the average file size, and the filesize distribution. `find /foo
-size +12k -size -24k | wc ; find /foo | wc ; find /foo -size +24k | wc ;
find /foo -size +128k''. Then decide if changing the blocksize makes
sense.


For my personal system, the overhead of increasing the blocksize to 2kb is
around 3-7%, 3% in most places and 7% where there tend to be many small
files
(/home/http).

Closing remarks:

If you use both tricks together, they almost cancel themselves out. The
overhead of having 1 inode for every 4kb is 128b/4kb, or about 3%, if you
format with 16kb/inode, the overhead drops to .75%. You save 2.25%. And as
it just so happens, the overhead of the bigger blocksize is loss of about
3%. So overall, you break even; within one or two percent of the origional
disk usage. This is how I formatted most of my system.

And if you actually need millions of 4kb files, well, unjourneled ext2fs
is
not the filesystem I would reccomend.

So, a quick summary. My system takes 7 minutes to boot. It has 723484 used
inodes, out of a total of 4.2 million inodes. I have 46gb of drivespace
used,
out of a total of 75gb. A boot with a full filesystem check takes 7
minutes
and requires reading about 500mb worth of inodes. A boot without a full
fsck
takes one minute (about 20 seconds of that just mounting).

Had I formatted it normally, I would have saved 500-1500mb (1-3%) of
drivespace, had 18 million inodes. Fsck times would probably take 4x-8x as
long and requrie reading about 2.3gb worth of inodes.

I considered the trade well worth it for me, and I suspect that it would
be well-worth it to many other people. (Excluding those who's boxes have
multi-year uptimes. :)


--- Update ---

If you put the 'nocheck' option into /etc/fstab, it makes mounting faster.
Normally, when you mount an ext2fs filesystem, it checks the block
allocation bitmaps. This check can only get semi-trivial errors, and
e2fsck does a much more throrough check, so disabling it doesn't cost
much. With this change, my system (the one I describe above) now boots in
40 seconds without an fsck, and in approximately 6 minutes with one. It
makes mounting instantanous.

For example:

/dev/hdb2 /                  ext2   defaults,nocheck                0 1
/dev/hdb7 /home              ext2   defaults,nocheck                0 2






--
No DVD movie will ever enter the public domain, nor will any CD. The last CD 
and the last DVD will have moldered away decades before they leave copyright. 
This is not encouraging the creation of knowledge in the public domain.




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
