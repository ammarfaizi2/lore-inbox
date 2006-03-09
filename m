Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbWCIX0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWCIX0q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751968AbWCIX0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:26:46 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:34391 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1751312AbWCIX0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:26:45 -0500
X-IronPort-AV: i="4.02,180,1139212800"; 
   d="scan'208"; a="313130754:sNHT30991548"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 9 of 20] ipath - char devices for diagnostics and lightweight subnet management
X-Message-Flag: Warning: May contain useful information
References: <eac2ad3017b5f160d24c.1141922822@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 09 Mar 2006 15:26:43 -0800
In-Reply-To: <eac2ad3017b5f160d24c.1141922822@localhost.localdomain> (Bryan O'Sullivan's message of "Thu,  9 Mar 2006 08:47:02 -0800")
Message-ID: <ada8xrjfbd8.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 09 Mar 2006 23:26:44.0416 (UTC) FILETIME=[ED8A4C00:01C643D0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > +static int ipath_sma_release(struct inode *in, struct file *fp)
 > +{
 > +	int s;
 > +
 > +	ipath_sma_alive = 0;
 > +	ipath_cdbg(SMA, "Closing SMA device\n");
 > +	for (s = 0; s < atomic_read(&ipath_max); s++) {
 > +		struct ipath_devdata *dd = ipath_lookup(s);
 > +
 > +		if (!dd || !(dd->ipath_flags & IPATH_INITTED))
 > +			continue;
 > +		*dd->ipath_statusp &= ~IPATH_STATUS_SMA;
 > +		if (dd->verbs_layer.l_flags & IPATH_VERBS_KERNEL_SMA)
 > +			*dd->ipath_statusp |= IPATH_STATUS_OIB_SMA;
 > +	}
 > +	return 0;
 > +}

Similarly what protects against another process opening the device
right after the ipath_sma_alive = 0 setting, but before you do all the
cleanup that's after that?

And what protects against a hot unplug of a device after the test of s
against ipath_max?

 - R.
