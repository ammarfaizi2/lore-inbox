Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751453AbWCMPnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbWCMPnc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 10:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWCMPnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 10:43:32 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:56418 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751444AbWCMPnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 10:43:31 -0500
To: "Sean Hefty" <sean.hefty@intel.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <openib-general@openib.org>
Subject: Re: [PATCH 5/6 v2] IB: IP address based RDMA connection manager
X-Message-Flag: Warning: May contain useful information
References: <ORSMSX401FRaqbC8wSA0000000e@orsmsx401.amr.corp.intel.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 13 Mar 2006 07:43:28 -0800
Message-ID: <adabqwafizj.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 13 Mar 2006 15:43:28.0825 (UTC) FILETIME=[DFBAB290:01C646B4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that cma_detach_from_dev():

 > +static void cma_detach_from_dev(struct rdma_id_private *id_priv)
 > +{
 > +	list_del(&id_priv->list);
 > +	if (atomic_dec_and_test(&id_priv->cma_dev->refcount))
 > +		wake_up(&id_priv->cma_dev->wait);
 > +	id_priv->cma_dev = NULL;
 > +}

doesn't need to do atomic_dec_and_test(), because it is never dropping
the last reference to id_priv (and in fact if it was, the last line
would be a use-after-free bug).

Does it make sense to replace it with:

	static void cma_detach_from_dev(struct rdma_id_private *id_priv)
	{
		list_del(&id_priv->list);
		/*
		 * cma_detach_from_dev() will never be dropping the last
		 * reference to id_priv, so no need to test here.
		 */
		atomic_dec(&id_priv->cma_dev->refcount);
		id_priv->cma_dev = NULL;
	}

on my x86_64 build that's worth

	add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-40 (-40)
	function                                     old     new   delta
	cma_detach_from_dev                          106      66     -40

 - R.
