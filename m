Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264864AbSJaLuo>; Thu, 31 Oct 2002 06:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264865AbSJaLuo>; Thu, 31 Oct 2002 06:50:44 -0500
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:28388 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S264864AbSJaLum>; Thu, 31 Oct 2002 06:50:42 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] UP locking fix for net/socket.c
Date: Thu, 31 Oct 2002 12:57:20 +0100
User-Agent: KMail/1.4.7
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gqRw9lYxl9PYUqV"
Message-Id: <200210311257.20535.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_gqRw9lYxl9PYUqV
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This race occurs on UP (not SMP) systems.  socket.c must
not continue using net_family after sock_unregister(net_family)
has returned.  Here is a scenario for this to occur: go to sleep in
the following call:

if ((i = net_families[family]->create(sock, protocol)) < 0)

While sleeping, a task calls sock_unregister(family), which
succeeds since on UP there is currently no locking of any kind.

Duncan.

Patches against 2.4.19 and 2.5.45 attached.  2.4.19 patch:

--- linux/net/socket.c.orig	2002-08-03 02:39:46.000000000 +0200
+++ linux/net/socket.c	2002-10-31 09:16:50.000000000 +0100
@@ -132,7 +132,6 @@
 
 static struct net_proto_family *net_families[NPROTO];
 
-#ifdef CONFIG_SMP
 static atomic_t net_family_lockct = ATOMIC_INIT(0);
 static spinlock_t net_family_lock = SPIN_LOCK_UNLOCKED;
 
@@ -170,13 +169,6 @@
 	atomic_dec(&net_family_lockct);
 }
 
-#else
-#define net_family_write_lock() do { } while(0)
-#define net_family_write_unlock() do { } while(0)
-#define net_family_read_lock() do { } while(0)
-#define net_family_read_unlock() do { } while(0)
-#endif
-
 
 /*
  *	Statistics counters of the socket lists

--Boundary-00=_gqRw9lYxl9PYUqV
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch_no_race_2.5"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch_no_race_2.5"

--- Yield/net/socket.c.orig	2002-10-31 09:10:07.000000000 +0100
+++ Yield/net/socket.c	2002-10-31 09:13:48.000000000 +0100
@@ -138,7 +138,6 @@
 
 static struct net_proto_family *net_families[NPROTO];
 
-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
 static atomic_t net_family_lockct = ATOMIC_INIT(0);
 static spinlock_t net_family_lock = SPIN_LOCK_UNLOCKED;
 
@@ -175,13 +174,6 @@
 	atomic_dec(&net_family_lockct);
 }
 
-#else
-#define net_family_write_lock() do { } while(0)
-#define net_family_write_unlock() do { } while(0)
-#define net_family_read_lock() do { } while(0)
-#define net_family_read_unlock() do { } while(0)
-#endif
-
 
 /*
  *	Statistics counters of the socket lists

--Boundary-00=_gqRw9lYxl9PYUqV
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch_no_race_2.4"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch_no_race_2.4"

--- linux/net/socket.c.orig	2002-08-03 02:39:46.000000000 +0200
+++ linux/net/socket.c	2002-10-31 09:16:50.000000000 +0100
@@ -132,7 +132,6 @@
 
 static struct net_proto_family *net_families[NPROTO];
 
-#ifdef CONFIG_SMP
 static atomic_t net_family_lockct = ATOMIC_INIT(0);
 static spinlock_t net_family_lock = SPIN_LOCK_UNLOCKED;
 
@@ -170,13 +169,6 @@
 	atomic_dec(&net_family_lockct);
 }
 
-#else
-#define net_family_write_lock() do { } while(0)
-#define net_family_write_unlock() do { } while(0)
-#define net_family_read_lock() do { } while(0)
-#define net_family_read_unlock() do { } while(0)
-#endif
-
 
 /*
  *	Statistics counters of the socket lists

--Boundary-00=_gqRw9lYxl9PYUqV--
