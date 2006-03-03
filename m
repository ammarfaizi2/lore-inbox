Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752100AbWCCA66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbWCCA66 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 19:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752103AbWCCA66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 19:58:58 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:6919 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1752100AbWCCA66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 19:58:58 -0500
X-IronPort-AV: i="4.02,161,1139212800"; 
   d="scan'208"; a="259195988:sNHT32713372"
To: Tilman Schmidt <tilman@imap.cc>
Cc: Arjan van de Ven <arjan@infradead.org>, Hansjoerg Lipp <hjlipp@web.de>,
       Karsten Keil <kkeil@suse.de>, i4ldeveloper@listserv.isdn4linux.de,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH 0/7] isdn4linux: add drivers for Siemens Gigaset ISDN DECT PABX
X-Message-Flag: Warning: May contain useful information
References: <gigaset307x.2006.02.27.001.0@hjlipp.my-fqdn.de>
	<1141032577.2992.83.camel@laptopd505.fenrus.org>
	<440779AF.5060202@imap.cc>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 02 Mar 2006 16:58:54 -0800
In-Reply-To: <440779AF.5060202@imap.cc> (Tilman Schmidt's message of "Fri, 03 Mar 2006 00:03:11 +0100")
Message-ID: <adapsl4s5rl.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 03 Mar 2006 00:58:56.0139 (UTC) FILETIME=[A5CFFDB0:01C63E5D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > So you are saying that, for example
 > 
 > 	spin_lock_irqsave(&cs->ev_lock, flags);
 > 	head = cs->ev_head;
 > 	tail = cs->ev_tail;
 > 	spin_unlock_irqrestore(&cs->ev_lock, flags);
 > 
 > is (mutatis mutandis) actually cheaper than
 > 
 > 	head = atomic_read(&cs->ev_head);
 > 	tail = atomic_read(&cs->ev_tail);
 > 
 > ? That's interesting. I wouldn't have expected that after reading
 > Documentation/atomic_ops.txt and Documentation/spinlock.txt.

No, atomic_read() is cheap because it doesn't have to do a locked
operation.  However, operations like atomic_inc() that do need to do
something special are quite expensive.

For example, on x86, each atomic_inc()/atomic_dec() is the same cost
as a spin_lock(), since they all have to do some sort of "lock ; incX"
or "lock ; decX".  But then spin_unlock() is cheap, because it can do
a simple unlocked mov.

So in other words,

 	spin_lock_irqsave(&lock, flags);
 	++head1;
 	++head2;
 	spin_unlock_irqrestore(&lock, flags);
 
should be cheaper than

 	atomic_inc(&head1);
 	atomic_inc(&head2);

On the other hand, if you use the spinlock variant, then you do incur
an extra cost by requiring the lock for both reads and writes, instead
of the cheap atomic_read().

But complex use of atomic_t is very hard to get right, so it's usually
better to use a spinlock.

 - R.
