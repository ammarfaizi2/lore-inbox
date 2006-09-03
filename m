Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWICT1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWICT1J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 15:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWICT1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 15:27:09 -0400
Received: from mtiwmhc13.worldnet.att.net ([204.127.131.117]:4749 "EHLO
	mtiwmhc13.worldnet.att.net") by vger.kernel.org with ESMTP
	id S932137AbWICT1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 15:27:07 -0400
Message-ID: <44FB2C7A.3040609@lwfinger.net>
Date: Sun, 03 Sep 2006 14:26:50 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       "David S. Miller" <davem@davemloft.net>,
       Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: 2.6.18-rc5 with GRE, iptables and Speedtouch ADSL, PPP over ATM
References: <m3odty57gf.fsf@defiant.localdomain> <20060903111507.GA12580@gondor.apana.org.au>
In-Reply-To: <20060903111507.GA12580@gondor.apana.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> [NET]: Drop tx lock in dev_watchdog_up
> 
> On Sat, Sep 02, 2006 at 08:39:28PM +0000, Krzysztof Halasa wrote:
>> =======================================================
>> [ INFO: possible circular locking dependency detected ]
>> -------------------------------------------------------
>> swapper/0 is trying to acquire lock:
>>  (&dev->queue_lock){-+..}, at: [<c02c8c46>] dev_queue_xmit+0x56/0x290
>>
>> but task is already holding lock:
>>  (&dev->_xmit_lock){-+..}, at: [<c02c8e14>] dev_queue_xmit+0x224/0x290
>>
>> which lock already depends on the new lock.
> 
> This turns out to be a genuine bug.  The queue lock and xmit lock are
> intentionally taken out of order.  Two things are supposed to prevent
> dead-locks from occuring:
> 
> 1) When we hold the queue_lock we're supposed to only do try_lock on the
> tx_lock.
> 
> 2) We always drop the queue_lock after taking the tx_lock and before doing
> anything else.
> 
>> the existing dependency chain (in reverse order) is:
>>
>> -> #1 (&dev->_xmit_lock){-+..}:
>>        [<c012e7b6>] lock_acquire+0x76/0xa0
>>        [<c0336241>] _spin_lock_bh+0x31/0x40
>>        [<c02d25a9>] dev_activate+0x69/0x120
> 
> This path obviously breaks assumption 1) and therefore can lead to ABBA
> dead-locks.
> 
> I've looked at the history and there seems to be no reason for the lock
> to be held at all in dev_watchdog_up.  The lock appeared in day one and
> even there it was unnecessary.  In fact, people added __dev_watchdog_up
> precisely in order to get around the tx lock there.
> 
> The function dev_watchdog_up is already serialised by rtnl_lock since
> its only caller dev_activate is always called under it.
> 
> So here is a simple patch to remove the tx lock from dev_watchdog_up.
> In 2.6.19 we can eliminate the unnecessary __dev_watchdog_up and
> replace it with dev_watchdog_up.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

This patch also fixes a circular locking problem that I found on Linville's wireless-dev tree
involving ieee80211 and wpa_supplicant.

Larry Finger




-- 
VGER BF report: H 1.06514e-06
