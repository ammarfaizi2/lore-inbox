Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265083AbTIDPZG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 11:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265085AbTIDPZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 11:25:06 -0400
Received: from pat.uio.no ([129.240.130.16]:2991 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S265083AbTIDPZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 11:25:00 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16215.22857.654633.466244@charged.uio.no>
Date: Thu, 4 Sep 2003 11:24:57 -0400
To: Pascal Schmidt <der.eremit@email.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [NFS] attempt to use V1 mount protocol on V3 server
In-Reply-To: <Pine.LNX.4.44.0309041621180.989-100000@neptune.local>
References: <16214.49538.216630.336724@charged.uio.no>
	<Pine.LNX.4.44.0309041621180.989-100000@neptune.local>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Pascal Schmidt <der.eremit@email.de> writes:

     > Fine with me if a buggy server results in a failure to
     > mount. However, I was seeing crashes.

I assume that your server's RPC engine replying with a PROG_MISMATCH
the way it should when it cannot support NFSv2?

Hmm.. Looking at the code, we appear not to be handling that case very
well in the RPC client. PROG_UNAVAIL, PROG_MISMATCH, and PROC_UNAVAIL
are all handled incorrectly as if the replies were garbage...

Althought this is harmless, we should really be returning an EIO
immediately, and report the error in the syslog...

Does the following patch (against 2.4.22) help?

Cheers,
  Trond

--- linux-2.4.22-up/net/sunrpc/clnt.c.orig	2003-08-23 14:11:09.000000000 -0400
+++ linux-2.4.22-up/net/sunrpc/clnt.c	2003-09-04 11:21:28.000000000 -0400
@@ -932,6 +932,24 @@
 	switch ((n = ntohl(*p++))) {
 	case RPC_SUCCESS:
 		return p;
+	case RPC_PROG_UNAVAIL:
+		printk(KERN_WARNING "RPC: %4d call_verify: program %u is unsupported by server %s\n",
+				task->tk_pid, (unsigned int)task->tk_client->cl_prog,
+				task->tk_client->cl_server);
+		goto out_eio;
+	case RPC_PROG_MISMATCH:
+		printk(KERN_WARNING "RPC: %4d call_verify: program %u, version %u unsupported by server %s\n",
+				task->tk_pid, (unsigned int)task->tk_client->cl_prog,
+				(unsigned int)task->tk_client->cl_vers,
+				task->tk_client->cl_server);
+		goto out_eio;
+	case RPC_PROC_UNAVAIL:
+		printk(KERN_WARNING "RPC: %4d call_verify: proc %u unsupported by program %u, version %u on server %s\n",
+				task->tk_pid, (unsigned int)task->tk_msg.rpc_proc,
+				(unsigned int)task->tk_client->cl_prog,
+				(unsigned int)task->tk_client->cl_vers,
+				task->tk_client->cl_server);
+		goto out_eio;
 	case RPC_GARBAGE_ARGS:
 		break;			/* retry */
 	default:
@@ -949,6 +967,7 @@
 		return NULL;
 	}
 	printk(KERN_WARNING "RPC: garbage, exit EIO\n");
+out_eio:
 	rpc_exit(task, -EIO);
 	return NULL;
 }
