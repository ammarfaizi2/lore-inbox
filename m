Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWBVDFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWBVDFt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 22:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWBVDFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 22:05:49 -0500
Received: from tomts20-srv.bellnexxia.net ([209.226.175.74]:22468 "EHLO
	tomts20-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751257AbWBVDFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 22:05:48 -0500
Date: Tue, 21 Feb 2006 22:00:44 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org
Subject: blktrace daemon vs LTTng lttd
Message-ID: <20060222030044.GB17987@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.31-grsec (i686)
X-Uptime: 21:39:03 up 14 days, 22:53,  4 users,  load average: 0.21, 0.11, 0.08
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi M. Axboe,

Tom Zanussi just informed me of your work of blktrace. I think that some aspects
of our respective projects (mine being LTTng) shows resemblances.

LTTng is a system wide tracer that aims at tracing programs/librairies and the
kernel. There is a version currently available at http://ltt.polymtl.ca. Is has
a viewer counterpart (LTTV) that analyses and show graphically the traces takes
by LTTng.

I just looked at the blktrace code, and here are some parts we share :

- We both use RelayFS for data transfer to user space.
- We both need to get highly precise timestamps.

Where LTTng might have more constraints is on the performance and reentrancy
side : my tracer is NMI reentrant (using atomic operations) and must be able to
dump data at a rate high enough to sustain a loopback ping flood (with
interrupts logged). Time precision must permit to reorder events occuring very
closely on two different CPUs.

I already developed a multithreaded daemon (lttd) that generically reads the
RelayFS channels : it uses mmap() and 4 ioctl() to control the channel
buffers. I just discussed it with Tom Zanussi in the following thread :

http://www.listserv.shafik.org/pipermail/ltt-dev/2006-February/001245.html

Here is the argumentation I gave to justify the use of ioctl() for RelayFS
channels (in the same discussion) :

http://www.listserv.shafik.org/pipermail/ltt-dev/2006-February/001247.html

I suggest to integrate my ioctl addition to the RelayFS channels so they can be
used very efficiently with both mmap() and ioctl() to control the reader.

It would be trivial to use send() instead of write() to adapt lttd to the
networked case. 

Using mmap() and write() instead or read() and write() would eliminate the
extra copy blktrace is doing when it writes to disk.

What do you think about it ?


On another point, I looked at your timekeeping in blktrace and I think you could
gain precision by using a monotonic clock instead of do_gettimeofday (which is
altered by NTP).


Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
