Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422681AbWBASGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422681AbWBASGw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 13:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWBASGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 13:06:51 -0500
Received: from mx2.netapp.com ([216.240.18.37]:46708 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S932448AbWBASGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 13:06:51 -0500
X-IronPort-AV: i="4.01,245,1136188800"; 
   d="scan'208"; a="355823708:sNHT1717036660"
Subject: [GIT] NFS and RPC client fixes
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance, Inc
Date: Wed, 01 Feb 2006 13:06:47 -0500
Message-Id: <1138817207.14230.7.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
X-OriginalArrivalTime: 01 Feb 2006 18:06:49.0394 (UTC) FILETIME=[458B6120:01C6275A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the repository at

   git pull git://git.linux-nfs.org/pub/linux/nfs-2.6.git

This will update the following files through the appended changesets.

  Cheers,
    Trond

----
 fs/lockd/clntproc.c            |   11 +++-
 fs/nfs/direct.c                |    2 -
 include/linux/lockd/lockd.h    |    2 -
 include/linux/sunrpc/auth.h    |   10 ++--
 net/sunrpc/auth.c              |   25 +++++++---
 net/sunrpc/auth_gss/auth_gss.c |   40 +++++++++++-----
 net/sunrpc/auth_unix.c         |    6 +-
 net/sunrpc/rpc_pipe.c          |  102 ++++++++++++++++++++++++----------------
 8 files changed, 127 insertions(+), 71 deletions(-)

commit 00b464debf0038b1628996065f0be564ccfbfd86
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Wed Feb 1 12:49:28 2006 -0500

    SUNRPC: Remove obsolete rpcauth #defines
    
     RPCAUTH_CRED_LOCKED, and RPC_AUTH_PROC_CREDS are unused. Kill them.
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 1935245655996ca4d14e687c3a100d2e2bbdc78d
Author: Dirk Mueller <dmueller@suse.com>
Date:   Wed Feb 1 12:19:47 2006 -0500

    NFSv3: fix sync_retry in direct i/o NFS
    
     Only do a sync_retry if the memcmp failed.
    
     Signed-off-by: Dirk Mueller <dmueller@suse.com>
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit fba3bad488a2eec2d76c067edb7a5ff92ef42431
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Wed Feb 1 12:19:27 2006 -0500

    SUNRPC: Move upcall out of auth->au_ops->crcreate()
    
     This fixes a bug whereby if two processes try to look up the same auth_gss
     credential, they may end up creating two creds, and triggering two upcalls
     because the upcall is performed before the credential is added to the
     credcache.
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit adb12f63e0f837078c6832fa2c90649ddeaab54f
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Wed Feb 1 12:19:13 2006 -0500

    SUNRPC: Remove the deprecated function lookup_hash() from rpc_pipefs code
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 9842ef3557abf5ec2fd92bfa6e29ce0e271b3f6e
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Wed Feb 1 12:18:44 2006 -0500

    SUNRPC: rpc_timeout_upcall_queue should not sleep
    
     The function rpc_timeout_upcall_queue runs from a workqueue, and hence
     sleeping is not recommended. Convert the protection of the upcall queue
     from being mutex-based to being spinlock-based.
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 8a3177604b729ec3b80e43790ee978863ac7551b
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Wed Feb 1 12:18:36 2006 -0500

    SUNRPC: Fix a lock recursion in the auth_gss downcall
    
     When we look up a new cred in the auth_gss downcall so that we can stuff
     the credcache, we do not want that lookup to queue up an upcall in order
     to initialise it. To do an upcall here not only redundant, but since we
     are already holding the inode->i_mutex, it will trigger a lock recursion.
    
     This patch allows rpcauth cache searches to indicate that they can cope
     with uninitialised credentials.
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit aaaa99423b4b1f9cfd33ea5643d9274c25f62491
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Wed Feb 1 12:18:25 2006 -0500

    NLM: Ensure that nlmclnt_cancel_callback() doesn't loop forever
    
     If the server returns NLM_LCK_DENIED_NOLOCKS, we currently retry the
     entire NLM_CANCEL request. This may end up looping forever unless the
     server changes its mind (why would it do that, though?).
    
     Ensure that we limit the number of retries (to 3).
    
     See bug# 5957 in bugzilla.kernel.org.
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 16fb24252a8170799e7adf14d8fc31b817fcaf53
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Wed Feb 1 12:18:22 2006 -0500

    NLM: Fix arguments to NLM_CANCEL call
    
     The OpenGroup docs state that the arguments "block", "exclusive" and
     "alock" must exactly match the arguments for the lock call that we are
     trying to cancel.
     Currently, "block" is always set to false, which is wrong.
    
     See bug# 5956 on bugzilla.kernel.org.
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

