Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292702AbSBZTGv>; Tue, 26 Feb 2002 14:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292705AbSBZTGm>; Tue, 26 Feb 2002 14:06:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42250 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292702AbSBZTGg>;
	Tue, 26 Feb 2002 14:06:36 -0500
Message-ID: <3C7BDC57.A835D657@zip.com.au>
Date: Tue, 26 Feb 2002 11:04:55 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Florian Lohoff <flo@rfc822.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [CRASH] gdth / __block_prepare_write: zeroing uptodate buffer! / NMI 
 Watchdog detected LOCKUP
In-Reply-To: <20020226184043.GA10420@paradigm.rfc822.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Lohoff wrote:
> 
> Hi,
> i have been looking for deadlocks we are experiencing on a couple of
> SMP machines (Dual Celeron and Dual PIII). After a night stressing a
> spare machine with dbench/bonnie++/tcpspray the machine locked up 30
> minutes after i killed the test. The last messages on the console were:
> 
> __block_prepare_write: zeroing uptodate buffer!

Yup.   This happens when the disk fills up.  Andrea and I were
discussing it over the weekend.   There's a new patch in the -aa
kernels which doesn't quite fix it :(

We'll fix it in 2.4.19-pre somehow.  It's possible that this problem
causes a chnuk of zeroes to be written into the file when you hit
ENOSPC, which is rather rude.  But your file was truncated anyway.

> 15 times - Machine was answering ping first but stopped after a couple
> of minutes. Another couple of minutes later the nmi_watchdog stepped in
> and produced an oops:

SCSI error recovery deadlocked.

Now it's *just* conceivable that the __block_prepare_write() problem
caused a junk request to be sent down to the driver, which caused
the driver to enter recovery, which it then screwed up.   But I
doubt it.

It's also conceivable that the NMI watchdog code itself caused
problems also.   Back in the days when it was permanently enabled,
some machines kept going silly until nmi watchdog was enabled.

Bottom line: I don't know why you got a SCSI error, and the lockup
is possibly a bug in the scsi layer.

-
