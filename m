Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbVETRC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVETRC7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 13:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVETRC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 13:02:59 -0400
Received: from fire.osdl.org ([65.172.181.4]:51928 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261498AbVETRCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 13:02:06 -0400
Date: Fri, 20 May 2005 10:01:58 -0700
From: Chris Wright <chrisw@osdl.org>
To: Linux Audit Discussion <linux-audit@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc4-mm2 - sleeping function called from invalid context at mm/slab.c:2502
Message-ID: <20050520170158.GY27549@shell0.pdx.osdl.net>
References: <200505171624.j4HGOQwo017312@turing-police.cc.vt.edu> <1116502449.23972.207.camel@hades.cambridge.redhat.com> <200505191845.j4JIjVtq006262@turing-police.cc.vt.edu> <200505201430.j4KEUFD0012985@turing-police.cc.vt.edu> <1116601195.29037.18.camel@localhost.localdomain> <1116601757.12489.130.camel@moss-spartans.epoch.ncsc.mil> <1116603414.29037.36.camel@localhost.localdomain> <1116607223.12489.155.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116607223.12489.155.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Smalley (sds@tycho.nsa.gov) wrote:
> Untested patch below, relative to 2.6.12-rc4-mm2 plus your socketcall
> patch to avoid the obvious conflict there.  Is this what you had in
> mind?
> 
>  include/linux/audit.h  |    2 ++
>  kernel/auditsc.c       |   38 ++++++++++++++++++++++++++++++++++++++
>  security/selinux/avc.c |   17 ++++++++---------
>  3 files changed, 48 insertions(+), 9 deletions(-)
> 
> --- linux-2.6.12-rc4-mm2/include/linux/audit.h.orig	2005-05-20 12:37:41.000000000 -0400
> +++ linux-2.6.12-rc4-mm2/include/linux/audit.h	2005-05-20 12:38:15.000000000 -0400
> @@ -238,6 +238,7 @@ extern uid_t audit_get_loginuid(struct a
>  extern int audit_ipc_perms(unsigned long qbytes, uid_t uid, gid_t gid, mode_t mode);
>  extern int audit_socketcall(int nargs, unsigned long *args);
>  extern int audit_sockaddr(int len, void *addr);
> +extern int audit_avc_path(struct dentry *dentry, struct vfsmount *mnt);
>  extern void audit_signal_info(int sig, struct task_struct *t);
>  #else
>  #define audit_alloc(t) ({ 0; })
> @@ -253,6 +254,7 @@ extern void audit_signal_info(int sig, s
>  #define audit_ipc_perms(q,u,g,m) ({ 0; })
>  #define audit_socketcall(n,a) ({ 0; })
>  #define audit_sockaddr(len, addr) ({ 0; })
> +#define audit_avc_path(dentry, mnt) ({ 0; })
>  #define audit_signal_info(s,t) do { ; } while (0)
>  #endif
>  
> --- linux-2.6.12-rc4-mm2/kernel/auditsc.c.orig	2005-05-20 12:37:19.000000000 -0400
> +++ linux-2.6.12-rc4-mm2/kernel/auditsc.c	2005-05-20 12:43:05.000000000 -0400
> @@ -34,6 +34,7 @@
>  #include <asm/types.h>
>  #include <linux/mm.h>
>  #include <linux/module.h>
> +#include <linux/mount.h>
>  #include <linux/socket.h>
>  #include <linux/audit.h>
>  #include <linux/personality.h>
> @@ -124,6 +125,11 @@ struct audit_aux_data_sockaddr {
>  	char			a[0];
>  };
>  
> +struct audit_aux_data_avc {

I guess it's not really avc specific (although it's primary user).

> +	struct audit_aux_data	d;
> +	struct dentry		*dentry;
> +	struct vfsmount		*mnt;
> +};
>  
>  /* The per-task audit context. */
>  struct audit_context {
> @@ -553,6 +559,11 @@ static inline void audit_free_aux(struct
>  	struct audit_aux_data *aux;
>  
>  	while ((aux = context->aux)) {
> +		if (aux->type == AUDIT_AVC) {
> +			struct audit_aux_data_avc *axi = (void *)aux;
> +			dput(axi->dentry);
> +			mntput(axi->mnt);
> +		}
>  		context->aux = aux->next;
>  		kfree(aux);
>  	}
> @@ -728,6 +739,12 @@ static void audit_log_exit(struct audit_
>  			} /* case AUDIT_SOCKADDR */
>  			break;
>  
> +		case AUDIT_AVC: {
> +			struct audit_aux_data_avc *axi = (void *)aux;
> +			if (axi->dentry)
> +				audit_log_d_path(ab, "path=", axi->dentry, axi->mnt);
> +			} /* case AUDIT_AVC */

Won't this change the order quite a bit?  And how do you correlate path
vs. exe, etc.?  Oh, I see, you're not using it for exe...

> +			break;
>  		}
>  		audit_log_end(ab);
>  
> @@ -1128,6 +1145,27 @@ int audit_sockaddr(int len, void *a)
>  	return 0;
>  }
>  
> +int audit_avc_path(struct dentry *dentry, struct vfsmount *mnt)
> +{
> +	struct audit_aux_data_avc *ax;
> +	struct audit_context *context = current->audit_context;
> +
> +	if (likely(!context))
> +		return 0;
> +
> +	ax = kmalloc(sizeof(*ax), GFP_ATOMIC);
> +	if (!ax)
> +		return -ENOMEM;
> +
> +	ax->dentry = dget(dentry);
> +	ax->mnt = mntget(mnt);
> +
> +	ax->d.type = AUDIT_AVC;
> +	ax->d.next = context->aux;
> +	context->aux = (void *)ax;
> +	return 0;
> +}
> +
>  void audit_signal_info(int sig, struct task_struct *t)
>  {
>  	extern pid_t audit_sig_pid;
> --- linux-2.6.12-rc4-mm2/security/selinux/avc.c.orig	2005-05-20 12:37:41.000000000 -0400
> +++ linux-2.6.12-rc4-mm2/security/selinux/avc.c	2005-05-20 12:39:06.000000000 -0400
> @@ -566,13 +566,10 @@ void avc_audit(u32 ssid, u32 tsid,
>  		case AVC_AUDIT_DATA_FS:
>  			if (a->u.fs.dentry) {
>  				struct dentry *dentry = a->u.fs.dentry;
> -				if (a->u.fs.mnt) {
> -					audit_log_d_path(ab, "path=", dentry,
> -							a->u.fs.mnt);
> -				} else {
> -					audit_log_format(ab, " name=%s",
> -							 dentry->d_name.name);
> -				}
> +				if (a->u.fs.mnt)
> +					audit_avc_path(dentry, a->u.fs.mnt);
> +				audit_log_format(ab, " name=%s",
> +						 dentry->d_name.name);
>  				inode = dentry->d_inode;
>  			} else if (a->u.fs.inode) {
>  				struct dentry *dentry;
> @@ -623,8 +620,10 @@ void avc_audit(u32 ssid, u32 tsid,
>  				case AF_UNIX:
>  					u = unix_sk(sk);
>  					if (u->dentry) {
> -						audit_log_d_path(ab, "path=",
> -							u->dentry, u->mnt);
> +						audit_avc_path(u->dentry, u->mnt);
> +						audit_log_format(ab, " name=%s",
> +								 u->dentry->d_name.name);
> +
>  						break;
>  					}
>  					if (!u->addr)
> 
