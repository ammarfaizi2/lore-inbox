Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261509AbSJYSLR>; Fri, 25 Oct 2002 14:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261514AbSJYSLR>; Fri, 25 Oct 2002 14:11:17 -0400
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:28596
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S261509AbSJYSLQ>; Fri, 25 Oct 2002 14:11:16 -0400
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200210251817.g9PIHTw02950@www.hockin.org>
Subject: Re: [BK PATCH 1/4] fix NGROUPS hard limit (resend)
To: jw@pegasys.ws (jw schultz)
Date: Fri, 25 Oct 2002 11:17:29 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <20021025124901.GE10440@pegasys.ws> from "jw schultz" at Oct 25, 2002 05:49:01 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	example group file extract:
> 		webroot:x:103:www,jim,joy
> 		custadm:x:140:%webroot,bob,carol,ted,alice
> 		webcusts:x:1000:%webcust1,%webcust2,%webcust3
> 		webcust1:x:1001:%custadm,%custwebs,Matt,Christoph
> 		webcust2:x:1002:%custadm,%custwebs,Suparna,Aaron,Tim
> 		webcust3:x:1003:%custadm,%custwebs,Randal,Jesse

I've always wanted something like this.  It really is not too difficult to
do, but it is entirely a library problem.

> 	Now, changing it at this level would require that
> 	the libs be updated (but so would infinite groups)
> 	and a way to inform the kernel of the nested group
> 	memberships.

unlimited groups requires a TRIVIAL change to libc.

> 	For informing the kernel i lean toward a sysfs
> 	interface fed by a user-space utility that would
> 	build or update a pinned table.  The in-kernel group
> 	lists would be unrolled (per the example
> 	webroot=custadm,webcust1,webcust2,webcust3)

gahh..Why does the kernel need to know about a group and members?  At login
time (or rather, setgroups() time, likely login, but could be other)
getgrent() or whatnot does a full expansion on the nested group file
(handling recursion properly!).  You call setgroups() with the full list of
GIDs for your user.  The kernel should not know about a group beyond a GID,
unless we're talking about vastly different semantics than traditional users
and groups.

> 	There would be problems with existing utilities due

problems with things that parse /etc/group.  Not problems with things that
use the getgr*() functions.

> 	It also provides a way to have 400 (out of 16000)
> 	users in a group without infinite line length in
> 	/etc/group.

Line length is/was an real issue.  Last I tried to do something like having
5000 users in a group, libc would not parse it.  Can't say I've tried
lately.  That, however, is another purely library problem.

> The important thing either way would be that you would save
> on memory for group lists and it would work over NFS without
> a protocol change.

No, it wouldn't work on NFS except to another system which understands this
scheme.  The patch I proposed uses CoW grouplists.  This is good
enough for the vast majority of cases - not too many apps call setgroups()
themselves, being a restricted syscall, and all that.

> I've actually wanted the nested group memberships for a long
> time.

So have I, but it is a different problem...Patches should be sent to
glibc developers.

