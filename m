Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264448AbTICUNc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 16:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264433AbTICUMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 16:12:08 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:1493 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264307AbTICUK6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 16:10:58 -0400
Date: Wed, 3 Sep 2003 15:10:44 -0500
From: linas@austin.ibm.com
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, mingo@redhat.com,
       riel@redhat.com, mranweil@us.ibm.com
Subject: Re: PATCH: kernel-2.4 brlock livelock
Message-ID: <20030903151043.B51004@forte.austin.ibm.com>
References: <20030903142150.A48064@forte.austin.ibm.com> <20030903194401.GA688@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030903194401.GA688@krispykreme>; from anton@samba.org on Thu, Sep 04, 2003 at 05:44:02AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 05:44:02AM +1000, Anton Blanchard wrote:
> 
> Hi,
> 
> > The patch changes the non-atomic code. It grabs the write lock, and
> > then spins, waiting for all of the existing readers to finish. 
> > New readers are held off.  This seems (to me) to be a reasonable 
> > thing to do, based on the following logic:
> 
> The problem is with recursive readers. One cpu takes a br read lock then
> wants to take the same lock again. It must be allowed to get that read lock.
> 
> We need to drop the write spinlock or else we will deadlock.

Whoops. 

OK, how about the following: readers on a given cpu are held off 
if the write lock is held *and* the read-count on that cpu is zero?

That way, 'recursive' readers on other CPU's can get a read-lock if
there's already a non-zero read-lock-count on that CPU.   

That should work if the thread holding the lock can't get scheduled
to another cpu.  Can these things wander around?

If they can wander around, then oone would have to order the cpus:
wait for read count to drop to zero on cpu 0 then on 1 then on 2, 
meanwhile the read-lock can be gotten on the higher ordered CPUs ...

If this sounds reasonable, would you care to see a revised patch?

What else can go wrong?

--linas
