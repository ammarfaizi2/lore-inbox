Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312962AbSHGUpN>; Wed, 7 Aug 2002 16:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312619AbSHGUpM>; Wed, 7 Aug 2002 16:45:12 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:9041 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S313508AbSHGUok>; Wed, 7 Aug 2002 16:44:40 -0400
Date: Wed, 7 Aug 2002 15:48:15 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200208072048.PAA04274@tomcat.admin.navo.hpc.mil>
To: Gregoryg@ParadigmGeo.com,
       "'trond.myklebust@fys.uio.no'" <trond.myklebust@fys.uio.no>
Subject: RE: O_SYNC option doesn't work (2.4.18-3)
Cc: "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> 
> >Furthermore, even with 'noac' they *all* have problems with races in
> >the sort of scenario you describe because there is no atomic
> >GETATTR+READ operation.
> >
> >Bottom line: If you want the sort of data cache consistency you are
> >describing, you *have* to use file locking.
> File locking, meaning lockd? There are so many problems with file locking in
> heterogeneous environments that we were moving towards dropping its usage.
> Instead, we planned to use some home grown TCP based lock server mechanism. 
> 
> I understand that locking file flushes NFS cache, isn't it? Why can't it be
> flushed by O_SYNC and "sync" options presence? This would make the life much
> easier for programmers...
> 
> This means that we will never be able to drop lockd locking and at the same
> time achieve file consistency via NFS?

NO. no and no.

It depends on the protocol. NFS v2 does no locking whatsoever. lockd was
created to have some shared locks to allow the APPLICATION to flush buffers,
but I don't think the daemon could force any of the NFS daemons (nfsd/biod)
to flush anything.

NFS v3 allows better traffic formation (using TCP). But I don't remember
locking being included either. I think that is aimed at NFS v4.

None of the versions of NFS are race free. This is due to the requirement
that NFS be layered on top of a real file system. Anything that goes
directly to the underlying file system will always beat out a remote NFS
client.

There never was any such thing as "cache coherency" in NFS. And there won't
be - the overhead is way too high. Think- to lock a section of a file,
you first tell the local daemon. That local daemon must then contact the
remote file server. That file server must then contact EVERY client to verify
that a lock is not in the process of being established. And confirm that the
locked section just hasn't yet been flushed back to the server. Then the server
can tell the client the section is locked.

What happens when one of the clients is down....
How long do you wait to determine a client is down...
What happens to other clients while the client holding the lock is down...
What happens when the server goes down....
What happens when the down client comes back up....
What happens when the server comes back up....
How do you request all clients to re-acquire locks... (and in what order)

And remember... NFS is a stateless protocol. No additional information about
currently open files can be saved by the clients or the server (daemons, not
applications). This makes NFS recovery much faster, but is a complete failure
at lock support. The file handles that are passed out on file open are not
foolproof. A server failure may require the clients to dismount/remount/reopen
the file to get a new/updated file handle. And this is on each block access.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
