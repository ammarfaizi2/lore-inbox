Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbTIYETo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 00:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbTIYETo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 00:19:44 -0400
Received: from palrel10.hp.com ([156.153.255.245]:2185 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261687AbTIYETm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 00:19:42 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16242.27867.715648.392875@napali.hpl.hp.com>
Date: Wed, 24 Sep 2003 21:19:39 -0700
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: akpm@zip.com.au, neilb@cse.unsw.edu.au, braam@clusterfs.com,
       davem@redhat.com, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       David Mosberger-Tang <davidm@HPL.HP.COM>, tridge@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl-controlled number of groups.
In-Reply-To: <20030925035943.AE41C2C04B@lists.samba.org>
References: <20030925035943.AE41C2C04B@lists.samba.org>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@HPL.HP.COM
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From the ia64-side, it looks mostly fine to me.  Some minor things:

 - Typo in first sentence of patch comment (can be -> to be ?)
 - If I'm reading the patch right, there will be identical sys32_getgroups16()
   definitions in .../ia32/sys_ia32.c and and compat_linux.c; did you mean
   to name the latter compat_getgroups16()?  (ditto for setgroups16 and s390
   and sparc64, i think)
 - I suspect removing NGROUPS from param.h will break glibc and/or user-level
   apps.  param.h is one of those kernel files that are directly exposed
   to user-level; may want to keep NGROUPS inside an #ifndef __KERNEL__.

	--david

>>>>> On Thu, 25 Sep 2003 13:21:01 +1000, Rusty Russell <rusty@rustcorp.com.au> said:

  Rusty> We have a client (using SAMBA) who has people in 190 groups.  Since NT
  Rusty> has hierarchical groups, this is not all that rare.

  Rusty> What do people think of this patch?

  Rusty> Name: Dynamic Allocation of Groups Array When Required: With Refcounting
  Rusty> Author: Rusty Russell
  Rusty> Status: Tested on 2.6.0-test5-bk5
  Rusty> Depends: Misc/qemu-page-offset.patch.gz

  Rusty> D: This patch allows the maximum number of groups can be varied using
  Rusty> D: sysctl.  To do this, we use a separate group allocation if >
  Rusty> D: NGROUPS_INTERNAL, which we reference count (sharing being
  Rusty> D: v. v. common).
  Rusty> D: 
  Rusty> D: Changes:
  Rusty> D: 1) Remove the NGROUPS define from archs.
  Rusty> D: 2) Fixup the few places which declare [NGROUPS] arrays on the stack.
  Rusty> D: 3) The ia64, s390 and sparc64 ports have their own setgroups/getgroups
  Rusty> D:    implementations: unify them on the ia64 one, which calls the core
  Rusty> D:    functions.
  Rusty> D: 4) Change the task_struct to have an [NGROUPS_INTERNAL] array and
  Rusty> D:    a pointer (not convinced this is worth it at all, might skip it
  Rusty> D:    and always use external).
  Rusty> D: 5) Use a reference counted external array, fix up fork() to deal.
  Rusty> D: 6) Introduce max_groups and use it instead of NGROUPS.
  Rusty> D: 7) Add a sysctl to vary max_groups.
  Rusty> D: 
  Rusty> D: This patch scars nfs: artificially restrict the groups there to 
  Rusty> D: SVC_CRED_NGROUPS (32), which is probably wrong, but won't break if
  Rusty> D: they don't change the default.
  Rusty> D: 
  Rusty> D: This patch breaks intermezzo: I'm not sure how they want to deal
  Rusty> D: with it.

