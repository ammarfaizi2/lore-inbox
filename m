Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbWAEOrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbWAEOrG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbWAEOrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:47:05 -0500
Received: from cod.sandelman.ca ([192.139.46.139]:54982 "EHLO
	lists.sandelman.ca") by vger.kernel.org with ESMTP id S1751439AbWAEOrE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:47:04 -0500
From: "Michael Richardson" <mcr@sandelman.ottawa.on.ca>
To: mochel@digitalimplant.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] device_shutdown can loop if the driver frees itself
X-Mailer: MH-E 7.82; nmh 1.1; XEmacs 21.4 (patch 17)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Wed, 04 Jan 2006 15:31:54 -0500
Message-ID: <7655.1136406714@sandelman.ottawa.on.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=


This patch changes device_shutdown() to use a newly introduce safe
reverse list traversal.  We experienced loops on system reboot if we had
removed and re-inserted our device from the device list. 

We noticed this problem on PPC405. Our PCI IDE device comes and goes a lot.

Our hypothesis was that there was a loop caused by the driver->shutdown
freeing memory.  It is possible that we do something wrong as well, but
being unable to reboot is kind of nasty.

Signed-off-by: Michael Richardson <mcr@marajade.sandelman.ca>

---

 drivers/base/power/shutdown.c |    4 ++--
 include/linux/list.h          |   13 +++++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

applies-to: 96a0b5842e24d6736c698cdbd820a3ad9d8d9f10
49291875d63ec697510fc4cc9a1766b7400ee2d3
diff --git a/drivers/base/power/shutdown.c b/drivers/base/power/shutdown.c
index f50a08b..3a417c8 100644
--- a/drivers/base/power/shutdown.c
+++ b/drivers/base/power/shutdown.c
@@ -35,10 +35,10 @@ extern int sysdev_shutdown(void);
  */
 void device_shutdown(void)
 {
-	struct device * dev;
+	struct device * dev, *devn;
 
 	down_write(&devices_subsys.rwsem);
-	list_for_each_entry_reverse(dev, &devices_subsys.kset.list,
+	list_for_each_entry_safe_reverse(dev, devn, &devices_subsys.kset.list,
 				kobj.entry) {
 		if (dev->driver && dev->driver->shutdown) {
 			dev_dbg(dev, "shutdown\n");
diff --git a/include/linux/list.h b/include/linux/list.h
index 8e33882..b31ec32 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -436,6 +436,19 @@ static inline void list_splice_init(stru
 	     pos = n, n = list_entry(n->member.next, typeof(*n), member))
 
 /**
+ * list_for_each_entry_safe_reverse - iterate backwards over list of given type safe against removal of list entry
+ * @pos:	the type * to use as a loop counter.
+ * @n:          another type * to use as temporary storage
+ * @head:	the head for your list.
+ * @member:	the name of the list_struct within the struct.
+ */
+#define list_for_each_entry_safe_reverse(pos, n, head, member)		\
+	for (pos = list_entry((head)->prev, typeof(*pos), member),	\
+		     n = list_entry(pos->member.next, typeof(*pos), member); \
+	     &pos->member != (head); 	\
+	     pos = n, n = list_entry(n->member.prev, typeof(*n), member))
+
+/**
  * list_for_each_rcu	-	iterate over an rcu-protected list
  * @pos:	the &struct list_head to use as a loop counter.
  * @head:	the head for your list.
---
0.99.9.GIT







--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQEVAwUAQ7wwuYCLcPvd0N1lAQJUSgf/Tq4ZdymwkPzKonoRmPmfRMrLmlJZu+r7
lb+2NtoYerFFX8HFQeO898AgTGkv7HpeLd2wKBeIJw1cG19VNX8+i/nUhWttQPJz
dosAF4AIR7B5lN5a7YWXQ8Di6GceyYq5uMH7D4lYnbaGE0Oh5TJeb6pu4PYBjcvs
BOchukEcn9eCj7KC2AltjQSmRbNfbYyUoypUF4JavB/r0Ul9VjdW98RQvCt6G7Pr
3HIvsNCpoirIoYCSn8JHjZMhfjuXrmZYEYSaJWYPg3/KnbzbFJ9fS5cqrFDa1YFi
fSSYauQH84G2sox2uv+dfWjNej3TXjX12SRqN8SuSE2cbL8Dua7+eg==
=nxPj
-----END PGP SIGNATURE-----
--=-=-=--
