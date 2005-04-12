Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262217AbVDMEh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbVDMEh1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 00:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262553AbVDMEen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 00:34:43 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:65207 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262532AbVDLS6W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 14:58:22 -0400
Date: Tue, 12 Apr 2005 21:58:09 +0300 (EEST)
From: Jani Jaakkola <jjaakkol@cs.Helsinki.FI>
To: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix reproducible SMP crash in security/keys/key.c
Message-ID: <Pine.LNX.4.58.0504122129510.3075@x40-4.cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


SMP race handling is broken in key_user_lookup() in security/keys/key.c
(if CONFIG_KEYS is set to 'y'). This came up on our Samba servers, but is
not restricted to samba, though samba is probably the only software which
is likely to trigger this repeatedly (and it did happen allready four 
times here in University of Helsinki, CS department).

However, it only takes two setreuid() calls at the same instant, so this
may be responsible for some other mysterious random crashes.

This is the same bug which was previously raported to LKML here (found by 
google):
http://www.ussg.iu.edu/hypermail/linux/kernel/0502.2/0521.html

Here is a small test program, which can be used to trigger the bug and 
crash the machine where it is run. It might take a few seconds:

#include<unistd.h>
#include<stdio.h>
int main() {
        int i;
        fork();
        while(1) {
                for(i=0;i<60000;i++) { setreuid(i,0); } 
                putchar('.'); fflush(stdout);
        };
}

The (rather obvious) problem is that key_user_lookup() does not properly 
re-initialize the user lookup if there was a race.

This patch applies to vanilla 2.6.11.7 and latest fedora kernel
2.6.11-1.14_FC3. When applied, the test program runs just fine (and does
nothing useful).

Please Cc: any replies to me, since I am not a regular kernel hacker and 
do not subscribe LKML.

Signed-Off-By: Jani Jaakkola <jjaakkol@cs.helsinki.fi>

--- linux-2.6.11/security/keys/key.c.orig       Wed Mar  2 09:38:25 2005
+++ linux-2.6.11/security/keys/key.c    Tue Apr 12 18:19:50 2005
@@ -56,10 +56,12 @@
 struct key_user *key_user_lookup(uid_t uid)
 {
        struct key_user *candidate = NULL, *user;
-       struct rb_node *parent = NULL;
-       struct rb_node **p = &key_user_tree.rb_node;
+       struct rb_node *parent;
+       struct rb_node **p;
 
  try_again:
+       parent = NULL;
+       p = &key_user_tree.rb_node;
        spin_lock(&key_user_lock);
 
        /* search the tree for a user record with a matching UID */

