Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264510AbUAIVqu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 16:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264508AbUAIVqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 16:46:50 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:6335 "EHLO
	thoron.boston.redhat.com") by vger.kernel.org with ESMTP
	id S264510AbUAIVqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 16:46:22 -0500
Date: Fri, 9 Jan 2004 16:46:18 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, <sds@epoch.ncsc.mil>,
       <selinux@tycho.nsa.gov>
Subject: Re: [PATCH][SELINUX] 2/7 Add netif controls
In-Reply-To: <20040109130613.711b34a6.akpm@osdl.org>
Message-ID: <Xine.LNX.4.44.0401091638160.22937-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jan 2004, Andrew Morton wrote:

> James Morris <jmorris@redhat.com> wrote:
> >
> > +static void sel_netif_destroy(struct sel_netif *netif)
> > +{
> > +	DEBUGP("%s: %s\n", __FUNCTION__, netif->nsec.dev->name);
> > +	
> > +	spin_lock_bh(&sel_netif_lock);
> > +	list_del_rcu(&netif->list);
> > +	sel_netif_total--;
> > +	spin_unlock_bh(&sel_netif_lock);
> > +
> > +	call_rcu(&netif->rcu_head, sel_netif_free, netif);
> > +}
> > +
> > +void sel_netif_put(struct sel_netif *netif)
> > +{
> > +	if (atomic_dec_and_test(&netif->users))
> > +		sel_netif_destroy(netif);
> > +}
> 
> This seems racy.  If the netif is still eligible for lookup on entry to
> sel_netif_put(), another CPU can come in and find the netif while it is
> hashed but while it has a zero refcount.  Only to have the netif destroyed
> under its feet?

The netif won't actually be freed until all of the CPUs have gone through
a quiescent state, and the calling code running on the other CPU will have
called sel_netif_put() before then.  These objects are extremely short
lived and should not be held over context switches.


- James
-- 
James Morris
<jmorris@redhat.com>



