Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbUKGVNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbUKGVNd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 16:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbUKGVNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 16:13:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:60592 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261685AbUKGVNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 16:13:14 -0500
Date: Sun, 7 Nov 2004 13:13:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Matt Domsch <Matt_Domsch@dell.com>
cc: davej@redhat.com, "Luck, Tony" <tony.luck@intel.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: EFI partition code broken..
In-Reply-To: <20041107200351.GA3169@lists.us.dell.com>
Message-ID: <Pine.LNX.4.58.0411071306000.24286@ppc970.osdl.org>
References: <Pine.LNX.4.58.0411070959560.2223@ppc970.osdl.org>
 <Pine.LNX.4.58.0411071128240.24286@ppc970.osdl.org> <20041107200351.GA3169@lists.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Nov 2004, Matt Domsch wrote:
> 
> The check for invalid primary master boot record (PMBR) needs to be
> moved up ahead of the reads for the GPTs (primary at the start of the
> disk, alternate/backup at the end of the disk).  When first written,
> Intel didn't specify that the PMBR (a normal DOS-like MBR partition
> table with a single entry of type 0xEE covering the whole disk) *had*
> to exist, so we let the code try looking for GPTs first.  When the
> PMBR test was added, it should have been added ahead of the GPT tests,
> not after.  I'll work up a patch to do just that, and will then remove
> the dependency on IA64.  Fair enough?

Yes, sounds good. Also, if I understand you correctly, I would suggest
actually taking the size of the disk from the PMBR 0xEE entry itself,
rather than depend on what size the disk reports (perhaps double-check
that it is sane, of course - the more careful the better).

With people doing things like concatenating partitions with "md", the size
of the disk itself is less important than what the partition table was set
up with - even if the size reporting of the disk itself is reliable.

For example, let's say that you create a EFI table on a RAID (striped or
whatever), and that in turn then means that the first sub-disk used for
the RAID will contain (as part of the RAID array) the EFI signature in its 
PMBR, we don't want to look at the GPT at the end of _that_ disk. See what 
I'm saying?

		Linus
