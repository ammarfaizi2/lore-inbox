Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262782AbUKRRiC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262782AbUKRRiC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 12:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262808AbUKRR30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 12:29:26 -0500
Received: from tentacle.s2s.msu.ru ([193.232.119.109]:51328 "EHLO
	tentacle.sectorb.msk.ru") by vger.kernel.org with ESMTP
	id S262804AbUKRR0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 12:26:11 -0500
Date: Thu, 18 Nov 2004 20:26:06 +0300
From: "Vladimir B. Savkin" <master@sectorb.msk.ru>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.10-rc2
Message-ID: <20041118172606.GA6729@tentacle.sectorb.msk.ru>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org>
X-Organization: Moscow State Univ., Dept. of Mechanics and Mathematics
X-Operating-System: Linux 2.6.9-rc2-mm1
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2004 at 06:49:04PM -0800, Linus Torvalds wrote:
> 
> Ok, the -rc2 changes are almost as big as the -rc1 changes, and we should 
> now calm down, so I do not want to see anything but bug-fixes until 2.6.10 
> is released. Otherwise we'll never get there.

Please accept this fix:

[PATCH] fix posix_locks_deadlock().

"blocked_list" may contain both leases and flock locks. Since the latter in
particular do not initialize the fl_owner field, we have to beware not to
call posix_same_owner() on them.

Signed-off-by: Trond Myklebust <trond.myklebust@fys.uio.no>
---
 locks.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

Index: linux-2.6.9-rc2-up/fs/locks.c
===================================================================
--- linux-2.6.9-rc2-up.orig/fs/locks.c	2004-09-19 13:55:33.680258334 -0700
+++ linux-2.6.9-rc2-up/fs/locks.c	2004-09-19 15:37:32.595634679 -0700
@@ -634,14 +634,13 @@
 int posix_locks_deadlock(struct file_lock *caller_fl,
 				struct file_lock *block_fl)
 {
-	struct list_head *tmp;
+	struct file_lock *fl;
 
 next_task:
 	if (posix_same_owner(caller_fl, block_fl))
 		return 1;
-	list_for_each(tmp, &blocked_list) {
-		struct file_lock *fl = list_entry(tmp, struct file_lock, fl_link);
-		if (posix_same_owner(fl, block_fl)) {
+	list_for_each_entry(fl, &blocked_list, fl_link) {
+		if (IS_POSIX(fl) && posix_same_owner(fl, block_fl)) {
 			fl = fl->fl_next;
 			block_fl = fl;
 			goto next_task;

~
:wq
                                        With best regards, 
                                           Vladimir Savkin. 

