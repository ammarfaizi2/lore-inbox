Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbUCIJCT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 04:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbUCIJCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 04:02:19 -0500
Received: from mx2.elte.hu ([157.181.151.9]:18876 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261787AbUCIJCM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 04:02:12 -0500
Date: Tue, 9 Mar 2004 10:03:26 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Message-ID: <20040309090326.GA10039@elte.hu>
References: <20040308202433.GA12612@dualathlon.random> <Pine.LNX.4.58.0403081238060.9575@ppc970.osdl.org> <20040308132305.3c35e90a.akpm@osdl.org> <20040308230247.GC12612@dualathlon.random> <20040308152126.54f4f681.akpm@osdl.org> <20040308234014.GG12612@dualathlon.random> <20040309083103.GB8021@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040309083103.GB8021@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner-4.26.8-itk2 SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> ugh? This is not my main argument against 'objrmap'. My main (and
> pretty much only) argument against it is the linear searching it
> reintroduces.

to clarify this somewhat. objrmap works fine (and roughly equivalently
to rmap) when processes map files via one vma mostly. (e.g. shared
libraries.)

objrmap falls apart badly if there are tons but _disjunct_ vmas to the
same inode. One such workload is Oracle's 'indirect buffer cache'. It is
a ~512 MB virtual memory window with 32KB mapsize, mapping to a much
larger shmfs page, featuring 16 thousand vmas per process.

The problem is that the ->i_mmap and ->i_mmap_shared lists 'merge' _all_
the vmas that somehow belong to the given inode. Ie. in the above case
it has a length of 16 thousand entries. So while possibly none of those
vmas shares any physical page with each other, your
try_to_unmap_obj(page) function will loop through possibly thousands of
vmas, killing the VM's ability to reclaim. (and also presenting the
'kswapd is stuck and eating up CPU time' phenomenon to users.)

Andrea, did you know about this property of your patch? If yes, why
didnt you mention it in the announcement, as a tradeoff to take care of?

it's ironic that precisely the workload you cite (shmfs for IO cache,
when the shared memory size is larger than what the process can map) is
the one that would hurt most from objrmap. In that workload there can be
possibly tens of thousands of disjunct vmas mapping the same shmfs inode
and kswapd would loop endlessly without achieving anything useful.

(remap_file_pages() will handle such workloads fine, but it's still a
big regression for those applications that happen to have more than a
handful of disjunct vmas per inode. I obviously like fremap, but i dont
want to force it down anyone's throat.)

	Ingo
