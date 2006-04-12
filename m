Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbWDLGC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWDLGC5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 02:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbWDLGC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 02:02:57 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:28815 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750929AbWDLGC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 02:02:56 -0400
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Sam Vilain <sam@vilain.net>, Kirill Korotaev <dev@sw.ru>,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, xemul@sw.ru,
       James Morris <jmorris@namei.org>
Subject: Re: [RFC][PATCH 2/5] uts namespaces: Switch to using uts namespaces
References: <20060407095132.455784000@sergelap>
	<20060407183600.D025B19B8FF@sergelap.hallyn.com>
	<443BA062.1040208@sw.ru> <443C19C6.80706@vilain.net>
	<20060412050123.GA7743@sergelap.austin.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 12 Apr 2006 00:00:35 -0600
In-Reply-To: <20060412050123.GA7743@sergelap.austin.ibm.com> (Serge E.
 Hallyn's message of "Wed, 12 Apr 2006 00:01:23 -0500")
Message-ID: <m1d5fn9vuk.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Quoting Sam Vilain (sam@vilain.net):
>> Kirill Korotaev wrote:
>> 
>> >Serge,
>> >
>> >BTW, have you noticed that NFS is using utsname for internal processes 
>> >and in general case this makes NFS ns to be coupled with uts ns?
>> >  
>> >
>> 
>> Either that, or each NFS vfsmount has a uts_ns pointer.
>
> Sorry, I must be being dense.  I only see utsname being used in the case
> of nfsroot.  Can you point me to where you're talking about?

We have the nfs lockd client code, and the sunrpc code.

I've been fighting a few a cold and some 2.6.17-rc1 bugs
so I haven't had a chance to drill down yet to see what
the system_utsname.nodename is actually being used for.

Until we actually understand what is happening it is too soon to
judge if it is a problem or not.

The nfsroot is clearly not a problem.

As for the other cases I'm not certain.

So skimming through the code quickly.

include/linux/lockd/lockd.h
> #define NLMCLNT_OHSIZE              (sizeof(system_utsname.nodename)+10)

fs/lockd/xdr.c
> #define NLM_caller_sz		1+XDR_QUADLEN(sizeof(system_utsname.nodename))

The previous two are just sizes, so not interesting for analysis.


fs/lockd/clntproc.c
> static void nlmclnt_setlockargs(struct nlm_rqst *req, struct file_lock *fl)
> {
> 	struct nlm_args	*argp = &req->a_args;
> 	struct nlm_lock	*lock = &argp->lock;
> 
> 	nlmclnt_next_cookie(&argp->cookie);
> 	argp->state   = nsm_local_state;
> 	memcpy(&lock->fh, NFS_FH(fl->fl_file->f_dentry->d_inode), sizeof(struct nfs_fh));
> 	lock->caller  = system_utsname.nodename;
> 	lock->oh.data = req->a_owner;
> 	lock->oh.len  = snprintf(req->a_owner, sizeof(req->a_owner), "%u@%s",
> 				(unsigned int)fl->fl_u.nfs_fl.owner->pid,
> 				system_utsname.nodename);
> 	lock->svid = fl->fl_u.nfs_fl.owner->pid;
> 	lock->fl.fl_start = fl->fl_start;
> 	lock->fl.fl_end = fl->fl_end;
> 	lock->fl.fl_type = fl->fl_type;
> }

I think this just creates a unique string with nodename+pid


fs/lockd/mon.c
> xdr_encode_common(struct rpc_rqst *rqstp, u32 *p, struct nsm_args *argp)
> {
> 	char	buffer[20];
> 
> 	/*
> 	 * Use the dotted-quad IP address of the remote host as
> 	 * identifier. Linux statd always looks up the canonical
> 	 * hostname first for whatever remote hostname it receives,
> 	 * so this works alright.
> 	 */
> 	sprintf(buffer, "%u.%u.%u.%u", NIPQUAD(argp->addr));
> 	if (!(p = xdr_encode_string(p, buffer))
> 	 || !(p = xdr_encode_string(p, system_utsname.nodename)))
> 		return ERR_PTR(-EIO);
> 	*p++ = htonl(argp->prog);
> 	*p++ = htonl(argp->vers);
> 	*p++ = htonl(argp->proc);
> 
> 	return p;
> }

This looks like it is just general server information

fs/lockd/svclock.c
> /*
>  * Initialize arguments for GRANTED call. The nlm_rqst structure
>  * has been cleared already.
>  */
> static int nlmsvc_setgrantargs(struct nlm_rqst *call, struct nlm_lock *lock)
> {
> 	locks_copy_lock(&call->a_args.lock.fl, &lock->fl);
> 	memcpy(&call->a_args.lock.fh, &lock->fh, sizeof(call->a_args.lock.fh));
> 	call->a_args.lock.caller = system_utsname.nodename;
> 	call->a_args.lock.oh.len = lock->oh.len;
> 
> 	/* set default data area */
> 	call->a_args.lock.oh.data = call->a_owner;
> 	call->a_args.lock.svid = lock->fl.fl_pid;
> 
> 	if (lock->oh.len > NLMCLNT_OHSIZE) {
> 		void *data = kmalloc(lock->oh.len, GFP_KERNEL);
> 		if (!data)
> 			return 0;
> 		call->a_args.lock.oh.data = (u8 *) data;
> 	}
> 
> 	memcpy(call->a_args.lock.oh.data, lock->oh.data, lock->oh.len);
> 	return 1;
> }

I think this is just a uniq identifier again.

net/sunrpc/clnt.c
> /*
>  * Create an RPC client
>  * FIXME: This should also take a flags argument (as in task->tk_flags).
>  * It's called (among others) from pmap_create_client, which may in
>  * turn be called by an async task. In this case, rpciod should not be
>  * made to sleep too long.
>  */
> struct rpc_clnt *
> rpc_new_client(struct rpc_xprt *xprt, char *servname,
> 		  struct rpc_program *program, u32 vers,
> 		  rpc_authflavor_t flavor)
> {
> 	struct rpc_version	*version;
> 	struct rpc_clnt		*clnt = NULL;
> 	struct rpc_auth		*auth;
> 	int err;
> 	int len;
> 
> 	dprintk("RPC: creating %s client for %s (xprt %p)\n",
> 		program->name, servname, xprt);
> 
> 	err = -EINVAL;
> 	if (!xprt)
> 		goto out_no_xprt;
> 	if (vers >= program->nrvers || !(version = program->version[vers]))
> 		goto out_err;
> 
> 	err = -ENOMEM;
> 	clnt = kmalloc(sizeof(*clnt), GFP_KERNEL);
> 	if (!clnt)
> 		goto out_err;
> 	memset(clnt, 0, sizeof(*clnt));
> 	atomic_set(&clnt->cl_users, 0);
> 	atomic_set(&clnt->cl_count, 1);
> 	clnt->cl_parent = clnt;
> 
> 	clnt->cl_server = clnt->cl_inline_name;
> 	len = strlen(servname) + 1;
> 	if (len > sizeof(clnt->cl_inline_name)) {
> 		char *buf = kmalloc(len, GFP_KERNEL);
> 		if (buf != 0)
> 			clnt->cl_server = buf;
> 		else
> 			len = sizeof(clnt->cl_inline_name);
> 	}
> 	strlcpy(clnt->cl_server, servname, len);
> 
> 	clnt->cl_xprt     = xprt;
> 	clnt->cl_procinfo = version->procs;
> 	clnt->cl_maxproc  = version->nrprocs;
> 	clnt->cl_protname = program->name;
> 	clnt->cl_pmap	  = &clnt->cl_pmap_default;
> 	clnt->cl_port     = xprt->addr.sin_port;
> 	clnt->cl_prog     = program->number;
> 	clnt->cl_vers     = version->number;
> 	clnt->cl_prot     = xprt->prot;
> 	clnt->cl_stats    = program->stats;
> 	clnt->cl_metrics  = rpc_alloc_iostats(clnt);
> 	rpc_init_wait_queue(&clnt->cl_pmap_default.pm_bindwait, "bindwait");
> 
> 	if (!clnt->cl_port)
> 		clnt->cl_autobind = 1;
> 
> 	clnt->cl_rtt = &clnt->cl_rtt_default;
> 	rpc_init_rtt(&clnt->cl_rtt_default, xprt->timeout.to_initval);
> 
> 	err = rpc_setup_pipedir(clnt, program->pipe_dir_name);
> 	if (err < 0)
> 		goto out_no_path;
> 
> 	auth = rpcauth_create(flavor, clnt);
> 	if (IS_ERR(auth)) {
> 		printk(KERN_INFO "RPC: Couldn't create auth handle (flavor %u)\n",
> 				flavor);
> 		err = PTR_ERR(auth);
> 		goto out_no_auth;
> 	}
> 
> 	/* save the nodename */
> 	clnt->cl_nodelen = strlen(system_utsname.nodename);
> 	if (clnt->cl_nodelen > UNX_MAXNODENAME)
> 		clnt->cl_nodelen = UNX_MAXNODENAME;
> 	memcpy(clnt->cl_nodename, system_utsname.nodename, clnt->cl_nodelen);
> 	return clnt;
> 
> out_no_auth:
> 	if (!IS_ERR(clnt->cl_dentry)) {
> 		rpc_rmdir(clnt->cl_pathname);
> 		dput(clnt->cl_dentry);
> 		rpc_put_mount();
> 	}
> out_no_path:
> 	if (clnt->cl_server != clnt->cl_inline_name)
> 		kfree(clnt->cl_server);
> 	kfree(clnt);
> out_err:
> 	xprt_destroy(xprt);
> out_no_xprt:
> 	return ERR_PTR(err);
> }

This appears to be restricted to cache nodename when an rpc
connection is setup.

So I think we are ok but we need to be certain.

Eric
