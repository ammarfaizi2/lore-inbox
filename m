Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbVHQHx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbVHQHx5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 03:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbVHQHx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 03:53:57 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:18383 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750759AbVHQHx4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 03:53:56 -0400
Date: Wed, 17 Aug 2005 09:56:13 +0200
From: Jens Axboe <axboe@suse.de>
To: Avi Kivity <avi@argo.co.il>
Cc: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       hdaps devel <hdaps-devel@lists.sourceforge.net>
Subject: Re: HDAPS, Need to park the head for real
Message-ID: <20050817075611.GE6019@suse.de>
References: <1124205914.4855.14.camel@localhost.localdomain> <20050816200708.GE3425@suse.de> <4302EB80.7060705@argo.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4302EB80.7060705@argo.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17 2005, Avi Kivity wrote:
> Jens Axboe wrote:
> 
> >Ok, I'll give you some hints to get you started... What you really want
> >to do, is:
> >
> >- Insert a park request at the front of the queue
> >- On completion callback on that request, freeze the block queue and
> > schedule it for unfreeze after a given time
> >
> > 
> >
> how will this interact with command queuing? there is a danger from both 
> commands previously queued but not yet completed, and commands that are 
> queued after the park request. or is the park request a barrier?

It doesn't interact with queueing, it doesn't matter what else is in the
queue. The park itself is not a barrier, since it should be placed as
next-to-execute at the front of the queue. Non-fs requests are never
reordered once inserted (since sorting on them doesn't make sense, the
io scheduler doesn't know what they are). Since the queue will not be
processed after the park has completed (it is frozen). So if the queue
currently looks like this:

[R0] <-> R1 <-> R2 <-> W1 <-> R3 <-> W2

(R is read, W is write, R0 is currently being processed), when you issue
the park the queue will look like:

[R0] <-> PARK <-> R1 <-> R2 <-> W1 <-> R3 <-> W2

Read completes, PARK will now be executed. While this happens, two more
writes are inserted somewhere in the queue. If successful, queue is
frozen in this state:

[] <-> R1 <-> W4 <-> R2 <-> W1 <-> W3 <-> R3 <-> W2

When the queue is thawed, R1 will be sent next.

-- 
Jens Axboe

