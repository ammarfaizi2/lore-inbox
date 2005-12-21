Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbVLUVWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbVLUVWb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 16:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbVLUVWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 16:22:31 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:58349 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750745AbVLUVWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 16:22:30 -0500
Date: Wed, 21 Dec 2005 13:22:24 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       nippung@calsoftinc.com
Subject: Re: [rfc][patch] Avoid taking global tasklist_lock for single threaded
 process at getrusage()
In-Reply-To: <20051221211135.GB4514@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0512211318070.3443@schroedinger.engr.sgi.com>
References: <20051221182320.GA4514@localhost.localdomain>
 <Pine.LNX.4.62.0512211209300.2829@schroedinger.engr.sgi.com>
 <20051221211135.GB4514@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Dec 2005, Ravikiran G Thirumalai wrote:

> We did look at that. Cases RUSAGE_CHILDREN and RUSAGE_SELF are always called by the 
> current task, so we can avoid tasklist locking there.
> getrusage for non-current tasks are always called with RUSAGE_BOTH.
> We ensure we  always take the siglock for RUSAGE_BOTH case, so that the
> p->signal* fields are protected and take the tasklist_lock only if we have 
> to traverse the tasklist hashlist. Isn't this safe?

Sounds okay. But its complex in the way its is coded now and its easy to 
assume that one can call getrusage with any parameter from inside the 
kernel. Maybe we can have a couple of separate functions 

rusage_children()
rusage_self()
rusage_both()

?

Only rusage_both would take a task_struct * parameter. The others would 
only operate on current. Change all the locations that call getrusage with 
RUSAGE_BOTH to call rusage_both().
