Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWHXMaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWHXMaq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 08:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWHXMap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 08:30:45 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:7088 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1751194AbWHXMao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 08:30:44 -0400
Subject: Re: [PATCH] SELinux: 3/3 convert sbsec semaphore to a mutex
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andrew Morton <akpm@osdl.org>
Cc: Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org,
       James Morris <jmorris@redhat.com>
In-Reply-To: <20060823140440.92bc9a10.akpm@osdl.org>
References: <1156362637.6662.51.camel@localhost.localdomain>
	 <20060823140440.92bc9a10.akpm@osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 24 Aug 2006 08:32:16 -0400
Message-Id: <1156422737.8506.137.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-23 at 14:04 -0700, Andrew Morton wrote:
> On Wed, 23 Aug 2006 15:50:37 -0400
> Eric Paris <eparis@redhat.com> wrote:
> 
> > This patch converts the semaphore in the superblock security struct to a
> > mutex.  No locking changes or other code changes are done.
> > 
> > This is being targeted for 2.6.19
> > 
> > Signed-off-by: Eric Paris <eparis@redhat.com>
> > Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
> > 
> >  security/selinux/hooks.c          |    7 +++----
> >  security/selinux/include/objsec.h |    2 +-
> >  2 files changed, 4 insertions(+), 5 deletions(-)
> > 
> > --- linux-2.6-sem-changes/security/selinux/include/objsec.h.patch3	2006-08-03 14:04:07.000000000 -0400
> > +++ linux-2.6-sem-changes/security/selinux/include/objsec.h	2006-08-03 14:18:44.000000000 -0400
> > @@ -63,7 +63,7 @@ struct superblock_security_struct {
> >  	unsigned int behavior;          /* labeling behavior */
> >  	unsigned char initialized;      /* initialization flag */
> >  	unsigned char proc;             /* proc fs */
> > -	struct semaphore sem;
> > +	struct mutex lock;
> >  	struct list_head isec_head;
> >  	spinlock_t isec_lock;
> >  };
> > --- linux-2.6-sem-changes/security/selinux/hooks.c.patch3	2006-08-02 14:29:28.000000000 -0400
> > +++ linux-2.6-sem-changes/security/selinux/hooks.c	2006-08-03 14:21:48.000000000 -0400
> > @@ -49,7 +49,6 @@
> >  #include <net/ip.h>		/* for sysctl_local_port_range[] */
> >  #include <net/tcp.h>		/* struct or_callable used in sock_rcv_skb */
> >  #include <asm/uaccess.h>
> > -#include <asm/semaphore.h>
> >  #include <asm/ioctls.h>
> >  #include <linux/bitops.h>
> >  #include <linux/interrupt.h>
> > @@ -240,7 +239,7 @@ static int superblock_alloc_security(str
> >  	if (!sbsec)
> >  		return -ENOMEM;
> >  
> > -	init_MUTEX(&sbsec->sem);
> > +	mutex_init(&sbsec->lock);
> >  	INIT_LIST_HEAD(&sbsec->list);
> >  	INIT_LIST_HEAD(&sbsec->isec_head);
> >  	spin_lock_init(&sbsec->isec_lock);
> > @@ -595,7 +594,7 @@ static int superblock_doinit(struct supe
> >  	struct inode *inode = root->d_inode;
> >  	int rc = 0;
> >  
> > -	down(&sbsec->sem);
> > +	mutex_lock(&sbsec->lock);
> >  	if (sbsec->initialized)
> >  		goto out;
> >  
> > @@ -690,7 +689,7 @@ next_inode:
> >  	}
> >  	spin_unlock(&sbsec->isec_lock);
> >  out:
> > -	up(&sbsec->sem);
> > +	mutex_unlock(&sbsec->lock);
> >  	return rc;
> >  }
> >  
> > 
> 
> Does this lock actually do anything?

The function is called from vfs_kern_mount normally, and from
selinux_complete_init just for the initial setup after initial policy
load.  The lock is for the initialization of the superblock security
struct.  Strictly speaking, we can't race from vfs_kern_mount since the
caller holds s_umount write lock already, but I didn't think we should
rely on that here.  Eric noticed that as well when he was preparing the
sem->mutex conversion patch and was originally going to drop the lock
altogether.

-- 
Stephen Smalley
National Security Agency

