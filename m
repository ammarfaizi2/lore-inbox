Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265395AbUJVRLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265395AbUJVRLv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 13:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265795AbUJVRLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 13:11:03 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:8088 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S271446AbUJVRDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 13:03:18 -0400
Date: Fri, 22 Oct 2004 19:04:03 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: shaggy@austin.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] zap_pte_range should not mark non-uptodate pages dirty
Message-ID: <20041022170403.GI14325@dualathlon.random>
References: <1098393346.7157.112.camel@localhost> <20041021144531.22dd0d54.akpm@osdl.org> <20041021223613.GA8756@dualathlon.random> <20041021160233.68a84971.akpm@osdl.org> <20041021232059.GE8756@dualathlon.random> <20041021164245.4abec5d2.akpm@osdl.org> <20041022003004.GA14325@dualathlon.random> <20041022012211.GD14325@dualathlon.random> <20041021190320.02dccda7.akpm@osdl.org> <20041022161744.GF14325@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022161744.GF14325@dualathlon.random>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 06:17:44PM +0200, Andrea Arcangeli wrote:
> So let's forget the mmapped case and let's fix the bh screwup in 2.6.

I propose a solution to fix the coherency problem that afflicts 2.6 if
invalidate_complete_page fails. If the page is still PagePrivate despite
we called try_to_release_page (which means clearing the uptodate bitflag
wouldn't help), we should simply return an error to the O_DIRECT writes.
That way the error would not be overlooked by the database writing. This
is a minium guarantee we have to provide: if we fail invalidate cause
the O_DIRECT write to fail.

Of course we should return write failures as well in the mmapped case,
but let's ignore the mmapped case for now.

The real showstopper bug is try_to_release_page failing and preventing
the coherency protocol to work even without mmaps. This could never
happen in 2.4, in 2.4 as worse ext3 would get an hearth attack, which is
much better than silent corruption in the backup.
