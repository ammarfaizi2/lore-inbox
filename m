Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265309AbUAYW71 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 17:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265317AbUAYW71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 17:59:27 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:27004 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S265309AbUAYW7W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 17:59:22 -0500
Message-ID: <40144A36.5090709@samwel.tk>
Date: Sun, 25 Jan 2004 23:59:02 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Felix von Leitner <felix-kernel@fefe.de>, linux-kernel@vger.kernel.org
Subject: Re: Request: I/O request recording
References: <20040124181026.GA22100@codeblau.de> <20040124153551.24e74f63.akpm@osdl.org>
In-Reply-To: <20040124153551.24e74f63.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Felix von Leitner <felix-kernel@fefe.de> wrote:
> 
>>I would like to have a user space program that I could run while I cold
>>start KDE.  The program would then record which I/O pages were read in
>>which order.  The output of that program could then be used to pre-cache
>>all those pages, but in an order that reduces disk head movement.
>>Demand Loading unfortunately produces lots of random page I/O scattered
>>all over the disk.
> 
> I wrote a similar thing in September of 2001.  What you do is:
[...]

When I saw this thread I've fiddled for a bit with the block_dump
functionality that's in the laptop_mode patch. I wanted to see if it
could support a similar thing completely from user space (except for the
block_dump code, of course). I've written a small tool to generate a
complete file that lists tuples (sector, size, device) from the kernel
output in syslog; it parses all "READ block xxx" messages since the
last reboot. Putting this through sort -n -u delivers a nicely sorted
file, ready for optimized reading.

Unfortunately I'm now stuck within the other part, which is reading the
pages back in memory at the next boot. It's not working, and I was 
hoping someone here could take a look and tell me what I'm doing wrong.

Here's what I've tried so far. I've written a program that simply reads 
the ranges by opening the device and reading from sector*512 to 
sector*512+size. It uses async io for efficiency, and to allow the 
kernel to merge read requests. It seems to read all the data, but after 
that the other programs seem to read most of it *again*! I only go from 
8500 down to 7000 reads or so, while most of the 7000 reads that remain 
are also in the range that is being prefetched. :(

I was wondering if the pages could have been removed so soon, so, to 
make sure, I mmaped the whole shebang with MAP_LOCKED and PROT_READ, and 
kept the mapping process in memory during the whole boot process. This 
had exactly the same effect. So, I thought that I might be reading the 
wrong blocks. However, when I feed it something like (160000, 4096, 
hdb1) I get a block_dump log that says exactly that (plus some extra, 
because mmap seems to read in a bit more than needed). So, that's not it.

I'm out of clues. If someone would be so kind to take a look at what I'm 
doing wrong, I'd very much appreciate it. I've put the code up at 
http://www.xs4all.nl/~bsamwel/block_read_replay.tar.gz. How to use it:

1. Patch your kernel with the patch that's included in the tarball. This 
patch modifies the block_dump output slightly, and enables a block_dump 
value of 2 which only reports READ actions. It's against 2.6.1-mm2, but 
it should apply fine to any kernel that has laptop_mode in it.

2. Record the bootup info. Somewhere at the very beginning, include 
"echo 2 > /proc/sys/vm/block_dump" in an init script. Reboot, and after 
the bootup sequence is complete, do echo 0 > /proc/sys/vm/block_dump.

3. "make" and put brexec (one of the two versions) somewhere your init 
scripts can access it.

4. Run slbrp (SysLog Block Read Parser) to generate a block list file: 
slbrp /var/log/syslog | sort -n -u > /etc/bootup_blocks.

5. Precede the echo 2 > /proc/sys/vm/block_dump at startup with a brexec 
("block read executor") call, e.g. "brexec /etc/bootup_blocks". The mmap 
version takes an extra parameter <N> = the number of seconds to keep the 
pages mapped and must be put in the background because it will simply 
wait for N seconds before exiting. So, it should be something like 
"brexec /etc/bootup_blocks 60" and then "sleep 30" to give it time to 
read everything before bootup continues. Yes, it's not pretty. It's just 
used for experimenting, so it doesn't matter.

6. Reboot, and disable block_dump after booting, like in step (2). Now 
the logging of reads only starts _after_ brexec has attempted to load 
all pages, and this gives info on what is still loaded. You'll probably 
see that it loads many things that are also listed in the bootup_blocks 
file. Now my question is: what am I doing wrong that it needs to read 
those again?

-- Bart
