Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbTIAAf3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 20:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263133AbTIAAf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 20:35:29 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:21385 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263131AbTIAAfW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 20:35:22 -0400
Date: Mon, 1 Sep 2003 01:35:04 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, mingo@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix
Message-ID: <20030901003504.GA31531@mail.jlokier.co.uk>
References: <20030828012152.1294f183.akpm@osdl.org> <20030829035729.E126C2C0BD@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030829035729.E126C2C0BD@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> Walking a 256 entry hash table isn't free even if it's empty.  Example
> patch below.

You can avoid walking the whole hash table.  Instead of this:

     (page, offset) -> list of futexes at (p,o)

You can use a two-level map like this:

     (page) -> (offset) -> list of futexes at (p,o)

Or you can use two one-level maps, like this:

     (page) -> list of futexes at (p)
     (page, offset) -> list of futexes at (p,o)

Either of these gives you the list of futexes give then page in
O(list_size).  They also mean you don't need the page->flags bit to
get O(1) for a page with no futexes, but it's probably a good
optimisation anyway.

-- Jamie
