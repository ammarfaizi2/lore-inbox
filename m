Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262015AbVBKIxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbVBKIxw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 03:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbVBKIxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 03:53:52 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:17498
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S262015AbVBKIwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 03:52:43 -0500
Date: Fri, 11 Feb 2005 09:52:39 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [RFC] Changing COW detection to be memory hotplug friendly
Message-ID: <20050211085239.GD18573@opteron.random>
References: <20050203035605.C981A7046E@sv1.valinux.co.jp> <Pine.LNX.4.61.0502072041130.30212@goblin.wat.veritas.com> <Pine.LNX.4.61.0502081549320.2203@goblin.wat.veritas.com> <20050210190521.GN18573@opteron.random> <Pine.LNX.4.61.0502101953190.6194@goblin.wat.veritas.com> <20050210204025.GS18573@opteron.random> <Pine.LNX.4.61.0502110710150.5866@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0502110710150.5866@goblin.wat.veritas.com>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2005 at 07:23:09AM +0000, Hugh Dickins wrote:
> And it's fine for the behaviour to be somewhat undefined in this
> peculiar case: the important thing is just that the page must not
> be freed and reused while I/O occurs, hence get_user_page raising
> the page_count - which I'm _not_ proposing to change!

Ok, I'm quite convinced it's correct now. The only thing that can make
mapcount go up without the lock on the page without userspace
intervention (and userspace intervention would make it an undefined
behaviour like in my example with fork), was the swapin, and you covered
it by moving the unlock after page_add_anon_rmap (so mapcount changes
atomically with the page_swapcount there too). Swapoff was already doing
it under the page lock.

Then we should use the mapcount/swapcount in remove_exclusive_swap_page
too.
