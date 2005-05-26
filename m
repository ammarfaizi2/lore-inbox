Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbVEZMJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVEZMJe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 08:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVEZMJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 08:09:34 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:52906 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261339AbVEZMJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 08:09:32 -0400
Date: Thu, 26 May 2005 07:08:59 -0500
From: Robin Holt <holt@sgi.com>
To: Simon Derr <Simon.Derr@bull.net>
Cc: Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Dinakar Guniguntala <dino@in.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc4] cpuset exit NULL dereference fix
Message-ID: <20050526120859.GD29852@lnx-holt.americas.sgi.com>
References: <20050526082508.927.67614.sendpatchset@tomahawk.engr.sgi.com> <Pine.LNX.4.61.0505261050480.11050@openx3.frec.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0505261050480.11050@openx3.frec.bull.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2005 at 11:00:10AM +0200, Simon Derr wrote:
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

Why not change the atomic into a lock and a refcount.  Grab the lock before
each increment/decrement of the refcount and only continue with the removal
code when the refcount reaches 0.  For a normal cpuset, the refcount could
be biased to 1.  Then child cpusets are created, they could increment their
parent cpuset's refcount.  When the notify_on_release flag used to be set,
we decrement the refcount by one.  Whenever the refcount reaches 0, we
automatically remove the cpuset.  Seems really clear, but would require
touching a larger chunk of the code.

Robin
