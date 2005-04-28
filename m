Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262099AbVD1M5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbVD1M5h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 08:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbVD1Mz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 08:55:56 -0400
Received: from gate.in-addr.de ([212.8.193.158]:51669 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S262099AbVD1MzW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 08:55:22 -0400
Date: Thu, 28 Apr 2005 14:33:15 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: David Teigland <teigland@redhat.com>
Cc: Steven Dake <sdake@mvista.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 1b/7] dlm: core locking
Message-ID: <20050428123315.GP21645@marowsky-bree.de>
References: <20050425165826.GB11938@redhat.com> <1114466097.30427.32.camel@persist.az.mvista.com> <20050426054933.GC12096@redhat.com> <1114537223.31647.10.camel@persist.az.mvista.com> <20050427030217.GA9963@redhat.com> <20050427134142.GZ4431@marowsky-bree.de> <20050427142638.GG16502@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050427142638.GG16502@redhat.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-04-27T22:26:38, David Teigland <teigland@redhat.com> wrote:

> > So in effect, the delivery of the suspend/membership distribution/resume
> > events are three cluster-wide barriers?
> > 
> > I can see how that simplifies the recovery algorithm.
> Correct.  I actually consider it two external barriers: the first after
> the lockspace has been suspended, the second after lockspace recovery is
> completed.

Hmmm. This is actually slightly different from what I thought you were
doing.

Actually, is that several phase step really necessary? Given that
failures can occur at any given point even then - during each barrier
and in-between - couldn't we just as well deliver the membership event
directly, and proceed with recovery as if that was the "final" state?
We always have to deal with nodes failing, rejoining etc at any given
step and eventually restarting the algorithm if needed.

(Well, a node joining you could serialize and only do that after you
have completed the recovery steps for the event before. But a failing
node during recovery seems to imply the need to restart the algorithm
anyway, and that's just what would happen if a new membership event was
delivered.)

Does it really simplify the recovery, or does it just obscure the
complexity, ie, snake oil?

That said, the model can be mapped as-is quite directly to how the
heartbeat 2.x handles resources which can be active more than once. The
first barrier would be the "we lost a node and are about to fence one of
your incarnations" (or "a node joined and we're about to start one"),
and the second one would be the "we fenced node X" or "we started you on
node X".

However, there's one property here: We assume that those notifications
_can never fail_; they are delivered (and guaranteed to be before we
commence the main operation), and that's it. Can a node in your model
choose to reject the suspend/resume operation?

> > And, I assume that the delivery of a "node down" membership event
> > implies that said node also has been fenced.
> Typically it does if you're combining the dlm with something that requires
> fencing (like a file system).  Fencing isn't relevant to the dlm itself,
> though, since the dlm software isn't touching any storage.

Ack. Good point, I was thinking too much in terms of GFS/OCFS2 here ;-)

> > Just some food for thought how this all fits together rather neatly.
> Interesting, and sounds correct.  I must admit that using the word "lock"
> to describe these CRM-level inter-dependent objects is new to me.

It's locks with dependencies, instead of one "lock" per resource group.
That's been mulling on the back of my mind ever since Stephen gave me
the DLM-centric-clustering-world talking to at Linux Kongress 98, I
think ;-) By now I think the model fits.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business

