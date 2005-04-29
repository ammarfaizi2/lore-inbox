Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263051AbVD2XAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263051AbVD2XAd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 19:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263050AbVD2XAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 19:00:33 -0400
Received: from fire.osdl.org ([65.172.181.4]:7119 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263051AbVD2W67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 18:58:59 -0400
Subject: Re: [PATCH 1b/7] dlm: core locking
From: Daniel McNeil <daniel@osdl.org>
To: David Teigland <teigland@redhat.com>
Cc: Lars Marowsky-Bree <lmb@suse.de>, Steven Dake <sdake@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050429040104.GB9900@redhat.com>
References: <20050425165826.GB11938@redhat.com>
	 <1114466097.30427.32.camel@persist.az.mvista.com>
	 <20050426054933.GC12096@redhat.com>
	 <1114537223.31647.10.camel@persist.az.mvista.com>
	 <20050427030217.GA9963@redhat.com> <20050427134142.GZ4431@marowsky-bree.de>
	 <20050427142638.GG16502@redhat.com>
	 <20050428123315.GP21645@marowsky-bree.de>
	 <1114706362.18352.85.camel@ibm-c.pdx.osdl.net>
	 <20050429040104.GB9900@redhat.com>
Content-Type: text/plain
Message-Id: <1114815509.18352.200.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 29 Apr 2005 15:58:29 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-28 at 21:01, David Teigland wrote:
> On Thu, Apr 28, 2005 at 09:39:22AM -0700, Daniel McNeil wrote:
> 
> > Since a DLM is a distributed lock manager, its usage is entirely for
> > locking some shared resource (might not be storage, might be shared
> > state, shared data, etc).   If the DLM can grant a lock, but not
> > guarantee that other nodes (including the ones that have been kicked
> > out of the cluster membership) do not have a conflicting DLM lock, then
> > any applications that depend on the DLM for protection/coordination
> > be in trouble.  Doesn't the GFS code depend on the DLM not being
> > recovered until after fencing of dead nodes?
> 
> No, it doesn't.  GFS depends on _GFS_ not being recovered until failed
> nodes are fenced.  Recovering GFS is an entirely different thing from
> recovering the DLM.  GFS actually writes to shared storage.
> 
> > Is there a existing DLM that does not depend on fencing? (you said
> > yours was modeled after the VMS DLM, didn't they depend on fencing?)
> 
> I've never heard of a DLM that depends on fencing.
> 
> > How would an application use a DLM that does not depend on fencing?
> 
> Go back to the definition of i/o fencing:  i/o fencing simply prevents a
> machine from modifying shared storage.  This is often done by disabling
> the victim's connection to the shared storage.  Notice shared storage is
> part of the definition, without it, fencing is irrelevant.
> 
> Fencing is not mainly about the node, it's mainly about the storage.  When
> a fencing victim is disconnected from storage, it usually means its SAN
> port has been turned off on a switch.  Notice that this doesn't touch or
> effect the node at all -- it simply blocks any i/o from the node before it
> reaches the storage.
> 
> Any distributed app using the DLM that writes only to its own local
> storage will not need fencing, there's nothing to fence.

Dave,

I have always thought about clustering based on the VMS design.
I googled around and found some OpenVMS slides that described it like
this -- text only :)

------
  The Connection Manager is code within OpenVMS that coordinates
  cluster membership across events such as:
	- Forming a cluster initially
	- Allowing a node to join the cluster
	- Cleaning up after a node which has failed or left the cluster

  all the while protecting against uncoordinated access to shared
  resources such as disks
------
  The Connection Manager enforces the Quorum Scheme to ensure that all 
  access to shared resources is coordinated
	Basic idea: A majority of the potential cluster systems must be
	present in the cluster before any access to shared resources
	(i.e. disks) is allowed
------
  If a cluster member is not part of a cluster with quorum, OpenVMS
  keeps it from doing any harm by:
	- Putting all disks into Mount Verify state, thus stalling all
	  disk I/O operations
	- Requiring that all processes can only be scheduled to run on
	  a CPU with the QUORUM capability bit set
	- Clearing the QUORUM capability bit on all CPUs in the system,
	  thus preventing any process from being scheduled to run on a
	  CPU and doing any work
------

So the Connection Manager controlled membership, quorum, and fencing
(stalling all disk i/o, etc).  AFAIR, the DLM would get a membership
event and do recovery after quorum and fencing.   From the description
above, nodes not part of the membership with quorum could not do
anything.

I have always thought that an distributed application could use the DLM
alone to protect access to shared storage.   The DLM would coordinate
access between the distributed application running on the nodes
in the cluster AND DLM locks would not be recovered and possibly
granted to applications running on the nodes still in the membership
until after nodes that are no longer a member of the cluster are safely
prevented from doing any harm.

So, when I said that the DLM was dependent on fencing, I was thinking
of the membership, quorum, prevention of harm (stalling of i/o to
prevent corrupting shared resource) as described above.

So, if an application was using your DLM to protect shared storage,
I think you are saying it possible the DLM lock could be granted 
before the node that was previously holding the lock and now is not
part of the cluster is fenced.  Is that right?  

If it is, what prevents GFS from getting a DLM lock granted and writing
to the shared storage before the node that previously had it is fenced?

Daniel

PS if an application is writing to local storage, what does it need a
DLM for?





 


