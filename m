Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267678AbUHaVBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267678AbUHaVBs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 17:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267540AbUHaUeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 16:34:36 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:35803 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269029AbUHaU2r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 16:28:47 -0400
Subject: flock affects local node only traditionally and applications expect
From: Steve French <smfltc@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-cifs-client@lists.samba.org
Content-Type: text/plain
Organization: IBM
Message-Id: <1093983929.8640.36.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 31 Aug 2004 15:25:29 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> flock affects local node only traditionally and applications 
> expect high performance from it. Our documentation merely says
>
>       flock(2) does not lock files over NFS.Use fcntl(2) instead:

I remember, in the days before Linux (BL), when the only apps that
cared about file locking were the ones running over the (and not just 
Novell, DOS, OS/2, Windows) networks (because local apps had other mechanisms
to serialize but it was one of the few decent ways to serialize when
you had an app run from multiple clients at the same time) ...

The man page also notes that in earlier versions of Linux 
that flock used to work over the network (since it used to be mapped
to fcntl),  but I read the reasons for the change as a semantic issue
between BSD/POSIX locks.  If the real issue is instead performance issues
then individual filesystems could make it a mount option for NFS, 
CIFS, GFS or any other filesystem that wants to map them to
support local semantics.  But given the increase in network performance,
why not optionally allow flock - it is reasonable to assume that some users
have apps that would benefit from local file lock semantics over the network
and that we should allow users to experience (as close to) local
semantics over network filesystems as the corresponding network
protocol (over the wire) could allow (at least as a mount option).  
I am curious what the other Samba guys think about adding this minor 
optional extension to the wire protocol.

The other issue that came up in the earlier discussion of these was Ken's
question about why should the client VFS manage a local copy of the lock
when the server side already will be doing that.  The client VFS has to be
able to keep the lock state to attempt to replay locks on a server crash, 
but the VFS on the client machine would not have to enforce the lock
semantics - not just because redundancy may slow things down (that is a trivial
performance penalty) but since the client copy of the lock state will 
often be stale if multiple clients are locking the file.  For mandatory
locks the correct semantics are more difficult to enforce (only) on
the server since reads/writes frequently go to the copy of the data in the
local page cache and never make it to the server.

Also ... is there a good writeup on any subtle semantic
differences between flock and fcntl locks?

