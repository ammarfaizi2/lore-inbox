Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbTE0A2J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 20:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbTE0A2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 20:28:09 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:65489
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262412AbTE0A2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 20:28:03 -0400
Date: Tue, 27 May 2003 02:41:15 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: akpm@digeo.com, davidsen@tmr.com, haveblue@us.ibm.com, habanero@us.ibm.com,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: userspace irq balancer
Message-ID: <20030527004115.GD3767@dualathlon.random>
References: <20030526233446.GZ3767@dualathlon.random> <20030526.164300.88501443.davem@redhat.com> <20030527000639.GA3767@dualathlon.random> <20030526.171527.35691510.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030526.171527.35691510.davem@redhat.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26, 2003 at 05:15:27PM -0700, David S. Miller wrote:
> One hardirq can equate to thousands of packets worth of softirq load,
> especially with NAPI.  And you cannot even know what this ratio is
> (packets processed per hardware IRQ load).  It can be anywhere from
> 1 to 1000.  And you absolutely do not want to behave identically
> for all such values.
> 
> How can you even claim to be taking this into account in a logical
> manner if you cannot even tell me how you will determine how much
> softirq load is created by a hardware irq?

you brought a very funny case ;), agreed! certainly if it's ksoftirqd
with NAPI that is causing the irq move to the next cpu you don't want to
migrate it to the next cpu ksoftirqd will keep following it, rounding
back and forth across all idle cpus (assuming a firwall with many idle
cpus). So basically you're saying that we've to change it to idle() ||
== ksoftirqd (i'll fix it thanks!). The additional check should avoid
the misbehaviour. In 2.4 normally the softirq (of course w/o NAPI) are
served in irq context so we didn't face this yet.

But it doesn't change my basic argument about this topic, that there's
no way in userspace to do anything remotely as accurate as that to boost
system performance to the maximum, especially on big systems. My current
algorithm was a minimal attempt to do something better than the static
(or almost static) bindings with all the info we have in kernel (that
userspace could never use efficiently on a timely basis).

Andrea
