Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267928AbUJUFX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267928AbUJUFX1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 01:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270621AbUJUFTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 01:19:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:60051 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267928AbUJUFQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 01:16:35 -0400
Date: Wed, 20 Oct 2004 22:16:32 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Chris Wright <chrisw@osdl.org>, mingo@elte.hu, johansen@immunix.com,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       Thomas Bleher <bleher@informatik.uni-muenchen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] delay rq_lock acquisition in setscheduler
Message-ID: <20041020221632.V2357@build.pdx.osdl.net>
References: <20041020183238.U2357@build.pdx.osdl.net> <20041021020022.GB8756@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041021020022.GB8756@dualathlon.random>; from andrea@novell.com on Thu, Oct 21, 2004 at 04:00:22AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrea Arcangeli (andrea@novell.com) wrote:
> On Wed, Oct 20, 2004 at 06:32:38PM -0700, Chris Wright wrote:
> > +	rq = task_rq_lock(p, &flags);
> > +	/* recheck policy now with rq lock held */
> > +	retval = -EPERM;
> > +	if (unlikely(oldpolicy != -1 && oldpolicy != p->policy))
> > +		goto out_unlock_rq;
> 
> to be really backwards compatible you should return 0 methinks, the only
> case when this race can trigger is with non deterministic usage, and the
> current kernel would never return -EPERM in such a non deterministic
> usage. However the -EPERM will signal the non deterministic usage, but I
> doubt it worth to return -EPERM there, since it makes it looks like the
> other side that didn't get EPERM is safe while it's not, since the other
> side isn't deterministic either.

true.  another alternative is to drop rq_lock and do the checks over.
i didn't convince myself yet that there's no chance for livelock,
although it seems unlikely.
