Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWJ1Su2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWJ1Su2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 14:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWJ1Su2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 14:50:28 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:33674 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932080AbWJ1Su0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 14:50:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=eOZ/Q/LlbS9nRSeG0lck3QI1BH0O+piEG+VLarHUsZ+w+ISCOa1KvDiPwseK0xVGkSdeatTOEXUXbo7wnU87Rp10fVniuQEhdbeVh9IqXJeQBEHZKNbZE8dGUp0vxyt1Sb5mhsHGJ0atQcQm2imgJuHb3WWysjC4uhPTtXZak5Q=
Date: Sun, 29 Oct 2006 03:50:48 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>,
       Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [PATCH] acpiphp: fix missing acpiphp_glue_exit()
Message-ID: <20061028185048.GI9973@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
	Kristen Carlson Accardi <kristen.c.accardi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

acpiphp_glue_exit() needs to be called to unwind when no slots found.
(It fixes data corruption when reloading acpiphp driver with no such devices)

Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 drivers/pci/hotplug/acpiphp_core.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: work-fault-inject/drivers/pci/hotplug/acpiphp_core.c
===================================================================
--- work-fault-inject.orig/drivers/pci/hotplug/acpiphp_core.c
+++ work-fault-inject/drivers/pci/hotplug/acpiphp_core.c
@@ -303,8 +303,10 @@ static int __init init_acpi(void)
 	/* read initial number of slots */
 	if (!retval) {
 		num_slots = acpiphp_get_num_slots();
-		if (num_slots == 0)
+		if (num_slots == 0) {
+			acpiphp_glue_exit();
 			retval = -ENODEV;
+		}
 	}
 
 	return retval;
