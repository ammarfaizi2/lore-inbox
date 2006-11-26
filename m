Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935308AbWKZKBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935308AbWKZKBK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 05:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935309AbWKZKBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 05:01:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63912 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S935308AbWKZKBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 05:01:09 -0500
Message-ID: <456965D5.1000302@redhat.com>
Date: Sun, 26 Nov 2006 18:00:53 +0800
From: Eugene Teo <eteo@redhat.com>
Organization: Red Hat Asia Pacific
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: lksctp-developers@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org, Eugene Teo <eteo@redhat.com>
Subject: [2.6 patch] net/sctp/socket.c: add missing sctp_spin_unlock_irqrestore
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a missing sctp_spin_unlock_irqrestore when returning
from "if(space_left<addrlen)" condition.

Signed-off-by: Eugene Teo <eteo@redhat.com>

  net/sctp/socket.c |   19 +++++++++++--------
  1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 935bc91..a5d4d75 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -3955,7 +3955,7 @@ static int sctp_copy_laddrs_to_user(stru
         struct sctp_sockaddr_entry *addr;
         unsigned long flags;
         union sctp_addr temp;
-       int cnt = 0;
+       int cnt = 0, err = 0;
         int addrlen;

         sctp_spin_lock_irqsave(&sctp_local_addr_lock, flags);
@@ -3968,21 +3968,24 @@ static int sctp_copy_laddrs_to_user(stru
                 sctp_get_pf_specific(sk->sk_family)->addr_v4map(sctp_sk(sk),
                                                                 &temp);
                 addrlen = sctp_get_af_specific(temp.sa.sa_family)->sockaddr_len;
-               if(space_left<addrlen)
-                       return -ENOMEM;
+               if(space_left<addrlen) {
+                       err = -ENOMEM;
+                       goto unlock;
+               }
                 temp.v4.sin_port = htons(port);
                 if (copy_to_user(*to, &temp, addrlen)) {
-                       sctp_spin_unlock_irqrestore(&sctp_local_addr_lock,
-                                                   flags);
-                       return -EFAULT;
+                       err = -EFAULT;
+                       goto unlock;
                 }
                 *to += addrlen;
                 cnt ++;
                 space_left -= addrlen;
         }
-       sctp_spin_unlock_irqrestore(&sctp_local_addr_lock, flags);
+       err = cnt;

-       return cnt;
+unlock:
+       sctp_spin_unlock_irqrestore(&sctp_local_addr_lock, flags);
+       return err;
  }

  /* Old API for getting list of local addresses. Does not work for 32-bit


-- 
eteo redhat.com  ph: +65 6490 4142  http://www.kernel.org/~eugeneteo
gpg fingerprint:  47B9 90F6 AE4A 9C51 37E0  D6E1 EA84 C6A2 58DF 8823
