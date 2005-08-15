Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964948AbVHOUXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbVHOUXq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 16:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbVHOUXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 16:23:45 -0400
Received: from smtpout.mac.com ([17.250.248.85]:25554 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S964948AbVHOUXp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 16:23:45 -0400
In-Reply-To: <20050815200522.GA3667@sysman-doug.us.dell.com>
References: <20050815200522.GA3667@sysman-doug.us.dell.com>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AC1976B5-FAFC-4809-B1B2-579D5F14FDFE@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base Driver (dcdbas) with sysfs support
Date: Mon, 15 Aug 2005 16:23:37 -0400
To: Doug Warzecha <Douglas_Warzecha@dell.com>
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 15, 2005, at 16:05:22, Doug Warzecha wrote:
> This patch adds the Dell Systems Management Base Driver with sysfs  
> support.

> +On some Dell systems, systems management software must access certain
> +management information via a system management interrupt (SMI).   
> The SMI data
> +buffer must reside in 32-bit address space, and the physical  
> address of the
> +buffer is required for the SMI.  The driver maintains the memory  
> required for
> +the SMI and provides a way for the application to generate the SMI.
> +The driver creates the following sysfs entries for systems management
> +software to perform these system management interrupts:

Why can't you just implement the system management actions in the kernel
driver?  This is tantamount to a binary SMI hook to userspace.  What
functionality does this provide on a dell system from an administrator's
point of view?

> +Host Control Action
> +
> +Dell OpenManage supports a host control feature that allows the  
> administrator
> +to perform a power cycle or power off of the system after the OS  
> has finished
> +shutting down.  On some Dell systems, this host control feature  
> requires that
> +a driver perform a SMI after the OS has finished shutting down.
> +
> +The driver creates the following sysfs entries for systems  
> management software
> +to schedule the driver to perform a power cycle or power off host  
> control
> +action after the system has finished shutting down:
> +
> +/sys/devices/platform/dcdbas/host_control_action
> +/sys/devices/platform/dcdbas/host_control_smi_type
> +/sys/devices/platform/dcdbas/host_control_on_shutdown

How is this different from shutdown() or reboot()?  What exactly is  
smi_type used
for?  Please provide better documentation on how to use this and what  
it does.

If this is supposed to be used with the RBU code to trigger a BIOS  
update, then
why not integrate it into one kernel driver that receives firmware,  
loads it into
the BIOS, and properly resets the machine at powerdown?  I think  
PowerPC does a
similar thing with OpenFirmware flash memory.  When I change the  
default boot
device or other firmware environment, I get a message from the kernel  
upon
shutdown:
Erasing <BRAND> flash bank 1...
Writing <BRAND> flash bank 1...

Would not a similar system work for Dell?  It would be far simpler to  
use than
the current mess of patches you've proposed.  If done properly, I  
could even
do this:

cat firmware-with-checksum.img >/sys/devices/platform/dellbios/ 
firmware_upgrade

Then an ordinary system reboot or shutdown would automatically use  
the SMI and
host-control-action to upgrade the firmware and shutdown or reboot,  
instead of
the normal ACPI shutdown and reboot code.

Cheers,
Kyle Moffett

--
Somone asked me why I work on this free (http://www.fsf.org/philosophy/)
software stuff and not get a real job. Charles Shultz had the best  
answer:

"Why do musicians compose symphonies and poets write poems? They do  
it because
life wouldn't have any meaning for them if they didn't. That's why I  
draw
cartoons. It's my life."
   -- Charles Shultz


