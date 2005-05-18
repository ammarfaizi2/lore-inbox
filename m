Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261985AbVERANl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbVERANl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 20:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVERANl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 20:13:41 -0400
Received: from graphe.net ([209.204.138.32]:12044 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261985AbVERANd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 20:13:33 -0400
Date: Tue, 17 May 2005 17:13:28 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, shai@scalex86.org
Subject: Re: [PATCH] Optimize sys_times for a single thread process
In-Reply-To: <20050517161000.5e0fb0a9.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0505171708250.18365@graphe.net>
References: <Pine.LNX.4.62.0505171536080.15653@graphe.net>
 <20050517161000.5e0fb0a9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2005, Andrew Morton wrote:

> Well, hrm, maybe.  If this task has one sibling thread, and that thread is
> in the process of exitting then (current == next_thread(current)) may
> become true before that sibling thread has had a chance to dump its process
> accounting info into the signal structure.

The task is only "unhashed" after the counters have been added in 
__exit_signal. See release_task in kernel/exit.c

> If that dumping happens prior to the __detach_pid() call then things are
> probably OK (modulo memory ordering issues).  Otherwise there's a little
> window where the accounting will go wrong.

__exit_signal takes various locks that will insure the proper sequencing.

> Have you audited that code to ensure that the desired sequencing occurs in
> all cases and that the appropriate barriers are in place?

AFAIK release task is always called for task removal.

> It all looks a bit fast-and-loose.  If there are significant performance
> benefits and these issues are loudly commented (they aren't at present)
> then maybe-OK, I guess.

There are significant performance benefits in particular for one standard 
NUMA benchmark that keeps calling sys_times over and over. I believe other 
programs may exhibit the same brain dead behavior.

