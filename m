Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270738AbUJUCAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270738AbUJUCAA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 22:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270722AbUJUB77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 21:59:59 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:57477 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S270787AbUJUB72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 21:59:28 -0400
Date: Thu, 21 Oct 2004 04:00:22 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Chris Wright <chrisw@osdl.org>
Cc: mingo@elte.hu, johansen@immunix.com, Stephen Smalley <sds@epoch.ncsc.mil>,
       Thomas Bleher <bleher@informatik.uni-muenchen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] delay rq_lock acquisition in setscheduler
Message-ID: <20041021020022.GB8756@dualathlon.random>
References: <20041020183238.U2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020183238.U2357@build.pdx.osdl.net>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 06:32:38PM -0700, Chris Wright wrote:
> +	rq = task_rq_lock(p, &flags);
> +	/* recheck policy now with rq lock held */
> +	retval = -EPERM;
> +	if (unlikely(oldpolicy != -1 && oldpolicy != p->policy))
> +		goto out_unlock_rq;

to be really backwards compatible you should return 0 methinks, the only
case when this race can trigger is with non deterministic usage, and the
current kernel would never return -EPERM in such a non deterministic
usage. However the -EPERM will signal the non deterministic usage, but I
doubt it worth to return -EPERM there, since it makes it looks like the
other side that didn't get EPERM is safe while it's not, since the other
side isn't deterministic either.
