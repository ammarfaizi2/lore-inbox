Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030367AbWHXG6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030367AbWHXG6a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 02:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030369AbWHXG6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 02:58:30 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:43864 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S1030367AbWHXG6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 02:58:30 -0400
Subject: Re: [PATCH] nfsd: lockdep annotation
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       arjan <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <17645.17252.217583.660976@cse.unsw.edu.au>
References: <1156330112.3382.34.camel@twins>
	 <17645.17252.217583.660976@cse.unsw.edu.au>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 08:54:13 +0200
Message-Id: <1156402453.3382.57.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 16:12 +1000, Neil Brown wrote:
> On Wednesday August 23, a.p.zijlstra@chello.nl wrote:
> > Hi,
> > 
> > while doing a kernel make modules_install install over an NFS mount.
> > (
> > 
> > =============================================
> > [ INFO: possible recursive locking detected ]
> > ---------------------------------------------
> 
> Thanks for the patch.  I had a patch to fix this in my queue, but I
> just hadn't got around to submitting it yet :-(
> Never mind, we'll go with yours and Andrew already has it.
> 
> I had flags the fh_lock in nfsd_setattr a I_MUTEX_CHILD which you
> didn't however I see that isn't needed (Why do we have PARENT and
> CHILD and NORMAL.... you would think that any two would do ??)

I_MUTEX_CHILD is only used in renames. All other childs are left
unannotated, it feels a bit sloppy (and it probably is) but it works
out. Unannotated lock operations are a separate class on their own, as
are I_MUTEX_NORMAL (used when you don't feel like figuring out which
would be the proper level, and there is no further nesting AFAIK).

This way you'll end up with PARENT -> {NORMAL, unannotated} which is as
valid as PARENT -> CHILD.
The only danger would be if you also have a locking sequence like CHILD
-> PARENT, that could go unnoticed, because the other direction is not
from CHILD. This could hide real deadlocks.

/me looks at Arjan, did I get it right?

> However there is a bit missing: the fh_lock in nfsd_proc_create
> in nfsproc.c needs I_MUTEX_PARENT - I'll send a separate patch to fix
> that.

Ah, right, must've overlooked it.

Thanks

