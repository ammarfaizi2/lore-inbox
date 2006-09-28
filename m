Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030357AbWI1Sbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030357AbWI1Sbd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 14:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030358AbWI1Sbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 14:31:32 -0400
Received: from smtp-out.google.com ([216.239.45.12]:64098 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030357AbWI1Sba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 14:31:30 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=T8j4Cr1WrvMLqrBGak6eILzOpP2apS/v7zZQ1Rz9XcC0vxW6MV8POfc/s53krRmuC
	cyAxTPJJ5UM+sVjFRk3Xw==
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: balbir@in.ibm.com
Cc: sekharan@us.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>,
       devel@openvz.org, CKRM-Tech <ckrm-tech@lists.sourceforge.net>
In-Reply-To: <451B815D.2010807@in.ibm.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <1159386644.4773.80.camel@linuxchandra>
	 <1159392487.23458.70.camel@galaxy.corp.google.com>
	 <1159395892.4773.107.camel@linuxchandra>  <451B815D.2010807@in.ibm.com>
Content-Type: text/plain
Organization: Google Inc
Date: Thu, 28 Sep 2006 11:31:15 -0700
Message-Id: <1159468275.2669.88.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-28 at 13:31 +0530, Balbir Singh wrote:
> Chandra Seetharaman wrote:
> > On Wed, 2006-09-27 at 14:28 -0700, Rohit Seth wrote:
> > 
> > Rohit,
> > 
> > For 1-4, I understand the rationale. But, your implementation deviates
> > from the current behavior of the VM subsystem which could affect the
> > ability of these patches getting into mainline.
> > 
> > IMO, the current behavior in terms of reclamation, LRU, vm_swappiness,
> > and writeback logic should be maintained.
> > 
> 
> <snip>
> 
> Hi, Rohit,
> 
> I have been playing around with the containers patch. I finally got
> around to reading the code.
> 
> 
> 1. Comments on reclaiming
> 
> You could try the following options to overcome some of the disadvantages of the
> current scheme.
> 
> (a) You could consider a reclaim path based on Dave Hansen's Challenged memory
> controller (see http://marc.theaimsgroup.com/?l=linux-mm&m=115566982532345&w=2).
> 

I will go through that.  Did you get a chance to stress the system and
found any short comings that should be resolved.

> (b) The other option is to do what the resource group memory controller does -
> build a per group LRU list of pages (active, inactive) and reclaim
> them using the existing code (by passing the correct container pointer,
> instead of the zone pointer). One disadvantage of this approach is that
> the global reclaim is impacted as the global LRU list is broken. At the
> expense of another list, we could maintain two lists, global LRU and
> container LRU lists. Depending on the context of the reclaim - (container
> over limit, memory pressure) we could update/manipulate both lists.
> This approach is definitely very expensive.
> 

Two LRUs is a nice idea.  Though I don't think it will go too far.  It
will involve adding another list pointers in the page structure.  I
agree that the mem handler is not optimal at all but I don't want to
make it mimic kernel reclaimer at the same time.

> 2. Comments on task migration support
> 
> (a) One of the issues I found while using the container code is that, one could
> add a task to a container say "a". "a" gets charged for the tasks usage,
> when the same task moves to a different container say "b", when the task
> exits, the credit goes to "b" and "a" remains indefinitely charged.
> 
hmm, when the task is removed from "a" then "a" gets the credits for the
amount of anon memory that is used by the task.  Or do you mean
something different.

> (b) For tasks addition and removal, I think it's probably better to move
> the entire process (thread group) rather than allow each individual thread
> to move across containers. Having threads belonging to the same process
> reside in different containers can be complex to handle, since they
> share the same VM. Do you have a scenario where the above condition
> would be useful?
> 
> 
I don't have a scenario where a task actually gets to move out of
container (except exit).  That asynchronous removal of tasks has already
got the code very complicated for locking etc.  But if you think moving
a thread group is useful then I will add that functionality.

Thanks,
-rohit

