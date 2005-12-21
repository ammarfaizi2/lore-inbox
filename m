Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbVLUUUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbVLUUUz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 15:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbVLUUUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 15:20:55 -0500
Received: from omx3-ext.sgi.com ([192.48.171.25]:5073 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932497AbVLUUUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 15:20:55 -0500
Date: Wed, 21 Dec 2005 12:20:20 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       nippung@calsoftinc.com
Subject: Re: [rfc][patch] Avoid taking global tasklist_lock for single threaded
 process at getrusage()
In-Reply-To: <20051221182320.GA4514@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0512211209300.2829@schroedinger.engr.sgi.com>
References: <20051221182320.GA4514@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Dec 2005, Ravikiran G Thirumalai wrote:

> Following patch avoids taking the global tasklist_lock when possible,
> if a process is single threaded during getrusage().  Any avoidance of 
> tasklist_lock is good for NUMA boxes (and possibly for large SMPs).  We found 
> that this optimization reduces the runtime of a certain scientific application 
> by half on a 16 cpu NUMA box.
> 
> This optimization is similar to the sys_times tasklist_lock optimization.

The optimization of sys_times is only possible because the "current" 
task is running and therefore guarantees that the thread will not be 
exiting.

getrusage and k_getrusage can be called onother tasks than the currently 
executing task and in those cases better take the tasklist lock because 
the task may exit while getrusage runs.

See wait_noreap_copyout() in kernel/exit.c and 
arch/mips/kernel/{sysirix,irixsig}.c for uses of getrusage where the 
struct task_struct * != current.

Maybe you can deal with these and insure that getrusage is always called 
for the current process? In that case the struct task_struct * parameter
needs to be dropped from getrusage and k_getrusage.

