Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268284AbUIKS63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268284AbUIKS63 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 14:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268281AbUIKS62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 14:58:28 -0400
Received: from cantor.suse.de ([195.135.220.2]:54925 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268289AbUIKS6O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 14:58:14 -0400
Date: Sat, 11 Sep 2004 20:55:22 +0200
From: Andi Kleen <ak@suse.de>
To: Paul Jackson <pj@sgi.com>
Cc: Anton Blanchard <anton@samba.org>, akpm@osdl.org, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [Patch 4/4] cpusets top mask just online, not all possible
Message-ID: <20040911185522.GA493@wotan.suse.de>
References: <20040911082810.10372.86008.84920@sam.engr.sgi.com> <20040911082834.10372.51697.75658@sam.engr.sgi.com> <20040911141001.GD32755@krispykreme> <20040911100731.2f400271.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040911100731.2f400271.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2004 at 10:07:31AM -0700, Paul Jackson wrote:
> Cpusets builds up additional data structures, used to manage a tasks CPU
> and Memory placement.  If more CPUs or Memory are added later on,
> cpusets won't know of them nor let you use them.  If CPUs or Memory are
> removed later on, cpusets will still think it is ok to use them, and
> potentially starve a task if that tasks cpuset had been configured to
> _only_ allow using the now departed CPU or Memory.

MPOL_BIND uses direct pointers to zones, the others just node numbers
and fall back to other zones.  Lost node numbers should be pretty easy to 
deal with because there is enough redirection. MPOL_BIND is a bit more
difficult.

My prefered solution would be to never actually remove the zone datastructure,
but just make them zero size when their memory is gone. Then the mempolicies 
could still keep pointers to them, but any allocations will fail.

This may require putting them into different memory though (currently
they are usually in the node itself) 

This should also allow cpumemset to work.

Of course the applications may not be very happy when all the memory
they are allowed to touch is gone, but fixing that is imho more
a high level user space management problem, nothing the kernel
should try to resolve.

-Andi
