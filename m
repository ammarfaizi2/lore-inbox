Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWIAQlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWIAQlu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 12:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWIAQlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 12:41:50 -0400
Received: from pat.uio.no ([129.240.10.4]:58866 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932114AbWIAQlt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 12:41:49 -0400
Subject: Re: [NFS] [PATCH 004 of 19] knfsd: lockd: introduce nsm_handle
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Olaf Kirch <okir@suse.de>
Cc: NeilBrown <neilb@suse.de>, Andrew Morton <akpm@osdl.org>,
       nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20060901161110.GD29574@suse.de>
References: <20060901141639.27206.patches@notabene>
	 <1060901043825.27464@suse.de> <1157125820.5632.44.camel@localhost>
	 <20060901161110.GD29574@suse.de>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 12:41:33 -0400
Message-Id: <1157128893.5632.74.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.105, required 12,
	autolearn=disabled, AWL 1.90, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 18:11 +0200, Olaf Kirch wrote:
> This is all related to the reasons for introducing NSM notification
> by name in the first place.
> 
> On the client side, we may have mounted several volumes from a multi-homed
> server, using different addresses, and you have several NLM client
> handles, each with one of these addresses - and each in a different
> nlm_host object.
> 
> Or you have an NFS server in a HA configuration, listening on a virtual
> address. As the server fails over, the alias moves to the backup
> machine.
> 
> Or (once we have IPv6) you may have a mix of v4 and v6 mounts.
> 
> Now when the server reboots, it will send you one or more SM_NOTIFY
> messages. You do not know which addresses it will use. In the multihomed
> case, you will get one SM_NOTIFY for each server address if the server
> is a Linux box. Other server OSs will send you just one SM_NOTIFY,
> and the sender address will be more or less random. In the HA case
> described above, the sender address will not match the address
> you used at all (since the UDP packet will have the interface's
> primary IP address, not the alias).
> 
> This is the main motivation for introducing the nsm_handle, and this is
> also the reason why there is potentially a 1-to-many relationship between
> nsm_handles (representing a "host") and nlm_host, representing a tuple of
> (NLM version, transport protocol, address).
> 
> Maybe we should rename nlm_host to something less confusing.

The local statd process is supposed to decode the notification from the
remote client/server, and then notify the kernel. It already sends that
notification on a per-nlm_host basis (i.e. it the call down to the
kernel contains the <address,version,transport protocol>.

If we need to mark more than one <address,version,transport protocol>
tuple as rebooting when we get a notification from the remote
client/server, then why not fix statd so that it does so. Why perform
these extra mappings in the kernel, which doesn't have the benefit of
reverse DNS lookups etc to help it out?

Cheers,
  Trond

