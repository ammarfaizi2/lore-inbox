Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbVKJGWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbVKJGWm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 01:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbVKJGWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 01:22:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:984 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751135AbVKJGWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 01:22:42 -0500
Date: Wed, 9 Nov 2005 22:22:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arun Sharma <arun.sharma@google.com>
Cc: rohit.seth@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Expose SHM_HUGETLB in shmctl(id, IPC_STAT, ...)
Message-Id: <20051109222223.538309e4.akpm@osdl.org>
In-Reply-To: <20051109184623.GA21636@sharma-home.net>
References: <20051109184623.GA21636@sharma-home.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arun Sharma <arun.sharma@google.com> wrote:
>
> Allow shmctl to find out if a shmid corresponds to a HUGETLB segment
> 
>  Signed-off-by: Arun Sharma <arun.sharma@google.com>
>  Acked-by: Rohit Seth <rohit.seth@intel.com>
> 
>  --- a/ipc/shm.c	Tue Nov  8 20:58:38 2005
>  +++ b/ipc/shm.c	Wed Nov  9 10:26:37 2005
>  @@ -197,7 +197,7 @@
>   		return -ENOMEM;
>   
>   	shp->shm_perm.key = key;
>  -	shp->shm_flags = (shmflg & S_IRWXUGO);
>  +	shp->shm_flags = (shmflg & (S_IRWXUGO | SHM_HUGETLB));
>   	shp->mlock_user = NULL;
>   
>   	shp->shm_perm.security = NULL;

I dunno.  The manpage says:

       The highlighted fields in the member shm_perm can be set:

           struct ipc_perm {
       ...
               ushort mode;  /* lower 9 bits of access modes */
       ...
           };

So if an application used to do:

	if (perm.mode == 0666)

it will now break, because we've gone and set bit 9 on hugetlb segments.
