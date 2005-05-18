Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262196AbVERRp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbVERRp7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 13:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVERRp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 13:45:59 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:14777 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S262196AbVERRph
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 13:45:37 -0400
Date: Wed, 18 May 2005 19:45:30 +0200
From: Jan Kasprzak <kas@fi.muni.cz>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: XFS lstat() _very_ slow on SMP
Message-ID: <20050518174530.GF19173@fi.muni.cz>
References: <20050516162506.GB19415@fi.muni.cz> <20050518140258.GA22587@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <20050518140258.GA22587@infradead.org>
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Christoph Hellwig wrote:
: On Mon, May 16, 2005 at 06:25:06PM +0200, Jan Kasprzak wrote:
: > 	Hi all,
: > 
: > 	I have a big XFS volume on my fileserver, and I have noticed that
: > making an incremental backup of this volume is _very_ slow. The incremental
: > backup essentially checks mtime of all files on this volume, and it
: > takes ~4ms of _system_ time (i.e. no iowait or what) to do a lstat().
: 
: Thanks a lot for the report, I'll investigate what's going on once I get
: a little time.  (Early next week I hope)

	Hmm, I feel like I am hunting ghosts - after a fresh reboot
of the 4-CPU server I did four runs of 128*128*128 files with various
sizes of the underlying filesystem (in order to eliminate the volume
size as a problematic factor). I've got the following numbers:

Volume size   create time           find -mtime +1000     cost of lseek()
  5GB         55m77 real 52m51 sys  1m1 real 0m53 sys       19 usecs
 25GB         58m15 real 55m27 sys  83m47 real 82m15 sys  2171 usecs (!!!!!!)
125GB         67m0 real 61m35 sys   0m55 real 0m48 sys      18 usecs
625GB         68m30 real 62m38 sys  0m57 real 0m49 sys      18 usecs

	So the results are probably not dependent on the volume size,
but on something totally random (such as which cpu the command
ends up running on or something like that), or on the system uptime
(and implied fragmentation of memory or what).

	I've tried to re-run the same test the next day (i.e. on
server with longer uptime), but the server crashed - my test script
ended locked up somewhere in kernel (probably holding some locks),
and then other processes started to lock up after accessing the file
system (my top(1) was running OK, but when I tried to "touch newfile"
in another shell, it locked up as well).  So I had to reset this server
again.

	I am not really sure where exactly the problem is. I think
it is related to XFS, big memory of this server (26 GB), four CPUs,
and maybe even the x86_64 architecture. I was not able to reproduce
the problem on the same HW using ext3fs, and the problem is also
a magnitude smaller on 2-way system with 4GB of RAM. Maybe I should
try to reproduce this on our Altix box to eliminate the x86_64 as the
possible source of problems.

	I use the attached "bigtree.pl" to create the directory structure
("time ./bigtree.pl /new-volume 3 128" for 128*128*128 files), and then
"strace -c find /new-volume -type f -mtime +1000 -print" (the numbers
without strace are almost the same, so strace is not a problem here).

	Thanks,

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
-- Yes. CVS is much denser.                                               --
-- CVS is also total crap. So your point is?             --Linus Torvalds --

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bigtree.pl"

#!/usr/bin/perl -w

use strict;

if ($#ARGV != 2) {
	print STDERR "Usage: $0 prefix depth width\n\t$0 /mnt1 2 256\n";
	exit 1;
}

my ($prefix, $maxdepth, $files) = @ARGV;
my $print = 10_000;
my $count = 0;
my $total = 0;

sub depth($$);

sub depth($$) {
	my ($depth, $prefix) = @_;
	for my $i (0..$files-1) {
		my $p = $prefix . '/' . $i;
		if ($depth < $maxdepth) {
			mkdir $p or die "mkdir $p: $!";
			depth($depth+1, $p);
		} else {
			open F, ">$p" or die "open $p: $!";
			close F;
			unless (++$count % $print) {
				print STDERR "$count/$total files created\n"
					if -t STDERR;
			}
		}
	}
}

$total = $files**$maxdepth;
depth (1, $prefix);

--3MwIy2ne0vdjdPXF--
