Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWGKUKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWGKUKv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 16:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWGKUKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 16:10:51 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:41890 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1751135AbWGKUKv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 16:10:51 -0400
Message-ID: <44B405C8.4040706@oracle.com>
Date: Tue, 11 Jul 2006 13:10:48 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: openib-general@openib.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>
Subject: ipoib lockdep warning
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get an awfully verbose lockdep warning when I bring up ipoib devices
and wanted to make sure it didn't go unreported.  I've put it up at the
following URL:

  http://oss.oracle.com/~zab/ipoib-multicast-lockdep-warning.txt

I looked into it a bit and it seems to be on to something.  There might
be a AB, BC, CA ordering deadlock.

AB:

priv->lock is held while acquiring query_idr.lock

ipoib_mcast_send()
  spin_lock(&priv->lock);
  ipoib_mcast_sendonly_join()
    ib_sa_mcmember_rec_query()
      send_mad()
        idr_pre_get(&query_idr)
          spin_lock(&idp->lock);

BC:

query_idr.lock is taken with interrupts enabled and so is implicitly
ordered before dev->_xmit_lock which is taken in interrupt context.

ipoib_mcast_join_task()
  ipoib_mcast_join()
    ib_sa_mcmember_rec_query()
      send_mad()
        idr_pre_get(&query_idr)
          spin_lock(&idp->lock)

CA:

dev->_xmit_lock is held while acquiring priv->lock.  This triggers the
lockdep warning that adding the dep between dev->_xmit_lock and
priv->lock connects a soft-irq-safe lock to a soft-irq-unsafe one.

ipoib_mcast_restart_task()
  local_irq_save(flags);
  netif_tx_lock(dev)
    spin_lock(&dev->_xmit_lock);
  spin_lock(&priv->lock);

I can imagine all sorts of potential fixes (block ints when calling idr?
 reorder acquiry in ipoib_mcast_restart_task()?) but I'm operating on a
partial view of the paths here so I wasn't comfortable suggesting a fix.
 I wouldn't be surprised to hear that there are circumstances that both
lockdep and I don't know about that stop this from being a problem :).

In any case, it'd be fantastic if someone who knows this code could sit
down with lockdep and some ipoib regression suite to shake out lockdep's
complaints.

- z
