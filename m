Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262541AbVA0J3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbVA0J3g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 04:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbVA0J3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 04:29:35 -0500
Received: from aun.it.uu.se ([130.238.12.36]:63109 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262541AbVA0J3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 04:29:30 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16888.46184.52179.812873@alkaid.it.uu.se>
Date: Thu, 27 Jan 2005 10:29:12 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, James Antill <james.antill@redhat.com>,
       Bryn Reeves <breeves@redhat.com>
Subject: Re: don't let mmap allocate down to zero
In-Reply-To: <20050127050927.GR10843@holomorphy.com>
References: <Pine.LNX.4.61.0501261116140.5677@chimarrao.boston.redhat.com>
	<20050126172538.GN10843@holomorphy.com>
	<20050127050927.GR10843@holomorphy.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III writes:
 > On Wed, Jan 26, 2005 at 11:18:08AM -0500, Rik van Riel wrote:
 > >> With some programs the 2.6 kernel can end up allocating memory
 > >> at address zero, for a non-MAP_FIXED mmap call!  This causes
 > >> problems with some programs and is generally rude to do. This
 > >> simple patch fixes the problem in my tests.
 > >> Make sure that we don't allocate memory all the way down to zero,
 > >> so the NULL pointer never gets covered up with anonymous memory
 > >> and we don't end up violating the C standard.
 > >> Signed-off-by: Rik van Riel <riel@redhat.com>
 > 
 > On Wed, Jan 26, 2005 at 09:25:38AM -0800, William Lee Irwin III wrote:
 > > SHLIB_BASE does not appear to be present in 2.6.9; perhaps something
 > > else is going on.
 > > I think we are better off:
 > > 	(a) checking for hitting zero explicitly as opposed to
 > > 		enforcing a randomly-chosen lower limit for addresses
 > > 	(b) enforcing vma allocation above FIRST_USER_PGD_NR*PGDIR_SIZE,
 > > 		to which SHLIB_BASE bears no relation.
 > 
 > There's a long discussion here, in which no one appears to have noticed
 > that SHLIB_BASE does not exist in mainline. Is anyone else awake here?

About the only kernel-level enforcement I would feel comfortable with is
to have non-fixed mmap()s refuse to grab the _page_ at address 0. Any range
larger than this is policy, and hence needs a user-space override mechanism.

Also, if user-space wants to catch accesses in a larger region above 0 then
it can do that itself, by checking the result of mmap(), or by doing a fixed
mmap() at address 0 with suitable size and rwx protection disabled.

/Mikael
