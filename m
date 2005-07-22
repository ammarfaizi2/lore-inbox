Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262088AbVGVOD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbVGVOD0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 10:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbVGVODZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 10:03:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25793 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262088AbVGVOCg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 10:02:36 -0400
Date: Fri, 22 Jul 2005 10:02:27 -0400
From: Neil Horman <nhorman@redhat.com>
To: =?iso-8859-1?Q?M=E1rcio?= Oliveira <moliveira@latinsourcetech.com>
Cc: Neil Horman <nhorman@redhat.com>, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: Memory Management
Message-ID: <20050722140227.GA15660@hmsendeavour.rdu.redhat.com>
References: <42DF9646.5070806@latinsourcetech.com> <20050721131132.GB11327@hmsendeavour.rdu.redhat.com> <42DFA5E6.1080302@latinsourcetech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42DFA5E6.1080302@latinsourcetech.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2005 at 10:40:54AM -0300, Márcio Oliveira wrote:
> 
> >http://people.redhat.com/nhorman/papers/rhel3_vm.pdf
> >I wrote this with norm awhile back.  It may help you out.
> >Regards
> >Neil
> > 
> >
> Neil,
> 
>   Thanks.~10-12GB of total RAM (16GB) are
> 
>   How can Proc virtual memory parameters like inactive_clean_percent, 
> overcommit_memory, overcommit_ratio and page_cache help me to solve / 
> reduce Out Of Memory conditions on servers with 16GB RAM and lots of GB 
> swap?
> 
I wouldn't touch memory overcommit if you are already seeing out of memory
issues.  If you are using lots of pagecache, I would suggest increasing
inactive_clean percent, reducing the pagecahce.max value, and modifying the
bdflush parameters in the above document such that bdflush runs sooner, more
often, and does more work per iteration.  This will help you move data in
pagecache back to disk more aggressively so that memory will be available for
other purposes, like heap allocations. Also if you're using a Red Hat kernel and
you have 16GB of ram in your system, you're a good candidate for the hugemem
kernel.  Rather than a straightforward out of memory condition, you may be
seeing a exhaustion of your kernels address space (check LowFree in
/proc/meminfo).  In this even the hugemem kernel will help you in that it
increases your Low Memory address space from 1GB to 4GB, preventing some OOM
conditions.


>   Kernel does not free cached memory (~10-12GB of total RAM - 16GB). Is 
> there some way to force the kernel to free cached memory?
> 
Cached memory is freed on demand.  Just because its listed under the cached line
below doesn't mean it can't be freed and used for another purpose.  Implement
the tunings above, and your situation should improve.

Regards
Neil

> /proc/meminfo:
> 
>              total:    used:    free:  shared: buffers:  cached:
> Mem:    16603488256 16523333632 80154624        0 70651904 13194563584
> Swap:   17174257664 11771904 17162485760
> MemTotal:     16214344 kB
> MemFree:         78276 kB
> Buffers:         68996 kB
> Cached:       12874808 kB
> 
> Thanks to all.
> 
> Marcio.
> 
> 

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/
