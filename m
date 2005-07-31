Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261825AbVGaQnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbVGaQnH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 12:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbVGaQlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 12:41:01 -0400
Received: from rutherford.zen.co.uk ([212.23.3.142]:12697 "EHLO
	rutherford.zen.co.uk") by vger.kernel.org with ESMTP
	id S261825AbVGaQkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 12:40:00 -0400
Date: Sun, 31 Jul 2005 17:39:33 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: IO scheduling & filesystem v a few processes writing a lot
Message-ID: <20050731163933.GB7280@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.10-5-k7-smp (i686)
X-Uptime: 17:09:34 up 1 day,  5:16,  2 users,  load average: 2.13, 2.29, 2.51
User-Agent: Mutt/1.5.6+20040907i
X-Originating-Rutherford-IP: [212.23.14.246]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I've got a backup system that I'm trying to eek some more performance
out of - and I don't understand the right way to get the kernel to
do disc writes efficiently - and hence would like some advice.

I was using rsync, but the problem with rsync is that I have
a back up server then filled with lots and lots of small files
- I want larger files for spooling to tape.
(Other suggestions welcome)

So I'm trying switching to streaming gzip'd tars from each
client to backup to the server. I have one server that
opens connections to each of the clients and sucks the data
using netcat (now netcat6 in ipv4 mode) and writes it to
disc, one file per client.   Now the downside here
relative to rsync is that it is going to transfer and
write a lot more data.

Now the clients are on 100Mb/s, and the server on GigE,
the clients sometime have to think while they gzip their data, so I'd
like to suck data from multiple clients at once.  So I run multiple of
these netcat's in parallel - currently about 9.

I've benchmarked write performance on the filesystem at
60-70MB/s for a single write process (as shown with iostat)
for a simple dd if=/dev/zero of=abigfile bs=1024k

My problem is that with the parallel writes iostat is showing
I'm actually getting ~3MB/s write bandwidth - that stinks!

The machine is a dual xeon with 1GB of RAM, an intel GigE
card and a 2.6.11 kernel, a 3ware-9000 series pci-x controller
with a 1.5TB RAID5 partition running Reiser3.  Reiser3 is used
because I couldn't get ext3 stable on a filesystem of this size
(-64ZByte free shown in df), and xfs didn't seem stable on
recovering from an arbitrarily placed reset.  The 3ware has
write caching (with battery backup). (Note this is the 9000
series SATA ones, not the older 7000/8000 that really did suck
when writing).  The CFQ scheduler is being used and I've turned up
nr_requests to 1024.

So as I see it I have to persuade all appropriate parts to buffer
sensibly and try and generate as large I/O requests as possible;
I've told netcat6 (on the read side) to use 128k buffers:
  nc6 -4 --recv-only --buffer-size=131072 --idle-timeout=3600

Iostat is showing the world is not happy:
avg-cpu:  %user   %nice %system %iowait   %idle
           0.15    0.00    2.65   97.20    0.00

Device:    rrqm/s wrqm/s   r/s   w/s  rsec/s  wsec/s    rkB/s    wkB/s
sda          0.00 249.95  0.10 193.62    0.80 3548.55     0.40  1774.28
avgrq-sz avgqu-sz   await  svctm  %util
18.32    1290.24   8225.93  5.15  99.73

avg-cpu:  %user   %nice %system %iowait   %idle
           0.15    0.00    3.05   95.95    0.85

Device:    rrqm/s wrqm/s   r/s   w/s  rsec/s  wsec/s    rkB/s    wkB/s
sda          0.00 260.96  0.00 217.62    0.00 4342.74     0.00  2171.37
avgrq-sz avgqu-sz   await  svctm  %util
19.96    1630.13   6951.26  4.60 100.12

(I could do with a pointer to something explaining all the fields here!)

But as I read this, the machine is stuck waiting on I/O (OK), but
only managing to write ~2MB/s - and seems to have done that 2MB in
about 200 writes (am I reading that correctly?) - which is rather
on the small side.

So I can understand it going slowly if it is interleaving all the
requests at tiny 10KB writes all over the disc - how do I persuade
it I'd like it to buffer more and get larger writes - or
how do I understand why it isn't?

At the moment it is feeling like I'm going to have to write
something that has a single process doing the writes and
accumulates the data from all the clients itself so that there
is only ever one process writing.

I'm open for all suggestions.

Dave
--
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
