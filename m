Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbVIJXC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbVIJXC0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 19:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbVIJXCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 19:02:25 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:60744 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932334AbVIJXCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 19:02:25 -0400
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [git pull] InfiniBand updates
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rolandd@cisco.com>
Date: Sat, 10 Sep 2005 16:02:12 -0700
Message-ID: <523bocedcb.fsf@cisco.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 10 Sep 2005 23:02:14.0218 (UTC) FILETIME=[AEE0E2A0:01C5B65B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git

This tree is also available from kernel.org mirrors at:

    rsync://rsync.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git

This will update the following files:

 drivers/infiniband/Kconfig                |   25 +-
 drivers/infiniband/core/Makefile          |    5 
 drivers/infiniband/core/cm.c              |    5 
 drivers/infiniband/core/mad_rmpp.c        |    4 
 drivers/infiniband/core/sa_query.c        |   30 ---
 drivers/infiniband/core/ucm.c             |  289 +++++++++++++++++++-----------
 drivers/infiniband/core/ucm.h             |   11 -
 drivers/infiniband/core/uverbs.h          |   26 +-
 drivers/infiniband/core/uverbs_cmd.c      |  155 +++++++++++-----
 drivers/infiniband/core/uverbs_main.c     |   98 ++++++----
 drivers/infiniband/hw/mthca/mthca_qp.c    |   45 +++-
 drivers/infiniband/ulp/ipoib/ipoib_main.c |    2 
 include/rdma/ib_cm.h                      |    1 
 include/rdma/ib_mad.h                     |   21 ++
 include/rdma/ib_sa.h                      |   31 +++
 include/rdma/ib_user_cm.h                 |   72 +++++++
 include/rdma/ib_user_verbs.h              |   21 ++
 17 files changed, 590 insertions(+), 251 deletions(-)

through the following changes:

commit 1b205c2d2464bfecbba80227e74b412596dc5521
Author: Roland Dreier <roland@eddore.topspincom.com>
Date:   Fri Sep 9 20:52:00 2005 -0700

    [PATCH] IB: fix CM use-after-free
    
    If the CM REQ handling function gets to error2, then it frees
    cm_id_priv->timewait_info.  But the next line goes through
    ib_destroy_cm_id() -> ib_send_cm_rej() -> cm_reset_to_idle(),
    which ends up calling cm_cleanup_timewait(), which dereferences the
    pointer we just freed.  Make sure we clear cm_id_priv->timewait_info
    after freeing it, so that doesn't happen.
    
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit 354ba39cf96e439149541acf3c6c7c0df0a3ef25
Author: John Kingman <kingman@storagegear.com>
Date:   Fri Sep 9 18:23:32 2005 -0700

    [PATCH] IB CM: support CM redir
    
    Changes to CM to support CM and port redirection (REJ reason 24).
    
    Signed-off-by: John Kingman <kingman <at> storagegear.com>
    Signed-off-by: Sean Hefty <sean.hefty@intel.com>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit 63aaf647529e8a56bdf31fd8f2979d4371c6a332
Author: Roland Dreier <roland@eddore.topspincom.com>
Date:   Fri Sep 9 15:55:08 2005 -0700

    Make sure that userspace does not retrieve stale asynchronous or
    completion events after destroying a CQ, QP or SRQ.  We do this by
    sweeping the event lists before returning from a destroy calls, and
    then return the number of events already reported before the destroy
    call.  This allows userspace wait until it has processed all events
    for an object returned from the kernel before it frees its context for
    the object.
    
    The ABI of the destroy CQ, destroy QP and destroy SRQ commands has to
    change to return the event count, so bump the ABI version from 1 to 2.
    The userspace libibverbs library has already been updated to handle
    both the old and new ABI versions.
    
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit 2e9f7cb7869059e55cd91f5e23c6380f3763db56
Author: Roland Dreier <roland@eddore.topspincom.com>
Date:   Fri Sep 9 15:45:57 2005 -0700

    [PATCH] IB: Add struct for ClassPortInfo
    
    Add structure definition for ClassPortInfo format.  This is
    needed for (at least) handling CM redirects.
    
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit fbed8eee70cf7e11fbf231afafc0ccb313acc62e
Author: Hal Rosenstock <halr@voltaire.com>
Date:   Fri Sep 9 15:24:04 2005 -0700

    [PATCH] IB: Move SA attributes to ib_sa.h
    
    SA: Move SA attributes to ib_sa.h so are accessible to more than
    sa_query.c. Also, remove deprecated attributes and add one missing one.
    
    Signed-off-by: Hal Rosenstock <halr@voltaire.com>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit 1325cc79163058739b70bed9860fccbecac6236b
Author: Hal Rosenstock <halr@voltaire.com>
Date:   Fri Sep 9 13:45:51 2005 -0700

    [PATCH] IB: Define more SA methods
    
    ib_sa.h: Define more SA methods (initially for madeye decode)
    
    Signed-off-by: Hal Rosenstock <halr@voltaire.com>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit 17781cd6186cb3472ff34b2d9a15e647bd311e8b
Author: James Lentini <jlentini@netapp.com>
Date:   Wed Sep 7 12:43:08 2005 -0700

    [PATCH] IB: clean up user access config options
    
    Add a new config option INFINIBAND_USER_MAD to control whether we
    build ib_umad.  Change INFINIBAND_USER_VERBS to INFINIBAND_USER_ACCESS,
    and have it control ib_ucm and ib_uat as well as ib_uverbs.
    
    Signed-off-by: James Lentini <jlentini@netapp.com>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit b5dcbf47e10e568273213a4410daa27c11cdba3a
Author: Hal Rosenstock <halr@voltaire.com>
Date:   Wed Sep 7 11:03:41 2005 -0700

    [PATCH] IB: RMPP fixes
    
    - Fix payload length of middle RMPP sent segments. Middle payload
      lengths should be 0 on the send side.
    
      (This is perhaps a compliance and should not be an interop issue as
      middle payload lengths are supposed to be ignored on receive).
    
    - Fix length in first segment of multipacket sends
    
      (This is a compliance issue but does not affect at least OpenIB to
      OpenIB RMPP transfers).
    
    Signed-off-by: Hal Rosenstock <halr@voltaire.com>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit 30a7e8ef13b2ff0db7b15af9afdd12b93783f01e
Author: Michael S. Tsirkin <mst@mellanox.co.il>
Date:   Wed Sep 7 09:45:00 2005 -0700

    [PATCH] IB: Initialize qp->wait
    
    Add missing call to init_waitqueue_head().
    
    Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit c9fe2b3287498b80781284306064104ef9c8a31a
Author: Roland Dreier <roland@eddore.topspincom.com>
Date:   Wed Sep 7 09:43:23 2005 -0700

    [PATCH] IB: really reset QPs
    
    When we modify a QP to the RESET state, completely clean up the QP
    so that it is really and truly reset.
    
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit 0b2b35f68140ceeb1b78ef85680198e63ebc8649
Author: Sean Hefty <sean.hefty@intel.com>
Date:   Thu Sep 1 09:28:03 2005 -0700

    [PATCH] IB: Add user-supplied context to userspace CM ABI
    
    - Add user specified context to all uCM events.  Users will not retrieve
      any events associated with the context after destroying the corresponding
      cm_id.
    - Provide the ib_cm_init_qp_attr() call to userspace clients of the CM.
      This call may be used to set QP attributes properly before modifying the QP.
    - Fixes some error handling synchonization and cleanup issues.
    - Performs some minor code cleanup.
    
    Signed-off-by: Sean Hefty <sean.hefty@intel.com>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit 1d6801f9dd3ebb054ae685153a01b1a4ec817f46
Author: Michael S. Tsirkin <mst@mellanox.co.il>
Date:   Thu Sep 1 09:19:44 2005 -0700

    [PATCH] IB/sa_query: avoid unnecessary list scan
    
    Using ib_get_client_data in SA event handler performs a list scan.
    It's better to use container_of to get the sa device directly.
    
    Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit 06c56e44f3e32a859420ecac97996cc6f12827bb
Author: Michael S. Tsirkin <mst@mellanox.co.il>
Date:   Thu Sep 1 09:19:02 2005 -0700

    [PATCH] IPoIB: fix memory leak
    
    Fix IPoIB memory leak on device removal.
    
    Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>
