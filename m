Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbVIRGPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbVIRGPP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 02:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbVIRGPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 02:15:14 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:44972 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751192AbVIRGPN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 02:15:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:x-enigmail-version:content-type:content-transfer-encoding;
        b=LXRTA/Y5izwPCX5yX+FdJV9SOJCI+sfoH9L2Cf3GvXboKAQQO4rYsk6wNVaO8ADW2RH30HTRAtrQAOdJl/CB+Jsmu4Lw0XbsU2CGBmnE52E1gMmXXTSYMhkNAveDqsntgpMyi7j40uVf5ylF4Cx3015kQV57zkA2lB0N3JNTErw=
Message-ID: <432D0612.7070408@gmail.com>
Date: Sun, 18 Sep 2005 02:15:46 -0400
From: Florin Malita <fmalita@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org, ctindel@users.sourceforge.net, fubar@us.ibm.com
Subject: [PATCH] bond_main.c: fix device deregistration in init exception
 path
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bond_init() is not releasing rtnl_sem after register_netdevice() and
before calling unregister_netdevice() (from bond_free_all()) in the
exception path. As the device registration is not completed
(dev->reg_state == NETREG_REGISTERING), the call to
unregister_netdevice() triggers BUG_ON(dev->reg_state != NETREG_REGISTERED).

Signed-off-by: Florin Malita <fmalita@gmail.com>
----
diff --git a/drivers/net/bonding/bond_main.c
b/drivers/net/bonding/bond_main.c
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5039,6 +5039,10 @@ static int __init bonding_init(void)
        return 0;

 out_err:
+       /* give register_netdevice() a chance to complete */
+       rtnl_unlock();
+       rtnl_lock();
+
        /* free and unregister all bonds that were successfully added */
        bond_free_all();
