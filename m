Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265074AbTF3Pkd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 11:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265075AbTF3Pkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 11:40:33 -0400
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:2063 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S265074AbTF3Pkb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 11:40:31 -0400
Date: Mon, 30 Jun 2003 17:55:02 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Chad Smith <chad_smith@hp.com>
Subject: /dev/mem: lseek+read vs. mmap (long)
Message-Id: <20030630175502.02fe27f4.khali@linux-fr.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(please CC: me on replies, I'm not subscribed to the list)

Hello everyone,

I've come to a curious problem while working on dmidecode [1], and more
particularly when Chad Smith asked me to fix dmidecode so that it would
work on IA-64 systems. Among other problems dmidecode had on IA-64
systems is that the DMI table was unreachable. Dmidecode used to read
this table from /dev/mem using lseek and read calls, and it worked well
for most systems, because most systems have their DMI table between
0xE0000 and 0xFFFFF, that is, at the beginning of the physical memory.
However, some systems have this table almost at the end of the physical
memory. Dmidecode used to fail on "/dev/mem: Unexpected end of file" on
these systems. I couldn't really understand why, since the failing
address was always below the physical limit. All such systems known so
far were laptops (made by IBM and Fujitsu-Siemens) but it happened that
all IA-64 systems also fall into this category. As long as only a few
laptops were affected by the problem, I had accepted it as unsolvable,
but Chad absolutely wanted dmidecode to work on IA-64 systems. He
finally found that using mmap instead of lseek+read would work on IA-64
systems. I had the trick tried on some laptops know not to be supported
by dmidecode, and it worked too. The changes have been commited to
dmidecode CVS since, and there is no more known system on which
dmidecode doesn't work.

As far as dmidecode is concerned, we could consider the problem is
solved. I still don't understand though. I took a look at
linux/drivers/char/mem.c (2.4.21, seems to be the same in 2.5.73 as far
as my problem is concerned), and did some experiments on my own machines
(although I don't own any "faulty" laptop nor any IA-64 system). Here
follows what I understood from my readings and experiments. Please
correct me when I'm wrong, and answer my questions (or redirect me to
the relevant docs) when you can.

1* Read calls on /dev/mem are limited to __pa(high_memory). What is this
limit supposed to represent? I could find that it matches the total
amount of memory my system reports to have (as shown at boot time or
later using dmesg) and is shorter by some kilobytes (80kB on my destop
system, 512kB on my Sony laptop) than the total amount of physical
memory available on the system. Since /dev/mem is supposed to give an
access to the physical memory, why isn't it limited to the exact
physical memory size?

2* Mmap calls on /dev/mem are not limited to a particular boundary, but
behave differently below and over __pa(high_memory) (VM_IO flag, I don't
know what it does, by the way). I noticed that I could even mmap some
kilobytes over my physical memory limit (getting nothing but 0xFF bytes,
but the call doesn't fail). Why is mmap allowed to return the portion of
the memory between __pa(high_memory) and the physical end of the memory
while read is explicitely forbidden to do the same?

Thanks.

[1] http://www.nongnu.org/dmidecode/

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
