Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbWDUQBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbWDUQBU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 12:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbWDUQBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 12:01:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:62628 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932372AbWDUQBT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 12:01:19 -0400
X-IronPort-AV: i="4.04,145,1144047600"; 
   d="scan'208"; a="26931220:sNHT36454194"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Problems with EDAC coexisting with BIOS
Date: Fri, 21 Apr 2006 09:01:00 -0700
Message-ID: <5389061B65D50446B1783B97DFDB392D998732@orsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problems with EDAC coexisting with BIOS
Thread-Index: AcZlXMiqURf32jV/TXK/mqDoitOxQA==
From: "Gross, Mark" <mark.gross@intel.com>
To: <bluesmoke-devel@lists.sourceforge.net>,
       "LKML" <linux-kernel@vger.kernel.org>
Cc: "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Ong, Soo Keong" <soo.keong.ong@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>,
       "Gross, Mark" <mark.gross@intel.com>
X-OriginalArrivalTime: 21 Apr 2006 16:01:18.0770 (UTC) FILETIME=[D3939920:01C6655C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sorry to have to bring up these issues after a fare amount of good
work, and I don't know how this problem managed to get by for as long as
it has, but there are some issues with the EDAC and the BIOS for managed
computer systems.

Managed computers are systems with automatic ECC logging to a System
Event Log or SEL.  They typically have an out of band Board Management
Controller aka BMC or IPMC that runs out of band WRT the OS payload.

The issues found with the EDAC driver are:
1) The default AMI BIOS behavior on SMI is to check the chipset error
registers (Dev0:Fun1) and re-hide them.
2) If you are lucky enough to have BIOS code that doesn't re-hide
Dev0:Fun1; then when EDAC is loaded there is a race condition between
the platform BIOS and the driver to gain access to these registers. 
3) If the platform BIOS does the ECC logging out of band WRT the payload
OS, there is no good way for the driver to know at load time.  

We discovered these problems when testing with one of the later RHEL4-U3
RC's.  The EDAC driver called panic when the device 0 Function 1 of the
E7250 was re-hidden by the legacy USB SMI that when off between the load
of the EDAC driver and the USB host driver.  Loading the EDAC driver for
many AMI bios's is a panic land mine waiting go off.  Unless the OS
knows that it can trust the BIOS to not re-hide those chipset registers
using this driver is not a safe thing to do.

Basically if device 0 : function 1 is hidden by the platform at boot
time un-hiding and using the device and function is a risky thing to do,
as there is likely a good reason for it to have been hidden in the first
place.  If the BIOS thinks that it owns some registers then the OS
should not use them without great care.

It is possible that the driver could be modified to check for re-hiding
of the DEV0:FUN1, but this will be racey WRT SMI processing.  At least
it shouldn't panic.  

The driver should never get loaded by default or automatically.  If the
user knows enough about there BIOS to trust that the SMI behavior will
coexist with the driver then its OK to load otherwise using this driver
is not a safe thing to do.

I think the best thing to do is to have the driver error out in its init
or probe code if the dev0:fun1 is hidden at boot time.

Comments?

Next steps?

Do you want me to send a patch implementing graceful error handling at
driver init time so it doesn't load if DEV0:FUN1 is hidden?

--mgross
Intel Open Source Technology Center
(503) 677-4628
(503)-712-6227
ms: JF1-235
2111 NW 25th Ave
Hillsboro, OR 97124
 
