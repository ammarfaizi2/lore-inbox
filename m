Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264495AbTGBUxA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 16:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264496AbTGBUxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 16:53:00 -0400
Received: from air-2.osdl.org ([65.172.181.6]:10172 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264495AbTGBUw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 16:52:56 -0400
Subject: maybe: kexec + e100 + CONFIG_PM != working
From: Andy Pfiffer <andyp@osdl.org>
To: Ed L Cashin <ecashin@uga.edu>
Cc: fastboot@osdl.org,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <87d6gtrjjs.fsf@uga.edu>
References: <20030626120244.B29672@atlas.cs.uga.edu>
	 <1056753599.1200.53.camel@andyp.pdx.osdl.net> <87k7b2q6mt.fsf@uga.edu>
	 <87d6gtrjjs.fsf@uga.edu>
Content-Type: text/plain
Organization: 
Message-Id: <1057179998.4341.22.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 02 Jul 2003 14:06:38 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-01 at 15:03, Ed L Cashin wrote:
> Ed L Cashin <ecashin@uga.edu> writes:
> 
> ...
> > I haven't tried the experiment you suggested where I disable e100 in
> > the kernel configuration.
> 
> OK, I just tried taking out the intel e100 driver and building in
> Becker's eepro100 driver.  This kernel can do kexec fine.

I just had lunch with someone that knows a lot more about the e100
driver than I do.

I would be curious to know what happens if you disable CONFIG_PM (as
seen in your .config), disable the eepro100 driver, re-enable the e100
driver, and then try kexec again.

The hint I received is that the e100_suspend() routine could call
pci_set_power_state() on the way down during a kexec, and that could
leave the card in a state that is difficult to resurrect when the new
kernel starts initializing devices.

You might also try commenting out the pci_set_power_state() lines in
e100_suspend() and leave CONFIG_PM enabled (untested diff for
illustration):

--- e100_main.c.orig	Wed Jul  2 14:00:59 2003
+++ e100_main.c	Wed Jul  2 14:02:22 2003
@@ -4305,11 +4305,11 @@
 	/* If wol is enabled */
 	if (bdp->wolopts || e100_asf_enabled(bdp)) {
 		pci_enable_wake(pcid, 3, 1);	/* Enable PME for power state D3 */
-		pci_set_power_state(pcid, 3);	/* Set power state to D3.        */
+		/*pci_set_power_state(pcid, 3);*/	/* Set power state to D3.        */
 	} else {
 		/* Disable bus mastering */
 		pci_disable_device(pcid);
-		pci_set_power_state(pcid, state);
+		/*pci_set_power_state(pcid, state);*/
 	}
 	return 0;
 }








