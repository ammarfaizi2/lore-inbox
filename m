Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752629AbWKGXXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629AbWKGXXP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 18:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752790AbWKGXXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 18:23:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22212 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752629AbWKGXXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 18:23:14 -0500
Date: Tue, 7 Nov 2006 23:23:03 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Alasdair G Kergon <agk@redhat.com>, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com, Ingo Molnar <mingo@elte.hu>,
       Eric Sandeen <sandeen@sandeen.net>, Srinivasa DS <srinivasa@in.ibm.com>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Message-ID: <20061107232303.GB30653@agk.surrey.redhat.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Alasdair G Kergon <agk@redhat.com>, linux-kernel@vger.kernel.org,
	dm-devel@redhat.com, Ingo Molnar <mingo@elte.hu>,
	Eric Sandeen <sandeen@sandeen.net>,
	Srinivasa DS <srinivasa@in.ibm.com>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <20061107122837.54828e24.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061107122837.54828e24.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2006 at 12:28:37PM -0800, Andrew Morton wrote:
> So...  what does this have to do with switching from mutex to semaphore?
 
I should have summarised the discussion, sorry.

This has always been a semaphore, but it got changed it to a mutex as part
of a global switch recently - and this indeed generated bug reports
from people who turn debugging on and report the error messages.

So the quick fix in this patch was to put things back how they were.


Now mutex.h states:
 * - only the owner can unlock the mutex
 * - task may not exit with mutex held

 * These semantics are fully enforced when DEBUG_MUTEXES is
 * enabled.

Which begs the question whether the stated semantics are stricter than
is actually necessary.

> If so, it's a bit sad to switch to semaphore just because of some errant
> debugging code.  Perhaps it would be better to create a new
> mutex_unlock_stfu() which suppresses the warning?
 
Ingo?

> > +	if (down_trylock(&bdev->bd_mount_sem))
> > +		return -EBUSY;
> > +
 
> This is a functional change which isn't described in the changelog.  What's
> happening here?

Srinivasa added it as a precaution.
Device-mapper should never fall foul of it, but confirming that is not
trivial unless you know the code well, so it's a useful check to prevent a
bug creeping back in.

Alasdair
-- 
agk@redhat.com
