Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267576AbUG3CTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267576AbUG3CTq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 22:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267579AbUG3CTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 22:19:45 -0400
Received: from mail.inter-page.com ([12.5.23.93]:46092 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S267576AbUG3CTM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 22:19:12 -0400
From: "Robert White" <rwhite@casabyte.com>
To: <linux-kernel@vger.kernel.org>
Subject: tcp_push_pending_frames() without TCP_CORK or TCP_NODELAY
Date: Thu, 29 Jul 2004 19:19:00 -0700
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAsIVuAS+Wekm4zD6W7LtKswEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I have several environments where I have two or more boxes tied together with
short/private Ethernet segments.  The applications on these boxes toss events back
and forth using that network.  Reliability is most important so I use TCP, but
performance is also important as a close second.  The events are often quite short
and are, as often as not assembled on the fly in the code via multiple writes.

The protocol(s) also have "known complete" moments where the sender knows that a
complete event has been written.

If I turn Nagle off, then the segmented write-on-assembly generates a lot of very
short (3 to 30 etc bytes) packets; if I leave it on then Nagle tends to delay the
complete events (because, of course, the stack isn't psychic 8-).

I currently flush these event boundaries by turning nagle off and then back on using
back-to-back calls to setsockop().  The extra syscalls seem like a waste.  To that
end I am looking into a patch to add a SIOCFLUSH ioctl or similar.

The below [untested] patch is my first-take on the question.  I am interested in
knowing whether this looks useful to others (or ill conceived etc 8-) before I try to
add this to the tree pervasively.

[Sorry about the mis-indented line to stifle outlook word-wrap.  I "have to" use this
bloody program here at work... /sigh 8-)]

==== Begin Patch ====
--- linux.orig/include/asm-i386/sockios.h       2004-06-15 22:19:02.000000000 -0700
+++ linux/include/asm-i386/sockios.h    2004-07-29 18:37:22.000000000 -0700
@@ -8,5 +8,6 @@
 #define SIOCGPGRP      0x8904
 #define SIOCATMARK     0x8905
 #define SIOCGSTAMP     0x8906          /* Get stamp */
+#define SIOCFLUSH      0x8907
 
 #endif
diff --recursive -u linux.orig/net/ipv4/tcp.c linux/net/ipv4/tcp.c
--- linux.orig/net/ipv4/tcp.c   2004-06-15 22:19:03.000000000 -0700
+++ linux/net/ipv4/tcp.c        2004-07-29 19:09:07.000000000 -0700
@@ -526,6 +526,14 @@
                else
                        answ = tp->write_seq - tp->snd_una;
                break;
+       case SIOCFLUSH:
+               {
+                       __u8 scratch = tp->nonagle;
+       tp->nonagle = (scratch & ~TCP_NAGLE_CORK) | TCP_NAGLE_OFF | TCP_NAGLE_PUSH;
+                       tcp_push_pending_frames(sk, tp);
+                       tp->nonagle = scratch;
+               }
+                return 0;
        default:
                return -ENOIOCTLCMD;
        };
==== End Patch ====


Robert White,
Casabyte, Inc.


