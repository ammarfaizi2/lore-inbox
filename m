Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131888AbRCVAd4>; Wed, 21 Mar 2001 19:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131889AbRCVAdq>; Wed, 21 Mar 2001 19:33:46 -0500
Received: from mozart.stat.wisc.edu ([128.105.5.24]:42501 "EHLO
	mozart.stat.wisc.edu") by vger.kernel.org with ESMTP
	id <S131888AbRCVAdl>; Wed, 21 Mar 2001 19:33:41 -0500
To: "Patrick O'Rourke" <orourke@missioncriticallinux.com>
Cc: Eli Carter <eli.carter@inet.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <BF9651D8732ED311A61D00105A9CA3150446D546@berkeley.gci.com>
From: buhr@stat.wisc.edu (Kevin Buhr)
In-Reply-To: Leif Sawyer's message of "Wed, 21 Mar 2001 14:41:05 -0900"
Date: 21 Mar 2001 18:32:55 -0600
Message-ID: <vbaae6e4p8o.fsf@mozart.stat.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Leif Sawyer <lsawyer@gci.com> writes:
> 
> What happens when init is not pid == 1, as is often the case
> during installs, booting off of cdrom, etc..

Well, after spending hours scrutinizing Patrick's one-line patch, I'll
guess that, in these cases, the patch does not prevent init from being
killed by an OOM error.  But, I'll bet that was a rhetorical question.

In any event, whatever process has pid == 1, it can't voluntarily exit
without a panic, and it's the reaper of all orphaned children, so it
makes sense not to kill it.  As Eli points out, the patch is cleaner
if rewritten:

--- xxx/linux-2.4.3-pre6/mm/oom_kill.c  Tue Nov 14 13:56:46 2000
+++ linux-2.4.3-pre6/mm/oom_kill.c      Wed Mar 21 15:25:03 2001
@@ -123,7 +123,7 @@

         read_lock(&tasklist_lock);
         for_each_task(p) {
-               if (p->pid) {
+               if (p->pid > 1) {
                         int points = badness(p);
                         if (points > maxpoints) {
                                 chosen = p;

since no valid pid is ever negative.

I don't see a valid reason for *not* making this change, but I'm
batting zero for two on my last two patch submissions, so I've
probably missed something.

Kevin <buhr@stat.wisc.edu>
