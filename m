Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946866AbWKAMp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946866AbWKAMp0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 07:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946864AbWKAMp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 07:45:26 -0500
Received: from ns1.suse.de ([195.135.220.2]:23772 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752078AbWKAMpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 07:45:25 -0500
Date: Wed, 1 Nov 2006 13:45:01 +0100
From: Stefan Seyfried <seife@suse.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>,
       Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>,
       LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
       linux-acpi@vger.kernel.org
Subject: Re: [PATCH] swsusp: Use platform mode by default
Message-ID: <20061101124501.GE10269@suse.de>
References: <200611011323.14830.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200611011323.14830.rjw@sisk.pl>
X-Operating-System: openSUSE 10.2 (i586) Beta2, Kernel 2.6.18.1-12-default
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 01:23:14PM +0100, Rafael J. Wysocki wrote:
> It has been reported that on some systems the functionality after a resume
> from disk is limited if the system is simply powered off during the suspend
> instead of using the ACPI S4 suspend (aka platform mode).
> 
> Unfortunately the default is currently to power off the system during the
> suspend so the users of these systems experience problems after the resume
> if they don't switch to the platform mode explicitly.  This patch makes swsusp
> use the platform mode by default to avoid such situations.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---

Acked-by: Stefan Seyfried <seife@suse.de>

Some background: i have put this as a default (from userspace, via
echo "platform" > disk) since at least two years (SuSE 9.3, probably
earlier) and have received one single bugreport where using "shutdown"
mode fixed a problem. I had much more reports from users that upgraded
from 9.1 and did not get the new setting about problems with "shutdown"
which were solved by changing to "platform", so from my experience,
"platform" mode is actually working better than "shutdown" mode.

Note that shutdown mode will not lead to spectacular failures, but small
annoyances like incorrectly reported AC / battery state etc.

> Index: linux-2.6.19-rc4-mm1/kernel/power/disk.c
> ===================================================================
> --- linux-2.6.19-rc4-mm1.orig/kernel/power/disk.c
> +++ linux-2.6.19-rc4-mm1/kernel/power/disk.c
> @@ -62,9 +62,11 @@ static void power_down(suspend_disk_meth
>  
>  	switch(mode) {
>  	case PM_DISK_PLATFORM:
> -		kernel_shutdown_prepare(SYSTEM_SUSPEND_DISK);
> -		error = pm_ops->enter(PM_SUSPEND_DISK);
> -		break;
> +		if (pm_ops && pm_ops->enter) {
> +			kernel_shutdown_prepare(SYSTEM_SUSPEND_DISK);
> +			error = pm_ops->enter(PM_SUSPEND_DISK);
> +			break;
> +		}

I have never heard of a system that had problems with not-present
pm_ops->enter, but this extra safety net cannot hurt.
-- 
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg  | "Well, surrounding them's out." 
