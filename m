Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264244AbTEaJGQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 05:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264245AbTEaJGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 05:06:15 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:10247 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264244AbTEaJGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 05:06:14 -0400
Date: Sat, 31 May 2003 10:19:32 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Hugh Dickins <hugh@veritas.com>
Cc: Jun Sun <jsun@mvista.com>, linux-kernel@vger.kernel.org,
       Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Properly implement flush_dcache_page in 2.4?  (Or is it possible?)
Message-ID: <20030531101932.B19071@flint.arm.linux.org.uk>
Mail-Followup-To: Hugh Dickins <hugh@veritas.com>,
	Jun Sun <jsun@mvista.com>, linux-kernel@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>
References: <20030531085248.A19071@flint.arm.linux.org.uk> <Pine.LNX.4.44.0305310919090.1481-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0305310919090.1481-100000@localhost.localdomain>; from hugh@veritas.com on Sat, May 31, 2003 at 09:33:04AM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 31, 2003 at 09:33:04AM +0100, Hugh Dickins wrote:
> I was about to concede to you: just because the pages are shared doesn't
> mean that _you_ have to be overanxious about immediately forcing changes
> to be visible to userspace (though it would be unfriendly if updates were
> to appear at lesser granularity than PAGE_SIZE: I've no idea whether
> that's a possibility), the "unspecified" would allow that much - but
> wouldn't allow you to show portions of entirely other files!

Other files should not be stored in the same page though - if that's
happening today, then we have a violation of POSIX, wrong from Linus'
"quality of implementation" standpoint, and its a security hole.

> But I've just remembered the peculiar VM_SHARED handling in mm/mmap.c:
> open a file O_RDONLY, mmap it PROT_READ MAP_SHARED, and the vma will be
> put on the i_mmap list, not on the i_mmap_shared list.  So the i_mmap
> list can actually contain shared mappings, not just private mappings.
> Poor naming certainly: the i_mmap_shared list is for mappings though
> which the object might be modified.

Hmm, you're right here.  I wonder whether we could allow VM_SHARED to be
set on such mappings, thereby putting the pages on the i_mmap_shared
list rather than the i_mmap list.

The alternative is that we scan these two lists for every case which we
need to do something; this seems to make the split lists rather pointless
from an architecture implementors point of view.

Maybe some of the VM gurus can shed some more light on this subject?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

