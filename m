Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbVBJUkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbVBJUkm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 15:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbVBJUkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 15:40:42 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:35697
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261902AbVBJUk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 15:40:28 -0500
Date: Thu, 10 Feb 2005 21:40:25 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [RFC] Changing COW detection to be memory hotplug friendly
Message-ID: <20050210204025.GS18573@opteron.random>
References: <20050203035605.C981A7046E@sv1.valinux.co.jp> <Pine.LNX.4.61.0502072041130.30212@goblin.wat.veritas.com> <Pine.LNX.4.61.0502081549320.2203@goblin.wat.veritas.com> <20050210190521.GN18573@opteron.random> <Pine.LNX.4.61.0502101953190.6194@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0502101953190.6194@goblin.wat.veritas.com>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2005 at 08:19:47PM +0000, Hugh Dickins wrote:
> On Thu, 10 Feb 2005, Andrea Arcangeli wrote:
> > 
> > The reason pinned pages cannot be unmapped is that if they're being
> > unmapped while a rawio read is in progress, a cow on some shared
> > swapcache under I/O could happen.
> > 
> > If a try_to_unmap + COW over a shared swapcache happens during a rawio
> > read, then the rawio reads will get lost generating data corruption.
> 
> Yes, but...
> 
> get_user_pages broke COW in advance of the I/O.  The reason for
> subsequent COW if the page gets unmapped is precisely because
> can_share_swap_page used page_count to judge exclusivity, and
> get_user_pages has bumped that up, so the page appears (in danger
> of being) non-exclusive when actually it is exclusive.  By changing
> can_share_swap_page to use page_mapcount, that frustration vanishes.

What if a second thread does a fork() while the rawio is in progress?
The page will be again no shareable, and if you unmap it the rawio will
be currupt if the thread that executed the fork while the I/O is in
progress writes to a part of the page again after it has been unmapped
(obviously the part of the page that isn't under read-rawio, rawio works
with the hardblocksize, not on the whole page). 
