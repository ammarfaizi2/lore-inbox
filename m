Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUCBFDU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 00:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbUCBFDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 00:03:20 -0500
Received: from SMTP2.andrew.cmu.edu ([128.2.10.82]:46471 "EHLO
	smtp2.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S261563AbUCBFDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 00:03:18 -0500
Message-ID: <4044119D.6050502@andrew.cmu.edu>
Date: Mon, 01 Mar 2004 23:46:21 -0500
From: Peter Nelson <pnelson@andrew.cmu.edu>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040221)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, ext3-users@redhat.com,
       jfs-discussion@oss.software.ibm.com, reiserfs-list@namesys.com,
       linux-xfs@oss.sgi.com
Subject: Desktop Filesystem Benchmarks in 2.6.3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently decided to reinstall my system and at the same time try a new 
file system. Trying to decide what filesystem to use I found a few 
benchmarks but either they don't compare all available fs's, are too 
synthetic (copy a source tree multiple times or raw i/o), or are meant 
for servers/databases (like Bonnie++). The two most file system 
intensive tasks I do regularly are `apt-get upgrade` waiting for the 
packages to extract and set themselves up and messing around with the 
kernel so I benchmarked these. To make it more realistic I installed 
ccache and did two compiles, one to fill the cache and a second using 
the full cache.

The tests I timed (in order):
  * Debootstrap to install base Debian system
  * Extract the kernel source
  * Run `make all` using the defconfig and an empty ccache
  * Copy the entire new directory tree
  * Run `make clean`
  * Run `make all` again, this time using the filled ccache
  * Deleting the entire directory tree

Here is summary of the results based upon what I am calling "dead" time 
calculated as `total time - user time`. As you can see in the full 
results on my website the user time is almost identical between 
filesystems, so I believe this is an accurate comparison. The dead time 
is then normalized using ext2 as a baseline (> 1 means it took that many 
times longer than ext2).

FS      deb     tar     make    cp      clean   make2   rm      total
ext2    1.00    1.00    1.00    1.00    1.00    1.00    1.00    1.00
ext3    1.12    2.47    0.88    1.16    0.91    0.93    3.01    1.13
jfs     1.64    2.18    1.22    1.90    1.60    1.19    12.84   1.79
reiser  1.12    1.99    1.05    1.41    0.92    1.56    1.42    1.28
reiser4 2.69    1.87    1.80    0.63    1.33    2.71    4.14    1.83
xfs     1.06    1.99    0.97    1.67    0.78    1.03    10.27   1.43

Some observations of mine
  * Ext2 is still overall the fastest but I think the margin is small
    enough that a journal is well worth it
  * Ext3, ReiserFS, and XFS all perform similarly and almost up to
    Ext2 except:
        o XFS takes an abnormally long time to do a large rm even
          though it is very fast at a kernel `make clean`
        o ReiserFS is significantly slower at the second make (from
          ccache)
  * JFS is fairly slow overall
  * Reiser4 is exceptionally fast at synthetic benchmarks like copying
    the system and untaring, but is very slow at the real-world
    debootstrap and kernel compiles.
  * Though I didn't benchmark it, ReiserFS sometimes takes a second or
    two to mount and Reiser4 sometimes takes a second or two to unmount
    while all other filesystem's are instantaneous.

Originally I had planned on using Reiser4 because of the glowing reviews 
they give themselves but I'm simply not seeing it. It might be that my 
Reiser4 is somehow broken but I don't think so. Based on these results I 
personally am now going with XFS as it's faster than ReiserFS in the 
real-world benchmarks and my current Ext3 partition's performance is 
getting worse and worse.

Full benchmark results, system information, and the script I used to run 
these tests are available from my website here:
<http://avatar.res.cmu.edu/news/pages/Projects/2.6FileSystemBenchmarks>

Feel free to comment, suggest improvements to my script, or run the test 
yourself.
-Peter Nelson
