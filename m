Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbUCAKm0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 05:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbUCAKmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 05:42:25 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:46560 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S261196AbUCAKmT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 05:42:19 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Tom Rini <trini@kernel.crashing.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [KGDB PATCH][6/7] KGDBOE fixes
Date: Mon, 1 Mar 2004 16:12:02 +0530
User-Agent: KMail/1.5
References: <20040227212301.GC1052@smtp.west.cox.net> <20040227214605.GH1052@smtp.west.cox.net> <20040227215211.GI1052@smtp.west.cox.net>
In-Reply-To: <20040227215211.GI1052@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403011612.02255.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok by me
-Amit

On Saturday 28 Feb 2004 3:22 am, Tom Rini wrote:
> Hello.  The following is a couple of small but important cleanups to
> kgdboe. - memset out_buf in case we don't have it full when we flush.
> - In rx_hook, if netpoll_trap() is set, clear it.  If kgdb_isn't connected,
>   schedule a breakpoint, and never call breakpoint() directly.
> - In kgdb_serial->hook, set netpoll_trap(1).  kgdb_serial->hook must be
>   called prior to using a 'serial' port, so this is where we should stick
>   this.
> - Backout unneeded changes to other files.
>
> --- linux-2.6.3/drivers/net/kgdb_eth.c.orig	2004-02-27 13:27:53.778658691
> -0700 +++ linux-2.6.3/drivers/net/kgdb_eth.c	2004-02-27 13:32:07.920255062
> -0700 @@ -18,6 +18,7 @@
>   * Refactored for netpoll API by Matt Mackall <mpm@selenic.com>
>   *
>   * Some cleanups by Pavel Machek <pavel@suse.cz>
> + * Further cleanups by Tom Rini <trini@mvista.com>
>   */
>
>  #include <linux/module.h>
> @@ -60,7 +61,6 @@
>  static atomic_t in_count;
>  int kgdboe = 0;			/* Default to tty mode */
>
> -extern void breakpoint(void);
>  static void rx_hook(struct netpoll *np, int port, char *msg, int len);
>
>  static struct netpoll np = {
> @@ -89,6 +89,7 @@
>  {
>  	if (out_count && np.dev) {
>  		netpoll_send_udp(&np, out_buf, out_count);
> +		memset(out_buf, 0, sizeof(out_buf));
>  		out_count = 0;
>  	}
>  }
> @@ -107,12 +108,15 @@
>  	np->remote_port = port;
>
> +	/* Do we need to clear the trap? */
> +	if (netpoll_trap())
> +		netpoll_set_trap(0);
>  	/* Is this gdb trying to attach? */
> -	if (!netpoll_trap() && len == 8 && !strncmp(msg, "$Hc-1#09", 8))
> -		breakpoint();
> +	if (kgdb_connected) {
> +		kgdb_schedule_breakpoint();
>
>  	for (i = 0; i < len; i++) {
>  		if (msg[i] == 3)
> -			breakpoint();
> +			kgdb_schedule_breakpoint();
>
>  		if (atomic_read(&in_count) >= IN_BUF_SIZE) {
>  			/* buffer overflow, clear it */
> @@ -138,6 +141,9 @@
>  	/* Un-initalized, don't go further. */
>  	if (kgdboe != 1)
>  		return 1;
> +
> +	netpoll_set_trap(1);
> +
>  	return 0;
>  }
>
> --- linux-2.6.3/net/core/skbuff.c.orig	2004-02-27 13:30:21.107968572 -0700
> +++ linux-2.6.3/net/core/skbuff.c	2004-02-27 13:30:44.279825113 -0700
> @@ -55,7 +55,6 @@
>  #include <linux/rtnetlink.h>
>  #include <linux/init.h>
>  #include <linux/highmem.h>
> -#include <linux/debugger.h>
>
>  #include <net/protocol.h>
>  #include <net/dst.h>
> --- linux-2.6.3/net/core/dev.c.orig	2004-02-27 13:30:27.687508165 -0700
> +++ linux-2.6.3/net/core/dev.c	2004-02-27 13:30:44.261829108 -0700
> @@ -1547,6 +1547,7 @@
>  }
>  #endif
>
> +
>  /**
>   *	netif_rx	-	post buffer to the network code
>   *	@skb: buffer to post

