Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262584AbUKEEDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbUKEEDg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 23:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262588AbUKEEDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 23:03:34 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:38616 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S262584AbUKEEDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 23:03:30 -0500
Date: Fri, 5 Nov 2004 05:03:09 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: fix iounmap and a pageattr memleak (x86 and x86-64)
Message-ID: <20041105040308.GJ8229@dualathlon.random>
References: <418837D1.402@us.ibm.com> <20041103022606.GI3571@dualathlon.random> <418846E9.1060906@us.ibm.com> <20041103030558.GK3571@dualathlon.random> <1099612923.1022.10.camel@localhost> <1099615248.5819.0.camel@localhost> <20041105005344.GG8229@dualathlon.random> <1099619740.5819.65.camel@localhost> <20041105020831.GI8229@dualathlon.random> <1099621391.5819.72.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099621391.5819.72.camel@localhost>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 06:23:11PM -0800, Dave Hansen wrote:
> I'm not quite sure if this has any other weird effects, so I'll hold on
> to it for a week or so and see if anything turns up.  

this fixed the problem for me too.

However I'm not convinced this is correct, nothing in the kernel should
ever free a bootmem piece of memory after the machine has booted.

If this helps, it also means we found an existing pte (not pmd) with
page_count 0 during the first unmap event (bootmem allocated). The
transition from mapped to unmapped works fine, but the transition from
unmapped to mapped will thorw the pte away and we'll regenerate a 2M pmd
where there was a pte instead. I wonder why there are 4k pages there in
the first place.

Anyways I understand what's going on now thanks to your debugging, and I
believe the only real fix is to use PageReserved to catch if we're
working on a newly allocated page or not, I don't like to depend on the
page_count being 0 for the bootmem pages like the previous code was
doing. I believe my code would now fall apart even if you were using it
with PSE disabled (nopentium or something). So I've to fix that bit at
least and I will use PageReserved for that.

The page_count of bootmem pages really doesn't matter since they must
never be freed. It really should remain 0 so we catch if anybody
executes a put_page on it.

I'll fix it up...
