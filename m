Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268289AbUH2Tu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268289AbUH2Tu1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 15:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268290AbUH2Tu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 15:50:27 -0400
Received: from mail3.bluewin.ch ([195.186.1.75]:39898 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id S268289AbUH2TuZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 15:50:25 -0400
Date: Sun, 29 Aug 2004 21:49:26 +0200
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org, albert@users.sourceforge.net
Subject: Re: [BENCHMARK] nproc: netlink access to /proc information
Message-ID: <20040829194926.GA3289@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org,
	albert@users.sourceforge.net
References: <20040827122412.GA20052@k3.hellgate.ch> <20040827162308.GP2793@holomorphy.com> <20040828194546.GA25523@k3.hellgate.ch> <20040828195647.GP5492@holomorphy.com> <20040828201435.GB25523@k3.hellgate.ch> <20040829160542.GF5492@holomorphy.com> <20040829170247.GA9841@k3.hellgate.ch> <20040829172022.GL5492@holomorphy.com> <20040829120733.455f0c82.pj@sgi.com> <20040829191707.GU5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040829191707.GU5492@holomorphy.com>
X-Operating-System: Linux 2.6.8 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Aug 2004 12:17:07 -0700, William Lee Irwin III wrote:
> > In glancing at the get_tgid_list() I see it is careful to only pick off
> > 20 (PROC_MAXPIDS) slots at a time.  But elsewhere in the kernel, I see
> > several uses of "do_each_thread()" which rip through the entire task
> > list in a single shot.
> > Is there a simple explanation for why it is ok in one place to take on
> > the entire task list in a single sweep, but in another it is important
> > to drop the lock every 20 slots?
> 
[...]
> Introducing another whole-tasklist scan, even if feasible, is probably
> not a good idea.

I'm not sure whether I should participate in that discussion. I'll risk
discrediting nproc with wild speculations on a subject I haven't really
looked into yet. Ah well...

As far as nproc (and process monitoring) is concerned, we aren't really
interested in walking a complete process list. All we care about is
which pids exist right now. How about a bit field, maintained by the
kernel, to indicate for each pid whether it exists or not? This would
amount to 4 KiB by default and 512 KiB for PID_MAX_LIMIT (4 million
processes). Maintenance cost would be one atomic bit operation per
process creation/deletion. No contested locks.

The list for the nproc user could be prepared based on the bit field
(or simply memcpy'd), no tasklist_lock or walking linked lists required.

What am I missing?

Roger
