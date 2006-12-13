Return-Path: <linux-kernel-owner+w=401wt.eu-S932575AbWLMAMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575AbWLMAMM (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 19:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbWLMAMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 19:12:12 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:2570 "EHLO
	sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932575AbWLMAML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 19:12:11 -0500
X-Greylist: delayed 601 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Dec 2006 19:12:10 EST
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: mapping PCI registers with write combining (and PAT on x86)...
X-Message-Flag: Warning: May contain useful information
References: <adalklcu5w3.fsf@cisco.com>
	<m1irggrasw.fsf@ebiederm.dsl.xmission.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 12 Dec 2006 16:01:57 -0800
In-Reply-To: <m1irggrasw.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's message of "Tue, 12 Dec 2006 15:47:43 -0700")
Message-ID: <adad56ou0i2.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 13 Dec 2006 00:01:58.0833 (UTC) FILETIME=[E8AB3A10:01C71E49]
Authentication-Results: sj-dkim-8; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim8002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > So I think we may simplify this but there is pci_mmap_page_range.  That
 > already handles this for the architectures that currently support it.
 > So it is probably the case the fbdev should be changed to use that.

Thanks... I was not aware of pci_mmap_page_range(), but that doesn't
seem to be quite the right interface.  It uses vma->vm_pgoff to say
what to remap.  A typical use for what I have in mind would be for a
userspace process to open a magic file and do mmap() at some
well-known offset (like 0), and have the kernel driver map the right
PCI registers into userspace, without userspace having to know what
offset to ask for.

This is especially important when the kernel has to handle picking a
"context" or "port" to avoid multiple userspace processes stepping on
each other.

And of course arch/i386/pci/i386.c has the following in its
pci_mmap_page_range() anyway:

	/* Write-combine setting is ignored, it is changed via the mtrr
	 * interfaces on this platform.
	 */

so the write_combine parameter is ignored...

 > No one had any serious objections to my patches as they were.  The actual
 > problem was that the patches were incomplete.  In particular if you
 > mismatch page protections it is possible to get silent data corruption
 > or processor crashes.  So we need checks to ensure all mappings of
 > a given page are using the same protections.
 > 
 > To a certain extent I think adding those checks really is a strawman
 > and should not stop the merge effort, because we have this feature and
 > those possible bugs on other architectures right now and we don't have
 > those checks.  But I also think in the long term we need them, it just
 > requires several days of going through the mm so we don't leave any
 > path uncovered.

It does seem somewhat hard to make sure there aren't multiple mappings
of the same thing, and I'm not sure it's worth trying to avoid it.  If
a device driver lets me mmap PCI memory with write-combining on, and
then (as root) I mmap raw PCI resources to get the same memory, whose
fault is it if things break?

I'm kind of an mm dummy but I don't even see a good way to avoid
multiple mappings like that.

 - R.
