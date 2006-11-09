Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753996AbWKIJIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753996AbWKIJIl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 04:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753966AbWKIJIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 04:08:41 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:8879 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1753996AbWKIJIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 04:08:39 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [take24 3/6] kevent: poll/select() notifications.
Date: Thu, 9 Nov 2006 10:08:44 +0100
User-Agent: KMail/1.9.5
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
References: <11630606373650@2ka.mipt.ru>
In-Reply-To: <11630606373650@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611091008.45227.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 November 2006 09:23, Evgeniy Polyakov wrote:
> poll/select() notifications.
>
> This patch includes generic poll/select notifications.
> kevent_poll works simialr to epoll and has the same issues (callback
> is invoked not from internal state machine of the caller, but through
> process awake, a lot of allocations and so on).
>
> Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mitp.ru>
>
> diff --git a/fs/file_table.c b/fs/file_table.c
> index bc35a40..0805547 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -20,6 +20,7 @@ #include <linux/capability.h>
>  #include <linux/cdev.h>
>  #include <linux/fsnotify.h>
>  #include <linux/sysctl.h>
> +#include <linux/kevent.h>
>  #include <linux/percpu_counter.h>
>
>  #include <asm/atomic.h>
> @@ -119,6 +120,7 @@ struct file *get_empty_filp(void)
>  	f->f_uid = tsk->fsuid;
>  	f->f_gid = tsk->fsgid;
>  	eventpoll_init_file(f);
> +	kevent_init_file(f);
>  	/* f->f_version: 0 */
>  	return f;
>
> @@ -164,6 +166,7 @@ void fastcall __fput(struct file *file)
>  	 * in the file cleanup chain.
>  	 */
>  	eventpoll_release(file);
> +	kevent_cleanup_file(file);
>  	locks_remove_flock(file);
>
>  	if (file->f_op && file->f_op->release)
> diff --git a/fs/inode.c b/fs/inode.c
> index ada7643..6745c00 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -21,6 +21,7 @@ #include <linux/pagemap.h>
>  #include <linux/cdev.h>
>  #include <linux/bootmem.h>
>  #include <linux/inotify.h>
> +#include <linux/kevent.h>
>  #include <linux/mount.h>
>
>  /*
> @@ -164,12 +165,18 @@ #endif
>  		}
>  		inode->i_private = 0;
>  		inode->i_mapping = mapping;

Here you test both KEVENT_SOCKET and KEVENT_PIPE

> +#if defined CONFIG_KEVENT_SOCKET || defined CONFIG_KEVENT_PIPE
> +		kevent_storage_init(inode, &inode->st);
> +#endif
>  	}
>  	return inode;
>  }
>
>  void destroy_inode(struct inode *inode)
>  {

but here you test only KEVENT_SOCKET

> +#if defined CONFIG_KEVENT_SOCKET
> +	kevent_storage_fini(&inode->st);
> +#endif
>  	BUG_ON(inode_has_buffers(inode));
>  	security_inode_free(inode);
>  	if (inode->i_sb->s_op->destroy_inode)
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 5baf3a1..c529723 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -276,6 +276,7 @@ #include <linux/prio_tree.h>
>  #include <linux/init.h>
>  #include <linux/sched.h>
>  #include <linux/mutex.h>
> +#include <linux/kevent_storage.h>
>
>  #include <asm/atomic.h>
>  #include <asm/semaphore.h>
> @@ -586,6 +587,10 @@ #ifdef CONFIG_INOTIFY
>  	struct mutex		inotify_mutex;	/* protects the watches list */
>  #endif
>

Here you include a kevent_storage only if KEVENT_SOCKET

> +#ifdef CONFIG_KEVENT_SOCKET
> +	struct kevent_storage	st;
> +#endif
> +
>  	unsigned long		i_state;
>  	unsigned long		dirtied_when;	/* jiffies of first dirtying */
>
> @@ -739,6 +744,9 @@ #ifdef CONFIG_EPOLL
>  	struct list_head	f_ep_links;
>  	spinlock_t		f_ep_lock;
>  #endif /* #ifdef CONFIG_EPOLL */
> +#ifdef CONFIG_KEVENT_POLL
> +	struct kevent_storage	st;
> +#endif
>  	struct address_space	*f_mapping;
>  };
>  extern spinlock_t files_lock;
