Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbWIIABs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbWIIABs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 20:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWIIABs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 20:01:48 -0400
Received: from intrepid.intrepid.com ([192.195.190.1]:29570 "EHLO
	intrepid.intrepid.com") by vger.kernel.org with ESMTP
	id S1750960AbWIIABq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 20:01:46 -0400
Message-Id: <200609090001.k8901arL009471@intrepid.intrepid.com>
From: "Gary Funck" <gary@intrepid.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: large file corruption (x86_64, ext3) under 2.6.17 kernels?
Date: Fri, 8 Sep 2006 17:01:37 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Thread-Index: AcbTox7vAY9pPTE4RZGg9rDi/47qnw==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Background: Back in May we installed Fedora Core 5 on a newly acquired
Opteron 275 (dual core, dual cpu) development server with 4G of memory
and a Tyan motherboard.  We used an online backup strategy that we
already had in place, where backups were written to two 300G Maxtor SATA
hard drives.  Recently, while trying to restore files from one of
the incremental backups we noticed that the gzip'd dump file was
corrupted.  We then ran "gunzip -t" on all our backups and discovered
that probably 1/3 of them were corrupted, mainly the larger, level 0
dumps, but not exclusively the level 0 dumps.

The file corruption problem seem to occur on large files,
generally in the 5G to 50G range, though there was one 700M file that
was also corrupted.  We have only about six weeks of backups online
-- we noticed that the corrupted files went back at least that far,
but haven't bothered to pull tapes (which are made weekly from the
images saved on the hard drives) to see if the problem has been
in place ever since we switched to the Opteron server.  Note that
the file systems where we saved the backup files are ext3,
with the -T largefile4 setting, but other than that the settings
were default.

Through the process of elimination we determined that the problem
was not the hard drives, not the SATA controller, not "dump", "dd",
or "gzip".  We know that everything was working fine on Fedora Core 5
on a vanilla x86 platform, prior to the move to the Opteron based
system.  This leaves mainly only the kernel and/or the ext3
file system manager as possible sources of the problem.  Note that
server and kernel aren't showing any other signs of problems: no
unusual meeasges in the system log, no other indications of errors
or problems.

The following command illustrates one of the experiments that we ran:
   dump -0 -b 32 -u -a -f - / | gzip -4 | tee /bak1/dump.0.gz >
/raid0/dump.0.gz
After execution of the command above we would expect that /bak1/dump.0.gz
and /raid0/dump.0.gz are identical.  But many times they were not.  In
the example above, the copy on /raid0 was corrupted (as reported by gunzip
-t),
but the copy on /bak1 was not [/raid0 is a 3-ware controller with two 200G
drives running in a RAID-1 configuraion, and /bak1 is an SATA drive].
We wrote a simple test program that writes sequences of blocks of 32k bytes
each, whith a sequence number in each block.  The test program would
read back the blocks and report errors.  We would see a range in the number
of blocks in error, usually in the low 20's out a several gigabyte file
that had roughly 250,000 32k blocks on it.  The file sizes of both
copies of the file were equal.  We could see no particular pattern in
the data blocks that were in error (such as shifting of the data or
interchange of the blocks).

Up until now, we've been running the stock FC5 kernels:
2.6.17-1.2145_FC5 and 2.6.17-1.2157_FC5, and their recently released
predecessors.  We have reasons to believe that both versions of
the kernel were demonstrating the file corruption that we were
seeing.  I should add that we did reboot several times during our
testing to eliminate the possibility that some system state had
been clobbered.  We found corrupted files on the SATA drives, on
different SATA controllers and on the 3ware.  There was no partiuclar
pattern except that we saw file corruption when writing large files.

Today we built and booted the 2.6.18-rc6 kernel, and re-ran our
tests (twice).  We're not seeing the file corruption errors.
We'll be running more extensive tests overnight.

I looked through the archives and didn't see any mention of
this sort of problem, so am wondering if seomthing like this
has been reported against the 2.6.17 kernel, and/or
whether there are some known fixes in the 2.6.18 kernel that
might have addressed issues like this one?

