Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWFAWR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWFAWR6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 18:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWFAWR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 18:17:58 -0400
Received: from es335.com ([67.65.19.105]:29472 "EHLO mail.es335.com")
	by vger.kernel.org with ESMTP id S1750736AbWFAWR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 18:17:57 -0400
Subject: Re: [openib-general] Re: [PATCH 1/2] iWARP Connection Manager.
From: Tom Tucker <tom@opengridcomputing.com>
To: Sean Hefty <mshefty@ichips.intel.com>
Cc: Steve Wise <swise@opengridcomputing.com>, netdev@vger.kernel.org,
       rdreier@cisco.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <447F5778.6010202@ichips.intel.com>
References: <20060531182650.3308.81538.stgit@stevo-desktop>
	 <20060531182652.3308.1244.stgit@stevo-desktop>
	 <447E1720.7000307@ichips.intel.com>
	 <1149181233.31610.34.camel@stevo-desktop>
	 <447F5778.6010202@ichips.intel.com>
Content-Type: text/plain
Date: Thu, 01 Jun 2006 17:21:16 -0500
Message-Id: <1149200476.18855.83.camel@trinity.ogc.int>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-01 at 14:09 -0700, Sean Hefty wrote:
> Steve Wise wrote:
> >>>+int iw_cm_disconnect(struct iw_cm_id *cm_id, int abrupt)
> >>>+{
> >>>+	struct iwcm_id_private *cm_id_priv;
> >>>+	unsigned long flags;
> >>>+	int ret = 0;
> >>>+
> >>>+	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
> >>>+	/* Wait if we're currently in a connect or accept downcall */
> >>>+	wait_event(cm_id_priv->connect_wait, 
> >>>+		   !test_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags));
> >>
> >>Am I understanding this check correctly?  You're checking to see if the user has 
> >>called iw_cm_disconnect() at the same time that they called iw_cm_connect() or 
> >>iw_cm_accept().  Are connect / accept blocking, or are you just waiting for an 
> >>event?
> > 
> > 
> > The CM must wait for the low level provider to finish a connect() or
> > accept() operation before telling the low level provider to disconnect
> > via modifying the iwarp QP.  Regardless of whether they block, this
> > disconnect can happen concurrently with the connect/accept so we need to
> > hold the disconnect until the connect/accept completes.
> > 
> > 
> >>>+EXPORT_SYMBOL(iw_cm_disconnect);
> >>>+static void destroy_cm_id(struct iw_cm_id *cm_id)
> >>>+{
> >>>+	struct iwcm_id_private *cm_id_priv;
> >>>+	unsigned long flags;
> >>>+	int ret;
> >>>+
> >>>+	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
> >>>+	/* Wait if we're currently in a connect or accept downcall. A
> >>>+	 * listening endpoint should never block here. */
> >>>+	wait_event(cm_id_priv->connect_wait, 
> >>>+		   !test_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags));
> >>
> >>Same question/comment as above.
> >>
> > 
> > 
> > Same answer.  
> 
> There's a difference between trying to handle the user calling 
> disconnect/destroy at the same time a call to accept/connect is active, versus 
> the user calling disconnect/destroy after accept/connect have returned.  In the 
> latter case, I think you're fine.  In the first case, this is allowing a user to 
> call destroy at the same time that they're calling accept/connect. 
> Additionally, there's no guarantee that the F_CONNECT_WAIT flag has been set by 
> accept/connect by the time disconnect/destroy tests it.

The problem is that we can't synchronously cancel an outstanding connect
request. Once we've asked the adapter to connect, we can't tell him to
stop, we have to wait for it to fail. During the time period between
when we ask to connect and the adapter says yeah-or-nay, the user hits
ctrl-C. This is the case where disconnect and/or destroy gets called and
we have to block it waiting for the outstanding connect request to
complete.

One alternative to this approach is to do the kfree of the cm_id in the
deref logic. This was the original design and leaves the object around
to handle the completion of the connect and still allows the app to
clean up and go away without all this waitin' around. When the adapter
finally finishes and releases it's reference, the object is kfree'd.

Hope this helps.
 
> 
> - Sean
> _______________________________________________
> openib-general mailing list
> openib-general@openib.org
> http://openib.org/mailman/listinfo/openib-general
> 
> To unsubscribe, please visit http://openib.org/mailman/listinfo/openib-general

