Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbULFJjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbULFJjn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 04:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbULFJjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 04:39:43 -0500
Received: from 70-56-133-193.albq.qwest.net ([70.56.133.193]:45789 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261474AbULFJjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 04:39:37 -0500
Date: Mon, 6 Dec 2004 02:38:33 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
cc: Stephen Rothwell <sfr@canb.auug.org.au>, paulmck@us.ibm.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Li Shaohua <shaohua.li@intel.com>
Subject: Re: Fw: [RFC] Strange code in cpu_idle()
In-Reply-To: <20041205232007.7edc4a78.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0412060157460.1036@montezuma.fsmlabs.com>
References: <20041205004557.GA2028@us.ibm.com> <20041206111634.44d6d29c.sfr@canb.auug.org.au>
 <20041205232007.7edc4a78.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	The original intent to go with synchronize_kernel and RCU 
protection was for simplicity's sake, as the alternative implementations 
at the time looked like major overkill. Now in defense of this method, 
when entering the idle thread and placing the processor in a holding state 
(hlt) and an RCU grace period is begun, the processor in the holding state 
will be unaware of the new RCU grace period until it exits the idle loop 
callback (pm_idle) anyway, so the rcu_read will block the other processors 
from making RCU grace period completion as much as the processor holding 
state. This is true of all current pm_idle callbacks on i386, x86_64 and 
ia64 with the exception of APM (but i'll conveniently ignore that for now 
;). When we do take an interrupt to exit the processor holding state and 
run through rcu_check_callbacks we will notice that we are in a hard 
interrupt and will defer marking of the processsor as quiescent. By that 
point we will have exited the idle thread callback therefore making it 
safe to use synchronize_kernel to protect removal of the callback.

Thanks,
	Zwane "who usually doesn't condone interface abuse" Mwaikambo
