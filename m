Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965185AbVHPKGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965185AbVHPKGM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 06:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965188AbVHPKGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 06:06:12 -0400
Received: from pcsbom.patni.com ([203.124.139.208]:28327 "EHLO
	pcsspz.PATNI.COM") by vger.kernel.org with ESMTP id S965185AbVHPKGM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 06:06:12 -0400
Reply-To: <shahid.shaikh@patni.com>
From: "shahid shaikh" <shahid.shaikh@patni.com>
To: <linux-kernel@vger.kernel.org>
Subject: Defination of Flag CONFIG_DEBUG_SPINLOCK_SLEEP in AS4 UP1
Date: Tue, 16 Aug 2005 15:37:07 +0530
Message-ID: <00a501c5a24a$4339aca0$11051aac@pcp41116>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1124187238-14495-287"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format...

------------=_1124187238-14495-287
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,
While doing insmod for a psuedo driver, kernel is dumping a stack because
sleep function is called.
My init_module function for psuedo driver calls add_disk to register admin
device.
In add_disk(), kernel is allocating memory using kmalloc with flag
GFP_KERNEL. This is hardcoded in kernel code for add_disk.

Whenever kernel inserts any module or driver it disable all interrupts. But
allocating memory with GFP_KERNEL  flag may sleep. This becomes self
contradicting. Hence an invalid context.
Through kmalloc(), might_sleep_if( flag & GFP_WAIT ) function is called
where flag is GFP_KERNEL.
At this, sleep function is called.
Sleep function have been defined differently depending on defination of
CONFIG_DEBUG_SPINLOCK_SLEEP flag.
The above flag is defined in AS4 UP1. If the flag is defined, might_sleep()
function calls sleep function and then calls reschedule function.
If not defined, might_sleep() function directly calls reschedule function.
In sleep function if irqs_disabled() returns 1, it dumps stack.
irqs_disabled() returns 1 when irqs are disabled.

What we should do to avoid the above scenario?

GFP_KERNEL flag in kmalloc code is hard coded. Can't change that.

We have to call add_disk from our init_module to register admin device for
our psuedo driver.

We tried by enabling irqs before calling add_disk using kernel api
local_irq_enable(). It works fine.
But is it correct to enable irqs in a kernel module?
After add_disk we even restored it back using kernel api
local_irq_disable().

Or is there any other way around thorugh which we can avoid the above
scenario?

Warm Regards,
Shahid Shaikh.





http://www.patni.com
World-Wide Partnerships. World-Class Solutions.
_____________________________________________________________________

This e-mail message may contain proprietary, confidential or legally
privileged information for the sole use of the person or entity to
whom this message was originally addressed. Any review, e-transmission
dissemination or other use of or taking of any action in reliance upon
this information by persons or entities other than the intended
recipient is prohibited. If you have received this e-mail in error
kindly delete  this e-mail from your records. If it appears that this
mail has been forwarded to you without proper authority, please notify
us immediately at netadmin@patni.com and delete this mail. 
_____________________________________________________________________

------------=_1124187238-14495-287--
