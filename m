Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbTJBSNc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 14:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263431AbTJBSNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 14:13:32 -0400
Received: from [205.180.85.17] ([205.180.85.17]:2965 "EHLO mail.fastclick.net")
	by vger.kernel.org with ESMTP id S263429AbTJBSNa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 14:13:30 -0400
Message-ID: <3F7C6ABF.8070900@fastclick.com>
Date: Thu, 02 Oct 2003 11:13:19 -0700
From: Brett <brettspamacct@fastclick.com>
Reply-To: brettspamacct@fastclick.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Getting total memory used by processes
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(note: using 2.4.22)

I patched the kernel with rmap and i2c, now I'm seeing weirdness where 
top reports 500-900 megs used by processes((mem used + swap used) - 
cached) but I know that can't be right. So it seems that memory is 
magically being used and I don't know who is using it.

I'd like to get the total memory used by processes using a better 
method.  So I created a perl script which does a ps listing, pulls out 
VSZ, sums that and spits out the result.  Here it is in all its glory:

open(PSOUT, "/bin/ps -auxwwt | /bin/awk '{print \$5}' |") || die "Error 
opening file";

my $size = 0;

while(<PSOUT>)
{
     chomp;
     $size += $_;
}

When I run this I get:

# perl getmem.pl
Total size = 2748144

yet I don't have 2.7 gigs in physical memory + swap:

# cat /proc/meminfo
         total:    used:    free:  shared: buffers:  cached:
Mem:  1588834304 1562914816 25919488        0 11993088 1055232000
Swap: 1077501952 538742784 538759168
MemTotal:      1551596 kB
MemFree:         25312 kB
MemShared:           0 kB
Buffers:         11712 kB
Cached:         952588 kB
SwapCached:      77912 kB
Active:         813644 kB
Inactive:       582436 kB
HighTotal:      655360 kB
HighFree:         2044 kB
LowTotal:       896236 kB
LowFree:         23268 kB
SwapTotal:     1052248 kB
SwapFree:       526132 kB

(btw, notice the ridiculous 972 megs cached? that's another issue.)

I'm sure linux doesn't have redundant copies of program executables and 
shared libraries for each process.  Many processes are invoked using the 
same executable.  If ps reports the program/shared library memory within 
VSZ then this might explain the large number I'm getting.

Could I parse /proc/<pid>/maps, going through each process and finding 
only those sections which aren't shared libraries/executables? maps 
looks like this:

08048000-080f3000 r-xp 00000000 03:04 293805     /usr/bin/perl
080f3000-080fb000 rw-p 000aa000 03:04 293805     /usr/bin/perl
080fb000-0d37e000 rwxp 00000000 00:00 0
40000000-40013000 r-xp 00000000 03:04 81603      /lib/ld-2.2.5.so
40013000-40014000 rw-p 00013000 03:04 81603      /lib/ld-2.2.5.so
40014000-40015000 rw-p 00000000 00:00 0
40015000-40017000 r-xp 00000000 03:04 539158 
/usr/lib/perl5/site_perl/5.6.1/i386-linux/auto/Time/HiRes/HiRes.so
40017000-40018000 rw-p 00001000 03:04 539158 
/usr/lib/perl5/site_perl/5.6.1/i386-linux/auto/Time/HiRes/HiRes.so
...

So I could sum up the sections where inode=0?  Or should I look at the 
permissions and not count shared? If it's a copy on write page then I 
don't know how many bytes are used by the parent process.

Anyone know if this is the right track/should I do something else/maybe 
there's another tool to help me? thanks for any information.


Thanks in advance,

Brett

