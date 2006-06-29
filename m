Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbWF2TeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWF2TeT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 15:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWF2TeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 15:34:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62699 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932317AbWF2TeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 15:34:17 -0400
Date: Thu, 29 Jun 2006 12:33:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: pj@sgi.com, Valdis.Kletnieks@vt.edu, jlan@engr.sgi.com, balbir@in.ibm.com,
       csturtiv@sgi.com, linux-kernel@vger.kernel.org, hadi@cyberus.ca,
       netdev@vger.kernel.org
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
Message-Id: <20060629123338.0d355297.akpm@osdl.org>
In-Reply-To: <44A425A7.2060900@watson.ibm.com>
References: <44892610.6040001@watson.ibm.com>
	<449999D1.7000403@engr.sgi.com>
	<44999A98.8030406@engr.sgi.com>
	<44999F5A.2080809@watson.ibm.com>
	<4499D7CD.1020303@engr.sgi.com>
	<449C2181.6000007@watson.ibm.com>
	<20060623141926.b28a5fc0.akpm@osdl.org>
	<449C6620.1020203@engr.sgi.com>
	<20060623164743.c894c314.akpm@osdl.org>
	<449CAA78.4080902@watson.ibm.com>
	<20060623213912.96056b02.akpm@osdl.org>
	<449CD4B3.8020300@watson.ibm.com>
	<44A01A50.1050403@sgi.com>
	<20060626105548.edef4c64.akpm@osdl.org>
	<44A020CD.30903@watson.ibm.com>
	<20060626111249.7aece36e.akpm@osdl.org>
	<44A026ED.8080903@sgi.com>
	<20060626113959.839d72bc.akpm@osdl.org>
	<44A2F50D.8030306@engr.sgi.com>
	<20060628145341.529a61ab.akpm@osdl.org>
	<44A2FC72.9090407@engr.sgi.com>
	<20060629014050.d3bf0be4.pj@sgi.com>
	<200606291230.k5TCUg45030710@turing-police.cc.vt.edu>
	<20060629094408.360ac157.pj@sgi.com>
	<20060629110107.2e56310b.akpm@osdl.org>
	<44A425A7.2060900@watson.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006 15:10:31 -0400
Shailabh Nagar <nagar@watson.ibm.com> wrote:

> >I agree, and I'm viewing this as blocking the taskstats merge.  Because if
> >this _is_ a problem then it's a big one because fixing it will be
> >intrusive, and might well involve userspace-visible changes.
> >  
> >
> First off, just a reminder that this is inherently a netlink flow 
> control issue...which was being exacerbated
> earlier by taskstats decision to send per-tgid data (no longer the case).
> 
> But I'd like to know whats our target here ? How many messages per 
> second do we want to be able to be sent
> and received without risking any loss of data ? Netlink will lose 
> messages at a high enough rate so the design point
> will need to be known a bit.
> 
> For statistics type usage of the genetlink/netlink, I would have thought 
> that userspace, provided it is reliably informed
> about the loss of data through ENOBUFS, could take measures to just 
> account for the missing data and carry on ?

Could be so.  But we need to understand how significant the impact of this
will be in practice.

We could find, once this is deployed is real production environments on
large machines that the data loss is sufficiently common and sufficiently
serious that the feature needs a lot of rework.

Now there's always a risk of that sort of thing happening with all
features, but it's usually not this evident so early in the development
process.  We need to get a better understanding of the risk before
proceeding too far.

And there's always a 100% reliable fix for this: throttling.  Make the
sender of the messages block until the consumer can catch up.  In some
situations, that is what people will want to be able to do.  I suspect a
good implementation would be to run a collection daemon on each CPU and
make the delivery be cpu-local.  That's sounding more like relayfs than
netlink.

