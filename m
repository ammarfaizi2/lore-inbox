Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbVDCMkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVDCMkb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 08:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbVDCMkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 08:40:31 -0400
Received: from ppp-184-150.30-151.libero.it ([151.30.150.184]:59916 "EHLO
	gandalf") by vger.kernel.org with ESMTP id S261716AbVDCMkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 08:40:05 -0400
Message-ID: <424E81CC.6000600@gmail.com>
Date: Sat, 02 Apr 2005 11:28:12 +0000
From: Luca Falavigna <dktrkranz@gmail.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: kaos@ocs.com.au
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] RCU in kernel/intermodule.c
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch, compiled against version 2.6.12-rc1, implements RCU mechanism in
intermodule functions.



Signed-off-by: Luca Falavigna <dktrkranz@gmail.com>

- --- ./kernel/intermodule.c.orig	2005-04-01 19:25:26.000000000 +0000
+++ ./kernel/intermodule.c	2005-04-02 02:46:22.000000000 +0000
@@ -3,7 +3,7 @@
 /* Written by Keith Owens <kaos@ocs.com.au> Oct 2000 */
 #include <linux/module.h>
 #include <linux/kmod.h>
- -#include <linux/spinlock.h>
+#include <linux/rcupdate.h>
 #include <linux/list.h>
 #include <linux/slab.h>

@@ -14,7 +14,6 @@
  */

 static struct list_head ime_list = LIST_HEAD_INIT(ime_list);
- -static DEFINE_SPINLOCK(ime_lock);
 static int kmalloc_failed;

 struct inter_module_entry {
@@ -22,8 +21,17 @@ struct inter_module_entry {
 	const char *im_name;
 	struct module *owner;
 	const void *userdata;
+	struct rcu_head rcu;
 };

+static void inter_module_free(struct rcu_head *rcu)
+{
+	struct inter_module_entry *ime;
+	
+	ime = container_of(rcu, struct inter_module_entry, rcu);
+	kfree(ime);
+}
+
 /**
  * inter_module_register - register a new set of inter module data.
  * @im_name: an arbitrary string to identify the data, must be unique
@@ -36,7 +44,6 @@ struct inter_module_entry {
  */
 void inter_module_register(const char *im_name, struct module *owner, const
void *userdata)
 {
- -	struct list_head *tmp;
 	struct inter_module_entry *ime, *ime_new;

 	if (!(ime_new = kmalloc(sizeof(*ime), GFP_KERNEL))) {
@@ -52,19 +59,15 @@ void inter_module_register(const char *i
 	ime_new->owner = owner;
 	ime_new->userdata = userdata;

- -	spin_lock(&ime_lock);
- -	list_for_each(tmp, &ime_list) {
- -		ime = list_entry(tmp, struct inter_module_entry, list);
+	list_for_each_entry(ime, &ime_list, list) {
 		if (strcmp(ime->im_name, im_name) == 0) {
- -			spin_unlock(&ime_lock);
 			kfree(ime_new);
 			/* Program logic error, fatal */
 			printk(KERN_ERR "inter_module_register: duplicate im_name '%s'", im_name);
 			BUG();
 		}
 	}
- -	list_add(&(ime_new->list), &ime_list);
- -	spin_unlock(&ime_lock);
+	list_add_rcu(&ime_new->list, &ime_list);
 }

 /**
@@ -77,20 +80,15 @@ void inter_module_register(const char *i
  */
 void inter_module_unregister(const char *im_name)
 {
- -	struct list_head *tmp;
 	struct inter_module_entry *ime;

- -	spin_lock(&ime_lock);
- -	list_for_each(tmp, &ime_list) {
- -		ime = list_entry(tmp, struct inter_module_entry, list);
+	list_for_each_entry(ime, &ime_list, list) {
 		if (strcmp(ime->im_name, im_name) == 0) {
- -			list_del(&(ime->list));
- -			spin_unlock(&ime_lock);
- -			kfree(ime);
+			list_del_rcu(&(ime->list));
+			call_rcu(&ime->rcu, inter_module_free);
 			return;
 		}
 	}
- -	spin_unlock(&ime_lock);
 	if (kmalloc_failed) {
 		printk(KERN_ERR
 			"inter_module_unregister: no entry for '%s', "
@@ -115,20 +113,18 @@ void inter_module_unregister(const char
  */
 static const void *inter_module_get(const char *im_name)
 {
- -	struct list_head *tmp;
 	struct inter_module_entry *ime;
 	const void *result = NULL;

- -	spin_lock(&ime_lock);
- -	list_for_each(tmp, &ime_list) {
- -		ime = list_entry(tmp, struct inter_module_entry, list);
+	rcu_read_lock();
+	list_for_each_entry_rcu(ime, &ime_list, list) {
 		if (strcmp(ime->im_name, im_name) == 0) {
 			if (try_module_get(ime->owner))
 				result = ime->userdata;
 			break;
 		}
 	}
- -	spin_unlock(&ime_lock);
+	rcu_read_unlock();
 	return(result);
 }

@@ -158,20 +154,18 @@ const void *inter_module_get_request(con
  */
 void inter_module_put(const char *im_name)
 {
- -	struct list_head *tmp;
 	struct inter_module_entry *ime;

- -	spin_lock(&ime_lock);
- -	list_for_each(tmp, &ime_list) {
- -		ime = list_entry(tmp, struct inter_module_entry, list);
+	rcu_read_lock();
+	list_for_each_entry(ime, &ime_list, list) {
 		if (strcmp(ime->im_name, im_name) == 0) {
 			if (ime->owner)
 				module_put(ime->owner);
- -			spin_unlock(&ime_lock);
+			rcu_read_unlock();
 			return;
 		}
 	}
- -	spin_unlock(&ime_lock);
+	rcu_read_unlock();
 	printk(KERN_ERR "inter_module_put: no entry for '%s'", im_name);
 	BUG();
 }

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQEVAwUBQk6BzMzkDT3RfMB6AQI+BggAu476KZ3UOURm+IOBJyFnrtpaC9OgA2/c
5Q5A3Rvl0RZkuv3xCZino9eMNOqhC7HOSbvS7OfOwuhSe6my8F2eSImQb8H0rGCa
T1TGa5FdO0IDDlX0pDkFX5h2fv9bcoyCMlWC2UI8c9x12jpWaU/rBQASBn+Wg58F
aeszrjaRWrXuXU47y6FucWbegc0X2eU7b+1sPMCRlA9X3f6agCOcgrmpZdjyrJm3
0Q5IpEW3AR/Aicbe4+n1mIj5LOahSQNU+lFq/yNgaNKPpOfBc9+dgyfpVAt2jSb/
UEC2PWqLcVFar+JSTbI6EYDyasb4dfFQtds/pIXo1POh6rAPboTiXA==
=Rm4E
-----END PGP SIGNATURE-----

