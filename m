Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161063AbWBPNoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161063AbWBPNoP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 08:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161118AbWBPNoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 08:44:15 -0500
Received: from fmmailgate05.web.de ([217.72.192.243]:45483 "EHLO
	fmmailgate05.web.de") by vger.kernel.org with ESMTP
	id S1161063AbWBPNoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 08:44:15 -0500
Date: Thu, 16 Feb 2006 14:44:06 +0100
Message-Id: <503052906@web.de>
MIME-Version: 1.0
From: Eckehardt Luhm <bselu@web.de>
To: andrewm@uow.edu.au, linux-kernel@vger.kernel.org
Subject: WOL problems with 3COM905C and suspend to disk
Organization: http://freemail.web.de/
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm experiencing problems using Wake On LAN with the 3c59x-driver of kernel
2.6.11.

The driver is loaded correctly with enable_wol=1. When going to suspend with
issuing "echo disk > /sys/power/state" vortex_down() seems to be called (I
added some debug outputs there). That's fine, because of the function
acpi_set_WOL() being called preparing the NIC for WOL.

Unfortunately right before the PC eventually goes down, the vortex driver
seems to be opened again. Adding some printk's to the driver I was able to
observe that after vortex_down() is called, and right before the RAM image
is saved to disk, vortex_up() is called. That's bad, because that disables
WOL. Then the power goes off and it's not possible to wake the PC by WOL.

I can exclude all kinds of hardware problems, because I managed to get it
working using a workaround. I added a global variable "vortex_down_called"
which is 0 by default. In vortex_down() I set it to 1 once acpi_set_WOL()
is called. Inside vortex_up() I first query this variable. If it's 0 the
function is executed normally. When it's 1 I return immediately not
executing vortex_up().

With this workaround WOL works fine after the suspend, the PC awakes as
expected. Of course I have to reload the 3c59x module once the PC has
resumed. Actually I don't like that workaround. Can you tell me, who is
re-opening the driver once it has been closed for suspend? What can I do
to make WOL work correctly?

Best regards, Ecke

______________________________________________________________
Verschicken Sie romantische, coole und witzige Bilder per SMS!
Jetzt bei WEB.DE FreeMail: http://f.web.de/?mc=021193

