Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267428AbSLLHN3>; Thu, 12 Dec 2002 02:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267429AbSLLHN3>; Thu, 12 Dec 2002 02:13:29 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:4567 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267428AbSLLHN2>;
	Thu, 12 Dec 2002 02:13:28 -0500
Date: Thu, 12 Dec 2002 13:04:06 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, John Levon <levon@movementarian.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Notifier for significant events on i386
Message-ID: <20021212130406.A20253@in.ibm.com>
Reply-To: vamsi@in.ibm.com
References: <1039471369.1055.161.camel@dell_ss3.pdx.osdl.net> <20021211165153.A17546@in.ibm.com> <20021211111639.GJ9882@holomorphy.com> <20021211171337.A17600@in.ibm.com> <20021211202727.GF20735@compsoc.man.ac.uk> <1039641336.18587.30.camel@irongate.swansea.linux.org.uk> <1039652384.1649.17.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1039652384.1649.17.camel@dell_ss3.pdx.osdl.net>; from shemminger@osdl.org on Thu, Dec 12, 2002 at 12:25:47AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2002 at 12:25:47AM +0000, Stephen Hemminger wrote:
> 
> This patch changes notifier to use RCU.  No interface change, just a little
> more memory in each notifier_block. Also some formatting cleanup.
> Please review and give comments.
> 
> <snip patch>

This looks good. I have a few of comments:

- add read_lock_rcu() / read_unlock_rcu() around the loop in
  notifier_call_chain() to be preempt-safe.

- I would suggest using struct list_head in the notifier_block
  and use the RCU list routines from include/linux/list.h
  instead of spreading subtle RCU memory-barrier black magic.

- Even though RCU list reading is lockless, premption needs to
  be disabled while reading as mentioned above. So, we do
  need an __notifier_call_chain() version for those handlers
  that could sleep inside the handler: they will have to
  handle the required locking themselves.
-- 
Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi@in.ibm.com
