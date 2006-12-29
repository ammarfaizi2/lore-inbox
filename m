Return-Path: <linux-kernel-owner+w=401wt.eu-S965040AbWL2Hr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbWL2Hr4 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 02:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965045AbWL2Hr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 02:47:56 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:26036 "EHLO
	vms048pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965040AbWL2Hrz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 02:47:55 -0500
X-Greylist: delayed 3608 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Dec 2006 02:47:55 EST
Date: Thu, 28 Dec 2006 22:47:37 -0800
From: Martin Stoilov <mstoilov@odesys.com>
Subject: kobject_add unreachable code
To: linux-kernel@vger.kernel.org
Message-id: <4594BA09.1080509@odesys.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7bit
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following code in kobject_add
    if (!kobj->k_name)
        kobj->k_name = kobj->name;
    if (!kobj->k_name) {
        pr_debug("kobject attempted to be registered with no name!\n");
        WARN_ON(1);
        return -EINVAL;
    }

doesn't look right to me. The second 'if' statement looks useless after
the assignment in the first one. May be it was meant to be like:
if (!*kobj->k_name)

See the full patch:

--- linux-2.6.20-rc2/lib/kobject.c      2006-12-28 19:59:56.000000000 -0800
+++ linux-2.6.20-rc2.mod/lib/kobject.c  2006-12-28 20:00:25.000000000 -0800
@@ -161,19 +161,19 @@
 int kobject_add(struct kobject * kobj)
 {
        int error = 0;
        struct kobject * parent;

        if (!(kobj = kobject_get(kobj)))
                return -ENOENT;
        if (!kobj->k_name)
                kobj->k_name = kobj->name;
-       if (!kobj->k_name) {
+       if (!*kobj->k_name) {
                pr_debug("kobject attempted to be registered with no
name!\n");
                WARN_ON(1);
                return -EINVAL;
        }
        parent = kobject_get(kobj->parent);


-Martin

