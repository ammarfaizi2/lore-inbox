Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266528AbUA3Bjj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 20:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266527AbUA3BiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 20:38:12 -0500
Received: from grebe.mail.pas.earthlink.net ([207.217.120.46]:16595 "EHLO
	grebe.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S266528AbUA3Bd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 20:33:27 -0500
Message-ID: <020d01c3e6d0$acd78f60$0700000a@irrosa>
From: "Curt Hartung" <curt@northarc.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
References: <01c501c3e6b9$67225f70$0700000a@irrosa> <20040129163852.4028c689.akpm@osdl.org>
Subject: Re: Raw devices broken in 2.6.1? AND- 2.6.1 I/O degraded?
Date: Thu, 29 Jan 2004 20:30:39 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "Curt Hartung" <curt@northarc.com> wrote:
> >
> > New to the list, checked the FAQ and nothing on this. I'm using raw
devices
> > for a large database application (highwinds-software) and under 2.4 it
runs

> Possibly whatever version of 2.4 you're using forgot to check for
> O_LARGEFILE.  But the code looks to be OK.
>

Ah yes, I remember running across "O_LARGEFILE" but my 2.4 was ignoring it
so I figured it was optional, compiling
with-  -D_FILE_OFFSET_BITS=64 -D_LARGEFILE64_SOURCE -D_LARGEFILE_SOURCE and
that seemed to do the trick

Setting O_LARGEFILE fixed the problem, thanks. Glad it was a simple
solution.

I have a separate, far more serious problem with the 2.6 I/O system but I'm
still working through FAQ's to see if its my error.

Long story short- I have a simple test program you can try, to see for
yourself (compare a 2.4 build with 2.6) :
http://66.118.69.159/~curt/bigfile_test.C compile with: gcc -o bf -lpthread
bigfile_test.C

Test platform is- 512M of RAM, athalon 1.33Ghz and some generic IBM drive,
ext2 (no journaling) results at the bottom. Its a vanilla installation of
RedHat 7.2

Long story slightly longer. I am the lead developer at one of the
"enterprise software vendors who has been clamboring for the new threading
model" (highwinds-software, UseNet server software)

I have been on pins and needles waiting for a stable release so I could
test/certify our software on it; our customers are screaming for it and I
want to give it to them, but the performance of our software on this kernel
was pathetic. Stalls, halts, terrible.

I finnaly narrowed it down to the disk subsystem, and the test program shows
the meat of it. When there is massive contention for a file, or just heavy
(VERY heavy) volume, the 2.6.1 kernel (presumably the filesystem portion)
falls over dead. The test program doesn't show death, but could by just
upping the thrasher count a bit.

Where do I go with this? Anyone have any idea who I can take this test
program to? I have been telling our customers for over a year now "Don't
worry, Linux will be able to rock with the new threading model" and then..
this.. I want to be constructive here. Any advice would be appreciated, I'm
new to the Linux community per se, though I've been developing on it for
years.

RESULTS:

Changing ONLY the kernel and rebooting, I ran the program twice to make sure
any buffers were flushed. This had a dramatic effect, as the second (and all
subsequent attempts, these results are representative) were consistenty
better, although the 2.6.1 implementation was still worse.

This test program accurately models the largest job our UseNet software
does, randomly accessing ENORMOUS files. It creates a 2G file and then
accesses it with and without contention.

[root|/usr/local/tornado_be/bin]$ uname -a
Linux professor.highwinds-software.com 2.6.1 #0 SMP Wed Jan 28 01:24:07 EST
2004 i686 unknown

bytes to write[2000027648]
time [227]
1000 random 8192-byte accesses (single threaded)
time [12]
1000 random 2048-byte accesses (single threaded)
time [11]
Now spawning 4 threads to kill the same file
1000 random 8192-byte accesses (with thrashers)
time [65]
1000 random 2048-byte accesses (with thrashers)
time [56]
[curt|/usr/local/test]$ ./bf bigfile
bytes to write[0]
time [0]
1000 random 8192-byte accesses (single threaded)
time [10]
1000 random 2048-byte accesses (single threaded)
time [10]
Now spawning 4 threads to kill the same file
1000 random 8192-byte accesses (with thrashers)
time [57]
1000 random 2048-byte accesses (with thrashers)
time [48]


[curt|/usr/local/test]$ uname -a
Linux professor.highwinds-software.com 2.4.7-10 #1 Thu Sep 6 16:46:36 EDT
2001 i686 unknown

bytes to write[2000027648]
time[139]
1000 random 8192-byte accesses (single threaded)
time[33]
1000 random 2048-byte accesses (single threaded)
time[13]
Now spawning 4 threads to kill the same file
1000 random 8192-byte accesses (with thrashers)
time[42]
1000 random 2048-byte accesses (with thrashers)
time[50]
[curt|/usr/local/test]$ ./bf bigfile
bytes to write[0]
time[0]
1000 random 8192-byte accesses (single threaded)
time[10]
1000 random 2048-byte accesses (single threaded)
time[9]
Now spawning 4 threads to kill the same file
1000 random 8192-byte accesses (with thrashers)
time[44]
1000 random 2048-byte accesses (with thrashers)
time[40]

