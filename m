Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318198AbSGWPYe>; Tue, 23 Jul 2002 11:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318199AbSGWPYe>; Tue, 23 Jul 2002 11:24:34 -0400
Received: from mons.uio.no ([129.240.130.14]:58843 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S318198AbSGWPYd>;
	Tue, 23 Jul 2002 11:24:33 -0400
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Organization: Dept. of Physics, University of Oslo, Norway
To: Olaf Kirch <okir@suse.de>
Subject: Re: [NFS] Locking patches (generic & nfs)
Date: Tue, 23 Jul 2002 17:27:38 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
References: <20020719101950.A15819@suse.de> <shsy9c27asf.fsf@charged.uio.no> <20020723170615.D1869@suse.de>
In-Reply-To: <20020723170615.D1869@suse.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_2AKPHME3BAIGNDN4KA07"
Message-Id: <200207231727.38671.trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_2AKPHME3BAIGNDN4KA07
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit

On Tuesday 23 July 2002 17:06, Olaf Kirch wrote:

> But as it is today, all blocked locks get inserted at the end of the
> list because time_before_eq does a signed comparison! With the unpatched
> code, when you have a blocked lock, and the conflicting lock is removed,
> lockd will never send out a GRANTED_MSG. Because the blocked lock is at the
> end of the list, and never picked up.

Fair enough: I see the bug now.

So why could we not do something like the following instead? This just ensures 
that we always leave the NLM_NEVER stuff at the end of the list which should 
suffice to keep nlmsvc_retry_blocked() happy.

Cheers,
  Trond

--------------Boundary-00=_2AKPHME3BAIGNDN4KA07
Content-Type: text/plain;
  charset="iso-8859-15";
  name="fix_svclock.dif"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="fix_svclock.dif"

--- linux/fs/lockd/svclock.c.orig	Tue Feb  5 08:52:37 2002
+++ linux/fs/lockd/svclock.c	Tue Jul 23 17:15:12 2002
@@ -64,7 +64,7 @@
 	if (when != NLM_NEVER) {
 		if ((when += jiffies) == NLM_NEVER)
 			when ++;
-		while ((b = *bp) && time_before_eq(b->b_when,when))
+		while ((b = *bp) && time_before_eq(b->b_when,when) && b->b_when != NLM_NEVER)
 			bp = &b->b_next;
 	} else
 		while ((b = *bp))

--------------Boundary-00=_2AKPHME3BAIGNDN4KA07--
