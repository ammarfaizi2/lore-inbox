Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751808AbWGZWl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbWGZWl7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 18:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbWGZWl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 18:41:59 -0400
Received: from redflag.CS.Princeton.EDU ([128.112.136.72]:28054 "EHLO
	redflag.CS.Princeton.EDU") by vger.kernel.org with ESMTP
	id S1751808AbWGZWl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 18:41:58 -0400
Message-ID: <44C7EF59.80200@cs.princeton.edu>
Date: Wed, 26 Jul 2006 18:40:25 -0400
From: Mark Huang <mlhuang@CS.Princeton.EDU>
Organization: Princeton University
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050929 Thunderbird/1.0.7 Fedora/1.0.7-1.1.fc4 Mnenhy/0.7.3.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] module_subsys: initialize earlier
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlx=-1 adultscore=0 adjust=0 reason=safe engine=3.0.0-0606280001 definitions=main-0607260019
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize module_subsys earlier (or at least earlier than devices) since it 
could be used very early in the boot process if kmod loads a module before the 
device initcalls. Otherwise, kmod will crash in 
kernel/module.c:mod_sysfs_setup() since the kset in module_subsys is not 
initialized yet.

I only noticed this problem because occasionally, kmod loads the modules for my 
SCSI and Ethernet adapters very early, during the boot process itself. I don't 
quite understand why it loads them sometimes and doesn't load them other times. 
Or who is telling kmod to do so. Can someone explain?

Please Cc: me on responses, thanks.

Signed-off-by: Mark Huang <mlhuang@cs.princeton.edu>

--- linux-2.6.18-rc2/kernel/params.c    2006-07-25 16:46:56.000000000 -0400
+++ linux-2.6.18-rc2.sysfs/kernel/params.c      2006-07-26 17:53:51.000000000 -0
400
@@ -690,7 +690,7 @@ static int __init param_sysfs_init(void)

         return 0;
  }
-__initcall(param_sysfs_init);
+subsys_initcall(param_sysfs_init);

  EXPORT_SYMBOL(param_set_byte);
  EXPORT_SYMBOL(param_get_byte);

