Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbVEZNqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVEZNqb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 09:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVEZNqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 09:46:31 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:61604 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261441AbVEZNq0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 09:46:26 -0400
Date: Thu, 26 May 2005 19:24:29 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Simon Derr <Simon.Derr@bull.net>
Cc: Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc4] cpuset exit NULL dereference fix
Message-ID: <20050526135429.GA3954@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20050526082508.927.67614.sendpatchset@tomahawk.engr.sgi.com> <Pine.LNX.4.61.0505261050480.11050@openx3.frec.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0505261050480.11050@openx3.frec.bull.fr>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2005 at 11:00:10AM +0200, Simon Derr wrote:
> > The obvious fix would be to always hold the cpuset_sem
> > semaphore while decrementing the use count and dealing with
> > notify_on_release.  However we don't want to force a global
> > semaphore into the mainline task exit path, as that might create
> > a scaling problem.
> > 
> > The actual fix is almost as easy - since this is only an issue
> > for cpusets using notify_on_release, which the top level big
> > cpusets don't normally need to use, only take the cpuset_sem
> > for cpusets using notify_on_release.
> 
> I'm a bit concerned about this. Since there might well be 
> 'notify_on_release' cpusets all over the system, and that there is only 
> one cpuset_sem semaphore, I feel like this 'scaling problem' still exists 
> even with:
> 
> if (notify_on_release(cs)) {
> 	down(&cpuset_sem);
> 	...
> 
> Maybe adding more per-cpuset data such as a per-cpuset removal_sem might 
> be worth it ?

This would have to be in addition to the existing cpuset_sem wont it ??
Not sure if we need to add any more complexity unless the scaling problem
is really huge.

However if we do end up making any changes then IMO locking can be made 
more granular, instead of one sem for cpus, memory and all operations 
on cpusets

	-Dinakar
