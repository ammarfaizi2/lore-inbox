Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266778AbUHCSA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266778AbUHCSA4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 14:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266789AbUHCSA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 14:00:56 -0400
Received: from bay7-f23.bay7.hotmail.com ([64.4.11.23]:21523 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S266778AbUHCSAu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 14:00:50 -0400
X-Originating-IP: [193.237.129.167]
X-Originating-Email: [royhills@hotmail.com]
From: "roy hills" <royhills@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Where is my memory going? (2.4.24 Kernel NFS server)
Date: Tue, 03 Aug 2004 19:00:49 +0100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY7-F23AunQmI2T60W0003f946@hotmail.com>
X-OriginalArrivalTime: 03 Aug 2004 18:00:50.0048 (UTC) FILETIME=[CF664800:01C47983]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running a Debian "Woody" x86 (P III) Linux system with 2.4.24 kernel 
which is acting as an NFS file server (using Kernel NFS support) and a 
PostgreSQL database server.  I have 768MB RAM in this system, which is all 
detected by the Kernel.

I can't work out where all the memory is being used, because if I subtract 
the RSS sizes of all processes (from "ps aux") from 768MB, I get an answer 
which is _much_ bigger than I get from "free", even after I adjust for 
buffers and cache.

I suspect that the Kernel NFS server is using the memory, but I can't find 
how to prove this, or how to get the NFS server to report its usage.  The 
nfsd processes show zero RSS in a ps listing.

I'm not 100% sure that this is a Kernel issue, so I apologise for this 
posting if this turns out to be
a user-space issue.

Here is an example:

neon# uname -a
Linux neon 2.4.24 #2 Sun Feb 22 12:49:11 GMT 2004 i686 unknown

neon# uptime
11:37:21 up 28 days, 17:57,  1 user,  load average: 0.06, 0.07, 0.02

neon# free
             total       used       free     shared    buffers     cached
Mem:        775728     728540      47188          0       2116       6972
-/+ buffers/cache:     719452      56276
Swap:       590952       3232     587720

So we've got about 700MB used and about 55MB free after allowing for buffers 
and cache.

neon:/home/rsh# ps aux | awk 'BEGIN {i=0}; {i+=$6}; END {print i}'
11232

Summing up the RSS fields from a "ps aux" listing shows that the processes 
are using about 11MB.  So where is the other 689MB going?

neon:/home/rsh# COLUMNS=75 ps aux
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0  1272   72 ?        S    Jul02   0:03 init [2]
root         2  0.0  0.0     0    0 ?        SW   Jul02   0:00 [keventd]
root         3  0.0  0.0     0    0 ?        SWN  Jul02   0:00 [ksoftirqd_C
root         4  0.0  0.0     0    0 ?        SW   Jul02  24:38 [kswapd]
root         5  0.0  0.0     0    0 ?        SW   Jul02   0:10 [bdflush]
root         6  0.0  0.0     0    0 ?        SW   Jul02   0:04 [kupdated]
root         7  0.0  0.0     0    0 ?        SW<  Jul02   0:00 [mdrecoveryd
root         8  0.0  0.0     0    0 ?        SW<  Jul02   0:00 [raid1d]
root         9  0.0  0.0     0    0 ?        SW<  Jul02   0:00 [raid1d]
root        10  0.0  0.0     0    0 ?        SW<  Jul02   0:00 [raid1d]
root        11  0.0  0.0     0    0 ?        SW<  Jul02   0:00 [raid1d]
root        12  0.0  0.0     0    0 ?        SW<  Jul02   0:00 [raid1d]
root        13  0.0  0.0     0    0 ?        SW   Jul02   0:01 [kjournald]
root       102  0.0  0.0     0    0 ?        SW   Jul02   0:01 [kjournald]
root       103  0.0  0.0     0    0 ?        SW   Jul02   1:43 [kjournald]
root       104  0.0  0.0     0    0 ?        SW   Jul02   4:54 [kjournald]
root       105  0.0  0.0     0    0 ?        SW   Jul02   5:57 [kjournald]
root       106  0.0  0.0     0    0 ?        SW   Jul02   0:01 [kjournald]
daemon     128  0.0  0.0  1384   84 ?        S    Jul02   0:00 /sbin/portma
root       224  0.0  0.0  2024  216 ?        S    Jul02   0:57 /sbin/syslog
root       227  0.0  0.0  2032    4 ?        S    Jul02   0:00 /sbin/klogd
root       231  0.0  0.0  1444    4 ?        S    Jul02   0:00 /sbin/rpc.st
root       237  0.0  0.0  1988    4 ?        S    Jul02   0:00 /usr/sbin/in
root       246  0.0  0.0     0    0 ?        SW   Jul02   0:50 [nfsd]
root       247  0.0  0.0     0    0 ?        SW   Jul02   0:43 [nfsd]
root       248  0.0  0.0     0    0 ?        SW   Jul02   0:50 [nfsd]
root       249  0.0  0.0     0    0 ?        SW   Jul02   0:00 [lockd]
root       250  0.0  0.0     0    0 ?        SW   Jul02   0:00 [rpciod]
root       251  0.0  0.0     0    0 ?        SW   Jul02   0:57 [nfsd]
root       252  0.0  0.0     0    0 ?        SW   Jul02   0:49 [nfsd]
root       253  0.0  0.0     0    0 ?        SW   Jul02   0:52 [nfsd]
root       254  0.0  0.0     0    0 ?        SW   Jul02   0:46 [nfsd]
root       255  0.0  0.0     0    0 ?        SW   Jul02   0:48 [nfsd]
root       258  0.0  0.0  1540    4 ?        S    Jul02   0:00 /usr/sbin/rp
mail       261  0.0  0.0  1720  172 ?        S    Jul02   0:03 /usr/sbin/nu
root       316  0.0  0.0  3776  612 ?        S    Jul02   0:08 /usr/sbin/sn
root       322  0.0  0.0  2780  268 ?        S    Jul02   0:17 /usr/sbin/ss
root       331  0.0  0.2  1976 1968 ?        SL   Jul02   0:00 /usr/sbin/nt
daemon     334  0.0  0.0  1384   52 ?        S    Jul02   0:00 /usr/sbin/at
root       337  0.0  0.0  1652  168 ?        S    Jul02   0:00 /usr/sbin/cr
root       344  0.0  0.0  1252    4 tty1     S    Jul02   0:00 /sbin/getty
root       345  0.0  0.0  1252    4 tty2     S    Jul02   0:00 /sbin/getty
root     16610  0.0  0.1  6328 1516 ?        S    11:31   0:00 /usr/sbin/ss
rsh      16612  0.0  0.2  6428 1580 ?        S    11:31   0:00 /usr/sbin/ss
rsh      16613  0.0  0.1  2220 1264 pts/0    S    11:31   0:00 -bash
root     16621  0.0  0.1  2224 1252 pts/0    S    11:32   0:00 bash
root     16650  0.0  0.1  3512 1516 pts/0    R    11:38   0:00 ps aux

Some other random details:

Using software RAID-1 with two IDE disks.
Hardware is Dell 500SC server.

I'm sure I must be missing something obvious here.  Any ideas or pointers?

Roy

_________________________________________________________________
It's fast, it's easy and it's free. Get MSN Messenger today! 
http://www.msn.co.uk/messenger

