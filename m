Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131402AbRC0QXd>; Tue, 27 Mar 2001 11:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131395AbRC0QXN>; Tue, 27 Mar 2001 11:23:13 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:47679 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S131393AbRC0QXL>; Tue, 27 Mar 2001 11:23:11 -0500
Date: Mon, 26 Mar 2001 15:26:25 +0100
From: Stephen Tweedie <sct@redhat.com>
To: Richard Jerrell <jerrell@missioncriticallinux.com>
Cc: linux-kernel@vger.kernel.org, Rik van Riel <riel@nl.linux.org>,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] mm/memory.c, 2.4.1 : memory leak with swap cache (updated)
Message-ID: <20010326152625.A1165@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0103221716460.20061-200000@jerrell.lowell.mclinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0103221716460.20061-200000@jerrell.lowell.mclinux.com>; from jerrell@missioncriticallinux.com on Thu, Mar 22, 2001 at 05:21:46PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 22, 2001 at 05:21:46PM -0500, Richard Jerrell wrote:
> 2.4.1 has a memory leak (temporary) where anonymous memory pages that have
> been moved into the swap cache will stick around after their vma has been
> unmapped by the owning process.  These pages are not free'd in free_pte()
> because they are still referenced by the page cache.  In addition, if the
> pages are dirty, they will be written out to the swap device before they
> are reclaimed even though the owning process no longer will be using the
> pages.
> 
> free_pte in mm/memory.c has been modified to check to see if the page is
> only being referenced by the swap cache (and possibly buffers).

But is it worth it?

fork and exit are very hot paths in the kernel, and this patch can force
a page cache lookup on a large number of pte which wouldn't be looked
up before.

The classic case is sendmail or apache, where you can have a parent
process rapidly forking a large number of children.  If part of the
parent gets swapped out due to lack of use, then the children all
inherit swapped ptes and each such page will result in an extra page
cache lookup in zap_page_range on exit with this change.

Given that the leak is, as you say, temporary, and that the leak will
be recovered as soon as we start swapping again, do we really want to
pollute the fast path for the sake of a bit more speed during
swapping?

Cheers,
 Stephen
