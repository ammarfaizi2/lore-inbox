Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWCIXYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWCIXYQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWCIXYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:24:16 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:20540 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S932118AbWCIXYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:24:15 -0500
X-IronPort-AV: i="4.02,180,1139212800"; 
   d="scan'208"; a="414158496:sNHT41594512"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 9 of 20] ipath - char devices for diagnostics and lightweight subnet management
X-Message-Flag: Warning: May contain useful information
References: <eac2ad3017b5f160d24c.1141922822@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 09 Mar 2006 15:24:13 -0800
In-Reply-To: <eac2ad3017b5f160d24c.1141922822@localhost.localdomain> (Bryan O'Sullivan's message of "Thu,  9 Mar 2006 08:47:02 -0800")
Message-ID: <adad5gvfbhe.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 09 Mar 2006 23:24:13.0853 (UTC) FILETIME=[93CC34D0:01C643D0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > +static int ipath_sma_open(struct inode *in, struct file *fp)
 > +{
 > +	int s;
 > +
 > +	if (ipath_sma_alive) {
 > +		ipath_dbg("SMA already running (pid %u), failing\n",
 > +			  ipath_sma_alive);
 > +		return -EBUSY;
 > +	}
 > +
 > +	for (s = 0; s < atomic_read(&ipath_max); s++) {
 > +		struct ipath_devdata *dd = ipath_lookup(s);
 > +		/* we need at least one infinipath device to be initialized. */
 > +		if (dd && dd->ipath_flags & IPATH_INITTED) {
 > +			ipath_sma_alive = current->pid;

It seems there's a window here where two processes can both pass the
if (ipath_sma_alive) test and then proceed to step on each other.

 - R.
