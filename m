Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262287AbVCIBoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262287AbVCIBoO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 20:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbVCIBlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 20:41:47 -0500
Received: from fmr21.intel.com ([143.183.121.13]:23180 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S262287AbVCIBjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 20:39:53 -0500
Message-Id: <200503090139.j291dfg16356@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Andrew Morton" <akpm@osdl.org>, "'Jens Axboe'" <axboe@suse.de>
Subject: Direct io on block device has performance regression on 2.6.x kernel
Date: Tue, 8 Mar 2005 17:39:41 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcUkSNzKYDObGXK9SD6A7gSOX+GhIw==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know where to start, but let me start with the bombshell:

Direct I/O on block device running 2.6.X kernel is a lot SLOWER
than running on a 2.4 Kernel!


Processing a direct I/O request on 2.6 is taking a lot more cpu
time compare to the same I/O request running on a 2.4 kernel.

The proof: easy.  I started off by having a pseudo disk, a software
disk that has zero access latency.  By hooking this pseudo disk into
the block layer API, I can effectively stress the entire I/O stack
above the block level.  Combined with user level test programs that
simply submit direct I/O in a simple while loop, I can measure how
fast kernel can process these I/O requests.  The performance metric
can be either throughput (# of I/O per second) or per unit of work
(processing time per I/O).  For the data presented below, I'm using
throughput metric (meaning larger number is better performance).
Pay attention to relative percentage as absolute number depends on
platform/CPU that test suite runs on.


			synchronous I/O			AIO
			(pread/pwrite/read/write)	io_submit
2.4.21 based
(RHEL3)		265,122				229,810

2.6.9			218,565				206,917
2.6.10		213,041				205,891
2.6.11		212,284				201,124

>From the above chart, you can see that 2.6 kernel is at least 18%
slower in processing direct I/O (on block device) in the synchronous
path and 10% slower in the AIO path compare to a distributor's 2.4
kernel.  What's worse, with each advance of kernel version, the I/O
path is becoming slower and slower.

Most of the performance regression for 2.6.9 came from dio layer (I
still have to find where the regression came from with 2.6.10 and 2.6.11).
DIO is just overloaded with too many areas to cover.  I think it's better
to break things up a little bit.

For example, by having a set of dedicated functions that do direct I/O
on block device improves the performance dramatically:

			synchronous I/O			AIO
			(pread/pwrite/read/write)	io_submit
2.4.21 based
(RHEL3)		265,122				229,810
2.6.9			218,565				206,917
2.6.9+patches	323,016				268,484

See, we can be actually 22% faster in synchronous path and 17% faster
In the AIO path, if we do it right!

Kernel patch and test suite to follow in the next couple postings.

- Ken




