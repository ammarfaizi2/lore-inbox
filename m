Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265102AbTFMByA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 21:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265103AbTFMByA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 21:54:00 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:20186 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S265102AbTFMBx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 21:53:58 -0400
Date: Thu, 12 Jun 2003 19:07:40 -0700
Message-Id: <200306130207.h5D27eH22519@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: davidm@hpl.hp.com
X-Fcc: ~/Mail/linus
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: FIXMAP-related change to mm/memory.c
In-Reply-To: David Mosberger's message of  Thursday, 12 June 2003 18:24:02 -0700 <200306130124.h5D1O2DT025311@napali.hpl.hp.com>
X-Shopping-List: (1) Sacrilegious persuasion whips
   (2) Fervent breath
   (3) Presidential contribution watchers
   (4) Atomic apparition ponds
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is it possible to constrain the FIXADDR range on x86/x86-64
> (FIXADDR_START-FIXADDR_TOP) such that the entire range is read-only by
> user-level?  

The fixmap area is used for other kernel-only mappings for things that I
doubt should be exposed to users, not just user-accessible pages.  At the
moment, the vsyscall page is the only user-accessible page in the fixmap
area.  I wrote the get_user_pages change to be as generic as possible, so
it would do the right thing if other uses of the fixmap area were added.
Your patch makes the various other kernel-internal fixmap pages readable by
users, which is not right.

The pte_user predicate was added just for this purpose.  It seems
reasonable to me to replace its use with a new pair of predicates,
pte_user_read and pte_user_write, whose meaning is clearly specified for
precisely this purpose.  That is, those predicates check whether a user
process should be allowed to read/write the page via something like ptrace.

That's the obvious idea to me.  But I have no special opinions about this
stuff myself.  The current code is as it is because that's what Linus wanted.


Thanks,
Roland
