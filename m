Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278313AbRJVI2Z>; Mon, 22 Oct 2001 04:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278281AbRJVI2P>; Mon, 22 Oct 2001 04:28:15 -0400
Received: from pat.uio.no ([129.240.130.16]:2204 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S278275AbRJVI2A>;
	Mon, 22 Oct 2001 04:28:00 -0400
To: "H . J . Lu" <hjl@lucon.org>
Cc: nfs@lists.sourceforge.net, linux kernel <linux-kernel@vger.kernel.org>,
        alan@redhat.com
Subject: Re: [NFS] Has anyone run the Connectathon Testsuite recently?
In-Reply-To: <20011021232452.A2473@lucon.org>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 22 Oct 2001 10:28:18 +0200
In-Reply-To: "H . J . Lu"'s message of "Sun, 21 Oct 2001 23:24:52 -0700"
Message-ID: <shshess6pul.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == hjl  <H> writes:

     > I checked out kernel 2.4.9-6 from RedHat 7.1 updates. It failed
     > the Connectathon Testsuite against the Linux and none-Linux
     > server. I believe both NFS server and client are broken in
     > 2.4.9-6. See

     > http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=54868

     > Now the question is how bad the current Linus/AC kernels are?


They are not affected. The RedHat kernel seems to have the (known) bug
in which the grace period isn't reset. My fault for introducing it in
the 2.4.9-ac series...

I haven't gotten round to syncing up the AC kernel to the full reclaim
code that's in Linus' kernel, but Alan has already applied the
following patch (as of 2.4.10-ac12).

Cheers,
  Trond

--- linux-2.4.9-6/fs/lockd/svc.c.orig	Thu Oct 18 15:00:46 2001
+++ linux-2.4.9-6/fs/lockd/svc.c	Mon Oct 22 10:25:21 2001
@@ -122,6 +122,15 @@
 			if (nlmsvc_ops) {
 				nlmsvc_ops->detach();
 				grace_period_expire = nlmsvc_grace_period + jiffies;
+#ifdef RPC_DEBUG
+				nlmsvc_grace_period = 10 * HZ;
+#else
+				if (nlm_grace_period)
+					nlmsvc_grace_period = ((nlm_grace_period + nlm_timeout - 1)
+								/ nlm_timeout) * nlm_timeout * HZ;
+				else
+					nlmsvc_grace_period = 5 * nlm_timeout * HZ;
+#endif
 			}
 		}
 
@@ -133,8 +142,10 @@
 		 */
 		if (!grace_period_expire) {
 			timeout = nlmsvc_retry_blocked();
-		} else if (time_before(grace_period_expire, jiffies))
+		} else if (time_before(grace_period_expire, jiffies)) {
 			grace_period_expire = 0;
+			nlmsvc_grace_period = 0;
+		}
 
 		/*
 		 * Find a socket with data available and call its

