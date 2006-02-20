Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932691AbWBTH7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932691AbWBTH7i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 02:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbWBTH7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 02:59:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33739 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932691AbWBTH7h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 02:59:37 -0500
Date: Sun, 19 Feb 2006 23:57:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: oliver@neukum.org, stern@rowland.harvard.edu, psusi@cfl.rr.com,
       pavel@suse.cz, torvalds@osdl.org, mrmacman_g4@mac.com,
       alon.barlev@gmail.com, linux-kernel@vger.kernel.org,
       linux-pm@lists.osdl.org
Subject: Re: Flames over -- Re: Which is simpler?
Message-Id: <20060219235752.2d6e252c.akpm@osdl.org>
In-Reply-To: <20060219232926.256665d6.akpm@osdl.org>
References: <43F89F55.5070808@cfl.rr.com>
	<200602192144.57748.oliver@neukum.org>
	<20060219130243.52af0782.akpm@osdl.org>
	<200602200755.57699.oliver@neukum.org>
	<20060219232926.256665d6.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
>  > If you simply block writes, the system will stall random tasks laundering
>  > pages, including those needed to make progress. Even syncing before
>  > suspend won't help you, as a running user space may dirty pages.
> 
>  Well of _course_ that will happen.

Actually, it won't happen.  There's already logic in there to help pdflush,
kswapd and memory-allocating tasks avoid blocking on congested queues. 
It's trivial to extend that to avoidance of hotunplugged queues.

Things like sync(), fsync(), O_SYNC and reads will necessarily block.

We may or may not decide to block on page-dirtyings.  Again, that's trivial
to do in balance_dirty_pages().

Race conditions are pretty much unavoidable - if someone goes and disables
a device when we're partway through and committed to I/O submission then
things will get very sticky.  But we can have a pretty successful solution
to all of this without a ton of effort.

But this is all the easy part.
