Return-Path: <linux-kernel-owner+w=401wt.eu-S965009AbXAJSFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbXAJSFM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 13:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbXAJSFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 13:05:12 -0500
Received: from 3a.49.1343.static.theplanet.com ([67.19.73.58]:47563 "EHLO
	pug.o-hand.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965009AbXAJSFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 13:05:10 -0500
Subject: [PATCH 0/4] Improve swap page error handling
From: Richard Purdie <richard@openedhand.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       kernel list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 10 Jan 2007 18:04:54 +0000
Message-Id: <1168452294.5801.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the error handling when writes fail to a swap page. 

Currently, the kernel will repeatedly retry the write which is unlikely
to ever succeed. Instead we allow the pages to be unused and then marked
as bad at which prevents reuse. It should hopefully be suitable for
testing in -mm.

Hugh Dickins (on a previous incarnation of this series):
> No, not this way, I'm afraid.  Sorry, I don't remember the prior
> discussion on LKML, must have flooded past when my attention was
> elsewhere.

I think you were cc'd on some of it but you never commented. Anyhow,
I've reworked this patch series based on your comments. The hints were
appreciated, thanks. This was the way I'd originally hoped to be able to
work things, I just couldn't find the right way to do it.

> Is it worth doing this at all?  Probably, but I've no experience
> whatsoever of swap write errors, so it's hard for me to judge: my
> guess is that many cases would turn out to be software errors (e.g.
> lower level needing more memory to perform the write).  But you'd
> be right to counter: let's assume they're hardware errors, and
> then fix up any software errors when reported.

I have a swap block driver where hardware write errors are more likely
and hence have a need to handle them more gracefully than IO loops. It
seems like a good idea to avoid the IO loops anyway.

> If it is worth doing this, then you'll need to add code to write
> back the swap header, to note the bad pages permanently: you may
> well have been waiting to see what reception the patches so far
> get, before embarking on that.

You can't proceed to do that until you're able to identify the bad pages
so this would be a necessary first step towards that, yes.

> I was uneasy with 2/4, wondered if swap_free(entry, page) would
> be a better direction to go than your swap_free_markbad(entry).

Agreed, see the following 1/4. 

Patch 4/4 in this series is optional but its appended in hope. It cleans
up code at the expense of what looks like a performance optimisation. I
found the code as it stands rather confusing as a newcomer to that code.

Richard

