Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266887AbUHVN0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266887AbUHVN0c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 09:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266894AbUHVN0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 09:26:32 -0400
Received: from adicia.telenet-ops.be ([195.130.132.56]:21171 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S266887AbUHVN03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 09:26:29 -0400
From: Karl Vogel <karl.vogel@seagha.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.8.1: swap storm of death
Date: Sun, 22 Aug 2004 15:27:10 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408221527.10303.karl.vogel@seagha.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can bring down my box by running a program that does a calloc() of 512Mb 
(which is the size of my RAM). The box starts to heavily swap and never 
recovers from it. The process that calloc's the memory gets OOM killed (which 
is also strange as I have 1Gb free swap).

After the OOM kill, the shell where I started the calloc() program is alive 
but very slow. The box continues to swap and the other processes remain dead.

To gather some more statistics, I did the following:

- start 'vmstat 1|tee vmstat.txt' in 1 VT session.
- run expunge (= program that does calloc(512Mb)) in another VT.

The box freezes for some time. After a while expunge is OOM killed, the vmstat 
on the other VT remains dead. A ping over the network is still possible and I 
can still start programs on the expunge VT, albeit it is slow as the disk is 
still thrashing.



The diagnostics can be found here:

* Kernel .config
  http://users.telenet.be/kvogel/config.txt

* expunge program
  http://users.telenet.be/kvogel/expunge.c

* vmstat 1  output while executing expunge (this freezes)
  http://users.telenet.be/kvogel/vmstat.txt

* vmstat in expunge VT after the OOM kill
  http://users.telenet.be/kvogel/vmstat-after-kill.txt

* /proc/slabinfo after OOM kill
  http://users.telenet.be/kvogel/slab.txt

* swapon -s
Filename                                Type            Size    Used    
Priority
/dev/hda3                               partition       1044216 0       -1

* Kernel boot line:
       kernel /vmlinuz-2.6.8.1 ro root=/dev/compat/root elevator=cfq 
voluntary-preempt=3 preempt=1

Kernel was patched with voluntary-preempt-2.6.8.1-P7
syslogd & klogd weren't running and 'dmesg -n 1' was done beforehand.



