Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316855AbSGSQVX>; Fri, 19 Jul 2002 12:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316883AbSGSQVX>; Fri, 19 Jul 2002 12:21:23 -0400
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:2440 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S316855AbSGSQVR>;
	Fri, 19 Jul 2002 12:21:17 -0400
Subject: Re: more thoughts on a new jail() system call
From: Shaya Potter <spotter@cs.columbia.edu>
To: linux-kernel@vger.kernel.org
In-Reply-To: <ah7m2r$3cr$1@abraham.cs.berkeley.edu>
References: <1026959170.14737.102.camel@zaphod> 
	<ah7m2r$3cr$1@abraham.cs.berkeley.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 19 Jul 2002 12:24:07 -0400
Message-Id: <1027095858.2634.48.camel@zaphod>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-18 at 20:21, David Wagner wrote:
> Shaya Potter  wrote:
> >sys_mknod) J - Need FIFO ability, everything else not.
> 
> Beware the ability to pass file descriptors across Unix
> domain sockets.  This should probably be restricted somehow.
> Along similar lines, you didn't mention sendmsg() and
> recvmsg(), but the fd-passing parts should probably be
> restricted.

as others said, fifo's should only work inside a jail.

could sendmsg and recvmsg possibly be a problem in this scenario? - hack
jail, hack local machine, have process on local machine communicate with
process in jail passing fds?

> 
> >sys_setuid16) ^J - since jail is secure, can setuid all you want.
> 
> I'd look very carefully at whether root can bypass any
> of the access controls you're relying on.  For instance,
> with root, one can bind to ports below 1024.

the whole point is too allow things like that safely.

> 
> >sys_ioctl) J - disallowed, but perhaps if devices recognize jails and
> >filter commands based on that... 
> 
> In my experience building jails (see Janus), this will
> be a problem.  There are a small number of ioctl()s that
> are widely used by applications.  To give some examples,
> I find that we needed to allow TIOCGPGRP, FIONBIO, and
> FIONREAD (they seem safe).  Also, I found that lots of
> real apps use TCGETS, TCSETS, and TIOCSPGRP; unfortunately,
> I'm not too sure whether these are safe.

Right, some of this might be need to be virtualized. we might need to
expand on FreeBSD's prison (internal) struct to store information like
this.  But haven't had a chance to go through ioctl's yet.  

Is it a problem to allow ioctls that reguler users can do?  We might
need to filter the options passed, but if we eliminated all ioctls that
only root could use, would probably be a start.

> 
> However, I agree that most ioctl()s are probably dangerous.
> Maybe a reasonable stance is to deny all ioctl()s by default,
> and have a few exceptions for known-safe ioctl()s to be allowed.

agree.

> 
> >sys_fcntl) F
> 
> Some fcntl() calls are unsafe.  For instance, F_SETOWN may
> give a backdoor way to send signals to processes outside
> the jail.

so these have to be filtered.

> 
> >sys_olduname) - P
> 
> I'd argue that this should be restricted, on general
> principles.  (General principle: A jailed process shouldn't
> be able to learn anything about the host it's running on.)

and as other said (as as I was sort of planning, and mentioned by other
uname like functions, virtualizing is beneficial here)

> 
> >sys_getcwd) C
> >sys_ustat) J - Do we want a jailed process getting this info?
> >sys_statfs) NOT SURE - should a jail process be able to get info on
system?
> >sys_fstatfs) same as statfs
> >sys_sysfs) J - info on local system?
> 
> It's probably not critical, but I'd argue that these should
> be denied, on general principles, unless there is some
> reason to think it will be very useful.  getcwd() is probably
> the most critical to deny, as it can give away detailed
> information in some cases.

as others mentioned cwd isn't a problem as chroot'd.  for the others, I
dont know, some seem to think its usefull.

> 
> (General principle: If you're in a jail, you shouldn't be
> able to learn any information about where that jail resides
> on the filesystem.)

I agree.  hence virtulize certian things.

> 
> >sys_stat) C
> 
> Similarly, I'd argue that st_dev maybe should be restricted.

what do you mean?

> 
> >sys_getppid) P
> >sys_getpgid) P
> 
> What if the parent process is outside the jail?  Does it
> cause any harm to disclose the parent pid?  I'm not sure...

everything will be parented at minimum to 1.  The trick is, things
shouldn't be able to be jailed after the fact, but should have to be
created inside the jail.  So it may be needed to break bsd's jail
semantics, and make jail a sort of exec like call.

> 
> >sys_setsid) NOT SURE - no clue what this really does
> 
> I think it's probably ok, but I'm not 100% sure, either.
> 
> >sys_socketcall) J - Bind seems to be the only problem. jail()
includes
> >an ip address, and a jailed process can only bind to that address. so
> >do we force the addr to be this address, or does one allow INADDR_ANY
> >and translate that to the jail'd ip address?
> 
> The most interesting part is whether connect()
> and sendto() should also be restricted.  I think
> restrictions on access to the network are going
> to be critical to security: it is the #1 easiest
> way to escape from a jail, if there are no restrictions
> on connect() and the like.  In principle, we could
> use IP Chains for this, though in practice, I suspect
> most callers to jail() will forget to set up appropriate
> IP filtering.  I wonder if there is any way to
> reduce the likelihood of this failure mode and keep
> programmers honest?

how could one use connect() to escape from the jail? I couldn't think of
any, but i'm probably missing something obvious.  

> 
> Also, socket() should probably be restricted to
> prevent creation of raw IP and PF_PACKET sockets
> and the like (sending forged traffic, sniffing
> on local traffic).

hmm, good point, but not sure that's in the scope of a jail.  jail is
there to limit damage to local system if its cracked, cracking a jail is
like cracking a vmware vm, you can do all you want inside, but cant get
out.

> 
> The SO_BINDTODEVICE and IP_HDRINCL socket option
> should probably be restricted.

BINDTODEVICE obviously, HDRINCL related to raw sockets, not sure this is
not in the scope of jail.

> 
> Also, are there any implications of SO_PASSCRED,
> SO_PEERCRED, SCM_RIGHTS, SCM_CREDENTIALS, SO_DEBUG,
> SO_REUSEADDR, IP_OPTIONS, IP_PKTINFO?

ok, I'll look into those.

> 
> See also sendmsg() and recvmsg() fd-passing.

dont know enough about fd-passing I've decided, where do I read up on
this.  Most of what I know about fd's are as an int, and the kernel
keeps track of what int goes to what file, so not sure how its a
problem.

> 
> >sys_syslog) NOT SURE (probably jailed away)
> 
> sys_syslog touches a global shared resource, hence
> should probably be denied to jailed processes.

or virtualized.

> 
> >sys_vhangup) NOT SURE -  Should be fine, right?
> 
> Seems ok to me.
> 
> >sys_fsync) NOT SURE - same as sync
> >sys_fdatasync) NOT SURE - probably same as other syncs.
> 
> The *sync*() calls seem ok to me.
> 
> >sys_getsid) NOT SURE - whats it for?
> 
> You shouldn't be able to call getsid() on some other
> process outside the jail.  Also, calling getsid() on
> yourself might reveal information about your parent,
> like getppid() or getpgid() (minor).

yes, thats what we were planning for things like getppid, and see my
comment about jail() perhaps being like exec.

