Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030308AbWGSUx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030308AbWGSUx3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 16:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbWGSUx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 16:53:29 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:42060 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030307AbWGSUx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 16:53:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=etf7DzXhc9XhOacnxzjU5egeASHoFGvli37XcE6NNI70uXe3wkKID1iwAtZxnz4nae1IRWGyFbeDzbtqb1Ha1sdzOKTmIk30MqAq1mohGOh5ZMpV9Iga41sh9/X/QFVGLP0fEYPOu5wPl1E4qYNcPJFHblOiVVYwx4RpSurP3j4=
Message-ID: <20f65d530607191353p734e9392g1283dae9a7b14b1a@mail.gmail.com>
Date: Thu, 20 Jul 2006 08:53:28 +1200
From: "Keith Chew" <keith.chew@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: network tx_timeout guidance
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

We are stress testing a wireless network driver from a vendor (ZD1211
chip, we realise that there is a rewrite project happenning but that
it still not ready for production yet).

So far, everything is going very well except after several days when a
Tx Timeout occurs. In this scenario, the driver goes into a tight
loop, and we keep getting the Tx Timeout. I have already contacted the
vendor, but just wanted additional opinion/feedback from the experts
at LKML.

In the code, this is the callback from the assignment:
============================
#define	ZD1211_TX_TIMEOUT		(HZ*10)
...
dev->watchdog_timeo = ZD1211_TX_TIMEOUT;
dev->tx_timeout = &zd1211_tx_timeout;
============================

A couple of questions:
(1) How should the zd1211_tx_timeout handle a Tx Timeout? At present
it is calling the usb_kill_urb via the kevent. Is this what it is
suppose to do?

============================
static void zd1211_tx_timeout(struct net_device *dev)
  struct zd1205_private *macp = dev->priv;
// Which will call zd1211_kill_tx_urb() below via kevent;
  defer_kevent(macp, KEVENT_KILL_TX_URB);
}

static void zd1211_kill_tx_urb(void *_macp) {
	  struct zd1205_private *macp = (struct zd1205_private *)_macp;
// conditional defines are ommited to keep things clear
    usb_kill_urb(macp->tx_urb);
}
============================

(2) What is the best way to simulate a Tx Timeout? Currently we have
to wait for several days (for 1 of the 10 PCs under stress testing)
for it to occur.

Regards
Keith
