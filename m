Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965251AbWGJVfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965251AbWGJVfs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 17:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965248AbWGJVfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 17:35:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5609 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965245AbWGJVfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 17:35:46 -0400
Date: Mon, 10 Jul 2006 14:35:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Brown, Len" <len.brown@intel.com>
Cc: vladimir.p.lebedev@intel.com, pavel@ucw.cz, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
Subject: Re: [patch] fix boot with acpi=off
Message-Id: <20060710143542.e1be4877.akpm@osdl.org>
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6ED0026@hdsmsx411.amr.corp.intel.com>
References: <CFF307C98FEABE47A452B27C06B85BB6ED0026@hdsmsx411.amr.corp.intel.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006 14:37:53 -0400
"Brown, Len" <len.brown@intel.com> wrote:

> Dunno why acpi_lock_ac_dir() makes pavel's box fail w/ acpi=off.

a) Because acpi_ac_init() forgot to check acpi_disabled, so
   acpi_ac_init() calls acpi_lock_ac_dir() even with acpi=off.

b) Because acpi_lock_ac_dir() is doing down() on an uninitialised
   semaphore, which hangs.

The fix to b) is in your tree now.

The fix for a) is below.



From: Pavel Machek <pavel@ucw.cz>

With acpi=off and acpi_ac/battery compiled into kernel, acpi breaks
boot. This fixes it.

Signed-off-by: Pavel Machek <pavel@suse.cz>
Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/ac.c      |    2 ++
 drivers/acpi/battery.c |    3 +++
 2 files changed, 5 insertions(+)

diff -puN drivers/acpi/ac.c~acpi-fix-boot-with-acpi=off drivers/acpi/ac.c
--- a/drivers/acpi/ac.c~acpi-fix-boot-with-acpi=off
+++ a/drivers/acpi/ac.c
@@ -285,6 +285,8 @@ static int __init acpi_ac_init(void)
 {
 	int result;
 
+	if (acpi_disabled)
+		return -ENODEV;
 
 	acpi_ac_dir = acpi_lock_ac_dir();
 	if (!acpi_ac_dir)
diff -puN drivers/acpi/battery.c~acpi-fix-boot-with-acpi=off drivers/acpi/battery.c
--- a/drivers/acpi/battery.c~acpi-fix-boot-with-acpi=off
+++ a/drivers/acpi/battery.c
@@ -757,6 +757,9 @@ static int __init acpi_battery_init(void
 {
 	int result;
 
+	if (acpi_disabled)
+		return -ENODEV;
+
 	acpi_battery_dir = acpi_lock_battery_dir();
 	if (!acpi_battery_dir)
 		return -ENODEV;
_

