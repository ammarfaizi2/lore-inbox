Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWHUX4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWHUX4E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 19:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbWHUX4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 19:56:04 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:54189
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750761AbWHUX4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 19:56:01 -0400
Date: Mon, 21 Aug 2006 16:56:16 -0700 (PDT)
Message-Id: <20060821.165616.107936004.davem@davemloft.net>
To: linas@austin.ibm.com
Cc: arnd@arndb.de, shemminger@osdl.org, akpm@osdl.org, netdev@vger.kernel.org,
       jklewis@us.ibm.com, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, Jens.Osterkamp@de.ibm.com, jgarzik@pobox.com
Subject: Re: [RFC] HOWTO use NAPI to reduce TX interrupts
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060821235244.GJ5427@austin.ibm.com>
References: <44E7BB7F.7030204@osdl.org>
	<200608191325.19557.arnd@arndb.de>
	<20060821235244.GJ5427@austin.ibm.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: linas@austin.ibm.com (Linas Vepstas)
Date: Mon, 21 Aug 2006 18:52:44 -0500

> Under what circumstance does one turn TX interrupts back on?
> I couldn't quite figure that out.

Don't touch interrupts until both RX and TX queue work is
fullydepleted.  You seem to have this notion that RX and TX interrupts
are seperate.  They aren't, even if your device can generate those
events individually.  Whatever interrupt you get, you shut down all
interrupt sources and schedule the ->poll().  Then ->poll() does
something like:

	all_tx_completion_work();
	ret = as_much_rx_work_as_budget_and_quota_allows();
	if (!ret)
		reenable_interrupts_and_complet_napi_poll();

You always run the TX completion work fully, then you do the RX work
within the quota/budget.

See the tg3 driver for details, really...

