Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262862AbSJGE03>; Mon, 7 Oct 2002 00:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262863AbSJGE03>; Mon, 7 Oct 2002 00:26:29 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:41508 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id <S262862AbSJGE02>; Mon, 7 Oct 2002 00:26:28 -0400
From: "Joseph D. Wagner" <wagnerjd@prodigy.net>
To: "Linux Kernel Development List" <linux-kernel@vger.kernel.org>
Subject: Idea: (Category: Memory Management) Increase the Number of Lists of Blocks that Contain Groups of Contiguous Page Frames
Date: Sun, 6 Oct 2002 23:31:52 -0500
Message-ID: <000901c26dba$7d4f7860$5f71d73f@joe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IDEA: (Category: Memory Management) Increase the Number of Lists of
Blocks that Contain Groups of Contiguous Page Frames

STATUS QUO: Currently, the Buddy System Algorithm, the kernel's strategy
for allocating groups of contiguous page frames, uses ten (10) groups of
lists of blocks that contain groups of 1, 2, 4, 8, 16, 32, 64, 128, 256,
and 512 contiguous page frames, respectively.  Since page frames are 4KB
in size, in terms of real memory usage these groups are 4KB, 8KB, 16KB,
32KB, 64KB, 128KB, 256KB, 512KB, 1MB, and 2MB in size, respectively.

PROBLEM: Applications that demand significant amounts of memory are
becoming increasingly popular and prevalent, such as digital video
editing, CAD, scientific and mathematical computations, games, and other
GUI applications.  Many of these applications may initially need more
than 2MB of contiguous memory.

While the memory manager currently handles this problem by assigning
multiple blocks of 2MB, these applications could benefit from the memory
manager maintaining larger contiguous blocks, especially on systems with
high memory (>= 896MB).

EXAMPLE: The X Windowing System uses an average of 10MB-16MB would
benefit from one honkin' 16MB contiguous memory chunk.

PROPOSED CHANGE: Change the number of groups of lists of blocks from ten
(10) to twenty-four (24).  This will allow the memory manager to group
free contiguous memory in chunks as large as 32GB.

Line 18 of the file "includes/linux/mmzone.h" should be changed from:

	#define MAX_ORDER 10

	to

	#define MAX_ORDER 24

I have tested this change on my own system with no adverse affects.

NOTE: This seems way too easy, IMHO.  I'm not an experienced kernel
developer so someone please check me on this.

STATISTICS: Unfortunately, I don't use my Linux system enough to get a
wide enough statistical sample.  In theory, a computer should experience
performance gains -- whether nominal or significant, I don't know --
when assigning larger chunks of memory to those applications that demand
more memory, but I'm going to have to rely on other Linux users and
developers to see if the theory is proven true.

Q&A: Why 32GB?
Linux supports a maximum of 64GB of memory, but there will never be a
case when all 64GB are free simply because the kernel itself will use
some memory.  Hence, the largest chunk that could ever be allocated is
32GB.

Doesn't having that many lists create a problem for computers without
that much memory?
Not at all.  On systems that don't have that much memory, those extra
lists will simply remain empty.  Again, I've tested this change on my
own system (256MB memory) with no adverse affects, but also see my note.

Why bother increasing the number of lists at all?
I'd like to respond with a question: why not cut the number of lists
down to three (3)?  Because the overhead involved in allocating 128 16KB
chunks is horrendous, especially when you could just allocate one 2MB
chunk.  Likewise, more demanding applications will benefit from the
reduced overhead of having more lists, but see my point in statistics.

Joseph Wagner

