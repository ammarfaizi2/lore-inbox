Return-Path: <linux-kernel-owner+w=401wt.eu-S965214AbWL2WBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965214AbWL2WBm (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 17:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965216AbWL2WBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 17:01:42 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:22972 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965214AbWL2WBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 17:01:41 -0500
Date: Fri, 29 Dec 2006 14:01:24 -0800
From: Martin Stoilov <mstoilov@odesys.com>
Subject: [PATCH] kobject: kobj->k_name verification fix
To: linux-kernel@vger.kernel.org
Message-id: <45959034.6050702@odesys.com>
MIME-version: 1.0
Content-type: multipart/mixed; boundary=------------050407080806080202050504
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050407080806080202050504
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

The function 'kobject_add' tries to verify the name of
a new kobject instance is properly set before continuing.
    if (!kobj->k_name)
        kobj->k_name = kobj->name;
    if (!kobj->k_name) {
        pr_debug("kobject attempted to be registered with no name!\n");
        WARN_ON(1);
        return -EINVAL;
    }
The statement:
    if (!kobj->k_name) {
        pr_debug("kobject attempted to be registered with no name!\n");
        WARN_ON(1);
        return -EINVAL;
    }
is useless the way it is right now, because it can never be true. I
think the
code was intended to be:
    if (!kobj->k_name)
        kobj->k_name = kobj->name;
    if (!*kobj->k_name) {
        pr_debug("kobject attempted to be registered with no name!\n");
        WARN_ON(1);
        return -EINVAL;
    }
because this would make sure the kobj->name buffer has something in it.
So the missing '*' is just a typo. Although, I would much prefer
expression like:
    if (*kobj->k_name == '\0') {
        pr_debug("kobject attempted to be registered with no name!\n");
        WARN_ON(1);
        return -EINVAL;
    }
because this would've made the intention clear, in this patch
I just restore the missing '*' without changing the coding style of
the function.

It looks like thunderbird client replaces the tabs with spaces even if I say
'paste without formatting'. Don't know how to insert the patch intact in
the
body of the message. Attaching the patch.

Signed-off-by: Martin Stoilov <mstoilov@odesys.com>
---



--------------050407080806080202050504
Content-Type: text/x-patch;
 name="kobject_add.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kobject_add.patch"

diff -pNru linux-2.6.20-rc2/lib/kobject.c linux-2.6.20-rc2.mod/lib/kobject.c
--- linux-2.6.20-rc2/lib/kobject.c	2006-12-29 11:48:30.000000000 -0800
+++ linux-2.6.20-rc2.mod/lib/kobject.c	2006-12-29 11:50:42.000000000 -0800
@@ -167,7 +167,7 @@ int kobject_add(struct kobject * kobj)
 		return -ENOENT;
 	if (!kobj->k_name)
 		kobj->k_name = kobj->name;
-	if (!kobj->k_name) {
+	if (!*kobj->k_name) {
 		pr_debug("kobject attempted to be registered with no name!\n");
 		WARN_ON(1);
 		return -EINVAL;

--------------050407080806080202050504--
