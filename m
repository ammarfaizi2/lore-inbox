Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbVLMQA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbVLMQA4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 11:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbVLMQA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 11:00:56 -0500
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:57394 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932336AbVLMQAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 11:00:55 -0500
Message-ID: <439EF02F.8020300@gentoo.org>
Date: Tue, 13 Dec 2005 16:00:47 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051205)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       venkatesh.pallipadi@intel.com, len.brown@intel.com
Subject: Re: [patch 10/26] ACPI: Prefer _CST over FADT for C-state capabilities
References: <20051213073430.558435000@press.kroah.org> <20051213082251.GK5823@kroah.com>
In-Reply-To: <20051213082251.GK5823@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------090106040105090900010408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090106040105090900010408
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> 
> ------------------
> From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> 
> Note: This ACPI standard compliance may cause regression
> on some system, if they have _CST present, but _CST value
> is bogus. "nocst" module parameter should workaround
> that regression.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=5165
> 
> (cherry picked from 883baf7f7e81cca26f4683ae0d25ba48f094cc08 commit)
> 
> Signed-off-by: Venkatesh Pallipadi<venkatesh.pallipadi@intel.com>
> Signed-off-by: Len Brown <len.brown@intel.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> ---
>  drivers/acpi/processor_idle.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Venkatesh followed up in a private email that a 3rd patch is needed to  solve 
the hyperthreading slowdown issue. This patch is not yet in Linus' tree (it is 
in acpi-test).

Maybe we should drop these patches (10 and 12) until the 3rd patch has been 
merged. I haven't been shipping the 3rd patch in Gentoo (yet) so I'm not able 
to gauge its effect...

Attaching the 3rd patch anyway.

Daniel

--------------090106040105090900010408
Content-Type: text/x-patch;
 name="p_LVL2_UP-flag-increment.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="p_LVL2_UP-flag-increment.patch"

From: Len Brown <len.brown@intel.com>

Bug fix for bugzilla #5165 http://bugzilla.kernel.org/show_bug.cgi?id=5165

Incremental changes to earlier patch.
* Changing the polarity of plvl2_up
* Skip promotion/demotion code when not needed.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Shaohua Li <shaohua.li@intel.com>

Index: linux-acpi-2.6/drivers/acpi/processor_idle.c
===================================================================
--- linux-acpi-2.6.orig/drivers/acpi/processor_idle.c
+++ linux-acpi-2.6/drivers/acpi/processor_idle.c
@@ -278,8 +278,6 @@ static void acpi_processor_idle(void)
 		}
 	}
 
-	cx->usage++;
-
 #ifdef CONFIG_HOTPLUG_CPU
 	/*
 	 * Check for P_LVL2_UP flag before entering C2 and above on
@@ -287,9 +285,12 @@ static void acpi_processor_idle(void)
 	 * detection phase, to work cleanly with logical CPU hotplug.
 	 */
 	if ((cx->type != ACPI_STATE_C1) && (num_online_cpus() > 1) && 
-	    !pr->flags.has_cst && acpi_fadt.plvl2_up)
-		cx->type = ACPI_STATE_C1;
+	    !pr->flags.has_cst && !acpi_fadt.plvl2_up)
+		cx = &pr->power.states[ACPI_STATE_C1];
 #endif
+
+	cx->usage++;
+
 	/*
 	 * Sleep:
 	 * ------
@@ -378,6 +379,15 @@ static void acpi_processor_idle(void)
 
 	next_state = pr->power.state;
 
+#ifdef CONFIG_HOTPLUG_CPU
+	/* Don't do promotion/demotion */
+	if ((cx->type == ACPI_STATE_C1) && (num_online_cpus() > 1) &&
+	    !pr->flags.has_cst && !acpi_fadt.plvl2_up) {
+		next_state = cx;
+		goto end;
+	}
+#endif
+
 	/*
 	 * Promotion?
 	 * ----------
@@ -549,7 +559,7 @@ static int acpi_processor_get_power_info
 	 * Check for P_LVL2_UP flag before entering C2 and above on
 	 * an SMP system. 
 	 */
-	if ((num_online_cpus() > 1) && acpi_fadt.plvl2_up)
+	if ((num_online_cpus() > 1) && !acpi_fadt.plvl2_up)
 		return_VALUE(-ENODEV);
 #endif
 

--------------090106040105090900010408--
