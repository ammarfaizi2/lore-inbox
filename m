Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWIAQLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWIAQLO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 12:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbWIAQLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 12:11:14 -0400
Received: from ns2.suse.de ([195.135.220.15]:17295 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932159AbWIAQLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 12:11:12 -0400
Date: Fri, 1 Sep 2006 18:11:10 +0200
From: Olaf Kirch <okir@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: NeilBrown <neilb@suse.de>, Andrew Morton <akpm@osdl.org>,
       nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [NFS] [PATCH 004 of 19] knfsd: lockd: introduce nsm_handle
Message-ID: <20060901161110.GD29574@suse.de>
References: <20060901141639.27206.patches@notabene> <1060901043825.27464@suse.de> <1157125820.5632.44.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157125820.5632.44.camel@localhost>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2006 at 11:50:20AM -0400, Trond Myklebust wrote:
> >   With this patch applied, all nlm_hosts from the same address
> >   will share the same nsm_handle. A future patch will add sharing
> >   by name.
> 
> <boggle>
> Exactly why is it desirable to have > 1 nlm_host from the same address?
> </boggle>
> 
> If we can map several clients into a single nsm_handle, then surely it
> makes sense to map them into the same nlm_host too.

This is all related to the reasons for introducing NSM notification
by name in the first place.

On the client side, we may have mounted several volumes from a multi-homed
server, using different addresses, and you have several NLM client
handles, each with one of these addresses - and each in a different
nlm_host object.

Or you have an NFS server in a HA configuration, listening on a virtual
address. As the server fails over, the alias moves to the backup
machine.

Or (once we have IPv6) you may have a mix of v4 and v6 mounts.

Now when the server reboots, it will send you one or more SM_NOTIFY
messages. You do not know which addresses it will use. In the multihomed
case, you will get one SM_NOTIFY for each server address if the server
is a Linux box. Other server OSs will send you just one SM_NOTIFY,
and the sender address will be more or less random. In the HA case
described above, the sender address will not match the address
you used at all (since the UDP packet will have the interface's
primary IP address, not the alias).

This is the main motivation for introducing the nsm_handle, and this is
also the reason why there is potentially a 1-to-many relationship between
nsm_handles (representing a "host") and nlm_host, representing a tuple of
(NLM version, transport protocol, address).

Maybe we should rename nlm_host to something less confusing.

Olaf
-- 
Olaf Kirch   |  --- o --- Nous sommes du soleil we love when we play
okir@suse.de |    / | \   sol.dhoop.naytheet.ah kin.ir.samse.qurax
