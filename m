Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUFCGSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUFCGSZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 02:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbUFCGSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 02:18:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:6370 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264212AbUFCGRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 02:17:37 -0400
Date: Wed, 2 Jun 2004 23:16:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: PATCH: Submission of via "velocity(tm)" series adapter driver
Message-Id: <20040602231648.57a08478.akpm@osdl.org>
In-Reply-To: <20040602201315.GA10339@devserv.devel.redhat.com>
References: <20040602201315.GA10339@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@redhat.com> wrote:
>
> +config VIA_VELOCITY
>  +	tristate "VIA Velocity support"

The driver bites the big one when there's no hardware present because it
still calls register_inetaddr_notifier():


Unable to handle kernel NULL pointer dereference at virtual address 000000e8
 printing eip:                                                              
*pde = 00000000
Oops: 0000 [#1]
SMP            
Modules linked in:
CPU:    0         
EIP:    0060:[<c024a10d>]    Not tainted VLI
EFLAGS: 00010286   (2.6.7-rc2-mm2)          
EIP is at velocity_netdev_event+0x15/0x40
eax: 00000000   ebx: c0474b88   ecx: cff94780   edx: c17a03d8
esi: cfc89114   edi: 00000001   ebp: ce0d3c08   esp: ce0d3c08
ds: 007b   es: 007b   ss: 0068                               
Process ip (pid: 1350, threadinfo=ce0d2000 task=ce4b8230)
Stack: ce0d3c28 c0127d67 c0474b88 00000001 cfc89114 cfc89114 cff71d48 cff71d38 
       ce0d3c50 c036246d c05304b0 00000001 cfc89114 00000014 cfc89114 cfc89114 
       ce0d3cbc cff71d38 ce0d3c74 c03628db cfc89114 ce84cc80 ce0d3cbc cff14e00 
Call Trace:                                                                    
 [<c0107ac3>] show_stack+0x83/0x90
 [<c0107c02>] show_registers+0x112/0x184
 [<c0107d70>] die+0x7c/0xe8             
 [<c01161da>] do_page_fault+0x3b6/0x516
 [<c0107751>] error_code+0x2d/0x38     
 [<c0127d67>] notifier_call_chain+0x23/0x40
 [<c036246d>] inet_insert_ifa+0x155/0x164  
 [<c03628db>] inet_rtm_newaddr+0x193/0x1a4
 [<c033594d>] rtnetlink_rcv+0x255/0x374   
 [<c0338fc5>] netlink_data_ready+0x1d/0x54
 [<c03387b6>] netlink_sendskb+0x22/0x44   
 [<c03388aa>] netlink_unicast+0x8e/0x98
 [<c0338dbf>] netlink_sendmsg+0x26b/0x27c
 [<c03273c5>] sock_sendmsg+0xa1/0xc0     
 [<c0328bf7>] sys_sendmsg+0x18f/0x1f4
 [<c0328fbb>] sys_socketcall+0x183/0x19c
 [<c0106c71>] sysenter_past_esp+0x52/0x71




There may be more elegant ways than this.  Maybe it should be done in ->open?




- Don't register the inet_addr notifier if the hardware is absent.  It
  oopses when other interfaces are being upped.

- Mark velocity_remove1() as __devexit_p in the pci_driver table.

- c99ification.


Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/net/via-velocity.c |   29 ++++++++++++++++++-----------
 1 files changed, 18 insertions(+), 11 deletions(-)

diff -puN drivers/net/via-velocity.c~via-velocity-oops-fix drivers/net/via-velocity.c
--- 25/drivers/net/via-velocity.c~via-velocity-oops-fix	2004-06-02 23:14:37.933999272 -0700
+++ 25-akpm/drivers/net/via-velocity.c	2004-06-02 23:14:37.939998360 -0700
@@ -269,8 +269,9 @@ static int velocity_resume(struct pci_de
 static int velocity_netdev_event(struct notifier_block *nb, unsigned long notification, void *ptr);
 
 static struct notifier_block velocity_inetaddr_notifier = {
-      notifier_call:velocity_netdev_event,
+      .notifier_call	= velocity_netdev_event,
 };
+static int velocity_notifier_registered;
 
 #endif				/* CONFIG_PM */
 
@@ -776,6 +777,12 @@ static int __devinit velocity_found1(str
 
 	pci_set_power_state(pdev, 3);
 out:
+#ifdef CONFIG_PM
+	if (ret == 0 && !velocity_notifier_registered) {
+		velocity_notifier_registered = 1;
+		register_inetaddr_notifier(&velocity_inetaddr_notifier);
+	}
+#endif
 	return ret;
 
 err_iounmap:
@@ -2123,13 +2130,13 @@ static int velocity_ioctl(struct net_dev
  */
 
 static struct pci_driver velocity_driver = {
-      name:VELOCITY_NAME,
-      id_table:velocity_id_table,
-      probe:velocity_found1,
-      remove:velocity_remove1,
+      .name	= VELOCITY_NAME,
+      .id_table	= velocity_id_table,
+      .probe	= velocity_found1,
+      .remove	= __devexit_p(velocity_remove1),
 #ifdef CONFIG_PM
-      suspend:velocity_suspend,
-      resume:velocity_resume,
+      .suspend	= velocity_suspend,
+      .resume	= velocity_resume,
 #endif
 };
 
@@ -2147,9 +2154,6 @@ static int __init velocity_init_module(v
 	int ret;
 	ret = pci_module_init(&velocity_driver);
 
-#ifdef CONFIG_PM
-	register_inetaddr_notifier(&velocity_inetaddr_notifier);
-#endif
 	return ret;
 }
 
@@ -2165,7 +2169,10 @@ static int __init velocity_init_module(v
 static void __exit velocity_cleanup_module(void)
 {
 #ifdef CONFIG_PM
-	unregister_inetaddr_notifier(&velocity_inetaddr_notifier);
+	if (velocity_notifier_registered) {
+		unregister_inetaddr_notifier(&velocity_inetaddr_notifier);
+		velocity_notifier_registered = 0;
+	}
 #endif
 	pci_unregister_driver(&velocity_driver);
 }
_

