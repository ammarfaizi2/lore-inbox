Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262174AbVBJRke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbVBJRke (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 12:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbVBJRkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 12:40:33 -0500
Received: from web26501.mail.ukl.yahoo.com ([217.146.176.38]:13502 "HELO
	web26501.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262174AbVBJRjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 12:39:55 -0500
Message-ID: <20050210173954.67324.qmail@web26501.mail.ukl.yahoo.com>
Date: Thu, 10 Feb 2005 17:39:54 +0000 (GMT)
From: Neil Conway <nconway_kernel@yahoo.co.uk>
Subject: NFS (ext3/VFS?) bug in 2.6.8/10
To: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people...

We're seeing lots of "No such file or directory" errors (ENOENT) coming
back from NFS accesses of one of our data server machines.

After (rather a lot of) investigation, we conclude that a kernel bug is
probably involved.  Happily, there's a really simple recipe to
reproduce the problem.

The problem has been observed on ext3 filesystems - we just haven't
tried any others yet.

Recipe:
Underneath an NFS-exported directory, build a test tree as follows:

mkdir testdir
cd testdir
for ((d=0;d<10;d++));do for ((d2=0;d2<499;d2++));do mkdir -p
$d/$d2;done;done
for ((d=0;d<10;d++));do for ((f=0;f<499;f++));do touch
$d/0/file$f;done;done
for ((d=0;d<10;d++));do for ((f=0;f<499;f++));do touch
$d/250/averyveryasdflongfilenameasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdffile$f;done;done

[Apologies for the long lines - but I don't think they'll be ambiguous
even if they split in the mailing.]

Now try: find . |wc -l
It should return 14981.

Now use NFS from here on, with the command:
find /net/$HOSTNAME$PWD | wc -l
or even
find /net/localhost/$PWD | wc -l
(Or whatever you need on your system - we use amd so that works for us.
Explicit NFS mounts are fine too.)

On the first try, this will probably just work and give 14981.

The recipe I have developed to break it is probably non-optimal but
here it is anyway...

Keep an eye on /proc/sys/fs/inode-nr.  You want to get the first entry
way below 14981 (the number of items in our tree).  The way I do this
is repeated use of commands like:
dd if=/dev/hda of=/dev/null bs=1M count=1500
where the 1500MB figure is quite variable depending on the particular
machine and kernel, but should probably be 50-100% of available RAM.

On one machine, I found that I had to help things along a little with:
echo 1000 > /proc/sys/vm/vfs_cache_pressure
but YMMV.  Either way, as soon as you can get the number of inodes down
to a few thousand, you are in the zone where there's a high probability
that the next "find" command will do something like this:

-bash-2.05b$ find /net/localhost/scratch/njconway/testdir/ |wc -l
find: /net/localhost/scratch/njconway/testdir/8/250: No such file or
directory
find: /net/localhost/scratch/njconway/testdir/1/250: No such file or
directory
find: /net/localhost/scratch/njconway/testdir/4/250: No such file or
directory
find: /net/localhost/scratch/njconway/testdir/6/250: No such file or
directory
find: /net/localhost/scratch/njconway/testdir/0/250: No such file or
directory
find: /net/localhost/scratch/njconway/testdir/7/250: No such file or
directory
11981

Sometimes after shrinking the inodes down a bit, a find will work, but
doing it again immediately (no inode shrinkage in between) will fail. 
Weird or what?

Now, what I know so far:

The tree is "magic" in really only two respects, one of which is key. 
Firstly and of least significance, there are several thousand entries
in it, in total.  Secondly, and most critically, quite a few of the
directories in it are bigger than 4kB in size.

-bash-2.05b$ ls -ld 0/0 0/1 0/250
drwxr-xr-x  2 njconway users  16384 Feb 10 13:00 0/0
drwxr-xr-x  2 njconway users   4096 Feb 10 13:00 0/1
drwxr-xr-x  2 njconway users 135168 Feb 10 13:00 0/250

ONLY the ones which exceed 4kB (page-size issue?) ever fail.  (I won't
get into how long it took to figure this out!)  I have tried using
rsize=4096,wsize=4096 on a non-automounted local NFS mount, and it
still
failed.  (Note that all failures are intermittent, hence the difficulty
with reproducing it originally.  This recipe just has a fairly good hit
rate but you could hit a dry spell of 5-10 "successes" in a row - it
helps to get nr_inodes down below 4000 though.)

One thing I notice today while writing this message - I can't persuade
it to fail for non-local mounts: however, it was the failures of
non-local mounts which originally lead to my looking into it, so maybe
this recipe just isn't tuned up quite right to make remote mounts fail.

Two sample machines on which this recipe reproduces the bug:

-bash-2.05b$ uname -a;cat /etc/redhat-release ;free
Linux fuslwr 2.6.8-1.521smp #1 SMP Mon Aug 16 09:25:06 EDT 2004 i686
i686 i386 GNU/Linux
Fedora Core release 2 (Tettnang)
             total       used       free     shared    buffers    
cached
Mem:       2074748    2067608       7140          0    1907904     
43920
-/+ buffers/cache:     115784    1958964
Swap:      2096440      66628    2029812

[njconway@fuslx1 ~]$  uname -a;cat /etc/redhat-release ;free
Linux fuslx1 2.6.10-1.760_FC3 #1 Wed Feb 2 00:14:23 EST 2005 i686 i686
i386 GNU/Linux
Fedora Core release 3 (Heidelberg)
             total       used       free     shared    buffers    
cached
Mem:        248200     238492       9708          0      58676     
53232
-/+ buffers/cache:     126584     121616
Swap:      2097104       8088    2089016

Both of these kernels are non-vanilla.  If people really want to see it
tried on a vanilla kernel I can do that too.

I have tried to reproduce this recipe on a 2.4.18 machine
(2.4.18-27.7.xsmp RH7.3) and failed.  I couldn't get nr_inodes to
reduce (the kernel docs, while ambiguous, suggest this just doesn't
happen under 2.4).  Possibly, 2.4 simply doesn't have this bug.

I don't actually know whether the "bug" is in the NFS client or server
code, or ext3 code (unlikely?) or indeed vfs/mm layers.  I can't
explain it to myself with anything other than a kernel bug somewhere
though.

I've browsed the nfs source code a bit looking for page size related
stuff, but I'm not familiar with it and predictably I got nowhere.  I'm
happy to try out patches and suggestions though.

Apologies for the length!

Any suggestions for what to try next?

Many thanks,
Neil Conway
PS: originally, my test machine was failing REALLY fast.  I noticed
that it had about 896MB of LOWMEM, and the rest of the 2GB was HIGHMEM.
 It failed every time LowFree blipped down to zero while NFS transfers
were underway.  By booting with mem=800M, most of the symptoms went
away but not all, and I ended up arriving at the recipe above, which
works even on machines with 256MB of RAM.  The odd thing I haven't
figured out yet is that the fuslwr machine mentioned above has 2GB of
RAM, and ALL of it is HIGHMEM.  Must be a kernel CONFIG option I guess.
 (Rant: what replaces Configure.help???)



		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - 250MB free storage. Do more. Manage less. 
http://info.mail.yahoo.com/mail_250
