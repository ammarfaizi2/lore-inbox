Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267826AbUIUQtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267826AbUIUQtd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 12:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267792AbUIUQtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 12:49:32 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:63880 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S267839AbUIUQsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 12:48:11 -0400
Subject: Re: [PATCH/RFC] exposing ACPI objects in sysfs
From: Alex Williamson <alex.williamson@hp.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: acpi-devel <acpi-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040921122428.GB2383@elf.ucw.cz>
References: <1095716476.5360.61.camel@tdi>
	 <20040921122428.GB2383@elf.ucw.cz>
Content-Type: text/plain
Organization: LOSL
Date: Tue, 21 Sep 2004 10:48:35 -0600
Message-Id: <1095785315.6307.6.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-21 at 14:24 +0200, Pavel Machek wrote:
> Hi!
> 
> >    I've lost track of how many of these patches I've done, but here's
> > the much anticipated next revision ;^)  The purpose of this patch is to
> > expose ACPI objects in the already existing namespace in sysfs
> > (/sys/firmware/acpi/namespace/ACPI).  There's a lot of information
> 
> Perhaps this needs some description in Documentation/ ?
> 

   Here's a start.  I'll add this to the next revision of the patch, but
for now, I'll send it alone for comment.  Thanks,

	Alex

--- /dev/null	2004-09-21 08:04:45.000000000 -0600
+++ linux-2.5/Documentation/acpi/acpi_sysfs	2004-09-21 10:41:45.000000000 -0600
@@ -0,0 +1,182 @@
+                  The ACPI sysfs object interface
+                  ===============================
+
+
+Revision History
+----------------
+2004-09-21: Alex Williamson <alex.williamson@hp.com> - Initial revision
+
+
+Overview
+--------
+
+   The ACPI sysfs interface attempts to solve the problem of providing
+an interface to ACPI namespace to user level programs.  ACPI objects
+are exposed as files under the /sys/firmware/acpi/namespace/ACPI/
+directory hierarchy.  For example, on an hp rx2600 system, the following
+objects are available:
+
+/sys/firmware/acpi/namespace/ACPI/_OSI
+/sys/firmware/acpi/namespace/ACPI/_OS_
+/sys/firmware/acpi/namespace/ACPI/_REV
+/sys/firmware/acpi/namespace/ACPI/_TZ/THM0/_TMP
+/sys/firmware/acpi/namespace/ACPI/_TZ/THM0/_CRT
+/sys/firmware/acpi/namespace/ACPI/_SB/CPU1/_SUN
+/sys/firmware/acpi/namespace/ACPI/_SB/CPU1/_UID
+/sys/firmware/acpi/namespace/ACPI/_SB/CPU0/_SUN
+/sys/firmware/acpi/namespace/ACPI/_SB/CPU0/_UID
+/sys/firmware/acpi/namespace/ACPI/_SB/SBA0/_UID
+/sys/firmware/acpi/namespace/ACPI/_SB/SBA0/_CRS
+/sys/firmware/acpi/namespace/ACPI/_SB/SBA0/_CID
+/sys/firmware/acpi/namespace/ACPI/_SB/SBA0/_HID
+/sys/firmware/acpi/namespace/ACPI/_SB/SBA0/PCI7/_HPP
+/sys/firmware/acpi/namespace/ACPI/_SB/SBA0/PCI7/_CRS
+/sys/firmware/acpi/namespace/ACPI/_SB/SBA0/PCI7/_PRT
+/sys/firmware/acpi/namespace/ACPI/_SB/SBA0/PCI7/_CID
+/sys/firmware/acpi/namespace/ACPI/_SB/SBA0/PCI7/_HID
+/sys/firmware/acpi/namespace/ACPI/_SB/SBA0/PCI7/_BBN
+/sys/firmware/acpi/namespace/ACPI/_SB/SBA0/PCI7/_STA
+/sys/firmware/acpi/namespace/ACPI/_SB/SBA0/PCI7/_UID
+...
+
+User space utilities can search ACPI namespace and call into the acpi_sysfs
+driver to evaluate objects.  The interface uses simple write and read
+operations to pass method arguments or commands and return the evaluated
+object value or attributes.  Simple objects (those that don't require
+method arguments) can be evaluated by simply reading the file:
+
+# xxd /sys/firmware/acpi/namespace/ACPI/_OS_    
+0000000: 0200 0000 1400 0000 1800 0000 0000 0000  ................
+0000010: 0000 0000 0000 0000 4d69 6372 6f73 6f66  ........Microsof
+0000020: 7420 5769 6e64 6f77 7320 4e54 0000 0000  t Windows NT....
+
+Standard ACPI objects are used for return values, allowing the interface
+to easily return ACPI packages, buffers, strings, etc...
+
+Todo: This interface really needs a libacpi and lsacpi type tools to
+      make it more readily available.
+
+Theory of Operation
+-------------------
+
+   The ACPI sysfs interface provides a per-open file backing store for
+ACPI object files.  Reads and writes to the file are consistent only
+within an open/close session (ie. closing the file clears all read and
+write data).  Object evaluation and special command processing only
+occurs when the object file is read.  This allows commands and arguments
+to be built up with multiple writes, but nothing occurs until the file
+is read.
+
+   Reading the object file at offset zero re-evaluates the object or
+command and clears current read/write buffers.  Reading from a non-zero
+offset returns the requested section of the current read buffer without
+re-evaluating the object or modifying the write buffer (should we clear
+the write buffer here?).
+
+   The ACPI sysfs interface uses standard ACPI data structures with the
+exception that all pointers in the structure are replaced by offsets
+into the read/write buffer.  Using the _OS_ object return value as an
+example, evaluating an object always returns a union acpi_object struct:
+
+union acpi_object
+{
+  acpi_object_type  type; /* See definition of acpi_ns_type for values */
+  struct
+  {
+    acpi_object_type  type;
+    acpi_integer      value; /* The actual number */
+  } integer;
+
+  struct
+  {
+    acpi_object_type  type;
+    u32               length;/* # of bytes in string, excluding trailing null */
+    char              *pointer;  /* points to the string value */
+  } string;
+...
+
+
+   Evaluating the first 4 bytes of the return buffer shows this is an
+ACPI_TYPE_STRING structure.  Using the string entry from the union, the
+next 4 bytes provides the length of the string (0x14 = 20 bytes).  Finally,
+this data type uses a pointer to a buffer to provide the actual data.  As
+seen in the output, the 8 byte pointer value (ia64 system) has been replaced
+by a buffer offset.  Therefore, the 20 byte char array starts at offset
+0x18 in the buffer.
+
+   The return value for commands is dependent on the command issued.
+The version command returns an acpi_object to facilitate synchronizing
+the size of a union acpi_object between kernel and user space.  The type
+commands simple return an acpi_object_type value.  Current available
+commands include:
+
+/* Get version, returned in union acpi_object (integer) struct */
+#define VERSION                 0x0
+/* Get the type of the object (Integer, String, Method, etc...) */
+#define GET_TYPE                0x1
+/* Get the type of the parent to the object (Device, Processor, etc...) */
+#define GET_PTYPE               0x2
+
+   Commands are issued by writing the following data structure to the ACPI
+object file:
+
+struct special_cmd {
+        u32                     magic;
+        unsigned int            cmd;
+        char                    *args;
+};
+
+The "magic" value is used to distinguish commands from method arguments
+and should always be set to ACPI_UINT32_MAX.  The cmd value is one of the
+operations to preform, such as GET_TYPE.  The args value is currently
+unused, but allows for data to be passed in for future commands.
+
+   Method arguments are always written to the ACPI object file as struct
+acpi_object_list:
+
+struct acpi_object_list
+{
+        u32                                 count;
+        union acpi_object                   *pointer;
+};
+
+Much like the return data, the pointer is replaced by an offset into the
+buffer (except this time, it's the caller's responsibility to make this
+conversion).  For example, If we wanted to take the string acpi_object
+above and convert it into an acpi_object_list, we'd end up with this:
+
+0000000: 0100 0000 0000 0000 1000 0000 0000 0000  ................
+0000010: 0200 0000 1400 0000 2800 0000 0000 0000  ................
+0000020: 0000 0000 0000 0000 4d69 6372 6f73 6f66  ........Microsof
+0000030: 7420 5769 6e64 6f77 7320 4e54 0000 0000  t Windows NT....
+
+Note that since this structure is for a 64 bit system, the pointer
+will be naturally aligned on a 8 byte boundary.  If we wanted to pass
+two arguments to the method, a string and a buffer, the structure we need
+to write would look like this:
+
+00000000  02 00 00 00 00 00 00 00 18 00 00 00 00 00 00 00 ................
+00000010  48 00 00 00 00 00 00 00 02 00 00 00 14 00 00 00 H...............
+00000020  30 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0...............
+00000030  4D 69 63 72 6F 73 6F 66 74 20 57 69 6E 64 6F 77 Microsoft Window
+00000040  73 20 4E 54 00 00 00 00 01 00 00 00 00 00 00 00 s NT............
+00000050  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
+
+   This structure shows 2 arguments, the first starts at offset 0x18.  The
+second argument starts at offset 0x48.  Using the same procedure above,
+the second argument is an ACPI_TYPE_INTEGER with a value of 0x0.  In this
+example, the string data come before the second argument, but it could
+just as easily be at the end of the buffer.  Maintaining proper data
+alignment is recommended.
+
+   On the kernel side, offsets are range checked to ensure they fall within
+the buffer before being converted to kernel pointers for the ACPI interpreter.
+
+   NOTE: ACPI methods have a purpose.  Randomly calling methods without
+knowing their side-effects will undoubtedly cause problems.  ACPI objects
+like _HID, _CID, _ADR, _SUN, _UID, _STA, _BBN should always be safe to
+evaluate.  These simply return data about the object.  Methods like
+_ON_, _OFF_, _S5_, etc... are meant to cause a change in the system and
+can cause problems.  The ACPI sysfs module makes an attempt to hide some
+of the more dangerous interfaces, but it not fool-proof.  DO NOT randomly
+read files in the ACPI namespace unless you know what they do.


