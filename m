Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262438AbVCKErH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbVCKErH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 23:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262966AbVCKErH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 23:47:07 -0500
Received: from fire.osdl.org ([65.172.181.4]:14311 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262438AbVCKErA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 23:47:00 -0500
Date: Thu, 10 Mar 2005 20:40:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Mackerras <paulus@samba.org>, Jean Tourrilhes <jt@bougret.hpl.hp.com>,
       javier@tudela.mad.ttd.net, linux-fbdev-devel@lists.sourceforge.net,
       acpi-devel@lists.sourceforge.net, linux1394-devel@lists.sourceforge.net,
       Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org
Subject: inappropriate use of in_atomic()
Message-Id: <20050310204006.48286d17.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


in_atomic() is not a reliable indication of whether it is currently safe
to call schedule().

This is because the lockdepth beancounting which in_atomic() uses is only
accumulated if CONFIG_PREEMPT=y.  in_atomic() will return false inside
spinlocks if CONFIG_PREEMPT=n.

Consequently the use of in_atomic() in the below files is probably
deadlocky if CONFIG_PREEMPT=n:

	arch/ppc64/kernel/viopath.c
	drivers/net/irda/sir_kthread.c
	drivers/net/wireless/airo.c
	drivers/video/amba-clcd.c
	drivers/acpi/osl.c
	drivers/ieee1394/ieee1394_transactions.c
	drivers/infiniband/core/mad.c

Note that the same beancounting is used for the "scheduling while atomic"
warning, so if the code calls schedule with locks held, we won't get a
warning.  Both are tied to CONFIG_PREEMPT=y.

The kernel provides no reliable runtime way of detecting whether or not it
is safe to call schedule().

Can we please find ways to change the above code to not use in_atomic()? 
Then we can whack #ifndef MODULE around its definition to reduce
reoccurrences.  Will probably rename it to something more scary as well.

Thanks.
