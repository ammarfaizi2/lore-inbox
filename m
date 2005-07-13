Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262804AbVGMWJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262804AbVGMWJQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 18:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVGMWGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 18:06:23 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:13185 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262799AbVGMWFd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 18:05:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=IN89xVIKezvd+pLMyO4wGDdwSBm6iw57rk3SP9Z0yZy7pT034FhVmVm6NAQYge7ZvLVulDkLLKwWMrEFbu6T0N5HWN9k77eqhSITSP1j1yS3bCtNS2NWA7fYQgBNW0h7orYa8l5ykikMjBcr2IwCoXzYjiu/FY1JIlfjHrgdfWA=
Message-ID: <3b0ffc1f050713150527c7c649@mail.gmail.com>
Date: Wed, 13 Jul 2005 18:05:30 -0400
From: Kevin Radloff <radsaq@gmail.com>
Reply-To: Kevin Radloff <radsaq@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Followup on 2.6.13-rc3 ACPI processor C-state regression
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, I had said that in 2.6.13-rc3, C2/C3 capabilities were not
detected on my Fujitsu Lifebook P7010D. I found that in the merge at:

http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blobdiff;h=893b074e3d1a48a4390cf84b4c1a10ef6be2460c;hp=c9d671cf7857dbc7101e99d469fa24eed711ac60;hb=5028770a42e7bc4d15791a44c28f0ad539323807;f=drivers/acpi/processor_idle.c

.. in the section at (please forgive my destruction of the formatting) ...

@@ -787,10 +843,7 @@ static int acpi_processor_get_power_info
         if ((result) || (acpi_processor_power_verify(pr) < 2)) {
             result = acpi_processor_get_power_info_fadt(pr);
             if (result)
-                return_VALUE(result);
-
-            if (acpi_processor_power_verify(pr) < 2)
-                return_VALUE(-ENODEV);
+               result = acpi_processor_get_power_info_default_c1(pr);
         }

.. a call to acpi_processor_power_verify() is removed, which breaks
detection of C2/C3 capabilities if the above
acpi_processor_get_power_info_cst() failed. It it had succeeded (and
returned 0), then acpi_processor_power_verify() is called in the
conditional statement, which will set the valid flags for C2/C3. But
if it fails, like on my laptop, then the valid flags will never be
set, despite the fact that the acpi_processor_get_power_info_fadt()
function finds the necessary info for a subsequent
acpi_processor_power_verify() call to succeed.

I don't know what exactly the proper fix here is (with the
introduction of the acpi_processor_get_power_info_default_c1()
function, that is), but simply reversing this part of the patch fixes
detection of C2/C3 on my laptop.

Please CC me with any followups, as I'm not on the list.

-- 
Kevin 'radsaq' Radloff
radsaq@gmail.com
http://saqataq.us/
