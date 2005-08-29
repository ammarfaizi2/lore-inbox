Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbVH2OWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbVH2OWq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 10:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbVH2OWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 10:22:46 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:7464 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1750708AbVH2OWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 10:22:46 -0400
To: ncunningham@cyclades.com
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.13
X-Message-Flag: Warning: May contain useful information
References: <Pine.LNX.4.58.0508281708040.3243@g5.osdl.org>
	<1125317978.6496.10.camel@localhost>
From: Roland Dreier <rolandd@cisco.com>
Date: Mon, 29 Aug 2005 07:22:27 -0700
In-Reply-To: <1125317978.6496.10.camel@localhost> (Nigel Cunningham's
 message of "Mon, 29 Aug 2005 22:19:38 +1000")
Message-ID: <52oe7gomak.fsf@cisco.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 29 Aug 2005 14:22:29.0193 (UTC) FILETIME=[1632B390:01C5ACA5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Nigel" == Nigel Cunningham <ncunningham@cyclades.com> writes:

    Nigel> Hi.  I have a couple of reports of powering off being
    Nigel> broken between 2.6.13-rc7 and 2.6.13 :( (One my computer
    Nigel> and one a Suspend2 user). I'll happily test patches.

Well, there aren't many differences between 2.6.13-rc7 and 2.6.13.  If
I had to guess, I would bet the commit below is what broke you.  I'm
including a patch that reverts it at the end of this email

BTW, I have no knowledge of this area -- I'm just basing this on pure
changelog reading.  So if reverting this patch does fix your system, I
have no idea what the correct fix is.

 - R.

commit 8dbddf17824861f2298de093549e6493d9844835
Author: Eric W. Biederman <ebiederm@xmission.com>
Date:   Sat Aug 27 00:56:18 2005 -0600

    [PATCH] acpi_shutdown: Only prepare for power off on power_off

    When acpi_sleep_prepare was moved into a shutdown method we
    started calling it for all shutdowns.

    It appears this triggers some systems to power off on reboot.

    Avoid this by only calling acpi_sleep_prepare if we are going to power
    off the system.

    Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

diff --git a/drivers/acpi/sleep/poweroff.c b/drivers/acpi/sleep/poweroff.c
--- a/drivers/acpi/sleep/poweroff.c
+++ b/drivers/acpi/sleep/poweroff.c
@@ -55,11 +55,7 @@ void acpi_power_off(void)
 
 static int acpi_shutdown(struct sys_device *x)
 {
-	if (system_state == SYSTEM_POWER_OFF) {
-		/* Prepare if we are going to power off the system */
-		return acpi_sleep_prepare(ACPI_STATE_S5);
-	}
-	return 0;
+	return acpi_sleep_prepare(ACPI_STATE_S5);
 }
 
 static struct sysdev_class acpi_sysclass = {
