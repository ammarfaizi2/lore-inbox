Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVCAGSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVCAGSv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 01:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVCAGSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 01:18:50 -0500
Received: from pop-6.dnv.wideopenwest.com ([64.233.207.24]:28820 "EHLO
	pop-6.dnv.wideopenwest.com") by vger.kernel.org with ESMTP
	id S261257AbVCAGRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 01:17:41 -0500
Date: Tue, 1 Mar 2005 01:17:33 -0500
From: Paul <set@pobox.com>
To: packet-writing@suse.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Data corruption with pktcdvd, kernel 2.6.10 (additional results)
Message-ID: <20050301061733.GA7884@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>, packet-writing@suse.com,
	linux-kernel@vger.kernel.org
References: <20050301035022.GH8097@squish.home.loc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050301035022.GH8097@squish.home.loc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi;

	Out of curiosity, I tried using the ide-scsi driver, instead
of the default ide-cdrom driver. These attempts failed in various
ways, including an oops, which I wont try to detail, as I seem to
recall this is known not working.
	From some of the error message that experiment resulted in,
and recent comments on linux-kernel about how the ide-cdrom driver
might not propogate errors, I tried again, but with 'hdparm -a0 -d0'
on the drive. This also had files ending in blocks of zeros and completely
zero files, but far fewer....
	Next, I tried making an ext2 fs instead of udf on the dvd+rw
disc, in addition to the -a0 -d0 hdparm settings. This made a dramatic
difference. The copy of the 2.6.10 kernel tree took around 2 minutes
from start to sync completion, vs. around 30 minutes on the udf fs.
And there was no corruption of files, as verifed by diff -r afterwards.
	(all this using the pktcdvd device)
	To me, this implies that write support for udf is shady,
or that it simply triggers some deeper bug. At the very least it
is grossly less efficient than ext2 for this task. Having udf
working well for this would be best, however, for portability.

Paul
set@pobox.com
	
Paul <set@pobox.com>, on Mon Feb 28, 2005 [10:50:22 PM] said:
> 	Hi;
> 
> 	I have played with the pktcdvd patch in the past, and most
> recently with the implementation in the 2.6.10 kernel, but never
> really stressed it. However, someone recently complained to me that
> it quite often resulted in corrupted files for them, so I performed
> a stress test; copy a kernel source tree to a cdrw and a dvd+rw.
> (mount /dev/pktcdvd/cdrw /cdrw -o rw,noatime)
> (cp -a /foo/2.6.10 /cdrw)
> 	Well, diff -r shows many corrupt files in both cases.
> The corruption is either that the file is completely zero, or at
> some point it ends in zero data. In other words, all or part of
> the file end up as zero's.
> 	Simpler tests, like copying a flat dir filled with 50meg
> of images did not turn up corruption.
> 	I would have liked to compare writing to dvd+rw without
> pktcdvd, but although I could make a udf fs on the disc, mount it and
> start writing to it, the throughput was impossibly slow. (like 1meg in
> several minutes-- at best.) Using pktcdvd was much faster, but it
> seems to bog down after a while into the kernel tree copy-- and if you
> look at the drive light, it seems to be doing lots of reading and 
> then little blips of writing. 'vmstat 1' shows very little bi/bo,
> often times 0/0.
> 	Can anyone suggest what might be done to find out what is
> going wrong here? I am using vanilla 2.6.10, udftools-1.0.0b-r3,
> a liteon LDW-451S dvd writer. The kernel is SMP with preempt enabled.
> The writer and the hardisc are both ATA.
> 	Let me know if I can help with more information or testing.
> 
> Thanks;
> 
> Paul
> set@pobox.com
> 
> 
> -- 
> To unsubscribe, e-mail: packet-writing-unsubscribe@suse.com
> For additional commands, e-mail: packet-writing-help@suse.com
> 
