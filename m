Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965281AbWHOHuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965281AbWHOHuc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 03:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965282AbWHOHuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 03:50:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30396 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965281AbWHOHub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 03:50:31 -0400
Date: Tue, 15 Aug 2006 00:50:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrzej Szymanski <szymans@agh.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange write starvation on 2.6.17 (and other) kernels
Message-Id: <20060815005025.22e8adfe.akpm@osdl.org>
In-Reply-To: <44E0A69C.5030103@agh.edu.pl>
References: <44E0A69C.5030103@agh.edu.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2006 18:36:44 +0200
Andrzej Szymanski <szymans@agh.edu.pl> wrote:

> I've encountered a strange problem - if an application is sequentially 
> writing a large file on a busy machine, a single write() of 64KB may 
> take even 30 seconds. But if I do fsync() after each write() the maximum 
> time of write()+fsync() is about 0.5 second (the overall performance is, 
> of course, degraded).
> 
> The point is, that some applications (samba+smbclient) time out after 
> 20s waiting for write().
> 
> Does anybody have an idea how to tune the kernel to avoid this strange 
> delay in write()?
> 
> I've tried to experiment with cfq and deadline IO scheduler - without 
> success. Decreasing /proc/vm/dirty_ratio to 5% helps a little.
> 
> If somebody want to test it, the tool I've written for measuring maximum 
> write() time is here: http://galaxy.agh.edu.pl/~szymans/writetimer
> 
> 1. Compile writetimer.c
> 2. Put a large background read from the disk
> 3. Simultaneously write 10 files 200MB each (write() without fsync())
> for i in 1 2 3 4 5 6 7 8 9 0 ; do ./writetimer 200 > testfile$i & done
> 4. and with fsync() after each write()
> for i in 1 2 3 4 5 6 7 8 9 0 ; do ./writetimer -200 > testfile$i & done
> (negative file size turns on fsync())
> 
> Tested on
> - 2.6.15-23 (512MB RAM, Pentium-M 1.7, Ubuntu 6.06, ATA disk)
> - 2.6.17-1.2145_FC5 (512MB RAM, Pentium-M 1.7, Fedora Core 5, ATA disk)
> - 2.6.12-2.3.legacy_FC3smp (2GB RAM, Fedora Core 3, software RAID 5 on 4 
> ATA disks)

Which filesystem?

If ext3 in ordered-data mode: any fsync() will sync the whole filesystem
(it has to).  Mounting with `-o writeback' should help.
