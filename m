Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbTHTReY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 13:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbTHTReX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 13:34:23 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:5885 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S262100AbTHTReP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 13:34:15 -0400
Message-ID: <3F43B13C.5010403@RedHat.com>
Date: Wed, 20 Aug 2003 13:34:52 -0400
From: Steve Dickson <SteveD@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: nfs@lists.sourceforge.net
CC: linux-kernel <linux-kernel@vger.kernel.org>, acl-devel@bestbits.at
Subject: [NFS] [PATCH] Stop call_decode() from ignorning RPC header errrors
Content-Type: multipart/mixed;
 boundary="------------070801080006030704060606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070801080006030704060606
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch stop call_decode() from ignoring errors
that are found while parsing the RPC header. I turns
out the nfs acls routines need these error codes to do
the right thing...

SteveD.

--------------070801080006030704060606
Content-Type: text/plain;
 name="linux-2.4.21-sunrpc-calldecode.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.4.21-sunrpc-calldecode.patch"

--- linux-2.4.21/net/sunrpc/clnt.c.diff	2003-08-18 11:11:22.000000000 -0400
+++ linux-2.4.21/net/sunrpc/clnt.c	2003-08-20 12:13:02.000000000 -0400
@@ -784,9 +784,16 @@ call_decode(struct rpc_task *task)
 				__FUNCTION__);
 
 	/* Verify the RPC header */
-	if (!(p = call_verify(task)))
+	if (!(p = call_verify(task))) {
+		/*
+		 * When call_verfiy sets tk_action to NULL (via task_exit)
+		 * a non-retry-able error has occurred (like the server
+		 * not supporting a particular procedure call).
+		 */
+		if (task->tk_action == NULL)
+			return;
 		goto out_retry;
-
+	}
 	/*
 	 * The following is an NFS-specific hack to cater for setuid
 	 * processes whose uid is mapped to nobody on the server.

--------------070801080006030704060606--

