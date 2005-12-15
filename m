Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbVLOPwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbVLOPwf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 10:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbVLOPwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 10:52:35 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:37023 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S1750775AbVLOPwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 10:52:33 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17313.37200.728099.873988@gargle.gargle.HOWL>
Date: Thu, 15 Dec 2005 18:52:48 +0300
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, dhowells@redhat.com,
       pj@sgi.com, mingo@elte.hu, hch@infradead.org, torvalds@osdl.org,
       arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
In-Reply-To: <1134658579.12421.59.camel@localhost.localdomain>
References: <1134559121.25663.14.camel@localhost.localdomain>
	<13820.1134558138@warthog.cambridge.redhat.com>
	<20051213143147.d2a57fb3.pj@sgi.com>
	<20051213094053.33284360.pj@sgi.com>
	<dhowells1134431145@warthog.cambridge.redhat.com>
	<20051212161944.3185a3f9.akpm@osdl.org>
	<20051213075441.GB6765@elte.hu>
	<20051213090219.GA27857@infradead.org>
	<20051213093949.GC26097@elte.hu>
	<20051213100015.GA32194@elte.hu>
	<6281.1134498864@warthog.cambridge.redhat.com>
	<14242.1134558772@warthog.cambridge.redhat.com>
	<16315.1134563707@warthog.cambridge.redhat.com>
	<1134568731.4275.4.camel@tglx.tec.linutronix.de>
	<43A0AD54.6050109@rtr.ca>
	<20051214155432.320f2950.akpm@osdl.org>
	<17313.29296.170999.539035@gargle.gargle.HOWL>
	<1134658579.12421.59.camel@localhost.localdomain>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
 > On Iau, 2005-12-15 at 16:41 +0300, Nikita Danilov wrote:
 > > But this change is about fixing bugs: mutex assumes that
 > > 
 > >  - only owner can unlock, and
 > > 
 > >  - owner cannot lock (immediate self-deadlock).
 > 
 > So add mutex_up/mutex_down that use the same semaphores but do extra
 > checks if lock debugging is enabled. All you need is an owner field for
 > debugging.

And to convert almost all calls to down/up to mutex_{down,up}. At which
point, it no longer makes sense to share the same data-type for
semaphore and mutex.

Also, (as was already mentioned several times) having separate data-type
for mutex makes code easier to understand, as it specifies intended
usage.

To avoid duplicating code, mutex can be implemented on top of semaphore,
like

struct mutex {
        struct semaphore sema;
#ifdef DEBUG_MUTEX
        void *owner;
#endif
};

or something similar.

 > 
 > Now generate a trace dump on up when up and to check for sleeping on a
 > lock you already hold (for both sem and mutex).

Sleeping on a semaphore "held" by the current thread is perfectly
reasonable usage of a generic counting semaphore, as it can be upped by
another thread.

 > 
 > Alan

Nikita.
