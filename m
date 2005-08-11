Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932533AbVHKW5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbVHKW5y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 18:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbVHKW5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 18:57:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3972 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932468AbVHKW5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 18:57:52 -0400
Message-Id: <20050811225637.538357000@localhost.localdomain>
References: <20050811225445.404816000@localhost.localdomain>
Date: Thu, 11 Aug 2005 15:54:52 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       David Howells <dhowells@redhat.com>, Chris Wright <chrisw@osdl.org>
Subject: [patch 7/8] CAN-2005-2099 Destruction of failed keyring oopses
Content-Disposition: inline; filename=failed-keyring-oops.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any  objections, please let us know.
------------------

properly is destroyed without oopsing [CAN-2005-2099].

The problem occurs in three stages:

 (1) The key allocator initialises the type-specific data to all zeroes. In
     the case of a keyring, this will become a link in the keyring name list
     when the keyring is instantiated.

 (2) If a user (any user) attempts to add a keyring with anything other than
     an empty payload, the keyring instantiation function will fail with an
     error and won't add the keyring to the name list.

 (3) The keyring's destructor then sees that the keyring has a description
     (name) and tries to remove the keyring from the name list, which oopses
     because the link pointers are both zero.

This bug permits any user to take down a box trivially.

Signed-Off-By: David Howells <dhowells@redhat.com>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 security/keys/keyring.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

Index: linux-2.6.12.y/security/keys/keyring.c
===================================================================
--- linux-2.6.12.y.orig/security/keys/keyring.c
+++ linux-2.6.12.y/security/keys/keyring.c
@@ -188,7 +188,11 @@ static void keyring_destroy(struct key *
 
 	if (keyring->description) {
 		write_lock(&keyring_name_lock);
-		list_del(&keyring->type_data.link);
+
+		if (keyring->type_data.link.next != NULL &&
+		    !list_empty(&keyring->type_data.link))
+			list_del(&keyring->type_data.link);
+
 		write_unlock(&keyring_name_lock);
 	}
 

--
