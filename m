Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932605AbVLQQXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605AbVLQQXW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 11:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbVLQQXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 11:23:22 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:64221 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S932601AbVLQQXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 11:23:21 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17316.13699.45888.529393@gargle.gargle.HOWL>
Date: Sat, 17 Dec 2005 18:57:55 +0300
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, cfriesen@nortel.com,
       torvalds@osdl.org, hch@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Newsgroups: gmane.linux.kernel
In-Reply-To: <43A2BAA7.5000807@yahoo.com.au>
References: <43A21E55.3060907@yahoo.com.au>
	<1134560671.2894.30.camel@laptopd505.fenrus.org>
	<439EDC3D.5040808@nortel.com>
	<1134479118.11732.14.camel@localhost.localdomain>
	<dhowells1134431145@warthog.cambridge.redhat.com>
	<3874.1134480759@warthog.cambridge.redhat.com>
	<15167.1134488373@warthog.cambridge.redhat.com>
	<1134490205.11732.97.camel@localhost.localdomain>
	<1134556187.2894.7.camel@laptopd505.fenrus.org>
	<1134558188.25663.5.camel@localhost.localdomain>
	<1134558507.2894.22.camel@laptopd505.fenrus.org>
	<1134559470.25663.22.camel@localhost.localdomain>
	<20051214033536.05183668.akpm@osdl.org>
	<15412.1134561432@warthog.cambridge.redhat.com>
	<11202.1134730942@warthog.cambridge.redhat.com>
	<43A2BAA7.5000807@yahoo.com.au>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin writes:
 > David Howells wrote:
 > > Nick Piggin <nickpiggin@yahoo.com.au> wrote:
 > > 
 > > 
 > >>> (2) Those that have CMPXCHG or equivalent: 68020, i486+, x86_64, ia64,
 > >>>sparc.
 > >>> (3) Those that have LL/SC or equivalent: mips (some), alpha, powerpc, arm6.
 > >>>
 > >>
 > >>cmpxchg is basically exactly equivalent to a store-conditional, so 2 and 3
 > >>are the same level.
 > > 
 > > 
 > > No, they're not. LL/SC is more flexible than CMPXCHG because under some
 > > circumstances, you can get away without doing the SC, and because sometimes
 > > you can do one LL/SC in lieu of two CMPXCHG's because LL/SC allows you to
 > > retrieve the value, consider it and then modify it if you want to. With
 > > CMPXCHG you have to anticipate, and so you're more likely to get it wrong.
 > > 
 > 
 > I don't think that is more flexible, just different. For example with
 > cmpxchg you may not have to do the explicit load if you anticipate an
 > unlocked mutex as the fastpath.
 > 
 > My point is that they are of semantically equal strength.

In the context of implementing mutex they most likely are. But not
generally: LL/SC fails when _any_ write was made into monitored
location, whereas CAS fails only when value stored in that location
changes. As a result, CAS has to deal with "ABA problem" when value
(e.g., first element in a queue) is changed from A to B (head of the
queue is removed) and then back to A (old head is inserted back).

Nikita.
