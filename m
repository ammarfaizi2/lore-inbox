Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130580AbRAAK2c>; Mon, 1 Jan 2001 05:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131188AbRAAK2W>; Mon, 1 Jan 2001 05:28:22 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:11944 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S130580AbRAAK2F>; Mon, 1 Jan 2001 05:28:05 -0500
Date: Mon, 1 Jan 2001 01:57:37 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: acme@conectiva.com.br, acpi@phobos.fachschaften.tu-muenchen.de
Cc: linux-kernel@vger.kernel.org
Subject: minor acpi cleanups against 2.4.0-prerelease
Message-ID: <20010101015737.A25374@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	I have not yet isolated the problem that causes acpi to hang
on initialization on my Sony PCG-1VN PictureBook (and which Suresh
reports also occurs on a Sony Vaio F250), but in the course of
tracking down the problem, I have noticed some code that needed
to be cleaned up, so I would like to at least hit that ball out
of my court.  I have attached the patch to this email.

	The changes are as follows:
		o namesapce/nsxfobj.c: acpi_ns_get_device_callback
		  had two identical calls to acpi_cm_release_mutex,
		  each of which was the first statement executed
		  depending on the result of an if statement, and
		  the condition being evaluated did not need the lock.
		  This folds the acpi_cm_release_mutex calls into a single
		  one before the if.

		o namespace/nseval.c: acpi_ns_evaluate_by_handle
		  had a goto target that was only reachable from one
		  point in the code.  Moving the target code to where
		  the goto used to be further simplified it.

		o BUG: namespace/nseval.c: acpi_ns_execute_control_method
		  would not would return without releasing the
		  ACPI_MTX_NAMESPACE mutex if acpi_ns_get_attached_obect
		  returned NULL.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="acpi.cleanup"

--- linux-2.4.0-prerelease/drivers/acpi/namespace/nsxfobj.c	Fri Dec 29 14:07:21 2000
+++ linux/drivers/acpi/namespace/nsxfobj.c	Mon Jan  1 01:37:10 2001
@@ -578,15 +578,13 @@
 	info = context;
 
 	acpi_cm_acquire_mutex (ACPI_MTX_NAMESPACE);
-
 	node = acpi_ns_convert_handle_to_entry (obj_handle);
+	acpi_cm_release_mutex (ACPI_MTX_NAMESPACE);
+
 	if (!node) {
-		acpi_cm_release_mutex (ACPI_MTX_NAMESPACE);
 		return (AE_BAD_PARAMETER);
 	}
 
-	acpi_cm_release_mutex (ACPI_MTX_NAMESPACE);
-
 	/*
 	 * Run _STA to determine if device is present
 	 */
@@ -694,4 +692,4 @@
 	acpi_cm_release_mutex (ACPI_MTX_NAMESPACE);
 
 	return (status);
-}
\ No newline at end of file
+}
--- linux-2.4.0-prerelease/drivers/acpi/namespace/nseval.c	Fri Dec 29 14:07:21 2000
+++ linux/drivers/acpi/namespace/nseval.c	Mon Jan  1 01:37:10 2001
@@ -253,8 +253,8 @@
 
 	node = acpi_ns_convert_handle_to_entry (handle);
 	if (!node) {
-		status = AE_BAD_PARAMETER;
-		goto unlock_and_exit;
+		acpi_cm_release_mutex (ACPI_MTX_NAMESPACE);
+		return (AE_BAD_PARAMETER);
 	}
 
 
@@ -316,12 +316,6 @@
 	 * so we just return
 	 */
 	return (status);
-
-
-unlock_and_exit:
-
-	acpi_cm_release_mutex (ACPI_MTX_NAMESPACE);
-	return (status);
 }
 
 
@@ -357,10 +351,6 @@
 	/* Verify that there is a method associated with this object */
 
 	obj_desc = acpi_ns_get_attached_object ((ACPI_HANDLE) method_node);
-	if (!obj_desc) {
-		return (AE_ERROR);
-	}
-
 
 	/*
 	 * Unlock the namespace before execution.  This allows namespace access
@@ -371,6 +361,10 @@
 	 */
 
 	acpi_cm_release_mutex (ACPI_MTX_NAMESPACE);
+
+	if (!obj_desc) {
+		return (AE_ERROR);
+	}
 
 	/*
 	 * Excecute the method via the interpreter

--J2SCkAp4GZ/dPZZf--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
