Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263897AbTEFPxQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 11:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263902AbTEFPxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 11:53:15 -0400
Received: from pat.uio.no ([129.240.130.16]:64983 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263897AbTEFPxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 11:53:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16055.56630.615496.19679@charged.uio.no>
Date: Tue, 6 May 2003 18:05:10 +0200
To: Michael Buesch <fsdeveloper@yahoo.de>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, neilb@cse.unsw.edu.au,
       nfs@lists.sourceforge.net, "Lever, Charles" <Charles.Lever@netapp.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Zeev Fisher <Zeev.Fisher@il.marvell.com>
Subject: Re: [NFS] processes stuck in D state
In-Reply-To: <200305061742.14032.fsdeveloper@yahoo.de>
References: <200305061652.13280.fsdeveloper@yahoo.de>
	<shsel3c85ks.fsf@charged.uio.no>
	<200305061742.14032.fsdeveloper@yahoo.de>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Michael Buesch <fsdeveloper@yahoo.de> writes:


     > To reproduce the problem:
     > - - mount some nfs from a server in your lan.
     > - - Open an app, that uses the mounted fs. I've simply opened a
     >   konqueror-window for the directory where the nfs is mounted.
     > - - shut down or crash the server or just pull the
     >     network-cable.
     > - - Now the konqueror-process is nonkillable in D
     >     state. There's no
     >   chance to kill it.

Unless you are using the 'intr' or 'soft' mount flags, then that is
*documented and expected* behaviour.

It is true that even when using the 'intr' mount flag, you don't
always succeed in killing a task that is hanging on NFS. That is
usually due to the fact that it is waiting on some semaphore that is
held by another process. semaphores always sleep in the
TASK_UNINTERRUPTIBLE state, so they cannot be signalled.
Linus has suggested a solution to this problem: to set up a special
class of semaphores that are killable with 'SIGKILL', but doing that
(and then replacing all those semaphores in the VFS and VM) is not
going to happen before 2.7.x. at the earliest.

However, as I've mentioned on this list *many* times before: there
exists a workaround if you are wanting to kill all processes in order
to unmount the partition:
  kill -9 all the processes.
  kill -9 rpciod.

Cheers,
  Trond
