Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264348AbUDUJm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264348AbUDUJm4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 05:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264373AbUDUJm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 05:42:56 -0400
Received: from cpmx.mail.saic.com ([139.121.17.160]:64415 "EHLO cpmx.saic.com")
	by vger.kernel.org with ESMTP id S264348AbUDUJmw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 05:42:52 -0400
Subject: Re: e100 NETDEV WATCHDOG transmit timeout since 2.6.4
From: Eamonn Hamilton <EAMONN.HAMILTON@saic.com>
To: Scott Feldman <scott.feldman@intel.com>
Cc: Mike Keehan <mike_keehan@yahoo.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
In-Reply-To: <Pine.LNX.4.58.0404201559290.7794@snichols-desk.amr.corp.intel.com>
References: <C6F5CF431189FA4CBAEC9E7DD5441E0103E9A4E6@orsmsx402.jf.intel.com>
	 <Pine.LNX.4.58.0404201559290.7794@snichols-desk.amr.corp.intel.com>
Content-Type: text/plain
Message-Id: <1082540561.3159.1.camel@ukabzc383.uk.saic.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 21 Apr 2004 10:42:41 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Scott,

Thanks for the patch - a bit of manual fumbling to get it applied, but
it seems to work ok so far ( ~46 minutes, so it's not exactly definitive
:)

Certainly it doesn't make things worse in my case at least.

Cheers,
Eamonn

On Wed, 2004-04-21 at 00:04, Scott Feldman wrote:
> On Tue, 20 Apr 2004, Mike Keehan wrote:
> 
> > I am getting these too in recent kernels, but only on a
> > 10Mhz half-duplex network. I have to manually down
> > and up the interface to recover.
> >
> > On a 100Mhz switched network, the e100 is OK (at least 12hours+).
> 
> 
> Mike/Eamonn,
> 
> Give this patch a try.  This adds a required workaround for ICH when
> working at 10/Half.  (Guessing you have an ICH system).
> 
> --- linux-2.5/drivers/net/e100.c	2004-04-20 15:52:24.000000000 -0700
> +++ linux-2.5/drivers/net/e100.c.mod	2004-04-20 15:55:32.000000000 -0700
> @@ -287,6 +287,7 @@ enum scb_cmd_hi {
>  };
> 
>  enum scb_cmd_lo {
> +	cuc_nop        = 0x00,
>  	ruc_start      = 0x01,
>  	ruc_load_base  = 0x06,
>  	cuc_start      = 0x10,
> @@ -514,10 +515,11 @@ struct nic {
>  	/* End: frequently used values: keep adjacent for cache effect */
> 
>  	enum {
> -		ich           = (1 << 0),
> -		promiscuous   = (1 << 1),
> -		multicast_all = (1 << 2),
> -		wol_magic     = (1 << 3),
> +		ich                = (1 << 0),
> +		promiscuous        = (1 << 1),
> +		multicast_all      = (1 << 2),
> +		wol_magic          = (1 << 3),
> +		ich_10h_workaround = (1 << 4),
>  	} flags					____cacheline_aligned;
> 
>  	enum mac mac;
> @@ -1225,6 +1227,12 @@ static void e100_watchdog(unsigned long
>  		/* Issue a multicast command to workaround a 557 lock up */
>  		e100_set_multicast_list(nic->netdev);
> 
> +	if(nic->flags & ich && cmd.speed==SPEED_10 && cmd.duplex==DUPLEX_HALF)
> +		/* Need SW workaround for ICH[x] 10Mbps/half duplex Tx hang. */
> +		nic->flags |= ich_10h_workaround;
> +	else
> +		nic->flags &= ~ich_10h_workaround;
> +
>  	mod_timer(&nic->watchdog, jiffies + E100_WATCHDOG_PERIOD);
>  }
> 
> @@ -1244,7 +1252,17 @@ static inline void e100_xmit_prepare(str
>  static int e100_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
>  {
>  	struct nic *nic = netdev->priv;
> -	int err = e100_exec_cb(nic, skb, e100_xmit_prepare);
> +	int err;
> +
> +	if(nic->flags & ich_10h_workaround) {
> +		/* SW workaround for ICH[x] 10Mbps/half duplex Tx hang.
> +		   Issue a NOP command followed by a 1us delay before
> +		   issuing the Tx command. */
> +		e100_exec_cmd(nic, cuc_nop, 0);
> +		udelay(1);
> +	}
> +
> +	err = e100_exec_cb(nic, skb, e100_xmit_prepare);
> 
>  	switch(err) {
>  	case -ENOSPC:
-- 
Eamonn Hamilton

Senior Technical Designer
Technical Projects and Design (North)

Tel : +44 (0) 1224 333833
Fax : +44 (0) 1224 840032
Email eamonn.hamilton@saic.com

