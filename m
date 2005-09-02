Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbVIBKcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbVIBKcY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 06:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbVIBKcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 06:32:24 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:21655 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751130AbVIBKcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 06:32:23 -0400
Message-ID: <43182A2D.9010105@jp.fujitsu.com>
Date: Fri, 02 Sep 2005 19:32:13 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brent Casavant <bcasavan@sgi.com>
CC: linux-ia64@vger.kernel.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.13] IOCHK interface for I/O error handling/detecting
 (for ia64)
References: <431694DB.90400@jp.fujitsu.com> <20050901172917.I10072@chenjesu.americas.sgi.com>
In-Reply-To: <20050901172917.I10072@chenjesu.americas.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your comment, Brent.

Brent Casavant wrote:
> On Thu, 1 Sep 2005, Hidetoshi Seto wrote:
>> static inline unsigned int
>> ___ia64_inb (unsigned long port)
>> {
>> 	volatile unsigned char *addr = __ia64_mk_io_addr(port);
>> 	unsigned char ret;
>>+	unsigned long flags;
>>
>>+	read_lock_irqsave(&iochk_lock,flags);
>> 	ret = *addr;
>> 	__ia64_mf_a();
>>+	ia64_mca_barrier(ret);
>>+	read_unlock_irqrestore(&iochk_lock,flags);
>>+
>> 	return ret;
>> }
> 
> I am extremely concerned about the performance implications of this
> implementation.  These changes have several deleterious effects on I/O
> performance.

Always there is a trade-off between security and performance.
However, I know these are kinds of interfaces for paranoia.

It would help us if I divide this patch into 2 parts, MCA related part
and CPE related part.  I'd appreciate it if you could find why I wrote
such crazy rwlock in the latter part and if you could help me with your
good sight.  I'll divide them, please wait my next mails.

> The first is serialization of all I/O reads and writes.  This will
> be a severe problem on systems with large numbers of PCI buses, the
> very type of system that stands the most to gain in reliability from
> these efforts.  At a minimum any locking should be done on a per-bus
> basis.

Yes, there is a room for improvement about the lock granularity.
Maybe it should be done not on a per-bus but per-host, I think.

> The second is the raw performance penalty from acquiring and dropping
> a lock with every read and write.  This will be a substantial amount
> of activity for any I/O-intensive system, heck even for moderate I/O
> levels.

Yes, but improbably some of paranoias accepts such unpleasant without
complaining...  We could complain about the performance of RAID-5 disks.

> The third is lock contention for this single lock -- I would fully expect
> many dozens of processors to be performing I/O at any given time on
> systems of interest, causing this to be a heavily contended lock.
> This will be even more severe on NUMA systems, as the lock cacheline
> bounces across the memory fabric.  A per-bus lock would again be much
> more appropriate.

Yes.  This implementation (at least the rwlock) wouldn't fit to such
monster boxes.  However the goal of this interface is definitely in
such hi-end world, so possible improvement should be taken in near
future.

> The final problem is that these performance penalties are paid even
> by drivers which are not IOCHK aware, which for the time being is
> all of them.  A reasonable solution must pay these penalties only
> for drivers which are IOCHK aware.  Reinstating the readX_check()
> interface is the obvious solution here.  It's simply too heavy a
> performance burden to pay when almost no drivers currently benefit
> from it.

Mixing aware and non-aware would make both unhappy.
At least we need to make efforts to separate them and locate them under
different host.
* readX_check(): That was kicked out by Linus.

> Otherwise, I also wonder if you have any plans to handle similar
> errors experienced under device-initiated DMA, or asynchronous I/O.
> It's not clear that there's sufficient infrastructure in the current
> patches to adequately handle those situations.
> 
> Thank you,
> Brent Casavant

Every improvements could be.

Requiring data integrity on device-initiated DMA or asynchronous I/O
isn't wrong thing.  But I don't think that all errors should be handled
in one infrastructure.  There is an another approach to PCI error
handling, asynchronous recovery which Linas Vepstas (IBM) working on,
so maybe both would be required to handle various situation.

Thanks,
H.Seto

