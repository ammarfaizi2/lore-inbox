Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbWFUVoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWFUVoG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWFUVoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:44:06 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:21729 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751485AbWFUVoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:44:05 -0400
Date: Wed, 21 Jun 2006 14:43:55 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: James Morris <jmorris@namei.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
       David Quigley <dpquigl@tycho.nsa.gov>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 2/3] SELinux: add security_task_movememory calls to mm
 code
In-Reply-To: <Pine.LNX.4.64.0606211734480.12872@d.namei>
Message-ID: <Pine.LNX.4.64.0606211438270.22367@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0606211517170.11782@d.namei>
 <Pine.LNX.4.64.0606211730540.12872@d.namei> <Pine.LNX.4.64.0606211734480.12872@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006, James Morris wrote:

> diff -purN -X dontdiff linux-2.6.17-mm1.p/mm/mempolicy.c linux-2.6.17-mm1.w/mm/mempolicy.c
> --- linux-2.6.17-mm1.p/mm/mempolicy.c	2006-06-21 11:54:12.000000000 -0400
> +++ linux-2.6.17-mm1.w/mm/mempolicy.c	2006-06-21 17:18:00.000000000 -0400
> @@ -88,6 +88,7 @@
>  #include <linux/proc_fs.h>
>  #include <linux/migrate.h>
>  #include <linux/rmap.h>
> +#include <linux/security.h>
>  
>  #include <asm/tlbflush.h>
>  #include <asm/uaccess.h>
> @@ -946,6 +947,10 @@ asmlinkage long sys_migrate_pages(pid_t 
>  		goto out;
>  	}
>  
> +	err = security_task_movememory(task);
> +	if (err)
> +		goto out;
> +
>  	err = do_migrate_pages(mm, &old, &new,
>  		capable(CAP_SYS_NICE) ? MPOL_MF_MOVE_ALL : MPOL_MF_MOVE);
>  out:

Acked-by: Christoph Lameter <clameter@sgi.com>


> diff -purN -X dontdiff linux-2.6.17-mm1.p/mm/migrate.c linux-2.6.17-mm1.w/mm/migrate.c
> --- linux-2.6.17-mm1.p/mm/migrate.c	2006-06-21 11:54:12.000000000 -0400
> +++ linux-2.6.17-mm1.w/mm/migrate.c	2006-06-21 17:17:52.000000000 -0400
> @@ -27,6 +27,7 @@
>  #include <linux/writeback.h>
>  #include <linux/mempolicy.h>
>  #include <linux/vmalloc.h>
> +#include <linux/security.h>
>  
>  #include "internal.h"
>  
> @@ -903,6 +904,11 @@ asmlinkage long sys_move_pages(pid_t pid
>  		goto out2;
>  	}
>  
> + 	err = security_task_movememory(task);
> + 	if (err)
> + 		goto out2;
> + 	
> +
>  	task_nodes = cpuset_mems_allowed(task);
>  
>  	/* Limit nr_pages so that the multiplication may not overflow */
> 

This check is before the validity of nodes has been verified but 
the check in sys_migrate_pages is after the checking of the nodes.


