Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264307AbUG2Gni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264307AbUG2Gni (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 02:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbUG2Gni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 02:43:38 -0400
Received: from omx3-ext.SGI.COM ([192.48.171.20]:4750 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264373AbUG2Gng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 02:43:36 -0400
Date: Wed, 28 Jul 2004 23:42:55 -0700
From: Paul Jackson <pj@sgi.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org,
       piggin@cyberone.com.au
Subject: Re: Oops in find_busiest_group(): 2.6.8-rc1-mm1
Message-Id: <20040728234255.29ef4c13.pj@sgi.com>
In-Reply-To: <1089871489.10000.388.camel@nighthawk>
References: <1089871489.10000.388.camel@nighthawk>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just hit what might be the same oops.

I had not upgraded my working kernel for a month, and just now, when I
upgraded to 2.6.8-rc2-mm1, running sn2_defconfig on a small SN2 system,
it fails to boot everytime, ending with an Oops that starts out with:

======================================================
Freeing unused kernel memory: 320kB freed
Unable to handle kernel NULL pointer dereference (address 0000000000000008)
swapper[0]: Oops 8813272891392 [1]
Modules linked in:

Pid: 0, CPU 0, comm:              swapper
psr : 0000101008022018 ifs : 8000000000000e20 ip  : [<a0000001000bd710>]    Not tainted
ip is at find_busiest_group+0xb0/0x640
======================================================

I added a conditional printk_ratelimit'ed print at the top of
find_busiest_group() whenever group is NULL, just before the first
dereference of group in the line:

	local_group = cpu_isset(this_cpu, group->cpumask);

That print fires about 20,480 times each 5 second suppression window.

But it boots, if I also add code to break out of the "do { ... } while
(group != sd->groups)" loop, whenever group goes NULL.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
