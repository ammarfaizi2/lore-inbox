Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264866AbTFLPhU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 11:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264871AbTFLPhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 11:37:20 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:4083 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264866AbTFLPhP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 11:37:15 -0400
Date: Thu, 12 Jun 2003 21:23:45 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: John M Flinchbaugh <glynis@butterfly.hjsoft.com>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: 2.5.70-bk16: nfs crash
Message-ID: <20030612155345.GB1438@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030612125630.GA19842@butterfly.hjsoft.com> <20030612135254.GA2482@in.ibm.com> <16104.40370.828325.379995@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16104.40370.828325.379995@charged.uio.no>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 08:35:14AM -0700, Trond Myklebust wrote:
> >>>>> " " == Dipankar Sarma <dipankar@in.ibm.com> writes:
>      > __d_drop() *must not* initialize d_hash fields. Lockfree lookup
>      > depends on that. If __d_drop() needs to be allowed on an
>      > unhashed dentry, the right thing to do would be to check for
>      > DCACHE_UNHASHED before unhashing. I will submit a patch a
>      > little later to do this.
> 
> Can you please remind us exactly what the benefits of all this are? 
> Why can't d_free() immediately free the memory instead of relying on
> the RCU mechanism?

Because we no longer hold the dcache_lock while doing a d_lookup().
With the dentry still around (RCU wouldn't happen until all CPUs
do a context switch or execute user-level code), lookup can continue
to traverse the hash list while another CPU deletes the currrent
dentry. Once RCU happens, it is guranteed that no other CPU
could be in that dentry during hash list traversal. That is why
we have _rcu versions of the list deletion macros.
Lockfree d_lookup() gives us significant benefits in larger
SMP machines.

Does my patch meet the requirements that you had for __d_drop() ?

Thanks
Dipankar
