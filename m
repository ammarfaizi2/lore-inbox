Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423939AbWKAIf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423939AbWKAIf1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 03:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423919AbWKAIf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 03:35:26 -0500
Received: from mx2.cs.washington.edu ([128.208.2.105]:42192 "EHLO
	mx2.cs.washington.edu") by vger.kernel.org with ESMTP
	id S1423918AbWKAIfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 03:35:25 -0500
Date: Wed, 1 Nov 2006 00:35:04 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: Pavel Emelianov <xemul@openvz.org>
cc: balbir@in.ibm.com, vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, pj@sgi.com, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com, menage@google.com,
       linux-mm@kvack.org
Subject: Re: [ckrm-tech] RFC: Memory Controller
In-Reply-To: <45485541.6060700@openvz.org>
Message-ID: <Pine.LNX.4.64N.0611010016350.27467@attu4.cs.washington.edu>
References: <20061030103356.GA16833@in.ibm.com> <4545D51A.1060808@in.ibm.com>
 <4546212B.4010603@openvz.org> <454638D2.7050306@in.ibm.com> <45470DF4.70405@openvz.org>
 <45472B68.1050506@in.ibm.com> <4547305A.9070903@openvz.org>
 <Pine.LNX.4.64N.0610312158240.18766@attu4.cs.washington.edu>
 <45485541.6060700@openvz.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2006, Pavel Emelianov wrote:

> beancounters may be implemented above any (or nearly any) userspace
> interface, no questions. But we're trying to come to agreement here,
> so I just say my point of view.
> 
> I don't mind having file system based interface, I just believe that
> configfs is not so good for it. I've already answered that having
> our own filesystem for it sounds better than having configfs.
> 
> Maybe we can summarize what we have come to?
> 

I've seen nothing but praise for Paul Menage's suggestion of implementing 
a single-level containers abstraction for processes and attaching 
these to various resource controller (disk, network, memory, cpu) nodes.  
The question of whether to use configfs or not is really at the fore-front 
of that discussion because making any progress in implementation is 
difficult without first deciding upon it, and the containers abstraction 
patchset uses configfs as its interface.

The original objection against configfs was against the lifetime of the 
resource controller.  But this is actually a two part question since there 
are two interfaces: one for the containers, one for the controllers.  At 
present it seems like the only discussion taking place is that of the 
container so this objection can wait.  After boot, there are one of two 
options:

 - require the user to mount the configfs filesystem with a single
   system-wide container as default

    i. include all processes in that container by default

   ii. include no processes in that container, force the user to add them

 - create the entire container abstraction upon boot and attach all
   processes to it in a manner similar to procfs

 [ In both scenarios, kernel behavior is unchanged if no resource
   controller node is attached to any container as if the container(s)
   didn't exist. ]

Another objection against configfs was the fact that you must define 
CONFIG_CONFIGFS_FS to use CONFIG_CONTAINERS.  This objection does not make 
much sense since it seems like we are falling the direction of abandoning 
the syscall approach here and looking toward an fs approach in the first 
place.  So CONFIG_CONTAINERS will need to include its own lightweight 
filesystem if we cannot use CONFIG_CONFIGFS_FS, but it seems redundant 
since this is what configfs is for: a configurable filesystem to interface 
to the kernel.  We definitely do not want two or more interfaces to 
_containers_ so we are reimplementing an already existing infrastructure.

The criticism that users can create containers and then not use them 
shouldn't be an issue if it is carefully implemented.  In fact, I proposed 
that all processes are initially attached to a single system-wide 
container at boot regardless if you've loaded any controllers or not just 
like how UMA machines work with node 0 for system-wide memory.  We should 
incur no overhead for having empty or _full_ containers if we haven't 
loaded controllers or have configured them properly to include the right 
containers.

So if we re-read Paul Menage's containers abstraction away from cpusets 
patchset that uses configfs, we can see that we are almost there with the 
exception of making it a single-layer "hierarchy" as he has already 
proposed.  Resource controller "nodes" that these containers can be 
attached to are a separate issue at this point and shouldn't be confused.

		David
