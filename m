Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbRBAFnn>; Thu, 1 Feb 2001 00:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129114AbRBAFnd>; Thu, 1 Feb 2001 00:43:33 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:49611 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129047AbRBAFnW>; Thu, 1 Feb 2001 00:43:22 -0500
Date: Wed, 31 Jan 2001 21:40:09 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org, acpi@phobos.fachschaften.tu-muenchen.de,
        torvalds@transmeta.com
Subject: PATCH: linux-2.4.1/drivers/acpi/amfldio.c will fail if bit_granularity==32
Message-ID: <20010131214009.A5533@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	I hope this bug was not the result of my cc'ing Linus
on some emails and not on others, because this bug is a mistake
that I made a few weeks ago and then fixed when it was immediately
pointed out to me by some smart person on the acpi list.

	The test "((1 << bit_granularity) -1) & ~mask" will always
fail on x86+gcc if bit_granularity == 32, because the value of 1<<32
on x86 + gcc-2.95.2 is 1, not 0.  The value of 1<<n is not defined
in ANSI C when n >= bitsizeof(result), so we should not do this anyhow.

	Anyhow, here is a patch that should fix the problem.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="acpi.diff"

--- linux-2.4.1/drivers/acpi/interpreter/amfldio.c	Mon Jan 29 10:15:59 2001
+++ linux/drivers/acpi/interpreter/amfldio.c	Wed Jan 31 05:23:48 2001
@@ -415,7 +415,8 @@
 
 		/* Check if update rule needs to be applied (not if mask is all ones) */
 
-		if (((1 << bit_granularity) -1) & ~mask) {
+		/* The left shift drops the bits we want to ignore. */
+	  	if ((~mask << (sizeof(mask)*8 - bit_granularity)) != 0) {
 			/*
 			 * Read the current contents of the byte/word/dword containing
 			 * the field, and merge with the new field value.

--7JfCtLOvnd9MIVvH--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
