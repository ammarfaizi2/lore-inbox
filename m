Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262379AbVD2D5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbVD2D5l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 23:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbVD2D5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 23:57:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45221 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262379AbVD2D5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 23:57:38 -0400
Date: Fri, 29 Apr 2005 12:01:04 +0800
From: David Teigland <teigland@redhat.com>
To: Daniel McNeil <daniel@osdl.org>
Cc: Lars Marowsky-Bree <lmb@suse.de>, Steven Dake <sdake@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1b/7] dlm: core locking
Message-ID: <20050429040104.GB9900@redhat.com>
References: <20050425165826.GB11938@redhat.com> <1114466097.30427.32.camel@persist.az.mvista.com> <20050426054933.GC12096@redhat.com> <1114537223.31647.10.camel@persist.az.mvista.com> <20050427030217.GA9963@redhat.com> <20050427134142.GZ4431@marowsky-bree.de> <20050427142638.GG16502@redhat.com> <20050428123315.GP21645@marowsky-bree.de> <1114706362.18352.85.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114706362.18352.85.camel@ibm-c.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 09:39:22AM -0700, Daniel McNeil wrote:

> Since a DLM is a distributed lock manager, its usage is entirely for
> locking some shared resource (might not be storage, might be shared
> state, shared data, etc).   If the DLM can grant a lock, but not
> guarantee that other nodes (including the ones that have been kicked
> out of the cluster membership) do not have a conflicting DLM lock, then
> any applications that depend on the DLM for protection/coordination
> be in trouble.  Doesn't the GFS code depend on the DLM not being
> recovered until after fencing of dead nodes?

No, it doesn't.  GFS depends on _GFS_ not being recovered until failed
nodes are fenced.  Recovering GFS is an entirely different thing from
recovering the DLM.  GFS actually writes to shared storage.

> Is there a existing DLM that does not depend on fencing? (you said
> yours was modeled after the VMS DLM, didn't they depend on fencing?)

I've never heard of a DLM that depends on fencing.

> How would an application use a DLM that does not depend on fencing?

Go back to the definition of i/o fencing:  i/o fencing simply prevents a
machine from modifying shared storage.  This is often done by disabling
the victim's connection to the shared storage.  Notice shared storage is
part of the definition, without it, fencing is irrelevant.

Fencing is not mainly about the node, it's mainly about the storage.  When
a fencing victim is disconnected from storage, it usually means its SAN
port has been turned off on a switch.  Notice that this doesn't touch or
effect the node at all -- it simply blocks any i/o from the node before it
reaches the storage.

Any distributed app using the DLM that writes only to its own local
storage will not need fencing, there's nothing to fence.

Dave

