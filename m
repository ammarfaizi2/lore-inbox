Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbUAaCNf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 21:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbUAaCNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 21:13:35 -0500
Received: from hera.kernel.org ([63.209.29.2]:63886 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262652AbUAaCNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 21:13:34 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: raid6 badness
Date: Sat, 31 Jan 2004 02:13:09 +0000 (UTC)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <bvf2vl$6pr$1@terminus.zytor.com>
References: <Pine.LNX.4.58.0401301158340.8900@sapphire.newearth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1075515189 6971 66.80.2.163 (31 Jan 2004 02:13:09 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Sat, 31 Jan 2004 02:13:09 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: hpa@smyrno.(none) (H. Peter Anvin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.58.0401301158340.8900@sapphire.newearth.org>
By author:    "Michael V. David" <michael@mvdavid.com>
In newsgroup: linux.dev.kernel
>
> This x86_64 system has dual Opteron CPUs on a Tyan 2880 board. Kernel
> version string:
> 
> Linux version 2.6.2-bk4 (michael@sapphire) (gcc version 3.3.2 20040119 (Red Hat Linux 3.3.2-8)) #3 SMP Fri Jan 30
> 08:56:11 EST 2004
> 
> The same problem was produced with kernel versions 2.6.2-rc2 and
> 2.6.2-rc2-bk4. Output reproduced here is from -bk4.
> 
> If raid6 is compiled into the kernel, the kernel panics while
> starting. In the present case, it was compiled as a module. On
> loading, there is a segfault, and syslog gets what follows:
> 
> ---<snip>---
> raid6: int64x1   1175 MB/s
> raid6: int64x2   1734 MB/s
> raid6: int64x4   1773 MB/s
> raid6: int64x8   1273 MB/s
> general protection fault: 0000 [1]
> CPU 1
> Pid: 7310, comm: modprobe Not tainted
> RIP: 0010:[<ffffffffa0186383>] <ffffffffa0186383>{:raid6:raid6_sse21_gen_syndrome+51}
> RSP: 0018:0000010021825dd8  EFLAGS: 00010202
                           ^
                           
It crashes because the stack is misaligned.  x86-64 requires that the
stack is always aligned to a 16-byte boundary, but your stack pointer
isn't.

The RAID-6 code for x86-64 specifically assumes proper stack
alignment, so a misaligned stack is fatal.

I don't know what would cause the stack to be misaligned, however.

	-hpa
