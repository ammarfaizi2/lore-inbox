Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262633AbVA0OZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbVA0OZN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 09:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbVA0OZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 09:25:13 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35088 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262633AbVA0OZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 09:25:06 -0500
Date: Thu, 27 Jan 2005 14:25:00 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, Rik van Riel <riel@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       James Antill <james.antill@redhat.com>,
       Bryn Reeves <breeves@redhat.com>
Subject: Re: don't let mmap allocate down to zero
Message-ID: <20050127142500.A775@flint.arm.linux.org.uk>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Mikael Pettersson <mikpe@csd.uu.se>, Rik van Riel <riel@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	James Antill <james.antill@redhat.com>,
	Bryn Reeves <breeves@redhat.com>
References: <Pine.LNX.4.61.0501261116140.5677@chimarrao.boston.redhat.com> <20050126172538.GN10843@holomorphy.com> <20050127050927.GR10843@holomorphy.com> <16888.46184.52179.812873@alkaid.it.uu.se> <20050127125254.GZ10843@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050127125254.GZ10843@holomorphy.com>; from wli@holomorphy.com on Thu, Jan 27, 2005 at 04:52:54AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 04:52:54AM -0800, William Lee Irwin III wrote:
> On Thu, Jan 27, 2005 at 10:29:12AM +0100, Mikael Pettersson wrote:
> > About the only kernel-level enforcement I would feel comfortable with is
> > to have non-fixed mmap()s refuse to grab the _page_ at address 0. Any range
> > larger than this is policy, and hence needs a user-space override mechanism.
> > Also, if user-space wants to catch accesses in a larger region above 0 then
> > it can do that itself, by checking the result of mmap(), or by doing a fixed
> > mmap() at address 0 with suitable size and rwx protection disabled.
> 
> FIRST_USER_PGD_NR is a matter of killing the entire box dead where it
> exists, not any kind of process' preference. Userspace should be
> prevented from setting up vmas below FIRST_USER_PGD_NR.

No it should not.  The PGD index is FAR to coarse to use - each PGD on
ARM maps 1MB of virtual address space.  Userspace text starts at 32K.

The protection against mmap() MAP_FIXED fiddling with the first page is
handled by the arch-specific mmap() wrappers, so generic code doesn't
have to worry about it.

What generic code _does_ have to worry about is:

(a) not removing the very first page.
(b) not removing the very first pointer to the 2nd level table in the
    1st level tables.

and that is all.  Maybe FIRST_USER_PGD_NR was a bad way of achieving
this, but in the instance of the VM upon which it was originally
implemented (somewhere between 2.2 and 2.4), it was deemed (by others
iirc) to be the best way of achieving it at the time.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
