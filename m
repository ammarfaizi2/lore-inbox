Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbUKXCKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbUKXCKj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 21:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUKXCIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 21:08:02 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:60427 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261684AbUKXCEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 21:04:31 -0500
Date: Wed, 24 Nov 2004 03:04:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, tao@acc.umu.se
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] small MCA cleanups (fwd)
Message-ID: <20041124020427.GM2927@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch forwarded below still applies and compiles against 
2.6.10-rc2-mm3.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Sun, 7 Nov 2004 13:11:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: tao@acc.umu.se
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] small MCA cleanups

The patch below does the following cleanups in the MCA code:
- make some needlessly global code static
- remove three unused global functions from mca-legacy.c (two of them
  were EXPORT_SYMBOL'ed); this should IMHO be safe since mca-legacy
  is not an API drivers should move to


diffstat output:
 drivers/mca/mca-bus.c      |    2 -
 drivers/mca/mca-legacy.c   |   59 -------------------------------------
 drivers/mca/mca-proc.c     |    4 +-
 include/linux/mca-legacy.h |    5 ---
 4 files changed, 3 insertions(+), 67 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/mca/mca-bus.c.old	2004-11-07 12:29:40.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/mca/mca-bus.c	2004-11-07 12:30:01.000000000 +0100
@@ -34,7 +34,7 @@
 /* Very few machines have more than one MCA bus.  However, there are
  * those that do (Voyager 35xx/5xxx), so we do it this way for future
  * expansion.  None that I know have more than 2 */
-struct mca_bus *mca_root_busses[MAX_MCA_BUSSES];
+static struct mca_bus *mca_root_busses[MAX_MCA_BUSSES];
 
 #define MCA_DEVINFO(i,s) { .pos = i, .name = s }
 
--- linux-2.6.10-rc1-mm3-full/include/linux/mca-legacy.h.old	2004-11-07 12:31:22.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/include/linux/mca-legacy.h	2004-11-07 12:31:44.000000000 +0100
@@ -34,10 +34,6 @@
 extern int mca_find_adapter(int id, int start);
 extern int mca_find_unused_adapter(int id, int start);
 
-/* adapter state info - returns 0 if no */
-extern int mca_isadapter(int slot);
-extern int mca_isenabled(int slot);
-
 extern int mca_is_adapter_used(int slot);
 extern int mca_mark_as_used(int slot);
 extern void mca_mark_as_unused(int slot);
@@ -50,7 +46,6 @@
  * so we can have a more interesting /proc/mca.
  */
 extern void mca_set_adapter_name(int slot, char* name);
-extern char* mca_get_adapter_name(int slot);
 
 /* These routines actually mess with the hardware POS registers.  They
  * temporarily disable the device (and interrupts), so make sure you know
--- linux-2.6.10-rc1-mm3-full/drivers/mca/mca-legacy.c.old	2004-11-07 12:30:12.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/mca/mca-legacy.c	2004-11-07 12:31:09.000000000 +0100
@@ -283,25 +283,6 @@
 EXPORT_SYMBOL(mca_set_adapter_name);
 
 /**
- *	mca_get_adapter_name - get the adapter description
- *	@slot:	slot to query
- *
- *	Return the adapter description if set. If it has not been
- *	set or the slot is out range then return NULL.
- */
-
-char *mca_get_adapter_name(int slot)
-{
-	struct mca_device *mca_dev = mca_find_device_by_slot(slot);
-
-	if(!mca_dev)
-		return NULL;
-
-	return mca_device_get_name(mca_dev);
-}
-EXPORT_SYMBOL(mca_get_adapter_name);
-
-/**
  *	mca_is_adapter_used - check if claimed by driver
  *	@slot:	slot to check
  *
@@ -365,43 +346,3 @@
 }
 EXPORT_SYMBOL(mca_mark_as_unused);
 
-/**
- *	mca_isadapter - check if the slot holds an adapter
- *	@slot:	slot to query
- *
- *	Returns zero if the slot does not hold an adapter, non zero if
- *	it does.
- */
-
-int mca_isadapter(int slot)
-{
-	struct mca_device *mca_dev = mca_find_device_by_slot(slot);
-	enum MCA_AdapterStatus status;
-
-	if(!mca_dev)
-		return 0;
-
-	status = mca_device_status(mca_dev);
-
-	return status == MCA_ADAPTER_NORMAL
-		|| status == MCA_ADAPTER_DISABLED;
-}
-EXPORT_SYMBOL(mca_isadapter);
-
-/**
- *	mca_isenabled - check if the slot holds an enabled adapter
- *	@slot:	slot to query
- *
- *	Returns a non zero value if the slot holds an enabled adapter
- *	and zero for any other case.
- */
-
-int mca_isenabled(int slot)
-{
-	struct mca_device *mca_dev = mca_find_device_by_slot(slot);
-
-	if(!mca_dev)
-		return 0;
-
-	return mca_device_status(mca_dev) == MCA_ADAPTER_NORMAL;
-}
--- linux-2.6.10-rc1-mm3-full/drivers/mca/mca-proc.c.old	2004-11-07 12:31:53.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/mca/mca-proc.c	2004-11-07 12:33:30.000000000 +0100
@@ -43,8 +43,8 @@
 	return len;
 }
 
-int get_mca_info(char *page, char **start, off_t off,
-		 int count, int *eof, void *data)
+static int get_mca_info(char *page, char **start, off_t off,
+			int count, int *eof, void *data)
 {
 	int i, len = 0;
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

