Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbTDXSKl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 14:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263773AbTDXSKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 14:10:41 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:9092 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S263769AbTDXSKk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 14:10:40 -0400
From: bob <bob@watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Apr 2003 14:22:38 -0400 (EDT)
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'karim@opersys.com'" <karim@opersys.com>,
       "'Tom Zanussi'" <zanussi@us.ibm.com>,
       "'Martin Hicks'" <mort@wildopensource.com>,
       "'Daniel Stekloff'" <dsteklof@us.ibm.com>,
       "'Patrick Mochel'" <mochel@osdl.org>,
       "'Randy.Dunlap'" <rddunlap@osdl.org>, "'hpa@zytor.com'" <hpa@zytor.com>,
       "'pavel@ucw.cz'" <pavel@ucw.cz>,
       "'jes@wildopensource.com'" <jes@wildopensource.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'wildos@sgi.com'" <wildos@sgi.com>,
       "'Robert Wisniewski'" <bob@watson.ibm.com>
Subject: RE: [patch] printk subsystems
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780C263852@orsmsx116.jf.intel.com>
References: <A46BBDB345A7D5118EC90002A5072C780C263852@orsmsx116.jf.intel.com>
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <16040.10837.495028.456650@k42.watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is both a qualitative difference and quantitative difference in a
lockless algorithm as described versus one that uses locking.  Most
importantly for Linux, these algorithms in practice have better performance
characteristics.  There is a whole body of literature on lock free
algorithms (see Maurice Herlihy's 1988 PODC Wait-Free Synchronization
paper).  When a process holds a lock nobody else can make progress.  If
that process is interrupted everybody waits.  Furthermore, when designing
for scalability, queue locks are used, which considerably exacerbates the
problem (see Kontothanassis TOCS Feb 1997).  Locking reduces concurrency,
lockfree and lockless algorithms allow increased concurrency (both
processes can simultaneously log their events once they've reserved space).

The lockless tag is indeed correct, accurate, and helpful in identifying
the characteristics of the algorithm.  More of these algorithms, such as
the recent RCU work, will need to be placed into Linux for it to perform
well on multiprocessors.

Robert Wisniewski
The K42 MP OS Project
Advanced Operating Systems
Scalable Parallel Systems
IBM T.J. Watson Research Center
914-945-3181
http://www.research.ibm.com/K42/
bob@watson.ibm.com

Perez-Gonzalez, Inaky writes:
 > 
 > > From: Karim Yaghmour [mailto:karim@opersys.com]
> >
> > relayfs actually uses 2 mutually-exclusive schemes internally -
> > 'lockless' and 'locking', depending on the availability of a cmpxchg
> > instruction (lockless needs cmpxchg).  If the lockless scheme is being
> > used, relay_lock_channel() does no locking or irq disabling of any
> > kind i.e. it's basically a no-op in that case.  
> 
> So that means you are using cmpxchg to do the locking. I mean, not the
> "locking" itself, but a similar process to that of locking. I see. 
> 
> However, isn't it the almost the same as spinlocking? You are basically
> trying to "allocate" a channel idx with atomic cmpxchg; if it fails, you
> are retrying, spinning on the retry code until successful.
> 
> Not meaning to be an smartass here, but I don't buy the "lockless" tag,
> I would agree it is an optimized-lock scheme [assuming it works better
> than the spinlock case, that I am sure it does because if not you guys
> would have not gone through the process of implementing it], but it is
> not lockless.
> 

>> Don't get me wrong - I don't mean the actual difference is not important;
>> what I mean is not important is me buying the "lockless" tag or not. I 
>> actually think that the method you guys use is really sharp.

