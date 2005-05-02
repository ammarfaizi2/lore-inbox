Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVEBVmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVEBVmh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 17:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVEBVmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 17:42:37 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:35456 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261157AbVEBVmf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 17:42:35 -0400
Subject: Re: How to flush data to disk reliably?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0505022057070.11701@alpha.polcom.net>
References: <Pine.LNX.4.62.0505021503470.11701@alpha.polcom.net>
	 <1115056355.10370.37.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0505022057070.11701@alpha.polcom.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1115070074.10338.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 02 May 2005 22:41:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-05-02 at 20:18, Grzegorz Kulewski wrote:
> What about other filesystems? Does anybody know anwser for Reiserfs3, 
> Reiser4, JFS, XFS and any other popular server filesystems? I assume that 
> if log file is some block device (like partition) both O_SYNC and fsync 
> will work? What about ext2? What about some strange RAID/DM/NBD 
> configurations? (I do not know in advance what our customers will use so I 
> need portable method.)

RAID does stripe sized rewrites so you get into the same situation as
with actual disks - a physical media failure might lose you old data
(but then if the disk goes bang so does the data...)

> I already saw them. But I am asking about current implementation status on 
> Linux. For example does fsync differ from fdatasync if file is block 
> device? Does O_SYNC always equal "write; fsync" for all not read only 
> operations? Is it faster because only one syscall is executed?

Benchmark it - it depends on your workload I imagine. If you are able to
write a log entry well before it is needed then the fsync can be a big
win because you can hope the data is already on or heading for disk when
you fsync

> Also flushing should be slow (for example 50 flushes/s) because disk seeks 
> are slow. So if I need say 200 reliable writes to log per second may I put 
> 4 independent disks into the server and use them as 4 independent log 
> files? But fsync operation blocks. Is there any "submit flush request and 
> get some info when done" command or should I use 4 threads / processes?

If you are trying to write logs on that kind of simplistic "reliable"
approach then you probably want a raid card with battery backed ram, at
that point fsync becomes very fast. Most transaction services tend to
use different algorithms to provide reliable service due to exactly
these kind of reasons.



