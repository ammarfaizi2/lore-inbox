Return-Path: <linux-kernel-owner+w=401wt.eu-S1161268AbXAMEkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161268AbXAMEkR (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 23:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161275AbXAMEkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 23:40:17 -0500
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:36522 "HELO
	smtp103.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1161268AbXAMEkQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 23:40:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=qP//SLAO8wHEdgYgLH3+Rs5PSoc3dkErTlTNAEzON+ZleSgJ0WB4FMo4QFyxbSRUgRame/f4b2QZne4oxKSBGusR9q9J6QgpMm/NdSaGkiuLcDDeu3+5F5whbZNoNLrtCX7MrJZqTUHKj0C0VZamykn+1KojtTWgOs+bdKpSDRY=  ;
X-YMail-OSG: CKwBtpwVM1lbbS0iErhbeukPgNstitJjG_rWB0fCA50qFSvq19oUgE2dBbv3q9BKL6CLx05SqhNg9d6WruA0faZHodrJjB0Ff5KEkmXOiRRDVJNvnjw6h1ZeMDvJMYijwP.USoxJRbY70KI-
Message-ID: <45A86291.8090408@yahoo.com.au>
Date: Sat, 13 Jan 2007 15:39:45 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ravikiran G Thirumalai <kiran@scalex86.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       pravin b shelar <pravin.shelar@calsoftinc.com>
Subject: Re: High lock spin time for zone->lru_lock under extreme conditions
References: <20070112160104.GA5766@localhost.localdomain>
In-Reply-To: <20070112160104.GA5766@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai wrote:
> Hi,
> We noticed high interrupt hold off times while running some memory intensive
> tests on a Sun x4600 8 socket 16 core x86_64 box.  We noticed softlockups,

[...]

> We did not use any lock debugging options and used plain old rdtsc to
> measure cycles.  (We disable cpu freq scaling in the BIOS). All we did was
> this:
> 
> void __lockfunc _spin_lock_irq(spinlock_t *lock)
> {
>         local_irq_disable();
>         ------------------------> rdtsc(t1);
>         preempt_disable();
>         spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
>         _raw_spin_lock(lock);
>         ------------------------> rdtsc(t2);
>         if (lock->spin_time < (t2 - t1))
>                 lock->spin_time = t2 - t1;
> }
> 
> On some runs, we found that the zone->lru_lock spun for 33 seconds or more
> while the maximal CS time was 3 seconds or so.

What is the "CS time"?

It would be interesting to know how long the maximal lru_lock *hold* time is,
which could give us a better indication of whether it is a hardware problem.

For example, if the maximum hold time is 10ms, that it might indicate a
hardware fairness problem.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
