Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277261AbRJDXGD>; Thu, 4 Oct 2001 19:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277263AbRJDXFy>; Thu, 4 Oct 2001 19:05:54 -0400
Received: from mailb.telia.com ([194.22.194.6]:21770 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id <S277261AbRJDXFn>;
	Thu, 4 Oct 2001 19:05:43 -0400
Message-Id: <200110042306.f94N69W22095@mailb.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com (Linus Torvalds)
Subject: [DATAPOINT] how max_readahead settings affect streaming throughput
Date: Fri, 5 Oct 2001 01:01:07 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

Summary: simultaneous streaming throughput up from 11 MB/s to 26 MB/s

With my "[PATCH] scaling of 'max_readahead' in /proc/ide/hda/settings"
I have been able to test different max_readaheads effect on throughput
when reading files bigger than RAM.

I question the decision to use 124 kB as default read ahead maximum.
The example cited was a FTP server serving 100 clients. With standard
readahead it would give 12.8 MB readahead (note: not for all files, only for
those file / processing combinations that makes use of it... Maybe the MIN
should be pushed up too)
With my earlier guess of 511 pages, 2MB, readahead for 100 files would
require 200MB RAM, not that unlikely available for a FTP server serving 100 
clients...

Viewing the result of this run I would recommend pushing it up somewere
in between - what about 1024 kB (100MB for 100 clients)
Concerned FTP operators could limit this or rather add memory, but there
are alot of people out there that might read two huge files simultaneous...
[I do not have a SCSI disk, readahead can not be changed on the fly
in Linus kernels - possible in Alan Cox but I guess they also have
the bug I found in 2.4.11-pre2. The results can't be that different. Since
the disk can not read data while the head is seeking...]

This huge gain is due to the seek time between files is approximately
the same as the actual read takes, resulting in halved throughput...

data as octave commands, can also be interpreted directly by humans :-)

/RogerL

------------------------------------------------------
kernel: 2.4.11-pre2 with max_readahead scaling patch
CPU: 933MHz Pentium III
HD is: IBM-DTLA-307045 (2MB cache)

diff = diff --brief huge1 huge2 # files are identical
read = cat huge1 huge2 >/dev/null
read2 = cat huge1 > /dev/null &
	cat huge2 >/dev/null
	# use the one that took the longest time

octave> x=4096/1024*[2047 1023 511 255 127 63 31] #get size in kB
x =

  8188  4092  2044  1020   508   252   124

octave> semilogx(
	x, [27.5, 27.4, 26.0, 25.5, 24.2, 21.5, 11.6],';diff;',
	x, [27.2, 27.3, 26.9, 28.4, 28.5, 28.5, 28.4],';read;',
	x, [26.3, 26.3, 26.3, 26.9, 27.2, 25.8, 10.9],';read2;')

-- 
Roger Larsson
Skellefteå
Sweden
