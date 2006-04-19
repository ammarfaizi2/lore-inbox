Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbWDSPAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbWDSPAx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 11:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWDSPAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 11:00:53 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:46546 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750829AbWDSPAw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 11:00:52 -0400
Date: Wed, 19 Apr 2006 10:00:33 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Sam Vilain <sam@vilain.net>,
       Kirill Korotaev <dev@sw.ru>, linux-kernel@vger.kernel.org,
       herbert@13thfloor.at, xemul@sw.ru, James Morris <jmorris@namei.org>
Subject: Re: [RFC][PATCH 2/5] uts namespaces: Switch to using uts namespaces
Message-ID: <20060419150033.GI7562@sergelap.austin.ibm.com>
References: <20060407095132.455784000@sergelap> <20060407183600.D025B19B8FF@sergelap.hallyn.com> <443BA062.1040208@sw.ru> <443C19C6.80706@vilain.net> <20060412050123.GA7743@sergelap.austin.ibm.com> <m1d5fn9vuk.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1d5fn9vuk.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> "Serge E. Hallyn" <serue@us.ibm.com> writes:
> 
> > Quoting Sam Vilain (sam@vilain.net):
> >> Kirill Korotaev wrote:
> >> 
> >> >Serge,
> >> >
> >> >BTW, have you noticed that NFS is using utsname for internal processes 
> >> >and in general case this makes NFS ns to be coupled with uts ns?
> >> >  
> >> >
> >> 
> >> Either that, or each NFS vfsmount has a uts_ns pointer.
> >
> > Sorry, I must be being dense.  I only see utsname being used in the case
> > of nfsroot.  Can you point me to where you're talking about?
> 
> We have the nfs lockd client code, and the sunrpc code.
> 
> I've been fighting a few a cold and some 2.6.17-rc1 bugs
> so I haven't had a chance to drill down yet to see what
> the system_utsname.nodename is actually being used for.
> 
> Until we actually understand what is happening it is too soon to
> judge if it is a problem or not.
> 
> The nfsroot is clearly not a problem.
> 
> As for the other cases I'm not certain.
> 
> So skimming through the code quickly.
> 
> include/linux/lockd/lockd.h
> > #define NLMCLNT_OHSIZE              (sizeof(system_utsname.nodename)+10)
> 
> fs/lockd/xdr.c
> > #define NLM_caller_sz		1+XDR_QUADLEN(sizeof(system_utsname.nodename))
> 
> The previous two are just sizes, so not interesting for analysis.
> 
> 
> fs/lockd/clntproc.c
> > static void nlmclnt_setlockargs(struct nlm_rqst *req, struct file_lock *fl)
> > {
> > 	struct nlm_args	*argp = &req->a_args;
> > 	struct nlm_lock	*lock = &argp->lock;
> > 
> > 	nlmclnt_next_cookie(&argp->cookie);
> > 	argp->state   = nsm_local_state;
> > 	memcpy(&lock->fh, NFS_FH(fl->fl_file->f_dentry->d_inode), sizeof(struct nfs_fh));
> > 	lock->caller  = system_utsname.nodename;
> > 	lock->oh.data = req->a_owner;
> > 	lock->oh.len  = snprintf(req->a_owner, sizeof(req->a_owner), "%u@%s",
> > 				(unsigned int)fl->fl_u.nfs_fl.owner->pid,
> > 				system_utsname.nodename);
> > 	lock->svid = fl->fl_u.nfs_fl.owner->pid;
> > 	lock->fl.fl_start = fl->fl_start;
> > 	lock->fl.fl_end = fl->fl_end;
> > 	lock->fl.fl_type = fl->fl_type;
> > }
> 
> I think this just creates a unique string with nodename+pid

In fs/lockd/svcshare.c, nlmsvc_share_file and nlmsvc_unshare_file do
compare the xdr_netobj->data field, which contains the snprinted
system_utsname.nodename.

However, if you're going to unshare utsname() and change your nodename,
the effect should be no different than if you just changed your
nodename :)  So I don't see this being a problem.

-serge
