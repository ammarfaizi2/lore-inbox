Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316089AbSGVE3N>; Mon, 22 Jul 2002 00:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316106AbSGVE3N>; Mon, 22 Jul 2002 00:29:13 -0400
Received: from palrel13.hp.com ([156.153.255.238]:26015 "HELO palrel13.hp.com")
	by vger.kernel.org with SMTP id <S316089AbSGVE3M>;
	Mon, 22 Jul 2002 00:29:12 -0400
Date: Mon, 22 Jul 2002 14:32:27 +1000
From: Martin Pool <mbp@sourcefrog.net>
To: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: NFS sillyrename possibly leaves setuid files behind
Message-ID: <20020722043226.GB5732@samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-GPG: 1024D/A0B3E88B: AFAC578F 1841EE6B FD95E143 3C63CA3F A0B3E88B
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I realize what follows is only arguably a bug, but please bear with
me.

Dan Stromberg originally raised this issue on the rsync mailing list,
but it seemed to be more of an NFS issue than an rsync one.
Basically, his situation is that he's was using rsync to update
software on a machine whose filesystem is NFS-mounted.  Some of those
updates might be security fixes, and in particular installation of new
versions of setuid/setgid programs, or deletion of setuid programs.

If any of the files being replaced/removed are in use at the time, the
client will create a .nfs* sillyrename file on the server.  I think
this will happen regardless of what tool is used for the update:
rsync, "make install", dpkg, rpm, ...

The problem from the administrator's point of view is that the old
vulnerable program is still accessible under the .nfs* name, at least
while the text is still in use.  If the client's abruptly
disconnected, then the sillyrename file could persist indefinitely, so
possibly somebody could exploit the security problem hours or days
after the administrator thought they'd updated the program.

I'm not sure what fix, if any, would be appropriate.  

One possibility would be for nfs_sillyrename to mask off the
setuid/setgid bits both locally and remotely if it moves the file, by
doing a SETATTR as well as RENAME.  That would fix this particular
problem, but at the cost of confusing anyone who does an fstat() on
the open file, etc.  You might well think it's too kludgy too.

I advised Dan to run rsync directly to the server, which works for
him, but will not work for some people because they're using e.g.
NetApp (which doesn't run rsync), or something non-Linux (so they
can't run dpkg, etc).

rsync could remove the setuid bits before replacing the file, but
that's only fixes this one tool, is perhaps even more kludgy, and
leaves a window where the program being updated is just broken.
(e.g. non-setuid passwd.)

You might also argue that the administrator should just make sure the
file is not in use; or that they should sweep for .nfs files straight
afterwards.

On the whole I think nfs_sillyrename should mask it, but I'd
completely understand if people disagreed.

-- 
Martin 
(please cc me on replies)
