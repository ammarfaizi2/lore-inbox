Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965311AbWFAVJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965311AbWFAVJR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 17:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965310AbWFAVJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 17:09:17 -0400
Received: from fmr17.intel.com ([134.134.136.16]:8101 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S965308AbWFAVJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 17:09:15 -0400
Message-ID: <447F5778.6010202@ichips.intel.com>
Date: Thu, 01 Jun 2006 14:09:12 -0700
From: Sean Hefty <mshefty@ichips.intel.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve Wise <swise@opengridcomputing.com>
CC: rdreier@cisco.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH 1/2] iWARP Connection Manager.
References: <20060531182650.3308.81538.stgit@stevo-desktop>	 <20060531182652.3308.1244.stgit@stevo-desktop>	 <447E1720.7000307@ichips.intel.com> <1149181233.31610.34.camel@stevo-desktop>
In-Reply-To: <1149181233.31610.34.camel@stevo-desktop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Wise wrote:
>>>+int iw_cm_disconnect(struct iw_cm_id *cm_id, int abrupt)
>>>+{
>>>+	struct iwcm_id_private *cm_id_priv;
>>>+	unsigned long flags;
>>>+	int ret = 0;
>>>+
>>>+	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
>>>+	/* Wait if we're currently in a connect or accept downcall */
>>>+	wait_event(cm_id_priv->connect_wait, 
>>>+		   !test_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags));
>>
>>Am I understanding this check correctly?  You're checking to see if the user has 
>>called iw_cm_disconnect() at the same time that they called iw_cm_connect() or 
>>iw_cm_accept().  Are connect / accept blocking, or are you just waiting for an 
>>event?
> 
> 
> The CM must wait for the low level provider to finish a connect() or
> accept() operation before telling the low level provider to disconnect
> via modifying the iwarp QP.  Regardless of whether they block, this
> disconnect can happen concurrently with the connect/accept so we need to
> hold the disconnect until the connect/accept completes.
> 
> 
>>>+EXPORT_SYMBOL(iw_cm_disconnect);
>>>+static void destroy_cm_id(struct iw_cm_id *cm_id)
>>>+{
>>>+	struct iwcm_id_private *cm_id_priv;
>>>+	unsigned long flags;
>>>+	int ret;
>>>+
>>>+	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
>>>+	/* Wait if we're currently in a connect or accept downcall. A
>>>+	 * listening endpoint should never block here. */
>>>+	wait_event(cm_id_priv->connect_wait, 
>>>+		   !test_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags));
>>
>>Same question/comment as above.
>>
> 
> 
> Same answer.  

There's a difference between trying to handle the user calling 
disconnect/destroy at the same time a call to accept/connect is active, versus 
the user calling disconnect/destroy after accept/connect have returned.  In the 
latter case, I think you're fine.  In the first case, this is allowing a user to 
call destroy at the same time that they're calling accept/connect. 
Additionally, there's no guarantee that the F_CONNECT_WAIT flag has been set by 
accept/connect by the time disconnect/destroy tests it.

- Sean
