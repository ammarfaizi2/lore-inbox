Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932531AbVHKW7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbVHKW7J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 18:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbVHKW6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 18:58:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8836 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932531AbVHKW55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 18:57:57 -0400
Message-Id: <20050811225635.464979000@localhost.localdomain>
References: <20050811225445.404816000@localhost.localdomain>
Date: Thu, 11 Aug 2005 15:54:51 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       David Howells <dhowells@redhat.com>, Chris Wright <chrisw@osdl.org>
Subject: [patch 6/8] CAN-2005-2098 Error during attempt to join key management session can leave semaphore pinned
Content-Disposition: inline; filename=key-session-join.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any  objections, please let us know.
------------------

from hanging future joins in the D state [CAN-2005-2098].

The problem is that the error handling path for the KEYCTL_JOIN_SESSION_KEYRING
operation has one error path that doesn't release the session management
semaphore. Further attempts to get the semaphore will then sleep for ever in
the D state.

This can happen in four situations, all involving an attempt to allocate a new
session keyring:

 (1) ENOMEM.

 (2) The users key quota being reached.

 (3) A keyring name that is an empty string.

 (4) A keyring name that is too long.

Any user may attempt this operation, and so any user can cause the problem to
occur.

Signed-Off-By: David Howells <dhowells@redhat.com>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 security/keys/process_keys.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.12.y/security/keys/process_keys.c
===================================================================
--- linux-2.6.12.y.orig/security/keys/process_keys.c
+++ linux-2.6.12.y/security/keys/process_keys.c
@@ -641,7 +641,7 @@ long join_session_keyring(const char *na
 		keyring = keyring_alloc(name, tsk->uid, tsk->gid, 0, NULL);
 		if (IS_ERR(keyring)) {
 			ret = PTR_ERR(keyring);
-			goto error;
+			goto error2;
 		}
 	}
 	else if (IS_ERR(keyring)) {

--
