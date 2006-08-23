Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965075AbWHWVE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965075AbWHWVE5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 17:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965202AbWHWVE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 17:04:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24235 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965075AbWHWVEz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 17:04:55 -0400
Date: Wed, 23 Aug 2006 14:04:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Eric Paris <eparis@redhat.com>
Cc: linux-kernel@vger.kernel.org, sds@tycho.nsa.gov,
       James Morris <jmorris@redhat.com>
Subject: Re: [PATCH] SELinux: 3/3 convert sbsec semaphore to a mutex
Message-Id: <20060823140440.92bc9a10.akpm@osdl.org>
In-Reply-To: <1156362637.6662.51.camel@localhost.localdomain>
References: <1156362637.6662.51.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2006 15:50:37 -0400
Eric Paris <eparis@redhat.com> wrote:

> This patch converts the semaphore in the superblock security struct to a
> mutex.  No locking changes or other code changes are done.
> 
> This is being targeted for 2.6.19
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
> 
>  security/selinux/hooks.c          |    7 +++----
>  security/selinux/include/objsec.h |    2 +-
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> --- linux-2.6-sem-changes/security/selinux/include/objsec.h.patch3	2006-08-03 14:04:07.000000000 -0400
> +++ linux-2.6-sem-changes/security/selinux/include/objsec.h	2006-08-03 14:18:44.000000000 -0400
> @@ -63,7 +63,7 @@ struct superblock_security_struct {
>  	unsigned int behavior;          /* labeling behavior */
>  	unsigned char initialized;      /* initialization flag */
>  	unsigned char proc;             /* proc fs */
> -	struct semaphore sem;
> +	struct mutex lock;
>  	struct list_head isec_head;
>  	spinlock_t isec_lock;
>  };
> --- linux-2.6-sem-changes/security/selinux/hooks.c.patch3	2006-08-02 14:29:28.000000000 -0400
> +++ linux-2.6-sem-changes/security/selinux/hooks.c	2006-08-03 14:21:48.000000000 -0400
> @@ -49,7 +49,6 @@
>  #include <net/ip.h>		/* for sysctl_local_port_range[] */
>  #include <net/tcp.h>		/* struct or_callable used in sock_rcv_skb */
>  #include <asm/uaccess.h>
> -#include <asm/semaphore.h>
>  #include <asm/ioctls.h>
>  #include <linux/bitops.h>
>  #include <linux/interrupt.h>
> @@ -240,7 +239,7 @@ static int superblock_alloc_security(str
>  	if (!sbsec)
>  		return -ENOMEM;
>  
> -	init_MUTEX(&sbsec->sem);
> +	mutex_init(&sbsec->lock);
>  	INIT_LIST_HEAD(&sbsec->list);
>  	INIT_LIST_HEAD(&sbsec->isec_head);
>  	spin_lock_init(&sbsec->isec_lock);
> @@ -595,7 +594,7 @@ static int superblock_doinit(struct supe
>  	struct inode *inode = root->d_inode;
>  	int rc = 0;
>  
> -	down(&sbsec->sem);
> +	mutex_lock(&sbsec->lock);
>  	if (sbsec->initialized)
>  		goto out;
>  
> @@ -690,7 +689,7 @@ next_inode:
>  	}
>  	spin_unlock(&sbsec->isec_lock);
>  out:
> -	up(&sbsec->sem);
> +	mutex_unlock(&sbsec->lock);
>  	return rc;
>  }
>  
> 

Does this lock actually do anything?

