Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVEZJBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVEZJBN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 05:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVEZJBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 05:01:13 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:54507 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261290AbVEZJBG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 05:01:06 -0400
Date: Thu, 26 May 2005 11:00:10 +0200 (CEST)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@openx3.frec.bull.fr
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Dinakar Guniguntala <dino@in.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Simon Derr <Simon.Derr@bull.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc4] cpuset exit NULL dereference fix
In-Reply-To: <20050526082508.927.67614.sendpatchset@tomahawk.engr.sgi.com>
Message-ID: <Pine.LNX.4.61.0505261050480.11050@openx3.frec.bull.fr>
References: <20050526082508.927.67614.sendpatchset@tomahawk.engr.sgi.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 26/05/2005 11:11:06,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 26/05/2005 11:11:54,
	Serialize complete at 26/05/2005 11:11:54
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 May 2005, Paul Jackson wrote:

> The existing code decrements the cpuset use count, and if the
> count goes to zero, processes the notify_on_release request,
> if appropriate.  However, once the count goes to zero, unless we
> are holding the global cpuset_sem semaphore, there is nothing to
> stop another task from immediately removing the cpuset entirely,
> and recycling its memory.
Good catch.

> 
> The obvious fix would be to always hold the cpuset_sem
> semaphore while decrementing the use count and dealing with
> notify_on_release.  However we don't want to force a global
> semaphore into the mainline task exit path, as that might create
> a scaling problem.
> 
> The actual fix is almost as easy - since this is only an issue
> for cpusets using notify_on_release, which the top level big
> cpusets don't normally need to use, only take the cpuset_sem
> for cpusets using notify_on_release.

I'm a bit concerned about this. Since there might well be 
'notify_on_release' cpusets all over the system, and that there is only 
one cpuset_sem semaphore, I feel like this 'scaling problem' still exists 
even with:

if (notify_on_release(cs)) {
	down(&cpuset_sem);
	...

Maybe adding more per-cpuset data such as a per-cpuset removal_sem might 
be worth it ?

	Simon.




