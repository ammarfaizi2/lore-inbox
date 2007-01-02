Return-Path: <linux-kernel-owner+w=401wt.eu-S932696AbXABJJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932696AbXABJJe (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 04:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932756AbXABJJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 04:09:33 -0500
Received: from [61.51.204.190] ([61.51.204.190]:40771 "EHLO
	freya.yggdrasil.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932683AbXABJJc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 04:09:32 -0500
X-Greylist: delayed 1206 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jan 2007 04:08:59 EST
Date: Tue, 2 Jan 2007 15:58:26 +0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Paul Moore <paul.moore@hp.com>
Subject: Re: selinux networking: sleeping functin called from invalid context in 2.6.20-rc[12]
Message-ID: <20070102155826.A14811@freya>
References: <20061225052124.A10323@freya> <20061224162511.eaac4a89.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20061224162511.eaac4a89.akpm@osdl.org>; from akpm@osdl.org on Sun, Dec 24, 2006 at 04:25:11PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 24, 2006 at 04:25:11PM -0800, Andrew Morton wrote:
> On Mon, 25 Dec 2006 05:21:24 +0800
> "Adam J. Richter" <adam@yggdrasil.com> wrote:
> 
>> 	Under 2.6.20-rc1 and 2.6.20-rc2, I get the following complaint
>> for several network programs running on my system:
>> 
>> [  156.381868] BUG: sleeping function called from invalid context at net/core/sock.c:1523
[...]
> There's a glaring bug in selinux_netlbl_inode_permission() - taking
> lock_sock() inside rcu_read_lock().
> 
> I would again draw attention to Documentation/SubmitChecklist.  In
> particular please always always always enable all kernel debugging options
> when developing and testing new kernel code.  And everything else in that
> file, too.
> 
> <guesses that this was tested on ia64>

	I have not yet performed the 21 steps of
linux-2.6.20-rc3/Documentation/SubmitChecklist, which I think is a
great objectives list for future automation or some kind of community
web site.  I hope to find time to make progress through that
checklist, but, in the meantime, I think the world may nevertheless be
infinitesmally better off if I post the patch that I'm currently
using that seems to fix the problem, seeing as how rc3 has passed
with no fix incorporated.

	I think the intent of the offending code was to avoid doing
a lock_sock() in a presumably common case where there was no need to
take the lock.  So, I have kept the presumably fast test to exit
early.

	When it turns out to be necessary to take lock_sock(), RCU is
unlocked, then lock_sock is taken, the RCU is locked again, and
the test is repeated.

	If I am wrong about lock_sock being expensive, I can
delete the lines that do the early return.

	By the way, in a change not included in this patch,
I also tried consolidating the RCU locking in this file into a macro
IF_NLBL_REQUIRE(sksec, action), where "action" is the code
fragment to be executed with rcu_read_lock() held, although this
required splitting a couple of functions in half.

	Anyhow, here is my current patch as MIME attachment.
Comments and labor in getting it through SubmitChecklist would
both be welcome.

Adam Richter

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="selinux.diff"

--- linux-2.6.20-rc3/security/selinux/ss/services.c	2007-01-02 01:47:40.000000000 +0800
+++ linux/security/selinux/ss/services.c	2007-01-02 15:36:30.000000000 +0800
@@ -2658,14 +2658,22 @@
 	rcu_read_lock();
 	if (sksec->nlbl_state != NLBL_REQUIRE) {
 		rcu_read_unlock();
 		return 0;
 	}
+	rcu_read_unlock();
+
+
+	rc = 0;
 	lock_sock(sock->sk);
-	rc = selinux_netlbl_socket_setsid(sock, sksec->sid);
-	release_sock(sock->sk);
+	rcu_read_lock();
+
+	if (sksec->nlbl_state == NLBL_REQUIRE)
+		rc = selinux_netlbl_socket_setsid(sock, sksec->sid);
+
 	rcu_read_unlock();
+	release_sock(sock->sk);
 
 	return rc;
 }
 
 /**

--0OAP2g/MAC+5xKAE--
