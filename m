Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbVHVUPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbVHVUPK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 16:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbVHVUPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 16:15:07 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:35507 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750830AbVHVUPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 16:15:02 -0400
Date: Tue, 23 Aug 2005 01:46:26 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: John Hawkes <hawkes@jackhammer.engr.sgi.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, pj@sgi.com, nickpiggin@yahoo.com.au,
       akpm@osdl.org
Subject: Re: [PATCH] ia64 cpuset + build_sched_domains() mangles structures
Message-ID: <20050822201626.GC7686@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <43074328.MailOXV1UXUHF@jackhammer.engr.sgi.com> <20050822070834.GA16722@elte.hu> <20050822141414.GB7686@in.ibm.com> <20050822160719.GB6652@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050822160719.GB6652@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2005 at 06:07:19PM +0200, Ingo Molnar wrote:
> great! Andrew, i'd suggest we try the merged patch attached below in 
> -mm.
> 

Ingo, unfortunately I am hitting panic's on stress testing. The panic
screen is attached in the .png below.

On debugging I found that the panic happens consistently in this line
 of code in function find_busiest_group

	*imbalance = min((max_load - avg_load) * busiest->cpu_power,
                                (avg_load - this_load) * this->cpu_power)
                        / SCHED_LOAD_SCALE;

Here I find that the "this" pointer is still NULL. I verified this by
a quick hack as below in the same function and with this hack it seems 
to run for hours

-	if (!busiest || this_load >= max_load)
+	if (!this || !busiest || this_load >= max_load)

This can only happen if the none of the sched groups pointed to by the 
'sd' of the current cpu contain the current cpu. I was wondering if
this had anything to do with the way that we are using RCU to assign/
read the 'sd' pointer.

Any thoughts ??

	-Dinakar

