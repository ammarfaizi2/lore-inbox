Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262538AbUKBXcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbUKBXcm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 18:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262637AbUKBX3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 18:29:03 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:18819 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S262538AbUKBXM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 18:12:59 -0500
Date: Wed, 3 Nov 2004 00:12:27 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: Jason Baron <jbaron@redhat.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: fix iounmap and a pageattr memleak (x86 and x86-64)
Message-ID: <20041102231227.GX3571@dualathlon.random>
References: <4187FA6D.3070604@us.ibm.com> <Pine.LNX.4.44.0411021728460.8117-100000@dhcp83-105.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0411021728460.8117-100000@dhcp83-105.boston.redhat.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 05:34:08PM -0500, Jason Baron wrote:
> I've seen the page_count being -1 (not sure why), for a number of pages in
> the identity mapped region...So the BUG() on 0 doesn't seem valid to me.

bugcheck on 0 is valid there, it signals memleak. page_count == -1
signals another bug that might or might not be fixed by this as far as I
can tell (this furthermore is a pte, so it sure can't have page_count ==
0 or -1). So please try to track down which pages had page_count == -1.

Note, we must not confuse page->count with page_count, for the former
value -1 means "in the freelist". For the latter it signals a bug.

> Also, in order to tell if the pages should be merged back to create a huge
> page, i don't see how the patch differentiates b/w pages that were split
> and those that weren't simply based on the page_count....

that's a page_count of the _pte_, not of the pages. so we're guaranteed
it's always 1 unless we deal with this very pageattr code that is the
only one that evers boost a pte page_count to > 1.

If you mean how can we provide an universal API with only keeping track
of things with the page_count of the pte, we can't, and that's why it's
not an universal API and that's why some symmetry is required by the
API.
