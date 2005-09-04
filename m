Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbVIDTtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbVIDTtT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 15:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbVIDTtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 15:49:19 -0400
Received: from smtp.istop.com ([66.11.167.126]:4561 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S1751023AbVIDTtS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 15:49:18 -0400
From: Daniel Phillips <phillips@istop.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Date: Sun, 4 Sep 2005 15:51:56 -0400
User-Agent: KMail/1.8
Cc: Joel.Becker@oracle.com, linux-cluster@redhat.com, wim.coekaerts@oracle.com,
       linux-fsdevel@vger.kernel.org, ak@suse.de, linux-kernel@vger.kernel.org
References: <20050901104620.GA22482@redhat.com> <200509040240.08467.phillips@istop.com> <20050904002828.3d26f64c.akpm@osdl.org>
In-Reply-To: <20050904002828.3d26f64c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509041551.56614.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 September 2005 03:28, Andrew Morton wrote:
> If there is already a richer interface into all this code (such as a
> syscall one) and it's feasible to migrate the open() tricksies to that API
> in the future if it all comes unstuck then OK.  That's why I asked (thus
> far unsuccessfully):
>
>    Are you saying that the posix-file lookalike interface provides
>    access to part of the functionality, but there are other APIs which are
>    used to access the rest of the functionality?  If so, what is that
>    interface, and why cannot that interface offer access to 100% of the
>    functionality, thus making the posix-file tricks unnecessary?

There is no such interface at the moment, nor is one needed in the immediate 
future.  Let's look at the arguments for exporting a dlm to userspace:

  1) Since we already have a dlm in kernel, why not just export that and save
     100K of userspace library?  Answer: because we don't want userspace-only
     dlm features bulking up the kernel.  Answer #2: the extra syscalls and
     interface baggage serve no useful purpose.

  2) But we need to take locks in the same lockspaces as the kernel dlm(s)!
     Answer: only support tools need to do that.  A cut-down locking api is
     entirely appropriate for this.

  3) But the kernel dlm is the only one we have!  Answer: easily fixed, a
     simple matter of coding.  But please bear in mind that dlm-style
     synchronization is probably a bad idea for most cluster applications,
     particularly ones that already do their synchronization via sockets.

In other words, exporting the full dlm api is a red herring.  It has nothing 
to do with getting cluster filesystems up and running.  It is really just 
marketing: it sounds like a great thing for userspace to get a dlm "for 
free", but it isn't free, it contributes to kernel bloat and it isn't even 
the most efficient way to do it.

If after considering that, we _still_ want to export a dlm api from kernel, 
then can we please take the necessary time and get it right?  The full api 
requires not only syscall-style elements, but asynchronous events as well, 
similar to aio.  I do not think anybody has a good answer to this today, nor 
do we even need it to begin porting applications to cluster filesystems.

Oracle guys: what is the distributed locking API for RAC?  Is the RAC team 
waiting with bated breath to adopt your kernel-based dlm?  If not, why not?

Regards,

Daniel
