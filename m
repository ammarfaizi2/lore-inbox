Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265016AbSJWOVi>; Wed, 23 Oct 2002 10:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265017AbSJWOVi>; Wed, 23 Oct 2002 10:21:38 -0400
Received: from sentry.gw.tislabs.com ([192.94.214.100]:56246 "EHLO
	sentry.gw.tislabs.com") by vger.kernel.org with ESMTP
	id <S265016AbSJWOVh>; Wed, 23 Oct 2002 10:21:37 -0400
Date: Wed, 23 Oct 2002 10:27:27 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
X-X-Sender: <sds@raven>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Russell Coker <russell@coker.com.au>, <linux-kernel@vger.kernel.org>,
       <linux-security-module@wirex.com>
Subject: Re: [PATCH] remove sys_security
In-Reply-To: <20021023125907.G2732@redhat.com>
Message-ID: <Pine.GSO.4.33.0210230942210.7042-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Oct 2002, Stephen C. Tweedie wrote:

> setfsuid() creates credentials which are _only_ applied to file
> operations.  The namespace happens to be the same one that applies to
> processes, but there's nothing that requires that to be the case, and
> if you have a corresponding setfssid() to set the effective set for fs
> access, you're explicitly requesting the fs namespace, not the process
> one.

Would we need a separate call for setting the SIDs to use for each
"namespace", i.e. fs (for open, mkdir, mknod, and symlink calls), IPC
(for semget, msgget, and shmget calls), process (for execve calls), and
socket (for socket, connect, listen, sendmsg, and sendto calls, requiring
two SIDs for send*)?

Notice that there are differences in the semantics of an fsuid vs. an fs
SID if the purpose of the fs SID is for newly created files.  The fs SID
would only be used for specifying a SID other than the default transition
SID for new files, which is normally determined by the policy logic
based on a combination of the creating process' SID, the SID of the parent
directory, and the kind (security class) of file.  The fs SID should not
be used as the process' effective SID in permission checks for operations
on existing files (you can't just use a file SID and a process SID
interchangeably, unlike uids).  By default, the fs SID would need to be
"unset" (e.g. SECSID_NULL) to indicate that a default transition SID
should be computed; you would not have an equivalent to the default case
of fsuid == euid.

While your approach would work for calls that take input SID parameters,
what about the various calls that return SIDs either directly or via
output SID parameters, e.g. extended forms of *stat, msgrcv, recvmsg,
getpeername/accept plus new calls like (sem|shm|msg)sid and getsecsid?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




