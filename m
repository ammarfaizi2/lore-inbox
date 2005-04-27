Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVD0Nn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVD0Nn6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 09:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVD0NmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 09:42:17 -0400
Received: from gate.in-addr.de ([212.8.193.158]:54206 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261525AbVD0Nl6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 09:41:58 -0400
Date: Wed, 27 Apr 2005 15:41:42 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: David Teigland <teigland@redhat.com>, Steven Dake <sdake@mvista.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 1b/7] dlm: core locking
Message-ID: <20050427134142.GZ4431@marowsky-bree.de>
References: <20050425165826.GB11938@redhat.com> <1114466097.30427.32.camel@persist.az.mvista.com> <20050426054933.GC12096@redhat.com> <1114537223.31647.10.camel@persist.az.mvista.com> <20050427030217.GA9963@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050427030217.GA9963@redhat.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-04-27T11:02:17, David Teigland <teigland@redhat.com> wrote:

Let me chime in here, because defining the properties of the membership
events delivered to the DLM is really important to figure out if/how it
can be integrated with other stacks.

> > In this case the order of lock messages with the membership changes is
> > important.  
> I think this might help clarify:  no membership change is applied to the
> lockspace on any nodes until the lockspace has first been suspended on
> all.  Suspending means no locking activity is processed.  The lockspace on
> all nodes is then told the new membership and does recovery.  Locking is
> then resumed.

So in effect, the delivery of the suspend/membership distribution/resume
events are three cluster-wide barriers?

I can see how that simplifies the recovery algorithm.

And, I assume that the delivery of a "node down" membership event
implies that said node also has been fenced.

So we can't deliver it raw membership events. Noted.

> I know you're more familiar with those details than I am.  What I keep
> trying to explain is that the dlm is in a different, simpler category.

Agreed. This is something I noticed when I looked at how the DLM fits
into the global cluster resource management architecture, too.

For example, if you talk to Stephen ;), you'll be told that every
cluster resource is essentially a lock. But, our resources have complex
dependencies, start/stop ordering etc; a DLM which tried to map these
would blow up completely.

So, we have the "top-level" "lock manager", our CRM, which manages these
complex "locks". However, it's also worth noting that there's rather few
of them to manage, and they don't change very often.

Now, the DLM has simpler locking semantics, but it manages magnitudes
more of them, and faster so.

If you want to think about this in terms of locking hierarchy, it's the
high-level feature rich sophisticated aka bloated lock manager which
controls the "lower level" faster and more scalable "sublockspace" and
coordinates it in terms of the other complex objects (like fencing,
applications, filesystems etc).

Just some food for thought how this all fits together rather neatly.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business

