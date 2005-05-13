Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262344AbVEMMVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbVEMMVQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 08:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbVEMMVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 08:21:16 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:60098 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262344AbVEMMVO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 08:21:14 -0400
Date: Fri, 13 May 2005 18:02:17 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Nathan Lynch <ntl@pobox.com>
Cc: Paul Jackson <pj@sgi.com>, Simon.Derr@bull.net,
       lse-tech@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, V Srivatsa <vatsa@in.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: [PATCH] cpusets+hotplug+preepmt broken
Message-ID: <20050513123216.GB3968@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20050511191654.GA3916@in.ibm.com> <20050511195156.GE3614@otto>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050511195156.GE3614@otto>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 02:51:56PM -0500, Nathan Lynch wrote:

> This trace is what should be fixed -- we're trying to schedule while
> the machine is "stopped" (all cpus except for one spinning with
> interrupts off).  I'm not too familiar with the cpusets code but I
> would like to stay away from nesting these semaphores if at all
> possible.

Vatsa pointed out another scenario where cpusets+hotplug is currently
broken. attach_task in cpuset.c is called without holding the hotplug 
lock and it is possible to call set_cpus_allowed for a task with no 
online cpus. 
Given this I think the patch I sent first is the most appropriate
patch. In addition we also need to take hotplug lock in the cpusets
code whenever we are modifying cpus_allowed of a task. IOW make cpusets 
and hotplug operations completly exclusive to each other. The same 
applies to memory hotplug code once it gets in.

However on the downside this would mean 
1. A lot of nested locks (mostly in cpuset_common_file_write)
2. Taking of hotplug (cpu now and later memory) locks for operations
   that may just be updating a flag


	-Dinakar
