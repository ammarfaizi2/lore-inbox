Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262687AbVG2SAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbVG2SAk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 14:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbVG2SAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 14:00:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6548 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262687AbVG2SAe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 14:00:34 -0400
Date: Fri, 29 Jul 2005 10:59:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kevin Radloff <radsaq@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>,
       acpi-devel@lists.sourceforge.net
Subject: Re: Followup on 2.6.13-rc3 ACPI processor C-state regression
Message-Id: <20050729105922.3da4b3aa.akpm@osdl.org>
In-Reply-To: <3b0ffc1f050713150527c7c649@mail.gmail.com>
References: <3b0ffc1f050713150527c7c649@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Radloff <radsaq@gmail.com> wrote:
>
> Previously, I had said that in 2.6.13-rc3, C2/C3 capabilities were not
> detected on my Fujitsu Lifebook P7010D. I found that in the merge at:
> 
> http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blobdiff;h=893b074e3d1a48a4390cf84b4c1a10ef6be2460c;hp=c9d671cf7857dbc7101e99d469fa24eed711ac60;hb=5028770a42e7bc4d15791a44c28f0ad539323807;f=drivers/acpi/processor_idle.c
> 
> .. in the section at (please forgive my destruction of the formatting) ...
> 
> @@ -787,10 +843,7 @@ static int acpi_processor_get_power_info
>          if ((result) || (acpi_processor_power_verify(pr) < 2)) {
>              result = acpi_processor_get_power_info_fadt(pr);
>              if (result)
> -                return_VALUE(result);
> -
> -            if (acpi_processor_power_verify(pr) < 2)
> -                return_VALUE(-ENODEV);
> +               result = acpi_processor_get_power_info_default_c1(pr);
>          }
> 
> .. a call to acpi_processor_power_verify() is removed, which breaks
> detection of C2/C3 capabilities if the above
> acpi_processor_get_power_info_cst() failed. It it had succeeded (and
> returned 0), then acpi_processor_power_verify() is called in the
> conditional statement, which will set the valid flags for C2/C3. But
> if it fails, like on my laptop, then the valid flags will never be
> set, despite the fact that the acpi_processor_get_power_info_fadt()
> function finds the necessary info for a subsequent
> acpi_processor_power_verify() call to succeed.
> 
> I don't know what exactly the proper fix here is (with the
> introduction of the acpi_processor_get_power_info_default_c1()
> function, that is), but simply reversing this part of the patch fixes
> detection of C2/C3 on my laptop.
> 

Len, Kevin confirms that the below patch fixes the above regression for
him.  Should we merge it now?


From: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>

Re-enable C2/C3 states for systems without CST.  Fixes a regression after
the patch for C2/C3 support for multiprocessors
(http://bugme.osdl.org/show_bug.cgi?id=4401), which accidentally removed
the acpi_processor_power_verify() call.

Signed-off-by: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/processor_idle.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/acpi/processor_idle.c~acpi-re-enable-c2-c3-cpu-states-for-systems-without drivers/acpi/processor_idle.c
--- devel/drivers/acpi/processor_idle.c~acpi-re-enable-c2-c3-cpu-states-for-systems-without	2005-07-14 15:53:47.000000000 -0700
+++ devel-akpm/drivers/acpi/processor_idle.c	2005-07-14 15:53:47.000000000 -0700
@@ -881,7 +881,7 @@ static int acpi_processor_get_power_info
 	result = acpi_processor_get_power_info_cst(pr);
 	if ((result) || (acpi_processor_power_verify(pr) < 2)) {
 		result = acpi_processor_get_power_info_fadt(pr);
-		if (result)
+		if ((result) || acpi_processor_power_verify(pr) < 2)
 			result = acpi_processor_get_power_info_default_c1(pr);
 	}
 
_

