Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbWFIHTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbWFIHTv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 03:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWFIHTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 03:19:51 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:39572 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751391AbWFIHTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 03:19:50 -0400
Date: Fri, 9 Jun 2006 09:19:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.17-rc6-mm1 -- BUG: possible circular locking deadlock detected!
Message-ID: <20060609071900.GA27005@elte.hu>
References: <a44ae5cd0606072127n761c64fepf388e2f9de8ca1fe@mail.gmail.com> <1149751953.10056.10.camel@imp.csi.cam.ac.uk> <20060608095522.GA30946@elte.hu> <1149764032.10056.82.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149764032.10056.82.camel@imp.csi.cam.ac.uk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Anton Altaparmakov <aia21@cam.ac.uk> wrote:

> This last lookup of physical location in map_mft_record() [actually in 
> readpage as map_mft_record() reads the page cache page containing the 
> record] cannot require us to load an extent mft record because the 
> runlist is complete so we cannot deadlock here.

ah! So basically, the locking sequences the validator observed during 
load_system_files() are a one-time event that can only occur during 
ntfs_fill_super().

if we ignore those dependencies (of the initial reading of the MFT inode 
generating recursive map_mft_record() calls) and take into account that 
the MFT inode will never again trigger map_mft_record() calls, then the 
locking is conflict-free after mounting has finished, right?

so the validator is technically correct that load_system_files() 
generates locking patterns that have dependency conflicts - but that 
code is guaranteed to be single-threaded because it's a one time event 
and because the VFS has no access to the filesystem at that time yet so 
there is zero parallellism.

can you think of any simple and clean solution that would avoid those 
conflicting dependencies within the NTFS code? Perhaps some way to read 
the MFT inode [and perhaps other, always-cached inodes that are later 
used as metadata] without locking? I can code it up and test it, but i 
dont think i can find the best method myself :-)

	Ingo
