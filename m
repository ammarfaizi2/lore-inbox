Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262607AbUKXQ52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262607AbUKXQ52 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 11:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbUKXQze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 11:55:34 -0500
Received: from mail9.messagelabs.com ([194.205.110.133]:30421 "HELO
	mail9.messagelabs.com") by vger.kernel.org with SMTP
	id S261486AbUKXQxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 11:53:42 -0500
X-VirusChecked: Checked
X-Env-Sender: icampbell@arcom.com
X-Msg-Ref: server-22.tower-9.messagelabs.com!1101311621!11022908!1
X-StarScan-Version: 5.4.2; banners=arcom.com,-,-
X-Originating-IP: [194.200.159.164]
Subject: Re: "deadlock" between smc91x driver and link_watch
From: Ian Campbell <icampbell@arcom.com>
To: Nicolas Pitre <nico@cam.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
In-Reply-To: <Pine.LNX.4.61.0411241014160.8946@xanadu.home>
References: <1101230194.14370.12.camel@icampbell-debian>
	 <20041123153158.6f20a7d7.akpm@osdl.org>
	 <1101289309.10841.9.camel@icampbell-debian>
	 <20041124014650.47af8ae4.akpm@osdl.org>
	 <1101290297.10841.15.camel@icampbell-debian>
	 <Pine.LNX.4.61.0411241014160.8946@xanadu.home>
Content-Type: text/plain
Organization: Arcom Control Systems
Date: Wed, 24 Nov 2004 15:52:38 +0000
Message-Id: <1101311558.31459.21.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
X-IMAIL-SPAM-VALHELO: (343671118)
X-IMAIL-SPAM-VALREVDNS: (343671118)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-24 at 10:21 -0500, Nicolas Pitre wrote:

> > + * smc_phy_configure_wq
> > + *
> > + * The net_device is referenced when the work was scheduled to avoid
> > + * the need for a flush_scheduled_work() in smc_close(). Drop the
> > + * reference and then do the configuration.
> 
> You probably want to invert the comment here too.

Quite right.

> > @@ -1536,10 +1553,8 @@
> >  	/* clear everything */
> >  	smc_shutdown(dev);
> >  
> > -	if (lp->phy_type != 0) {
> > -		flush_scheduled_work();
> > +	if (lp->phy_type != 0)
> >  		smc_phy_powerdown(dev, lp->mii.phy_id);
> 
> 
> How do you ensure that smc_phy_configure() can't end up being called 
> after smc_phy_powerdown() here?

Hmm, I think that smc_phy_configure() is only called from
smc_drv_resume() and smc_timeout() (via the workqueue).

For smc_drv_resume() I expected that there would be some sort of mutual
exclusion in the generic layers to prevent _close() and _resume() from
happening at the same time.

For smc_timeout() I would also expect that the generic layer would have
cancelled the tx_timeout etc before calling smc_close().

I guess I don't know if either of these things are true -- anyone know?

The other solution might be to set phy_type to 0 in smc_phy_powerdown()
and then redetect it in smc_open() and smc_resume(). Or just use another
flag altogether.

Ian.

-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road,                    Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom       Phone:  +44 (0)1223 411 200


_____________________________________________________________________
The message in this transmission is sent in confidence for the attention of the addressee only and should not be disclosed to any other party. Unauthorised recipients are requested to preserve this confidentiality. Please advise the sender if the addressee is not resident at the receiving end.  Email to and from Arcom is automatically monitored for operational and lawful business reasons.

This message has been virus scanned by MessageLabs.
