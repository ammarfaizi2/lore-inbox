Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVAWD36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVAWD36 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 22:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVAWD36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 22:29:58 -0500
Received: from bgm-24-94-57-164.stny.rr.com ([24.94.57.164]:65485 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261198AbVAWD3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 22:29:55 -0500
Subject: Re: [PATCH] e100 locking up netconsole.
From: Steven Rostedt <rostedt@kihontech.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linux NICS <linux.nics@intel.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1106445146.11995.36.camel@localhost.localdomain>
References: <1106445146.11995.36.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 22 Jan 2005 22:29:43 -0500
Message-Id: <1106450983.11995.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-01-22 at 20:52 -0500, Steven Rostedt wrote:
> I'm currently working with Ingo's RT patched kernel, but I believe this
> affects the mainline too.
> 
> If the transmit buffer of the e100 overflowed, then the system would
> hang. This was caused because the e100 driver would stop the queue, and
> find_skb in netpoll.c would then loop forever.  This is because the e100
  ^^^^^^^^^

Should be netpoll_send_pkt.  That's what I get when I search for
"repeat" to remember which function I saw the problem in.


> net_poll would never start the queue again after the transmits have
> completed.
> 
> For those that use the e100 and netconsole, all you need to do is a
> sysreq 't' to lock up the system.
> 
> Here's the patch: (from Ingo's linux-2.6.11-rc2-V0.7.36-02, but should
> be OK with 2.6.11-rc2)
> 
> 
> Index: drivers/net/e100.c
> ===================================================================
> --- drivers/net/e100.c	(revision 60)
> +++ drivers/net/e100.c	(working copy)
> @@ -1630,6 +1630,7 @@
>  	struct nic *nic = netdev_priv(netdev);
>  	e100_disable_irq(nic);
>  	e100_intr(nic->pdev->irq, netdev, NULL);
> +	e100_tx_clean(nic);
>  	e100_enable_irq(nic);
>  }
>  #endif
> 
> 
> 
> -- Steve
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Steven Rostedt
Senior Engineer
Kihon Technologies

