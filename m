Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263526AbUBBX4E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 18:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263793AbUBBX4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 18:56:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:51908 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263526AbUBBX4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 18:56:01 -0500
Date: Mon, 2 Feb 2004 15:55:51 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland McGrath <roland@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restore protections after forced fault in get_user_pages
In-Reply-To: <200402022348.i12NmWcK016232@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0402021551320.9720@home.osdl.org>
References: <200402022348.i12NmWcK016232@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 2 Feb 2004, Roland McGrath wrote:
> 
> It would be ideal.  However, it would also require changing the interfaces
> further.  Currently handle_mm_fault just says what happened, and doesn't
> give back the page directly.  get_user_pages then retakes
> mm->page_table_lock and calls follow_page to look up the page.

I'd suggest making this be:
 - handle_mm_fault() take a more detailed flag ("read / write / copy", 
   where the new "copy" part is a write that actually leaves the page 
   only readable, but marks it dirty)
 - we do "follow-page" with a read.

That should be sufficient, I think: since "handle_mm_fault()" marks the 
page dirty (but not writable) and will have done all the work to do a COW, 
we know that once we do the "follow_page()", we'll be getting a private 
copy. Which is what we wanted.

So only "handle_mm_fault()" would actually need changing.

I think.

Anybody see any problems with this approach?

		Linus
