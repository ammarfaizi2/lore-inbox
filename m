Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262832AbVG3Ag0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262832AbVG3Ag0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 20:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262825AbVG3Adp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 20:33:45 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:11750 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262761AbVG3AcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 20:32:24 -0400
Date: Fri, 29 Jul 2005 17:32:13 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: tony.luck@intel.com
cc: linux-kernel@vger.kernel.org, alex.williamson@hp.com
Subject: Re: long delays (possibly infinite) in time_interpolator_get_counter
In-Reply-To: <200507292206.j6TM6w4k004594@agluck-lia64.sc.intel.com>
Message-ID: <Pine.LNX.4.62.0507291714530.19670@schroedinger.engr.sgi.com>
References: <200507292206.j6TM6w4k004594@agluck-lia64.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/include/linux/timex.h b/include/linux/timex.h

Oh. Before I forget: You need to make the same changes to the asm code in 
arch/ia64/kernel/fsys.S in order for this to work properly. The asm code 
has been optimized to the hilt to save every cycle possible. Please dont 
add any. The C code is typically bypassed for all user space gettimeofday 
/ clock_gettime calls.

Hmm.. However, if you did not see the problem in the asm code (which does 
not have the nesting issue of C and wastes some time doing other things) 
then we may solve the issue by either also calling asm from kernel space 
or making sure that some time is wasted on something else then the 
cmpxchg in the inner loop.

Or we can make "nojitter" the default? Then do a

if (nojitter)
	printk(KERN_ERR "Beware: SMP system using ITC as a time source!"
		"Time may fluctuate.\n");

at bootup and hope for the best?
