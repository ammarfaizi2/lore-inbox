Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135829AbRAJPSt>; Wed, 10 Jan 2001 10:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135859AbRAJPSj>; Wed, 10 Jan 2001 10:18:39 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:34629 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S135839AbRAJPSh>; Wed, 10 Jan 2001 10:18:37 -0500
Date: Wed, 10 Jan 2001 09:18:35 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200101101518.JAA57008@tomcat.admin.navo.hpc.mil>
To: phillips@innominate.de, Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        linux-kernel@vger.kernel.org
Subject: Re: FS callback routines
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> Jesse Pollard wrote:
> > Daniel Phillips <phillips@innominate.de>:
> > > This may be the most significant new feature in 2.4.0, as it allows us
> > > to take a fundamentally different approach to many different problems.
> > > Three that come to mind: mail (get your mail instantly without polling);
> > > make (don't rely on timestamps to know when rebuilding is needed, don't
> > > scan huge directory trees on each build); locate (reindex only those
> > > directories that have changed, keep index database current).  As you
> > > noticed, there are many others.
> > > ...
> > 
> > It would also be very nice if the security of the feature could be
> > confirmed. The problem with SGI's implementation is that it becomes
> > possible to monitor files that you don't own, don't have access to,
> > or are not permitted to know even exist.
> 
> To receive notification about events in a given directory you have to be
> able to open it.  Is this adequate for your needs?

It depends on the implementation - One problem is that you may be able
to open the directory at the time you start monitoring, then the permission
is removed. Most implementations do not recheck access rights on each
notification (fair amount of overhead).

My belief is (and I could be wrong) that most such callbacks are done by
placing a watch list on/for a device:inode identifier. When activity on
a matching device:inode occurs, the matching callback is invoked. No path name
access rights rechecking is performed since the scan of the path could
easily overwhelm the the operation being performed on the file.

The only guard would be the path scan done at the time the callback is
established. The justification is that "It's just like opening a file, the
access rights are checked on open". A callback is not an open, UNLESS callbacks
can only be placed on open file id's.

In SGI's case, the file alteration monitor (a daemon) performs this activity
while running as root, and providing RPC access to remote systems. This RPC
is unauthenticated, permitting non-local users to track files that exist on
local hosts. Since RPC cannot verify the identity of the remote user, it
permits tracking of ANY file on the system (via RPC spoofing of user identity
in the RPC call).

This was determined to be A Bad Thing, and not allowed.

> > For these reasons, we have disabled the feature.
> 
> It's nice to have that option, isn't it? ;-)

It would be if it could be done in a secure manner.

Also usefull (after callbacks work): an extension to callbacks to allow
catching file read/write/seek/truncate/ioctl actions, and being able to
perform actions on behalf of the owner of the file (as an implementation
of the original action). This might reqire the user to provide a "daemon"
to monitor the file, or to be activated by a callback established by the
owner of the file. (I know, there is a lot to consider when implementing
something like this - process environment, what executable is to be run
to do this, the interface to getting the users request/returning results..)

Use: ability to provide customized versions of the file based on the identity
of the user that opened the file - fields could be hidden/generated, queries
could be passed (via ioctl). This could provide a simple way to implement
a small data manager, but without the overhead (ie $$$) for a data base system
or the complexity of establishing a data base style client-server.

I do think such an extension should be permitted/denied based on a capability
though.

Ahh well, rambling ideas....

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
