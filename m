Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266689AbSKZTkK>; Tue, 26 Nov 2002 14:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266693AbSKZTkK>; Tue, 26 Nov 2002 14:40:10 -0500
Received: from dexter.citi.umich.edu ([141.211.133.33]:6528 "EHLO
	dexter.citi.umich.edu") by vger.kernel.org with ESMTP
	id <S266689AbSKZTkG>; Tue, 26 Nov 2002 14:40:06 -0500
Date: Tue, 26 Nov 2002 14:47:09 -0500 (EST)
From: Chuck Lever <cel@citi.umich.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] refine RPC over TCP socket connect behavior
Message-ID: <Pine.LNX.4.44.0211261439110.9482-100000@dexter.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description:
  further refine TCP socket connect behavior in the RPC client.  this
  patch implements the following behavior changes in the RPC client:

+  the RPC client's TCP socket connect timeout is now the same as the
   RPC TCP retransmit timeout value, giving sysadmins a means to adjust
   the RPC connect timeout for links with long RTTs (like, to Mars).

+  if multiple RPC requests notice the TCP transport socket is
   disconnected, cause them all to wait at least RPC_REESTABLISH_TIMEOUT
   seconds before retrying to connect.  before, only one would wait, and
   the rest would retry immediately, resulting in unpredictable behavior.

+  if an unrecognized error occurs when trying to establish a connection,
   just exit without retrying.  This prevents potential infinite hangs.

Apply Against:
  2.5.49

Test status:
  Pull ethernet cable while client is under load and watch RPC debug
  output.  Does not affect normal operation of RPC client.


diff -Naur 03-req_offset/include/linux/sunrpc/xprt.h 04-connect3/include/linux/sunrpc/xprt.h
--- 03-req_offset/include/linux/sunrpc/xprt.h	Fri Nov 22 16:40:53 2002
+++ 04-connect3/include/linux/sunrpc/xprt.h	Mon Nov 25 13:24:29 2002
@@ -45,13 +45,6 @@
 #define RPC_MAX_TCP_TIMEOUT	(600*HZ)
 
 /*
- * Wait duration for an RPC TCP connection to be established.  Solaris
- * NFS over TCP uses 60 seconds, for example, which is in line with how
- * long a server takes to reboot.
- */
-#define RPC_CONNECT_TIMEOUT	(60*HZ)
-
-/*
  * Delay an arbitrary number of seconds before attempting to reconnect
  * after an error.
  */
diff -Naur 03-req_offset/net/sunrpc/clnt.c 04-connect3/net/sunrpc/clnt.c
--- 03-req_offset/net/sunrpc/clnt.c	Fri Nov 22 16:40:30 2002
+++ 04-connect3/net/sunrpc/clnt.c	Mon Nov 25 13:24:29 2002
@@ -557,7 +557,7 @@
 
 	if (!clnt->cl_port) {
 		task->tk_action = call_connect;
-		task->tk_timeout = RPC_CONNECT_TIMEOUT;
+		task->tk_timeout = xprt->timeout.to_initval;
 		rpc_getport(task, clnt);
 	}
 }
diff -Naur 03-req_offset/net/sunrpc/xprt.c 04-connect3/net/sunrpc/xprt.c
--- 03-req_offset/net/sunrpc/xprt.c	Fri Nov 22 16:40:51 2002
+++ 04-connect3/net/sunrpc/xprt.c	Mon Nov 25 13:24:29 2002
@@ -461,7 +461,7 @@
 		if (inet->state != TCP_ESTABLISHED) {
 			dprintk("RPC: %4d  waiting for connection\n",
 					task->tk_pid);
-			task->tk_timeout = RPC_CONNECT_TIMEOUT;
+			task->tk_timeout = xprt->timeout.to_initval;
 			/* if the socket is already closing, delay briefly */
 			if ((1 << inet->state) & ~(TCPF_SYN_SENT|TCPF_SYN_RECV))
 				task->tk_timeout = RPC_REESTABLISH_TIMEOUT;
@@ -481,7 +481,7 @@
 		if (inet->state != TCP_ESTABLISHED) {
 			xprt_close(xprt);
 			task->tk_status = -EAGAIN;
-			goto out_write;
+			break;
 		}
 
 		/* Otherwise, the connection is already established. */
@@ -491,24 +491,14 @@
 	case -EPIPE:
 		xprt_close(xprt);
 		task->tk_status = -ENOTCONN;
-		goto out_write;
+		break;
 
 	default:
-		/* Report myriad other possible returns.  If this file
-		 * system is soft mounted, just error out, like Solaris.  */
+		/* Report myriad other possible returns, and exit. */
 		xprt_close(xprt);
-		if (task->tk_client->cl_softrtry) {
-			printk(KERN_WARNING
+		printk(KERN_WARNING
 			"RPC: error %d connecting to server %s, exiting\n",
 					-status, task->tk_client->cl_server);
-			task->tk_status = -EIO;
-		} else {
-			printk(KERN_WARNING
-			"RPC: error %d connecting to server %s\n",
-					-status, task->tk_client->cl_server);
-			rpc_delay(task, RPC_REESTABLISH_TIMEOUT);
-			task->tk_status = status;
-		}
 		break;
 	}
 
@@ -528,26 +518,37 @@
 	case 0:
 		dprintk("RPC: %4d xprt_conn_status: connection established\n",
 				task->tk_pid);
-		goto out;
+		xprt_release_write(xprt, task);
+		return;
 	case -ETIMEDOUT:
 		dprintk("RPC: %4d xprt_conn_status: timed out\n",
 				task->tk_pid);
-		/* prevent TCP from continuing to retry SYNs */
-		xprt_close(xprt);
+		task->tk_status = -EAGAIN;
+		if (task->tk_client->cl_softrtry)
+			task->tk_status = -EIO;
+		break;
+	case -ENOTCONN:
+		dprintk("RPC: %4d xprt_conn_status: no network path\n",
+				task->tk_pid);
+		if (!task->tk_client->cl_softrtry) {
+			rpc_delay(task, RPC_REESTABLISH_TIMEOUT);
+			task->tk_status = -EAGAIN;
+		} else
+			task->tk_status = -EIO;
 		break;
 	default:
-		printk(KERN_ERR "RPC: error %d connecting to server %s\n",
+		printk(KERN_WARNING
+			"RPC: error %d connecting to server %s, exiting\n",
 				-task->tk_status, task->tk_client->cl_server);
-		xprt_close(xprt);
-		rpc_delay(task, RPC_REESTABLISH_TIMEOUT);
 		break;
 	}
-	/* if soft mounted, cause this RPC to fail */
-	if (task->tk_client->cl_softrtry)
-		task->tk_status = -EIO;
+	/* prevent TCP from continuing to retry SYNs */
+	xprt_close(xprt);
 
- out:
-	xprt_release_write(xprt, task);
+	/* if we're retrying, hold the write lock to prevent other
+	 * requests from retrying the connect */
+	if (task->tk_status != -EAGAIN)
+		xprt_release_write(xprt, task);
 }
 
 /*

