Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264484AbTLVVfm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 16:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264489AbTLVVfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 16:35:42 -0500
Received: from mail.it4u.net ([81.8.150.196]:32271 "EHLO mail.it4u.net")
	by vger.kernel.org with ESMTP id S264484AbTLVVfl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 16:35:41 -0500
From: Anders Torger <torger@ludd.luth.se>
To: linux-kernel@vger.kernel.org
Subject: Finding a user space alternative to the (removed) OOM killer
Date: Mon, 22 Dec 2003 22:35:42 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312222235.42228.torger@ludd.luth.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It has come to my attention that the OOM killer has been removed. I used it 
actively in my software in a hackish fashion, in the following way:

I have implemented a reverb processor using convolution running on a compact 
linux platform, using no swap memory. In the setup process, there is a 
benchmarking algorithm that finds out through a series of test runs how short 
I/O delay (cpu limited) and how long reverb tails (memory limited) the 
computer can handle. The ugly (or elegant) hack here was to set the convolver 
process to user nobody and a nicer priority when it allocates its convolution 
buffers (can be more than hundred megabytes), which then will get it killed 
by the OOM killer if it runs out of memory, which is detected and treated by 
supporting code as it ran out of memory. All memory is touched by memset and 
an temporary dummy buffer of 10 megabytes is allocated last, touched and then 
released to verify that there is a bit of spare memory left.

This solution proved to work well on the embedded system. In some rare 
occasions with a larger amount of processes, the OOM killer could kill the 
wrong process despite the leads, but that happened seldom enough so I did not 
care about making a better solution. 

Until now that is. Without the OOM killer, the hack does not work at all, so I 
need some new method. One idea is to verify at each malloc call that there is 
enough memory left in the system in order to service it and if not, return 
NULL. If the system has swap, the system would be defined to be out of memory 
if any of the allocated memory has to be put to swap disk (the convolver is 
realtime and thus needs realtime access to memory).

The problem is to implement the function (user space please) that returns how 
many more bytes one can safely allocate without forcing anything to a swap or 
running the system out of memory. Perhaps it is possible to use /proc/meminfo 
to implement this?

Any ideas?

/Anders Torger

