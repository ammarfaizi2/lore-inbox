Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278303AbRJSG3j>; Fri, 19 Oct 2001 02:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278317AbRJSG3T>; Fri, 19 Oct 2001 02:29:19 -0400
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:3082 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S278303AbRJSG3I>; Fri, 19 Oct 2001 02:29:08 -0400
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Fri, 19 Oct 2001 08:29:36 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: SMP-i386: Linux timekeeping
Message-ID: <3BCFE46A.28403.1C1D7F@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
X-Content-Conformance: HerringScan-0.9/Sophos-3.50+2.6+2.03.079+01 October 2001+68125@20011019.062007Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I haven't stidied the latest changes in the kernel (since 2.4.7), but I 
got positive feedback from a user regarding my experimental patches 
"PPSkit-CVS-2.4.7-TEST_SMP*" that can be found on ftp.kernel.org 
somewhere near daemons/ntp/PPS.

These two patches add new functionality so that SMP systems with 
different, but relative constant (i.e. drifting at the same rate) clock 
speeds for the CPUs are handled better.

Of course nothing comes for free: I use TSC calibration per CPU during 
startup and a per-CPU TSC conversion factor plus last_TSC values per 
CPU. To avoid inter-CPU interrupts, I chose to let the CPU that 
processes the timer interrupt update the other CPUs' data.

Currently I use no locks to protect the data. Doing so might cause some 
time spikes when a value is read while being updated.

Can some guru here tell me what lock to use, or is a new one required?
Usually things like cpu_data[] are read-only, but I update them now 
from time to time.

The code deals with nanoseconds, and the performance that a test user 
reported was (under load):

assert 10035 time 1003435349.891827405 delta 0.999942712 jitter -2413
assert 10036 time 1003435350.891774086 delta 0.999946681 jitter 3969
assert 10037 time 1003435351.891723976 delta 0.999949890 jitter 3209
assert 10038 time 1003435352.891663539 delta 0.999939563 jitter -10327
assert 10039 time 1003435353.891610403 delta 0.999946864 jitter 7301
assert 10040 time 1003435354.891553922 delta 0.999943519 jitter -3345
assert 10041 time 1003435355.891498601 delta 0.999944679 jitter 1160
assert 10042 time 1003435356.891446761 delta 0.999948160 jitter 3481
assert 10043 time 1003435357.891387342 delta 0.999940581 jitter -7579
assert 10044 time 1003435358.891332625 delta 0.999945283 jitter 4702

(Comparing the system clock to a one-pulse-per-second external pulse 
applied to the serial port)

So if anybody wants to play with the code, do so. But don't use the 
kernel for your production database right now! The non-SMP variant 
works on i386 for weeks at home.

A port to a more recent kernel is planned as soon as the branch seems 
stable enough.

Regards,
Ulrich
(I am not subscribed to linux-kernel, so make sure I get your comments)

