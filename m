Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbUJXLMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbUJXLMm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 07:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbUJXLMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 07:12:41 -0400
Received: from spc1-leed3-6-0-cust18.seac.broadband.ntl.com ([80.7.68.18]:8697
	"EHLO fentible.pjc.net") by vger.kernel.org with ESMTP
	id S261445AbUJXLL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 07:11:59 -0400
Date: Sun, 24 Oct 2004 12:11:57 +0100
From: Patrick Caulfield <pcaulfie@redhat.com>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org,
       DECnet list <linux-decnet-user@lists.sourceforge.net>
Subject: [PATCH] DECnet connect hang bugfix
Message-ID: <20041024111157.GA31630@tykepenguin.com>
Mail-Followup-To: davem@redhat.com, linux-kernel@vger.kernel.org,
	DECnet list <linux-decnet-user@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a bug in the DECnet connect that seems to have been in 2.6 for
a while now.

If a connection is rejected by a remote host (eg invalid access control, no
such object etc) the Linux end hangs in connect() because it is only waiting for
the socket to go into RUN state.

This patch sets the ECONNREFUSED error state on the socket when the connection
is rejected to that the connect() exits it's wait loop and returns the error to
the user.



===== dn_nsp_in.c 1.14 vs edited =====
--- 1.14/net/decnet/dn_nsp_in.c	2004-06-28 21:14:20 +01:00
+++ edited/dn_nsp_in.c	2004-10-14 13:44:23 +01:00
@@ -419,6 +419,7 @@
 		case DN_CI:
 		case DN_CD:
 			scp->state = DN_RJ;
+			sk->sk_err = ECONNREFUSED;
 			break;
 		case DN_RUN:
 			sk->sk_shutdown |= SHUTDOWN_MASK;

-- 

patrick
