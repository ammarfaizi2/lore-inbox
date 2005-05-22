Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbVEVUjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbVEVUjy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 16:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVEVUjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 16:39:36 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:43167 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261688AbVEVUjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 16:39:20 -0400
Message-ID: <4290EABA.8030504@t-online.de>
Date: Sun, 22 May 2005 22:25:30 +0200
From: Hans Adams <hans.adams-darmstadt@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: de-DE, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Dangerous libata Data Corruption Bug (2.4 & 2.6)
References: <46UjR-6u6-5@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: EIrc1iZE8e4-VlqvoZ45WkYizR2m4fIh30Fe2fW-Kb3cVBbC9xSHsl
X-TOI-MSGID: a1279d57-55c3-4b41-85d1-e9368df05e52
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

perth.adelaide@free.fr wrote:
 >
 > I've been setting up software RAID5/6 file servers for the past few 
month, and I
 > came accross a data corruption bug using the libata driver : It's not 
an easy
 > one to find as I need to copy and copy over data to finally have an error
 > (usually betwen 150GB to 2TB).
 >
 > So far, every server using the libata driver I've setup has this bug
 >
You should take provision to distiguish these errors from those caused
by faulty memory or buggy filesystems.


 > Here's the awful script I've been using to find this bug :
 >
1) I would write to (raw) devices or partitions to circumvent
filesystems.
2) I would make incore tests to circumvent faulty (main) memory.

 > "
 > #!/bin/sh
 > dd if=/dev/urandom of=/tmp/dummy01 bs=1M count=5120
 > md5sum /tmp/dummy01 > /tmp/dummy.md5
 > cd /tmp
 > while [ 1 = 1 ]
 >     do
 >         cp /tmp/dummy01 /tmp/dummy02
 >         rm /tmp/dummy01
 >         cp /tmp/dummy02 /tmp/dummy01
 >         md5sum -cv /tmp/dummy.md5
 >         echo "1" >> /tmp/mdc
 >         rm /tmp/dummy02
 >         echo "Tested over: `cat /tmp/mdc | wc -l`0 GB"
 >     done
 > "
 > -

A proposal in pseudocode:

Step I)

Have two (output) devices named  A und B.

Grab a set of buffers, and memlock those to main memory.
(Just to avoid interactions with VMM and its interaction with
ide-drivers).

Randomly chose one buffer from set  (let us call it buffer A)

Do until the least sized partition is filled
	fill buffer A with a bitpattern (this may be randomly choosen,
					but other may even better work....)
	randomly chose a second buffer from set (let us call it buffer B)
	memcopy buffer A to buffer B
	( be sure to use the fastest available version of memcopy,
	just to stress memory and its interface to cpu
	remember, that some memory tends to be faulty at _READ_)
	compare _BITWISE_ buffers A und B
	if they do not match => faulty memory or memory interface, stop
	output buffer A to device A, buffer B to device B
	put buffer A back to the set of allocated buffers.
	Rename buffer B to buffer A

Bitwise compare device A to device B. => if faulty,
	bad device drivers or devices themselves,  here libata ....

if not, take step II)

Repeat above for all available file systems, but use two files instead
of devices
	to test the filesystems. If error =>
		filesystem or their interaction with block devices and buffer
management

if not, take step III)
Repeat step I with buffers not memlocked....
	if error => faulty buffer management and its interaction with VMM

if not, take step IV)
Repeat step II with buffers not memlocked ....
	if error => faulty buffer management and its interaction both with VMM
and 				filesystems

If not, your system seems healthy....

Some hints regarding fast memcpy, using gcc:
Including <memory.h>,
and compiling your program with at least -O, should result in compiled
code like:

...prolog

movl $buffer_B, %edi
movl $buffer_A, %esi
cld
movl $262144,%ecs
rep movsl		; that is one of the fastest ways to copy memory contents

epilog ...

Please try it, and best wishes, Hans Adams

