Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263508AbTIHUuQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 16:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263512AbTIHUuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 16:50:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:11401 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263508AbTIHUuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 16:50:11 -0400
Date: Mon, 8 Sep 2003 13:32:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: fedor@karpelevitch.net, abz@frogfoot.net, linux-kernel@vger.kernel.org
Subject: Re: possibly bug in 8139cp? (WAS Re: BUG: 2.4.23-pre3 + ifconfig)
Message-Id: <20030908133220.66676107.akpm@osdl.org>
In-Reply-To: <20030908172641.GB21226@gtf.org>
References: <20030904180554.GA21536@oasis.frogfoot.net>
	<200309071217.03470.fedor@karpelevitch.net>
	<20030907191552.GA26123@oasis.frogfoot.net>
	<200309080943.26254.fedor@karpelevitch.net>
	<20030908172641.GB21226@gtf.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> On Mon, Sep 08, 2003 at 09:43:25AM -0700, Fedor Karpelevitch wrote:
> > > > > I just installed 2.4.23-pre3 on one of our servers. If I
> > > > > up/down the loopback device multiple times ifconfig hangs on
> > > > > the second down (as in unkillable) and afterwards ifconfig
> > > > > stops functioning and I can't reboot the machine, etc.
> 
> This sounds like the NAPI bug we're chasing.
> 

Well it's the same as the bug which was recently added to 2.6:

- dev_close() used to do

	test_bit(__LINK_STATE_RX_SCHED, &dev->state);

- the netif_poll_disable() in tg3.c used to do

	test_and_set_bit(__LINK_STATE_RX_SCHED, &dev->state);

- someone copied the tg3 netif_poll_disable() into netdevice.h and then
  used it in dev_close(), thus changing and presumably breaking
  dev_close().


I haven't tested this yet, but it'll probably fix things for all NICs and
it might break tg3.  In which case it's a net win ;)


diff -puN include/linux/netdevice.h~ifdown-lockup-fix include/linux/netdevice.h
--- 25/include/linux/netdevice.h~ifdown-lockup-fix	Mon Sep  8 13:20:28 2003
+++ 25-akpm/include/linux/netdevice.h	Mon Sep  8 13:20:34 2003
@@ -854,7 +854,7 @@ static inline void netif_rx_complete(str
 
 static inline void netif_poll_disable(struct net_device *dev)
 {
-	while (test_and_set_bit(__LINK_STATE_RX_SCHED, &dev->state)) {
+	while (test_bit(__LINK_STATE_RX_SCHED, &dev->state)) {
 		/* No hurry. */
 		current->state = TASK_INTERRUPTIBLE;
 		schedule_timeout(1);

_

