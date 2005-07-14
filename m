Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262890AbVGNEKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262890AbVGNEKl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 00:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262887AbVGNEKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 00:10:40 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:21230 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262896AbVGNEKh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 00:10:37 -0400
Subject: Re: RT and XFS
From: Daniel Walker <dwalker@mvista.com>
To: Dave Chinner <dgc@sgi.com>
Cc: Nathan Scott <nathans@sgi.com>, Ingo Molnar <mingo@elte.hu>,
       Steve Lord <lord@xfs.org>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
In-Reply-To: <20050714135023.E241419@melbourne.sgi.com>
References: <1121209293.26644.8.camel@dhcp153.mvista.com>
	 <20050713002556.GA980@frodo> <20050713064739.GD12661@elte.hu>
	 <1121273158.13259.9.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <20050714002246.GA937@frodo>  <20050714135023.E241419@melbourne.sgi.com>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 21:10:26 -0700
Message-Id: <1121314226.14816.18.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-14 at 13:50 +1000, Dave Chinner wrote:
> Now that I've read the thread, I see it's not mrlocks that is the
> issue with unlocking in a different context - it's semaphores.
> 
> All the pagebuf synchronisation is done with a semaphore because
> it's held across the I/O and it's _most definitely_ released in a
> different context when doing async I/O. Just about all metadata I/O
> is async because once the transaction has been logged to disk we
> don't need to write these buffers out synchronously. Not to mention
> the log I/O completion unlocks the buffers in a transaction in a
> different context as well.
> 
> The whole point of using a semaphore in the pagebuf is because there
> is no tracking of who "owns" the lock so we can actually release it
> in a different context. Semaphores were invented for this purpose,
> and we use them in the way they were intended. ;)

Where is the that semaphore spec, is that posix ?  There is a new
construct called "complete" that is good for this type of stuff too. No
owner needed , just something running, and something waiting till it
completes.

> Realistically, I seriously doubt the need for any sort of rt changes
> to these semaphores. They can be held for indeterminant periods of
> time potentially across multiple disk I/Os (e.g. when held locked in
> a transaction that requires more metadata to be read in from disk to
> make progress).  Hence there is no really no point in making them RT
> aware because if you end up waiting on one of them you can forget
> about pretty much any RT guarantee that you've ever given....

PI is always good, cause it allows the tracking of what is high
priority , and what is not . 

Daniel

