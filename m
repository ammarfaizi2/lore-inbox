Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbWENA2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbWENA2J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 20:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbWENA2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 20:28:09 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:54051 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964825AbWENA2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 20:28:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=VI8T59UQaZ0kuZ8Icc5CI07Aukxya3XRx9O+f3mzO8TymrRd56DtQHTgJzXVkSWxw4/saF/jFIVK2r0khOuuh1l/I3J/IMOm1oCFo34ILH7dfg2BETuifUHR2EfCxaH/HLBWUXWmBRQ5wm8sa2g2Hj5/WgtEA7WCDRy7QhUSn4o=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] mem-leak fix for acpi_thermal_write_trip_points()
Date: Sun, 14 May 2006 02:28:58 +0200
User-Agent: KMail/1.9.1
Cc: Andy Grover <andrew.grover@intel.com>,
       Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>,
       Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605140228.58460.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's a memory leak in
 drivers/acpi/thermal.c::acpi_thermal_write_trip_points()
found by the Coverity checker as bug #1243

The problem is simply that if the allocation of 'active' fails, then we'll
return from the function without freeing the memory previously allocated 
to 'limit_string'.

One fix would have been the insertion of kfree(limit_string); just before
the return_VALUE(-ENOMEM); call, but I chose a different fix.
Except for this one return the function only has a single exit point at 
the end: label, and there it does proper cleanup of everything. So even 
though setting the return value (the 'count' variable) and jumping there 
results in a pointless kfree(NULL) call (since 'active' will be NULL), I 
thought this was a small price to pay for the bennefit of having just a 
single exit path for the function.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/acpi/thermal.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)


--- linux-2.6.17-rc4-git2-orig/drivers/acpi/thermal.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.17-rc4-git2/drivers/acpi/thermal.c	2006-05-14 02:18:30.000000000 +0200
@@ -942,8 +942,10 @@ acpi_thermal_write_trip_points(struct fi
 	memset(limit_string, 0, ACPI_THERMAL_MAX_LIMIT_STR_LEN);
 
 	active = kmalloc(ACPI_THERMAL_MAX_ACTIVE * sizeof(int), GFP_KERNEL);
-	if (!active)
-		return_VALUE(-ENOMEM);
+	if (!active) {
+		count = -ENOMEM;
+		goto end;
+	}
 
 	if (!tz || (count > ACPI_THERMAL_MAX_LIMIT_STR_LEN - 1)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid argument\n"));



