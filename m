Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262785AbVDHKUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262785AbVDHKUv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 06:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262783AbVDHKTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 06:19:17 -0400
Received: from kiwi.iasi.rdsnet.ro ([213.157.176.3]:2730 "EHLO
	mail.iasi.rdsnet.ro") by vger.kernel.org with ESMTP id S262784AbVDHKNp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 06:13:45 -0400
Date: Fri, 8 Apr 2005 13:13:40 +0300 (EEST)
From: Tarhon-Onu Victor <mituc@iasi.rdsnet.ro>
To: linux-kernel@vger.kernel.org
Subject: ACPI/HT or Packet Scheduler BUG?
Message-ID: <Pine.LNX.4.61.0504081225510.27991@blackblue.iasi.rdsnet.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 	I am not subscribed to this list so please CC me if you post a 
reply, if you need additional info or if you suggest a patch (in which 
I would be very interested).

 	Occurrence:
 	- the kernels must be compiled with Hyper Threading support (and
the CPU/MB must support it);
 	- a (tc) process is reading statistics from the htb tree and another
tries to delete or deletes the tree.
 	The bug will not occur if the system is booted with acpi=off or 
if it's not SMP (HT) capable. I reproduced the bug on 2.6.10-1.770_FCsmp 
(Fedora Core update package) and vanilla 2.6.11, 2.6.11.5, 2.6.11.6, 
2.6.12-rc1 and 2.6.12-rc2 compiled with SMP and ACPI support in order to 
enable Hyper Threading (with and without preempt, with or without SMT 
support). The compiler I used is GCC version 3.4.2 (from Fedora Core 3).

 	Result: almost all the time the system hangs but still can 
execute SysRq commands.

 	How I tested
 	~~~~~~~~~~~~
 	On a console I was running a script that initializes a htb tree 
on an interface (dummy0) in an endless loop:
 	while /bin/true; do . htbdown.dummy0.sh; done
 	...and on another console I run tc -s also in an endless loop:
 	while /bin/true; do tc -s class sh dev dummy0; done

 	After a while (sometimes after 2 runs of the htbdown.dummy0.sh 
script, sometimes after 20) the system hangs. It still responds to SysRq 
commands and I was able to see the two tc processes running. Sometimes I 
still have ping replies from it and one time, just one time in 2 days I 
still was able to log in remotely.
 	There are no printk messages, or no other warnings or errors 
printed in the system log or kernel log. It just hangs and it seems like 
something is wasting all the CPU power: when I still was able to log in 
I noticed that one of the two virtual CPUs was 100% with system 
interrupts and the other was 100% system. I wasn't able to strace any of 
the two running tc's.
 	What I was able to paste with the mouse in my console, to catch 
in a typescript and also the script that initializes the htb tree on 
dummy0 can be found at ftp://blackblue.iasi.rdsnet.ro/pub/various/k/ .
 	The test host is a 3.0GHz Intel Prescott and I first noticed the 
bug on a system with a 2.8GHz Intel Northwood, both having motherboards 
with Intel chipset (865GBF). I am not able to test it in other SMP 
environments (Intel Xeon or Itanium, AMD Opteron, Dual P3, etc), so I'm 
not able to tell if it's an ACPI bug, a SMP bug or a Packet Scheduler 
bug.


-- 
Any views or opinions presented within this e-mail are solely those of
the author and do not necessarily represent those of any company, unless
otherwise expressly stated.
