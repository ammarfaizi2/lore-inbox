Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162932AbWLBLBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162932AbWLBLBA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162945AbWLBLA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 06:00:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:1963 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1162946AbWLBLA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 06:00:56 -0500
X-Authenticated: #3612999
Date: Sat, 2 Dec 2006 12:00:36 +0100 (CET)
From: Karsten Weiss <knweiss@gmx.de>
To: Christoph Anton Mitterer <calestyo@scientia.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives //
 memory hole mapping related bug?!
In-Reply-To: <4570CF26.8070800@scientia.net>
Message-ID: <Pine.LNX.4.64.0612021048200.2981@addx.localnet>
References: <4570CF26.8070800@scientia.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christoph!

On Sat, 2 Dec 2006, Christoph Anton Mitterer wrote:

> I found a severe bug mainly by fortune because it occurs very rarely.
> My test looks like the following: I have about 30GB of testing data on

This sounds very familiar! One of the Linux compute clusters I
administer at work is a 336 node system consisting of the
following components:

* 2x Dual-Core AMD Opteron 275
* Tyan S2891 mainboard
* Hitachi HDS728080PLA380 harddisk
* 4 GB RAM (some nodes have 8 GB) - intensively tested with
   memtest86+
* SUSE 9.3 x86_64 (kernel 2.6.11.4-21.14-smp) - But I've also
   e.g. tried the latest openSUSE 10.2 RC1+ kernel 2.6.18.2-33 which
   makes no difference.

We are running LS-Dyna on these machines and discovered a
testcase which shows a similar data corruption. So I can
confirm that the problem is for real an not a hardware defect
of a single machine!

Here's a diff of a corrupted and a good file written during our
testcase:

("-" == corrupted file, "+" == good file)
...
  009f2ff0  67 2a 4c c4 6d 9d 34 44  ad e6 3c 45 05 9a 4d c4  |g*L.m.4D..<E..M.|
-009f3000  39 60 e6 44 20 ab 46 44  56 aa 46 44 c2 35 e6 44  |9.D .FDV.FD.5.D|
-009f3010  45 e1 48 44 88 3d 47 44  f3 81 e6 44 93 0b 46 44  |E.HD.=GD...D..FD|
-009f3020  d4 eb 48 44 22 57 e6 44  3d 3d 48 44 ac 89 49 44  |..HD"W.D==HD..ID|
-009f3030  00 8c e9 44 39 af 2d 44  e7 1b 8d 44 a8 6e e9 44  |...D9.-D...D.n.D|
-009f3040  16 d4 2e 44 5e 12 8c 44  78 51 e9 44 c0 f5 2f 44  |...D^..DxQ.D../D|
...
-009f3fd0  22 ae 4e 44 81 b5 ee 43  0c 8a df 44 8d e2 6b 44  |".ND...C...D..kD|
-009f3fe0  6c a0 e8 43 b6 8f e9 44  22 ae 4e 44 55 e9 ed 43  |l..C...D".NDU..C|
-009f3ff0  a8 b2 e0 44 78 7c 69 44  56 6f e8 43 5e b2 e0 44  |...Dx|iDVo.C^..D|
+009f3000  1b 32 30 44 50 59 3d 45  a2 79 4e c4 66 6e 2f 44  |.20DPY=E.yN.fn/D|
+009f3010  40 91 3d 45 d1 b6 4e c4  a1 6c 31 44 1b cb 3d 45  |@.=E..N..l1D..=E|
+009f3020  0d f6 4e c4 57 7c 33 44  bf cb 3c 45 88 9a 4d c4  |..N.W|3D..<E..M.|
+009f3030  79 e9 29 44 3a 10 3d 45  d3 e1 4d c4 17 28 2c 44  |y.)D:.=E..M..(,D|
+009f3040  f6 50 3d 45 dc 25 4e c4  b6 50 2e 44 b3 4f 3c 45  |.P=E.%N..P.D.O<E|
...
+009f3fd0  9c 70 6c 45 04 be 9f c3  fe fc 8f 44 ce 65 6c 45  |.plE.......D.elE|
+009f3fe0  fc 56 9c c3 32 f7 90 44  e5 3c 6c 45 cd 79 9c c3  |.V..2..D.<lE.y..|
+009f3ff0  f3 55 92 44 c1 10 6c 45  5e 12 a0 c3 60 31 93 44  |.U.D..lE^...1.D|
  009f4000  88 cd 6b 45 c1 6d cd c3  00 a5 8b 44 f2 ac 6b 45  |..kE.m.....D..kE|
...

Please notice:

a) the corruption begins at a page boundary
b) the corrupted byte range is a single memory page and
c) almost every fourth byte is set to 0x44 in the corrupted case
    (but the other bytes changed, too)

To me this looks as if a wrong memory page got written into the
file.

>From our testing I can also tell that the data corruption does
*not* appear at all when we are booting the nodes with mem=2G.
However, when we are using all the 4GB the data corruption
shows up - but not everytime and thus not on all nodes.
Sometimes a node runs for ours without any problem. That's why
we are testing on 32 nodes in parallel most of the time. I have
the impression that it has something to do with physical memory
layout of the running processes.

Please also notice that this is a silent data corruption. I.e.
there are no error or warning messages in the kernel log or the
mce log at all.

Christoph, I will carefully re-read your entire posting and the
included links on Monday and will also try the memory hole
setting.

If somebody has an explanation for this problem I can offer
some of our compute nodes+time for testing because we really
want to get this fixed as soon as possible.

Best regards,
Karsten

-- 
Dipl.-Inf. Karsten Weiss - http://www.machineroom.de/knweiss
