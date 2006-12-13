Return-Path: <linux-kernel-owner+w=401wt.eu-S964828AbWLMA2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWLMA2z (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 19:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbWLMA2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 19:28:55 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:40947 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964828AbWLMA2y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 19:28:54 -0500
X-Greylist: delayed 361 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Dec 2006 19:28:54 EST
From: ebiederm@xmission.com (Eric W. Biederman)
To: Roland Dreier <rdreier@cisco.com>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: mapping PCI registers with write combining (and PAT on x86)...
References: <adalklcu5w3.fsf@cisco.com>
	<m1irggrasw.fsf@ebiederm.dsl.xmission.com> <adad56ou0i2.fsf@cisco.com>
Date: Tue, 12 Dec 2006 17:22:39 -0700
In-Reply-To: <adad56ou0i2.fsf@cisco.com> (Roland Dreier's message of "Tue, 12
	Dec 2006 16:01:57 -0800")
Message-ID: <m1ac1sr6eo.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <rdreier@cisco.com> writes:

>  > So I think we may simplify this but there is pci_mmap_page_range.  That
>  > already handles this for the architectures that currently support it.
>  > So it is probably the case the fbdev should be changed to use that.
>
> Thanks... I was not aware of pci_mmap_page_range(), but that doesn't
> seem to be quite the right interface.  It uses vma->vm_pgoff to say
> what to remap.  A typical use for what I have in mind would be for a
> userspace process to open a magic file and do mmap() at some
> well-known offset (like 0), and have the kernel driver map the right
> PCI registers into userspace, without userspace having to know what
> offset to ask for.
>
> This is especially important when the kernel has to handle picking a
> "context" or "port" to avoid multiple userspace processes stepping on
> each other.

Agreed.  But I think it is a healthier starting point then the fbdev
location.  A little refactoring and we should be able to handle
the generic case.

> And of course arch/i386/pci/i386.c has the following in its
> pci_mmap_page_range() anyway:
>
> 	/* Write-combine setting is ignored, it is changed via the mtrr
> 	 * interfaces on this platform.
> 	 */
>
> so the write_combine parameter is ignored...

Yes.  Although my earlier patch fixed that :)

It is also worth nothing that the pci prefetchable attribute 
says that write-combining is safe through that bar.

>  > No one had any serious objections to my patches as they were.  The actual
>  > problem was that the patches were incomplete.  In particular if you
>  > mismatch page protections it is possible to get silent data corruption
>  > or processor crashes.  So we need checks to ensure all mappings of
>  > a given page are using the same protections.
>  > 
>  > To a certain extent I think adding those checks really is a strawman
>  > and should not stop the merge effort, because we have this feature and
>  > those possible bugs on other architectures right now and we don't have
>  > those checks.  But I also think in the long term we need them, it just
>  > requires several days of going through the mm so we don't leave any
>  > path uncovered.
>
> It does seem somewhat hard to make sure there aren't multiple mappings
> of the same thing, and I'm not sure it's worth trying to avoid it.  If
> a device driver lets me mmap PCI memory with write-combining on, and
> then (as root) I mmap raw PCI resources to get the same memory, whose
> fault is it if things break?
>
> I'm kind of an mm dummy but I don't even see a good way to avoid
> multiple mappings like that.

It is possible.  It is just a matter of looking for other mappings of the
same thing, and seeing if one exists seeing if it has the mapping
attributes you are asking for.  We have reverse mappings and
the basic infrastructure.

The justification for pursuing reverse mappings really is that it is
less work than taking weeks tracing down the one bug caused by
allowing this and then silently corrupting data.

The obvious problem comes when one mapping is write combined and
the other mapping is write back.

Eric
