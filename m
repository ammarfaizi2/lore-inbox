Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbUCRPwU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 10:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbUCRPwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 10:52:20 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:22921
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262720AbUCRPwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 10:52:17 -0500
Date: Thu, 18 Mar 2004 16:53:06 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-aa1
Message-ID: <20040318155306.GI2246@dualathlon.random>
References: <20040318022201.GE2113@dualathlon.random> <Pine.LNX.4.44.0403181026250.16728-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403181026250.16728-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 10:32:58AM -0500, Rik van Riel wrote:
> At that point we'll want to split the file-backed stuff off

the filebacked stuff is already separated, what can be separated further
is the preparation for the page->as.mapping support.

> I'm kind of curious which one will end up better under
> which workloads ;)

I know of big iron critical workloads where mine will work better,
though I agree for a desktop not runing kde the anonm is cheaper in
terms of memory utilization (saves .

andrea@dualathlon:~> egrep 'vm_area|anon_vma' /proc/slabinfo 
vm_area_struct      6613   8500     76   50    1 : tunables  120   60    8 : slabdata    170    170      0
anon_vma            2085   2250     12  250    1 : tunables  120   60    8 : slabdata      9      9      0
andrea@dualathlon:~> free
             total       used       free     shared    buffers     cached
Mem:       1031348    1014156      17192          0      18144     665052
-/+ buffers/cache:     330960     700388
Swap:      1028152          0    1028152
andrea@dualathlon:~> 

the anonmm would take 12*2085+6613*12 = 104k less in my 1G desktop loaded with
my usual stuff (not really, the difference is less than 100k since anonmm takes
quite some bytes, which is significant too if we count the kbytes like I'm
doing), I believe those 100k may be worth it for the super high end workload
swapping 8G on a 16G box with hundred of tasks each task with its own anonymous
direct memory big chunk of memory, anon_vma will avoid checking all hundred MM
for each anon page we swap, plus it gets mremap efficiently which sounds safer
for the short term.
