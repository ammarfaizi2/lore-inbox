Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279305AbRKFNzE>; Tue, 6 Nov 2001 08:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279313AbRKFNy4>; Tue, 6 Nov 2001 08:54:56 -0500
Received: from mons.uio.no ([129.240.130.14]:10204 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S279305AbRKFNyj>;
	Tue, 6 Nov 2001 08:54:39 -0500
To: Bob Smart <smart@hpc.CSIRO.AU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Red Hat needs this patch (was Re: handling NFSERR_JUKEBOX)
In-Reply-To: <200111061036.VAA07886@trout.hpc.CSIRO.AU>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 06 Nov 2001 14:54:24 +0100
In-Reply-To: <200111061036.VAA07886@trout.hpc.CSIRO.AU>
Message-ID: <shsg07sknsf.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Bob Smart <smart@hpc.CSIRO.AU> writes:

     > Maybe there is a subset of servers for which the patch is OK,
     > and we could make that clear in the help for the config
     > option. I'll ask Cray for clarification about their server.

I'm still not convinced this is a good idea, but if you are going to
do things inside the NFS client, why don't you instead write a wrapper
function around rpc_call_sync() for fs/nfs/nfs3proc.c. Something like

static int
nfs_rpc_wrapper(struct rpc_clnt *clnt, struct rpc_message *msg, int flags)
{
        sigset_t oldset;
        int res;
        rpc_clnt_sigmask(clnt, &oldset);
        do {
                res = rpc_call_sync(clnt, msg, flags);
                if (result != -EJUKEBOX)
                        break;
                set_current_state(TASK_INTERRUPTIBLE);
                schedule_timeout(NFS_JUKEBOX_RETRY_TIME);
                res = -ERESTARTSYS;
        } while (!signalled());
        rpc_clnt_sigunmask(clnt, &oldset);
        return res;
}

and then use a couple of '#define's to wrap rpc_call() and
rpc_call_sync() in nfs3_proc_*(). That will take care of all those
synchronous calls in one fell swoop.

You'll still need to take care of asynchronous reads, writes and
unlink, but those are easy. Just do something like

if (task->tk_error == -EJUKEBOX) {
        rpc_delay(task, NFS_JUKEBOX_RETRY_TIMEO);
        rpc_restart_call(task);
        return;
}

in nfs_readpage_result(), nfs_writeback_done(), nfs_commit_done(), and
nfs_async_unlink_done()...

Cheers,
   Trond
