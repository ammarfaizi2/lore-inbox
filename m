Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbRBIVwA>; Fri, 9 Feb 2001 16:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129448AbRBIVvv>; Fri, 9 Feb 2001 16:51:51 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:15318 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S129210AbRBIVvh>;
	Fri, 9 Feb 2001 16:51:37 -0500
Date: Fri, 9 Feb 2001 16:50:37 -0500 (EST)
From: Richard A Nelson <cowboy@vnet.ibm.com>
X-X-Sender: <cowboy@badlands.lexington.ibm.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.2.19pre{3-9} and IPC problem
Message-ID: <Pine.LNX.4.33.0102091645450.14044-100000@badlands.lexington.ibm.com>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.2.19pre3, IPC_RMID had the following change:
        case IPC_RMID:
                if (current->euid == shp->u.shm_perm.uid ||
                    current->euid == shp->u.shm_perm.cuid ||
                    capable(CAP_SYS_ADMIN)) {
                        shp->u.shm_perm.mode |= SHM_DEST;
                        if (shp->u.shm_nattch <= 0)
                                killseg (id);
+                       /* Do not find it any more */
+                       shp->u.shm_perm.key = IPC_PRIVATE;
                        break;
                }
                err = -EPERM;
                goto out;

I've two questions related to the change:
  1) Should not the two new lines have been inserted before the
     killseg() call?  It appears that killseg() will kfree() the
     storage backing shp!?!  If so, the key setting portion could
     be altering anything or faulting, no?

  2) on 2.2.19pre{7-9} I've seen occasion glitches wherein it appears
     that shm_ctl(IPC_RMID) hasn't set the key to IPC_PRIVATE, because
     an attempt to recreate the segment fails (but only sometimes).
     Has anyone else seen this?  Is it possibly related to the above
     issue?
-- 
Rick Nelson
Life'll kill ya                         -- Warren Zevon
Then you'll be dead                     -- Life'll kill ya

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
