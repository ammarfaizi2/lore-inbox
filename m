Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318407AbSGSAea>; Thu, 18 Jul 2002 20:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318411AbSGSAe3>; Thu, 18 Jul 2002 20:34:29 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:36357 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP
	id <S318407AbSGSAe2>; Thu, 18 Jul 2002 20:34:28 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: more thoughts on a new jail() system call
Date: 19 Jul 2002 00:21:47 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <ah7m2r$3cr$1@abraham.cs.berkeley.edu>
References: <1026959170.14737.102.camel@zaphod>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1027038107 3483 128.32.153.211 (19 Jul 2002 00:21:47 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 19 Jul 2002 00:21:47 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaya Potter  wrote:
>sys_mknod) J - Need FIFO ability, everything else not.

Beware the ability to pass file descriptors across Unix
domain sockets.  This should probably be restricted somehow.
Along similar lines, you didn't mention sendmsg() and
recvmsg(), but the fd-passing parts should probably be
restricted.

>sys_setuid16) ^J - since jail is secure, can setuid all you want.

I'd look very carefully at whether root can bypass any
of the access controls you're relying on.  For instance,
with root, one can bind to ports below 1024.

>sys_ioctl) J - disallowed, but perhaps if devices recognize jails and
>filter commands based on that... 

In my experience building jails (see Janus), this will
be a problem.  There are a small number of ioctl()s that
are widely used by applications.  To give some examples,
I find that we needed to allow TIOCGPGRP, FIONBIO, and
FIONREAD (they seem safe).  Also, I found that lots of
real apps use TCGETS, TCSETS, and TIOCSPGRP; unfortunately,
I'm not too sure whether these are safe.

However, I agree that most ioctl()s are probably dangerous.
Maybe a reasonable stance is to deny all ioctl()s by default,
and have a few exceptions for known-safe ioctl()s to be allowed.

>sys_fcntl) F

Some fcntl() calls are unsafe.  For instance, F_SETOWN may
give a backdoor way to send signals to processes outside
the jail.

>sys_olduname) - P

I'd argue that this should be restricted, on general
principles.  (General principle: A jailed process shouldn't
be able to learn anything about the host it's running on.)

>sys_getcwd) C
>sys_ustat) J - Do we want a jailed process getting this info?
>sys_statfs) NOT SURE - should a jail process be able to get info on system?
>sys_fstatfs) same as statfs
>sys_sysfs) J - info on local system?

It's probably not critical, but I'd argue that these should
be denied, on general principles, unless there is some
reason to think it will be very useful.  getcwd() is probably
the most critical to deny, as it can give away detailed
information in some cases.

(General principle: If you're in a jail, you shouldn't be
able to learn any information about where that jail resides
on the filesystem.)

>sys_stat) C

Similarly, I'd argue that st_dev maybe should be restricted.

>sys_getppid) P
>sys_getpgid) P

What if the parent process is outside the jail?  Does it
cause any harm to disclose the parent pid?  I'm not sure...

>sys_setsid) NOT SURE - no clue what this really does

I think it's probably ok, but I'm not 100% sure, either.

>sys_socketcall) J - Bind seems to be the only problem. jail() includes
>an ip address, and a jailed process can only bind to that address. so
>do we force the addr to be this address, or does one allow INADDR_ANY
>and translate that to the jail'd ip address?

The most interesting part is whether connect()
and sendto() should also be restricted.  I think
restrictions on access to the network are going
to be critical to security: it is the #1 easiest
way to escape from a jail, if there are no restrictions
on connect() and the like.  In principle, we could
use IP Chains for this, though in practice, I suspect
most callers to jail() will forget to set up appropriate
IP filtering.  I wonder if there is any way to
reduce the likelihood of this failure mode and keep
programmers honest?

Also, socket() should probably be restricted to
prevent creation of raw IP and PF_PACKET sockets
and the like (sending forged traffic, sniffing
on local traffic).

The SO_BINDTODEVICE and IP_HDRINCL socket option
should probably be restricted.

Also, are there any implications of SO_PASSCRED,
SO_PEERCRED, SCM_RIGHTS, SCM_CREDENTIALS, SO_DEBUG,
SO_REUSEADDR, IP_OPTIONS, IP_PKTINFO?

See also sendmsg() and recvmsg() fd-passing.

>sys_syslog) NOT SURE (probably jailed away)

sys_syslog touches a global shared resource, hence
should probably be denied to jailed processes.

>sys_vhangup) NOT SURE -  Should be fine, right?

Seems ok to me.

>sys_fsync) NOT SURE - same as sync
>sys_fdatasync) NOT SURE - probably same as other syncs.

The *sync*() calls seem ok to me.

>sys_getsid) NOT SURE - whats it for?

You shouldn't be able to call getsid() on some other
process outside the jail.  Also, calling getsid() on
yourself might reveal information about your parent,
like getppid() or getpgid() (minor).
