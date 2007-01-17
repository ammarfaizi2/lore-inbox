Return-Path: <linux-kernel-owner+w=401wt.eu-S932585AbXAQRQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932585AbXAQRQx (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 12:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbXAQRQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 12:16:53 -0500
Received: from usea-naimss1.unisys.com ([192.61.61.103]:3815 "EHLO
	usea-naimss1.unisys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932585AbXAQRQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 12:16:52 -0500
X-Greylist: delayed 1802 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jan 2007 12:16:52 EST
Subject: PATCH: Update disable_IO_APIC to use 8-bit destination field
	(X86_64)
From: Benjamin Romer <benjamin.romer@unisys.com>
To: linux-kernel@vger.kernel.org
Cc: Vivek Goyal <vgoyal@in.ibm.com>, ebiederm@xmission.com
Content-Type: text/plain
Organization: Unisys Corporation
Date: Wed, 17 Jan 2007 11:46:46 -0500
Message-Id: <1169052407.3082.43.camel@ustr-romerbm-2.na.uis.unisys.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Jan 2007 16:46:48.0782 (UTC) FILETIME=[14BC9EE0:01C73A57]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On the Unisys ES7000/ONE system, we encountered a problem where
performing a kexec reboot or dump on any cell other than cell 0 causes
the system timer to stop working, resulting in a hang during timer
calibration in the new kernel. 

We traced the problem to one line of code in disable_IO_APIC(), which
needs to restore the timer's IO-APIC configuration before rebooting. The
code is currently using the 4-bit physical destination field, rather
than using the 8-bit logical destination field, and it cuts off the
upper 4 bits of the timer's APIC ID. If we change this to use the
logical destination field, the timer works and we can kexec on the upper
cells. This was tested on two different cells (0 and 2) in an ES7000/ONE
system.

For reference, the relevant Intel xAPIC spec is kept at
ftp://download.intel.com/design/chipsets/e8501/datashts/30962001.pdf,
specifically on page 334.

-- Ben

--- linux-2.6.19.2.orig/arch/x86_64/kernel/io_apic.c    2007-01-10
14:10:37.000000000 -0500
+++ linux-2.6.19.2/arch/x86_64/kernel/io_apic.c 2007-01-17
09:20:24.000000000 -0500
@@ -1261,7 +1261,7 @@
                entry.dest_mode       = 0; /* Physical */
                entry.delivery_mode   = dest_ExtINT; /* ExtInt */
                entry.vector          = 0;
-               entry.dest.physical.physical_dest =
+               entry.dest.logical.logical_dest =
                                        GET_APIC_ID(apic_read(APIC_ID));
 
                /*


