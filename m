Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbVBGFRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVBGFRb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 00:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVBGFRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 00:17:30 -0500
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:9857 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261353AbVBGFRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 00:17:01 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] module-init-tools: generate modules.seriomap
Date: Mon, 7 Feb 2005 00:16:59 -0500
User-Agent: KMail/1.7.2
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.de>, Greg KH <greg@kroah.com>
References: <200502060255.30088.dtor_core@ameritech.net> <1107747708.8689.18.camel@localhost.localdomain>
In-Reply-To: <1107747708.8689.18.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502070016.59479.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 February 2005 22:41, Rusty Russell wrote:
> On Sun, 2005-02-06 at 02:55 -0500, Dmitry Torokhov wrote:
> > Hi Rusty,
> > 
> > I have converted serio bus to use ID matching and changed serio drivers
> > to use MODULE_DEVICE_TABLE. Now that Vojtech pulled the changes into his
> > tree it would be nice if official module-init-tools generated the module
> > map so that hotplug scripts could automatically load proper drivers.
> 
> Sure, applied.  

Thanks!

> I would appreciated tests, however: you can download the 
> testsuite from the same place you get module-init-tools.  I don't expect
> you to be able to compile for all endian/size combinations, but I can do
> that for you.

Ok, I will take a look at it but it will take couple of days...

> You should also put the logic into the kernel's scripts/mod/file2alias,
> which is where this is supposed to go these days (I haven't removed the
> modules.XXX files, since hotplug has enough deployment problems without
> me making things worse).

Oh, I see. I wasn't sure where it should go and FC3 hotplug uses modules.*map
so I went that route. What do you think about the patch below then?

I am a little bit confused - is anybody using module aliases at the moment?
I could not find anything on my box...

-- 
Dmitry


===================================================================


ChangeSet@1.2125, 2005-02-07 00:14:52-05:00, dtor_core@ameritech.net
  Input: adjust file2alias utility to export aliases for
         serio drivers (serio:tyNprNidNexN).
         Move serio_device_id from serio.h to mod_devicetable.h
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 include/linux/mod_devicetable.h |   10 ++++++++++
 include/linux/serio.h           |   10 +---------
 scripts/mod/file2alias.c        |   23 ++++++++++++++++++++++-
 3 files changed, 33 insertions(+), 10 deletions(-)


===================================================================



diff -Nru a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
--- a/include/linux/mod_devicetable.h	2005-02-07 00:15:11 -05:00
+++ b/include/linux/mod_devicetable.h	2005-02-07 00:15:11 -05:00
@@ -165,4 +165,14 @@
 };
 
 
+#define SERIO_ANY	0xff
+
+struct serio_device_id {
+	__u8 type;
+	__u8 extra;
+	__u8 id;
+	__u8 proto;
+};
+
+
 #endif /* LINUX_MOD_DEVICETABLE_H */
diff -Nru a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	2005-02-07 00:15:11 -05:00
+++ b/include/linux/serio.h	2005-02-07 00:15:11 -05:00
@@ -19,13 +19,7 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/device.h>
-
-struct serio_device_id {
-	unsigned char type;
-	unsigned char extra;
-	unsigned char id;
-	unsigned char proto;
-};
+#include <linux/mod_devicetable.h>
 
 struct serio {
 	void *port_data;
@@ -173,8 +167,6 @@
 #define SERIO_TIMEOUT	1
 #define SERIO_PARITY	2
 #define SERIO_FRAME	4
-
-#define SERIO_ANY	0xff
 
 /*
  * Serio types
diff -Nru a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
--- a/scripts/mod/file2alias.c	2005-02-07 00:15:11 -05:00
+++ b/scripts/mod/file2alias.c	2005-02-07 00:15:11 -05:00
@@ -4,7 +4,7 @@
  *
  * Copyright 2002-2003  Rusty Russell, IBM Corporation
  *           2003       Kai Germaschewski
- *           
+ *
  *
  * This software may be used and distributed according to the terms
  * of the GNU General Public License, incorporated herein by reference.
@@ -181,6 +181,24 @@
 	return 1;
 }
 
+/* Looks like: "serio:tyNprNidNexN" */
+static int do_serio_entry(const char *filename,
+			  struct serio_device_id *id, char *alias)
+{
+	id->type = TO_NATIVE(id->type);
+	id->proto = TO_NATIVE(id->proto);
+	id->id = TO_NATIVE(id->id);
+	id->extra = TO_NATIVE(id->extra);
+
+	strcpy(alias, "serio:");
+	ADD(alias, "ty", id->type != SERIO_ANY, id->type);
+	ADD(alias, "pr", id->proto != SERIO_ANY, id->proto);
+	ADD(alias, "id", id->id != SERIO_ANY, id->id);
+	ADD(alias, "ex", id->extra != SERIO_ANY, id->extra);
+
+	return 1;
+}
+
 /* looks like: "pnp:dD" */
 static int do_pnp_entry(const char *filename,
 			struct pnp_device_id *id, char *alias)
@@ -270,6 +288,9 @@
 	else if (sym_is(symname, "__mod_ccw_device_table"))
 		do_table(symval, sym->st_size, sizeof(struct ccw_device_id),
 			 do_ccw_entry, mod);
+	else if (sym_is(symname, "__mod_serio_device_table"))
+		do_table(symval, sym->st_size, sizeof(struct serio_device_id),
+			 do_serio_entry, mod);
 	else if (sym_is(symname, "__mod_pnp_device_table"))
 		do_table(symval, sym->st_size, sizeof(struct pnp_device_id),
 			 do_pnp_entry, mod);
