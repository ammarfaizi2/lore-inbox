Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbVBJTmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVBJTmP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 14:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVBJTmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 14:42:14 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:4967
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261333AbVBJTl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 14:41:59 -0500
Date: Thu, 10 Feb 2005 20:41:56 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Hugh Dickins <hugh@veritas.com>, IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
Subject: Re: [RFC] Changing COW detection to be memory hotplug friendly
Message-ID: <20050210194156.GQ18573@opteron.random>
References: <20050203035605.C981A7046E@sv1.valinux.co.jp> <Pine.LNX.4.61.0502072041130.30212@goblin.wat.veritas.com> <Pine.LNX.4.61.0502081549320.2203@goblin.wat.veritas.com> <20050210190521.GN18573@opteron.random> <1108063004.29712.54.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108063004.29712.54.camel@localhost>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2005 at 11:16:44AM -0800, Dave Hansen wrote:
> We actually do that, in addition to the more active methods of capturing
> the memory that we're about to remove.

This sounds the best way to go. btw, is this a different codebase from
the one that Toshihiro is testing?

> You're right, I don't really see a problem with ignoring those pages, at
> least in the active migration code.  We would, of course, like to keep
> the number of things that we depend on good faith to get migrated to a
> minimum, but things under I/O are the least of our problems.

Indeed. It's very similar to locked pages. All pages can be pinned for a
transient amount of time, either in the pte or with
PG_pinned/PG_writeback (now perhaps Hugh found a way to drop the pin on
the pte [I'm still unconvinced about that], but sure you're left with
transient pinning with PG_locked or PG_writeback).

> The only thing we might want to do is put something in the rawio code to
> look for the PG_capture pages to ensure that it gives the migration code
> a shot at them every once in a while (when I/O is not in flight,
> obviously).

If there are persistent usages PG_capture sounds a good idea. Perhaps
the whole point that Toshihiro has problem with is that there are really
persistent users that require PG_capture? He mentioned direct IO, that's
not a long time, if something core dump could be a long time.
