Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261938AbVBUJ6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbVBUJ6M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 04:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbVBUJ6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 04:58:12 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:48344 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261938AbVBUJ6E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 04:58:04 -0500
Date: Mon, 21 Feb 2005 10:57:42 +0100
From: Andi Kleen <ak@suse.de>
To: Ray Bryant <raybry@sgi.com>
Cc: Andi Kleen <ak@suse.de>, Paul Jackson <pj@sgi.com>, ak@muc.de,
       raybry@austin.rr.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview II
Message-ID: <20050221095742.GA8788@wotan.suse.de>
References: <20050215214831.GC7345@wotan.suse.de> <4212C1A9.1050903@sgi.com> <20050217235437.GA31591@wotan.suse.de> <4215A992.80400@sgi.com> <20050218130232.GB13953@wotan.suse.de> <42168FF0.30700@sgi.com> <20050220214922.GA14486@wotan.suse.de> <20050220143023.3d64252b.pj@sgi.com> <20050220223510.GB14486@wotan.suse.de> <42198DE5.2040703@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42198DE5.2040703@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2005 at 01:29:41AM -0600, Ray Bryant wrote:
> This is different than your reply above, which seems to imply that:
> 
> (A)  Step 1 is to migrate mapped files using mbind().  I don't understand
>      how to do this in general, because:
>      (a)  I don't know how to make a non-racy list of the mapped files to
>           migrate without assuming that the process to be migrated is 
>           stopped

That was just a stop gap way to do the migration before you have
xattrs for shared libraries. If you have them it's not needed.

> and  (b)  If the mapped file is associated with the DEFAULT memory policy,
>           and page placement was done by first touch, then it is not clear
>           how to use mbind() to cause the pages to be migrated, and still
>           end up with the identical topological placement of pages after
>           the migration.

It can be done, but it's ugly. But it really was only intended for
the shared libraries.

> (B)  Step 2 is to use page_migrate() to migrate just the anonymous pages.
>      I don't like the restriction of this to just anonymous pages.

That would be only in this scenario; I agree it doesn't make sense
to add it as a general restriction to the syscall.

> 
> Fundamentally, I don't see why (A) is much different from allowing one
> process to manipulate the physical storage for another process.  It's
> just stated in terms of mmap'd objects instead of pid's.  So I don't
> see why that is fundamentally different from a page_migration() call
> with va_start and va_end arguments.

An mmaped object exists on its own. It's access is fully reference counted etc.

> The only problem I see with that is the following:  Suppose that a user
> wants to migrate a portion of their own address space that is composed
> of (at last partly) anonymous pages or pages mapped to a file associated
> with the DEFAULT memory policy, and we want the pages to be toplogically
> allocated the same way after the migration as they were before the
> migration?

It doesn't seem very realistic to me. When a user wants to change
its own address room then they can use mbind() from the beginning
and they should know how their memory layout is.

-Andi
