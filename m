Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284180AbSBMOIb>; Wed, 13 Feb 2002 09:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284300AbSBMOIX>; Wed, 13 Feb 2002 09:08:23 -0500
Received: from penguin-ext.wise.edt.ericsson.se ([193.180.251.34]:39923 "EHLO
	penguin-ext.wise.edt.ericsson.se") by vger.kernel.org with ESMTP
	id <S284717AbSBMOIK>; Wed, 13 Feb 2002 09:08:10 -0500
Message-ID: <E244E44D6AB85E40AEEF7EAABE3545FA08ABD8@enleent104.nl.eu.ericsson.se>
From: "Henk de Groot (ELN)" <Henk.de.Groot@eln.ericsson.se>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-hams@vger.kernel.org'" <linux-hams@vger.kernel.org>
Cc: "'stephen@g6dzj.demon.co.uk'" <stephen@g6dzj.demon.co.uk>,
        "'davem@redhat.com'" <davem@redhat.com>,
        "'henk.de.groot@hetnet.nl'" <henk.de.groot@hetnet.nl>
Subject: Re: AX25 Patches for 2.4.17 and above - have they been included y
	et
Date: Wed, 13 Feb 2002 15:07:24 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Jeroen has send a final version of the fix a while ago to the linux-ham mailing
list with the request to the maintainers to handle this. But it looks like
nothing has been done, or maybe we should be a little more patient. I haven't
seen it on the linux-kernel mailing-list yet.

Here is the patch, copied from
<http://hes.iki.fi/archive/linux-hams/200201/0050.html>. I've put them inline
(were attachments), hopefully it works.

<quote>
From: Jeroen Vreeken (pe1rxq@amsat.org)
Date: Thu Jan 17 2002 - 23:50:14 EET

Hi all, 

Finally a proper fix for the problem, turns out I was a bit to 
enthousiastic when I tried using sock_orphan the first time. 

Attached are two patches, one for ax25 and one for netrom. 
Can the maintainers apply them? 

Jeroen 
</quote>

01-ax25-sock_orphan.diff
---------------------------------------------------------------------------------
diff -ruN linux-2.4.17/net/ax25/af_ax25.c linux/net/ax25/af_ax25.c
--- linux-2.4.17/net/ax25/af_ax25.c	Fri Sep 14 02:16:23 2001
+++ linux/net/ax25/af_ax25.c	Thu Jan 17 22:29:58 2002
@@ -102,6 +102,7 @@
  *			Joerg(DL1BKE)		Added support for SO_BINDTODEVICE
  *			Arnaldo C. Melo		s/suser/capable(CAP_NET_ADMIN)/, some more cleanups
  *			Michal Ostrowski	Module initialization cleanup.
+ *			Jeroen(PE1RXQ)		Use sock_orphan() on release.
  */
 
 #include <linux/config.h>
@@ -1018,7 +1019,7 @@
 				sk->state                = TCP_CLOSE;
 				sk->shutdown            |= SEND_SHUTDOWN;
 				sk->state_change(sk);
-				sk->dead                 = 1;
+				sock_orphan(sk);
 				sk->destroy              = 1;
 				break;
 
@@ -1029,7 +1030,7 @@
 		sk->state     = TCP_CLOSE;
 		sk->shutdown |= SEND_SHUTDOWN;
 		sk->state_change(sk);
-		sk->dead      = 1;
+		sock_orphan(sk);
 		ax25_destroy_socket(sk->protinfo.ax25);
 	}
 

---------------------------------------------------------------------------------
02-netrom-sock_orphan.diff
---------------------------------------------------------------------------------
diff -ruN linux-2.4.17/net/netrom/af_netrom.c linux/net/netrom/af_netrom.c
--- linux-2.4.17/net/netrom/af_netrom.c	Mon Sep 10 16:58:35 2001
+++ linux/net/netrom/af_netrom.c	Thu Jan 17 22:34:54 2002
@@ -31,6 +31,7 @@
  *	NET/ROM 007	Jonathan(G4KLX)	New timer architecture.
  *					Impmented Idle timer.
  *			Arnaldo C. Melo s/suser/capable/, micro cleanups
+ *			Jeroen (PE1RXQ)	Use sock_orphan() on release.
  */
 
 #include <linux/config.h>
@@ -572,9 +573,8 @@
 			sk->state                = TCP_CLOSE;
 			sk->shutdown            |= SEND_SHUTDOWN;
 			sk->state_change(sk);
-			sk->dead                 = 1;
+			sock_orphan(sk);
 			sk->destroy              = 1;
-			sk->socket               = NULL;
 			break;
 
 		default:

---------------------------------------------------------------------------------

