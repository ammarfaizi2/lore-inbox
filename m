Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262779AbVDAPbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262779AbVDAPbc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 10:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262780AbVDAPbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 10:31:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62187 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262779AbVDAPa6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 10:30:58 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <40f323d0050331115016b707f1@mail.gmail.com> 
References: <40f323d0050331115016b707f1@mail.gmail.com>  <29204.1111608899@redhat.com> <29760.1111611165@redhat.com> 
To: torvalds@osdl.org, akpm@osdl.org
Cc: Benoit Boissinot <bboissin@gmail.com>,
       Michael A Halcrow <mahalcro@us.ibm.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Keys: Fix request_key default keyring handling
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Fri, 01 Apr 2005 16:30:41 +0100
Message-ID: <9667.1112369441@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch fixes the way request_key handles the default destination
key when it's the group keyring. It also removes the check for the no-change
default keyring spec, which shouldn't appear in the task_struct::jit_keyring
member (it's purely for getting the old value from the keyctl function).

Signed-Off-By: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 /tmp/keys.patch 
 security/keys/keyctl.c      |    2 +-
 security/keys/request_key.c |    3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

--- ./security/keys/request_key.c.orig	2005-03-31 21:23:43.000000000 +0200
+++ ./security/keys/request_key.c	2005-03-31 21:41:03.000000000 +0200
@@ -335,8 +335,7 @@ static void request_key_link(struct key 
 			dest_keyring = current->user->uid_keyring;
 			break;
 
-		case KEY_REQKEY_DEFL_NO_CHANGE:
-		case KEY_SPEC_GROUP_KEYRING:
+		case KEY_REQKEY_DEFL_GROUP_KEYRING:
 		default:
 			BUG();
 		}
--- ./security/keys/keyctl.c.orig	2005-03-31 21:41:35.000000000 +0200
+++ ./security/keys/keyctl.c	2005-03-31 21:42:01.000000000 +0200
@@ -951,7 +951,7 @@ long keyctl_set_reqkey_keyring(int reqke
 	case KEY_REQKEY_DEFL_NO_CHANGE:
 		return current->jit_keyring;
 
-	case KEY_SPEC_GROUP_KEYRING:
+	case KEY_REQKEY_DEFL_GROUP_KEYRING:
 	default:
 		return -EINVAL;
 	}
