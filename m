Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264871AbVBDXFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264871AbVBDXFt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 18:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265382AbVBDXEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 18:04:39 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:44548 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S266115AbVBDWxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 17:53:40 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
Message-Id: <5.1.0.14.2.20050205094038.05323240@171.71.163.14>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 05 Feb 2005 09:51:56 +1100
To: Andrew Morton <akpm@osdl.org>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: Drive performance bottleneck
Cc: Ian Godin <Ian.Godin@lowrydigital.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050204013204.378cbbee.akpm@osdl.org>
References: <c4fc982390674caa2eae4f252bf4fc78@lowrydigital.com>
 <c4fc982390674caa2eae4f252bf4fc78@lowrydigital.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:32 PM 4/02/2005, Andrew Morton wrote:
>Something funny is happening here - it looks like there's plenty of CPU
>capacity left over.
[..]
>Could you monitor the CPU load during the various tests?  If the `dd'
>workload isn't pegging the CPU then it could be that there's something
>wrong with the I/O submission patterns.

as an educated guess, i'd say that the workload is running out of memory 
bandwidth ..

lets say the RAM is single-channel DDR400.  peak bandwidth = 3.2Gb/s (400 x 
10^6 x 64 bits / 1000000000).  its fair to say that peak bandwidth is 
pretty rare thing to achieve with SDRAM given real-world access patterns -- 
lets take a conservative "it'll be 50% efficient" -- so DDR400 realistic 
peak = 1.6Gbps.

as far as memory-accesses go, a standard user-space read() from disk 
results in 4 memory-accesses (1. DMA from HBA to RAM, 2. read in 
copy_to_user(), 3. write in copy_to_user(), 4. userspace accessing that data).
1.6Gbps / 4 = 400MB/s -- or roughly what Ian was seeing.

sg_dd uses a window into a kernel DMA window.  as such, two of the four 
memory acccesses are cut out (1. DMA from HBA to RAM, 2. userspace 
accessing data).
1.6Gbps / 2 = 800MB/s -- or roughly what Ian was seeing with sg_dd.

DIRECT_IO should achieve similar numbers to sg_dd, but perhaps not quite as 
efficient.


cheers,

lincoln.
