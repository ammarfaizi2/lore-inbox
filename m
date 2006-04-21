Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWDUErf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWDUErf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 00:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWDUEok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 00:44:40 -0400
Received: from mail.kroah.org ([69.55.234.183]:5762 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932247AbWDUEoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 00:44:14 -0400
Date: Thu, 20 Apr 2006 21:37:57 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Alexander Patrakov <patrakov@ums.usu.ru>,
       David Miller <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 05/22] : Fix hotplug race during device registration
Message-ID: <20060421043757.GF12846@kroah.com>
References: <20060421043353.602539000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-hotplug-race-during-device-registration.patch"
In-Reply-To: <20060421043706.GA12846@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas de Grenier de Latour <degrenier@easyconnect.fr>

On Sun, 9 Apr 2006 21:56:59 +0400,
Sergey Vlasov <vsu@altlinux.ru> wrote:
> However, show_address() does not output anything unless
> dev->reg_state == NETREG_REGISTERED - and this state is set by
> netdev_run_todo() only after netdev_register_sysfs() returns, so in
> the meantime (while netdev_register_sysfs() is busy adding the
> "statistics" attribute group) some process may see an empty "address"
> attribute.

I've tried the attached patch, suggested by Sergey Vlasov on
hotplug-devel@, and as far as i can test it works just fine.

Signed-off-by: Alexander Patrakov <patrakov@ums.usu.ru>
Signed-off-by: David Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/core/dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.16.9.orig/net/core/dev.c
+++ linux-2.6.16.9/net/core/dev.c
@@ -2932,11 +2932,11 @@ void netdev_run_todo(void)
 
 		switch(dev->reg_state) {
 		case NETREG_REGISTERING:
+			dev->reg_state = NETREG_REGISTERED;
 			err = netdev_register_sysfs(dev);
 			if (err)
 				printk(KERN_ERR "%s: failed sysfs registration (%d)\n",
 				       dev->name, err);
-			dev->reg_state = NETREG_REGISTERED;
 			break;
 
 		case NETREG_UNREGISTERING:

--
