Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261433AbSKMO3g>; Wed, 13 Nov 2002 09:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261669AbSKMO3g>; Wed, 13 Nov 2002 09:29:36 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:40459 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S261433AbSKMO3f>; Wed, 13 Nov 2002 09:29:35 -0500
Message-ID: <3DD26382.692BD476@aitel.hist.no>
Date: Wed, 13 Nov 2002 15:36:50 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.47 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Margit Schubert-While <margitsw@t-online.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Optimal SCSI Commands per device (TCQ) ?
References: <4.3.2.7.2.20021113133414.00b53b00@mail.dns-host.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Margit Schubert-While wrote:
> 
> What is the optimal TCQ for eg. AIC7xxxx on Adaptec 39160
> with 2 x U160 disks on each channel ? (MAN3184MP and
> DDYS-T18350N)
> What does it depend on ?

The optimal depends on what you do, so the best
way to get a good answer is to try several
settings and see what works best.

Generally, a deeper tagged queue gives
better throughput.  The difference
is biggest when going from 0 to 1.
Making the queues progressively deeper
gives even more throughput, but the 
improvement diminishes quickly.

You have to look up how deep queues your disks
support, because this is variable among 
different models.  Some might max out at 8,
others can handle 256. There seems to be little
benefit at all beyond 32.

There is currently a downside to deep queues.
Linux v. 2.5 has a fair io scheduler that ensures
that no process waits "too long" for its
disk accesses.  This is particularly
important for reads.  A deep tagged
queue may improve total throughput, but
this may defeat the io scheduler so
processes doing random reads get starved
waiting for processes doing large linear
reads or writes.  

If this don't bother you, go for a deep
queue like 32 perhaps. If you want fairness
(users wait for response, i.e. desktop
machine or file/web server for multiple
people) go for something more shallow.

I have seen recommendations as low as 2-4 tags
to let the io scheduler enforce fairness.
2-4 tags is a lot better than none, going
from 4 to 32 probably makes less difference
than from 0 to 4. 

For an example of what a fair scheduler does,
look at previously posted benchmarks with
kernel compiles during a dbench run on the same disk.
Without fairness the compile takes many times longer.
with fairness the compile time is almost the same
as when compiling without the additional burden of a dbench.

Helge Hafting
