Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964997AbWIFXIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbWIFXIy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbWIFXC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:02:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:50636 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964971AbWIFXCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:02:04 -0400
Date: Wed, 6 Sep 2006 15:56:52 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Sridhar Samudrala <sri@us.ibm.com>,
       "David S. Miller" <davem@davemloft.net>
Subject: [patch 19/37] SCTP: Fix sctp_primitive_ABORT() call in sctp_close().
Message-ID: <20060906225652.GT15922@kroah.com>
References: <20060906224631.999046890@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sctp-fix-sctp_primitive_abort-call-in-sctp_close.patch"
In-Reply-To: <20060906225444.GA15922@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Sridhar Samudrala <sri@us.ibm.com>

With the recent fix, the callers of sctp_primitive_ABORT()
need to create an ABORT chunk and pass it as an argument rather
than msghdr that was passed earlier.

Signed-off-by: Sridhar Samudrala <sri@us.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>

---
 net/sctp/socket.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- linux-2.6.17.11.orig/net/sctp/socket.c
+++ linux-2.6.17.11/net/sctp/socket.c
@@ -1246,9 +1246,13 @@ SCTP_STATIC void sctp_close(struct sock 
 			}
 		}
 
-		if (sock_flag(sk, SOCK_LINGER) && !sk->sk_lingertime)
-			sctp_primitive_ABORT(asoc, NULL);
-		else
+		if (sock_flag(sk, SOCK_LINGER) && !sk->sk_lingertime) {
+			struct sctp_chunk *chunk;
+
+			chunk = sctp_make_abort_user(asoc, NULL, 0);
+			if (chunk)
+				sctp_primitive_ABORT(asoc, chunk);
+		} else
 			sctp_primitive_SHUTDOWN(asoc, NULL);
 	}
 

--
