Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265287AbUF1XOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265287AbUF1XOV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 19:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265288AbUF1XOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 19:14:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:219 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265287AbUF1XOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 19:14:07 -0400
Date: Mon, 28 Jun 2004 16:12:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: "R. J. Wysocki" <rjwysocki@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>
Subject: Re: 2.6.7-mm3: Kernel BUG on dual Opteron with DEBUG_SLAB
Message-Id: <20040628161256.4d0365ab.akpm@osdl.org>
In-Reply-To: <200406282129.35120.rjwysocki@sisk.pl>
References: <20040626233105.0c1375b2.akpm@osdl.org>
	<20040628001935.37b19aa2.akpm@osdl.org>
	<200406282118.36911.rjwysocki@sisk.pl>
	<200406282129.35120.rjwysocki@sisk.pl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"R. J. Wysocki" <rjwysocki@sisk.pl> wrote:
>
> Kernel BUG at mempolicy:585

OK, this is a straight use-after-free bug:


--- 25/mm/mempolicy.c~a 2004-06-28 15:46:42.000000000 -0700
+++ 25-akpm/mm/mempolicy.c      2004-06-28 15:48:25.000000000 -0700
@@ -582,7 +582,7 @@ static struct zonelist *zonelist_policy(
                break;
        default:
                nd = 0;
-               BUG();
+               printk("%s: policy=%x\n", __FUNCTION__, policy->policy);
        }
        return NODE_DATA(nd)->node_zonelists + (gfp & GFP_ZONEMASK);
 }

linux:/home/akpm> dmesg -s 1000000|grep zonelist
Built 1 zonelists
zonelist_policy: policy=6b6b
zonelist_policy: policy=6b6b

Andi, could you take a look?  Enabling CONFIG_DEBUG_SLAB and CONFIG_NUMA
triggers it 100% of the time.
