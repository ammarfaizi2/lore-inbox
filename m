Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261473AbREUNis>; Mon, 21 May 2001 09:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261462AbREUNi2>; Mon, 21 May 2001 09:38:28 -0400
Received: from pat.uio.no ([129.240.130.16]:42468 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S261459AbREUNiT>;
	Mon, 21 May 2001 09:38:19 -0400
MIME-Version: 1.0
Message-ID: <15113.6718.559887.978482@charged.uio.no>
Date: Mon, 21 May 2001 15:38:06 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Matt Chapman <matthewc@cse.unsw.edu.au>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        NFS maillist <nfs@lists.sourceforge.net>
Subject: Another bug? linux/fs/nfs/write.c
In-Reply-To: <20010521142400.A7229@cse.unsw.edu.au>
In-Reply-To: <20010521142400.A7229@cse.unsw.edu.au>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,
  The following mail from Matt describes a problem in the NFS
read/write code that can cause a vicious hang. Obvious patch to fix it
is attached...

Cheers,
   Trond

>>>>> " " == Matt Chapman <matthewc@cse.unsw.edu.au> writes:

     > Trond, Here's another bug which seems to be causing crashes.

     > nfs_update_request keeps calling nfs_wait_on_request until the
     > request can be locked.  Presumably it's relying on
     > nfs_wait_on_request to schedule, and hence run rpciod to
     > retransmit any lost requests.  However, if the fs is mounted
     > with the intr option and a signal has arrived, then
     > nfs_wait_on_request (ultimately, wait_event_interruptible)
     > returns immediately with -ERESTARTSYS, and the loop spins.

     > Presumably nfs_update_request needs to check the return value
     > of nfs_wait_on_request and return right up the chain on
     > -ERESTARTSYS.  However, since I don't know this code very well,
     > I'd prefer it if you had a look at it and gave some advice.

diff -u --recursive --new-file linux-2.4.5-fixes/fs/nfs/write.c linux-2.4.5-write/fs/nfs/write.c
--- linux-2.4.5-fixes/fs/nfs/write.c	Mon May 21 11:34:51 2001
+++ linux-2.4.5-write/fs/nfs/write.c	Mon May 21 13:18:47 2001
@@ -863,9 +863,12 @@
 		req = _nfs_find_request(inode, page);
 		if (req) {
 			if (!nfs_lock_request(req)) {
+				int error;
 				spin_unlock(&nfs_wreq_lock);
-				nfs_wait_on_request(req);
+				error = nfs_wait_on_request(req);
 				nfs_release_request(req);
+				if (error < 0)
+					return ERR_PTR(error);
 				continue;
 			}
 			spin_unlock(&nfs_wreq_lock);
