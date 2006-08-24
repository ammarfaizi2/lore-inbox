Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbWHXN21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbWHXN21 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 09:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWHXN21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 09:28:27 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:18215 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751440AbWHXN20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 09:28:26 -0400
Subject: Re: [patch] dubious process system time.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <p731wr6fh54.fsf@verdi.suse.de>
References: <20060824121825.GA4425@skybase>  <p731wr6fh54.fsf@verdi.suse.de>
Content-Type: text/plain
Organization: IBM Corporation
Date: Thu, 24 Aug 2006 15:28:23 +0200
Message-Id: <1156426103.28464.29.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 14:32 +0200, Andi Kleen wrote:
> > The system time that is accounted to a process includes the time spent
> > in three different contexts: normal system time, hardirq time and
> > softirq time. To account hardirq time and sortirq time to a process
> > seems wrong, because the process could just happen to run when the
> > interrupt arrives that was caused by an i/o for a completly different
> > process. And the sum over stime and cstime of all processes won't
> > match cputstat->system either. 
> > The following patch changes the accounting of system time so that
> > hardirq and softirq time are not accounted to a process anymore.
> 
> So where does it get accounted then? It has to be accounted somewhere.
> Sounds like a quite radical change to me, might break a lot of 
> existing assumptions.

At the moment hardirq+softirq is just added to a random process, in
general this is completely wrong. You just need a system with a cpu hog
and an i/o bound process and you get queer results.
To add hardirq+softirq to a single process is wrong to begin with, for
that you would need to be able to identify the process that caused the
i/o. And if two processes require a single file page then what? Split
the time required to load the page to two processes? Not really. The
conclusion is that hardirq+softirq time should not be accouted to any
process. It is accounted globally in cpustat->softirq and
cpustat->hardirq.

There is one assumption that would break by the change: that the sum of
the hardirq and softirq time is contained in the sum of the stime and
cstime fields of all processes. I don't think that this is relevant.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


