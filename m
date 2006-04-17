Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbWDQQDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbWDQQDP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 12:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWDQQDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 12:03:15 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:59094 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750962AbWDQQDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 12:03:14 -0400
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: =?ISO-8859-1?Q?T=F6r=F6k?= Edwin <edwin@gurde.com>
Cc: linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>,
       linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net
In-Reply-To: <200604142301.10188.edwin@gurde.com>
References: <200604021240.21290.edwin@gurde.com>
	 <200604072138.35201.edwin@gurde.com>
	 <1144863768.32059.67.camel@moss-spartans.epoch.ncsc.mil>
	 <200604142301.10188.edwin@gurde.com>
Content-Type: text/plain; charset=utf-8
Organization: National Security Agency
Date: Mon, 17 Apr 2006 12:06:53 -0400
Message-Id: <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-14 at 23:01 +0300, Török Edwin wrote:
> Would there be a reason to implement floating labels in SELinux?

Unclear.  CMWs and the Posix.1e draft had floating information labels,
but they were separate from the access control label.  So if implemented
in SELinux, they would be a separate field of the incore security
structures and, if required to persist, they would be a separate xattr
name/value pair.  They wouldn't be used for access control checking by
SELinux internally.  One would have to define the meaning of floating
for TE (or your scheme), as they aren't hierarchical.  Traditional
hierarchical floating labels track reads and writes, e.g. process
information label floats up upon reads to dominate the information label
of the object, and the object information label floats up upon writes to
dominate the information label of the writing process, so that if P
copies from object A to object B, object B ends up with an information
label at least as high as object A.  Whether or not this is useful has
been a subject of debate.

> How can I substitute floating labels (i.e. what would be its closest 
> approximation)?

Ideally, you would just predefine your control requirements, as below,
and enforce that via SELinux policy rather than trying to separately
track the data flow via LSM and enforce some kind of restriction via
your userspace component+netfilter module.  Also see the Security
marking RFC posted by James Morris to netdev.

> Functional requirement:
> - be able to control/know which programs have access to the internet
> - be able to control/know which processes have access to a certain socket
> - be able to control/know which processes share a socket, and which processes 
> are the only ones accessing a socket
> 
> I used the term 'control/know', because I don't actually want to restrict the 
> applications by using fireflier lsm, I just want it to provide information to 
> its userspace part.

Hmmm...well, the control requirements above can be met by SELinux, just
not in the manner you are trying to meet them, as SELinux already labels
and controls use of sockets and access to ports, nodes (hosts), and
network interfaces.

> -- plan for fireflier SELinux integration (fireflier target version 2.1)---
> 
> Possible approaches I thought of:
> 1)  put programs needing to share a socket in the same domain, and match based 
> on the domain of the socket. But what happens if a program would need to be 
> in 2  or more domains (xinetd comes to mind)

The processes don't have to be in the same domain to share the socket;
SELinux policy already allows you to permit one domain to
inherit/receive and use sockets created by another domain if so
configured.  

> But a problem remains: if there is a base policy that sets a context on a 
> program, and  my module would try to set a domain for it too, won't they 
> conflict?

You could extend the definition of the existing domain via your module
if that fits your needs.  As the base policy becomes more modularized,
you could replace the particular module entirely with your own if that
is necessary.

> 2) each program has its own domain, and xinetd is in a domain of its own, but 
> it has access to all the sockets of its childs (domains). The same for 
> postfix
> Also run selinux in non-enforcing mode, with avc logging turned off. I only 
> need labeling, not restrictions.

But you do need restrictions (on network access); you just want to
implement them yourself for some reason rather than using the existing
SELinux controls.  Not clear why.

> 3)Or should I assume, that if a user has a base policy set up, he has 
> configured that properly, and only those programs share sockets, that he 
> intends to?
> In this case fireflier would need to do only this:
> - if selinux is disabled, then run a policy generator, that generates a base 
> policy (not necessarely a module). fireflier will make sure user runs with 
> selinux enabled, avc logging off, enforcing off
> - if selinux is enabled, fireflier won't do shared socket checks, assuming 
> that the policy will limit the sharing of sockets

Depends on whether you want your tool to continue to be useful for
systems using SELinux.

> Important question: can a file's context be set from the policy? 
> (without using setfiles, to relabel the file, the user might want to enable 
> selinux later, I don't want to mess up his labeling)
> (this might sound silly: can a define a default auto-transition to a context?)

Certain defaults are provided from policy, but the per-file labeling
comes from the xattrs.  Newly created files are assigned an initial
label by the kernel (both incore and xattr) based on policy by default,
or optionally overridden by application request (still subject to policy
control).

> To have all tasks assigned a security structure, fireflier lsm needs to be 
> compiled into the kernel.

Yes.  So?

> I thought of this, see label_all_processes. Unfortunately I found no way of 
> actually doing this. I would need to iterate through the tasklist structure, 
> but the task_lock export is going to be removed from the kernel.

So, if built-in isn't an option, propose an interface to the core
security framework to allow security modules to perform such
initialization without needing to directly touch the lock themselves
(i.e. they just call the function provided by the security framework,
and let it deal with taking the lock if that is appropriate).  Not the
same as exporting the lock directly to all modules for arbitrary misuse.

> Locking added. I use a lock every time the inode's sid is modified.

Except that your lock does no good.  See below.

> diff -uprN null/hooks.c fireflier_lsm/hooks.c
> --- null/hooks.c	1970-01-01 02:00:00.000000000 +0200
> +++ fireflier_lsm/hooks.c	2006-04-14 22:53:40.000000000 +0300

> +static void inode_update_perm(struct task_struct *tsk,struct inode *inode)
> +{
> +	struct fireflier_task_security_struct *tsec;
> +	struct fireflier_inode_security_struct *isec;
> +        u32 sid;
> +   
> +     	tsec = tsk->security;
> +   	isec = inode->i_security;
> +   	if(!isec) 
> +     		return;
> +   
> +        if(unlikely(!tsec))
> +       		sid = compute_inode_sid(isec->sid,FIREFLIER_SID_UNLABELED);
> +   	else
> +     		sid = compute_inode_sid(isec->sid,tsec->sid);
> +        spin_lock(&isec->sid_lock);
> +        isec->sid=sid;     
> +        spin_unlock(&isec->sid_lock);

The above locking is useless.
T1:	sid = compute_inode_sid(isec->sid, tsec->sid)
T2: 	sid = compute_inode_sid(isec->sid, tsec->sid)
T1:	lock; isec->sid = sid; unlock
T2:	lock; isec->sid = sid; unlock
You lose T1's information that way.

> +static void fireflier_socket_post_create(struct socket *sock, int family,
> +					 int type, int protocol, int kern)
> +{
> +	struct fireflier_inode_security_struct *isec;
> +	struct fireflier_task_security_struct *tsec = current->security;
> +        struct inode* inode=SOCK_INODE(sock);
> +   
> +	secondary_ops->socket_post_create(sock,family,type,protocol,kern);
> +	
> +        inode_alloc_security(inode);
> +	isec = inode->i_security;
> +   
> +        spin_lock(&isec->sid_lock);
> +	isec->sid = kern ? FIREFLIER_SECINITSID_KERNEL : tsec->sid;
> +        spin_unlock(&isec->sid_lock);

Shouldn't be necessary here, right, as the socket isn't yet accessible
to any other thread?  Likewise for the accept case?  Only when you are
mutating it after it becomes accessible to userspace.

-- 
Stephen Smalley
National Security Agency

