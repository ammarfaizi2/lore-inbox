Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWIDIsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWIDIsu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 04:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWIDIsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 04:48:50 -0400
Received: from ns.suse.de ([195.135.220.2]:12223 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751205AbWIDIss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 04:48:48 -0400
Date: Mon, 4 Sep 2006 10:48:46 +0200
From: Olaf Kirch <okir@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: NeilBrown <neilb@suse.de>, Andrew Morton <akpm@osdl.org>,
       nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [NFS] [PATCH 004 of 19] knfsd: lockd: introduce nsm_handle
Message-ID: <20060904084846.GB28400@suse.de>
References: <20060901141639.27206.patches@notabene> <1060901043825.27464@suse.de> <1157125820.5632.44.camel@localhost> <20060901161110.GD29574@suse.de> <1157128893.5632.74.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157128893.5632.74.camel@localhost>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2006 at 12:41:33PM -0400, Trond Myklebust wrote:
> The local statd process is supposed to decode the notification from the
> remote client/server, and then notify the kernel. It already sends that
> notification on a per-nlm_host basis (i.e. it the call down to the
> kernel contains the <address,version,transport protocol>.

Why does statd need to send the full <address,version,transport protocol>
to the kernel in the first place?

All that's really needed is a unique identification of the host having
rebooted, nevermind how we have been talking to it, and in what role.

I consider the current practice a side effect of a bad implementation
which duplicates a lot of state by dumping everything into the nlm_host.

With the current code, we cannot even monitor IPv6 addresses, because
there's not enough room in the NSM_MON packet. With my proposed change,
we can ditch version and transport protocol, and all of a sudden we
have 16 bytes for the address - ie enough to make IPv6 happy.

In the long run, we could clean out nlm_host even more - there's
a lot of cruft in there.

	h_name		just h_nsmhandle->sm_name
	h_gracewait	could be shared as well
	h_state		should move to nsmhandle as well
	h_nsmstate	currently not used, could move to nsmhandle as well
	h_pidcount	currently allocated per nlm_host, which leads
			to aliasing if we mix NFSv2 and v3 mounts

On a side note, we may want to always allocate an RPC client for each
nlm_host.  Then we can ditch the following variables as well, which are
in the rpc_client's portmap info anyway:

	h_proto		pm_prot
	h_version	pm_vers
	h_sema		useless
	h_nextrebind	we can stop rebinding every 60s, the sunrpc
			doesn't need that anymore. During recovery,
			we can just call rpc_force_rebind
			directly.

Or going even further, one could make the nlm_host agnostic of transports
and protocol versions. Just stick a (short) array of RPC clients in the
nlm_host - any code that places NLM calls will need some extra logic
to select the right client, but it would save on memory and reduce
complexity.

Olaf
-- 
Olaf Kirch   |  --- o --- Nous sommes du soleil we love when we play
okir@suse.de |    / | \   sol.dhoop.naytheet.ah kin.ir.samse.qurax

-- 
VGER BF report: H 2.68873e-09
