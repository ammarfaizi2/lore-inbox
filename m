Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbULNEbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbULNEbh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 23:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbULNEbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 23:31:37 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:46089 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261411AbULNENz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 23:13:55 -0500
Date: Tue, 14 Dec 2004 05:13:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: marcel@holtmann.org, maxk@qualcomm.com
Cc: bluez-devel@lists.sf.net, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [2.6 patch] net/bluetooth/: misc possible cleanups
Message-ID: <20041214041352.GZ23151@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains the following possible cleanups:
- make needlessly global code static
- remove the following EXPORT_SYMBOL'ed but unused functions in 
  hci_core.c:
  - hci_suspend_dev
  - hci_resume_dev
  - hci_register_cb
  - hci_unregister_cb

Please comment on which of these changes are correct and which conflict 
with pending patches.


diffstat output:
 include/net/bluetooth/hci_core.h |    7 ----
 include/net/bluetooth/rfcomm.h   |   27 -------------------
 net/bluetooth/cmtp/capi.c        |    4 ++
 net/bluetooth/cmtp/cmtp.h        |    1 
 net/bluetooth/hci_conn.c         |    2 -
 net/bluetooth/hci_core.c         |   44 +------------------------------
 net/bluetooth/hci_sock.c         |   10 +++----
 net/bluetooth/l2cap.c            |    2 -
 net/bluetooth/rfcomm/core.c      |   37 +++++++++++++++++++++-----
 net/bluetooth/rfcomm/sock.c      |    4 +-
 10 files changed, 44 insertions(+), 94 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc3-mm1-full/net/bluetooth/cmtp/cmtp.h.old	2004-12-14 02:12:11.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/bluetooth/cmtp/cmtp.h	2004-12-14 02:12:38.000000000 +0100
@@ -120,7 +120,6 @@
 void cmtp_detach_device(struct cmtp_session *session);
 
 void cmtp_recv_capimsg(struct cmtp_session *session, struct sk_buff *skb);
-void cmtp_send_capimsg(struct cmtp_session *session, struct sk_buff *skb);
 
 static inline void cmtp_schedule(struct cmtp_session *session)
 {
--- linux-2.6.10-rc3-mm1-full/net/bluetooth/cmtp/capi.c.old	2004-12-14 02:12:47.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/bluetooth/cmtp/capi.c	2004-12-14 02:13:38.000000000 +0100
@@ -74,6 +74,8 @@
 #define CMTP_APPLID	2
 #define CMTP_MAPPING	3
 
+static void cmtp_send_capimsg(struct cmtp_session *session, struct sk_buff *skb);
+
 static struct cmtp_application *cmtp_application_add(struct cmtp_session *session, __u16 appl)
 {
 	struct cmtp_application *app = kmalloc(sizeof(*app), GFP_KERNEL);
@@ -337,7 +339,7 @@
 	capi_ctr_handle_message(ctrl, appl, skb);
 }
 
-void cmtp_send_capimsg(struct cmtp_session *session, struct sk_buff *skb)
+static void cmtp_send_capimsg(struct cmtp_session *session, struct sk_buff *skb)
 {
 	struct cmtp_scb *scb = (void *) skb->cb;
 
--- linux-2.6.10-rc3-mm1-full/include/net/bluetooth/hci_core.h.old	2004-12-14 02:13:54.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/net/bluetooth/hci_core.h	2004-12-14 02:31:34.000000000 +0100
@@ -277,7 +277,6 @@
 	return NULL;
 }
 
-void hci_acl_connect(struct hci_conn *conn);
 void hci_acl_disconn(struct hci_conn *conn, __u8 reason);
 void hci_add_sco(struct hci_conn *conn, __u16 handle);
 
@@ -372,8 +371,6 @@
 void hci_free_dev(struct hci_dev *hdev);
 int hci_register_dev(struct hci_dev *hdev);
 int hci_unregister_dev(struct hci_dev *hdev);
-int hci_suspend_dev(struct hci_dev *hdev);
-int hci_resume_dev(struct hci_dev *hdev);
 int hci_dev_open(__u16 dev);
 int hci_dev_close(__u16 dev);
 int hci_dev_reset(__u16 dev);
@@ -546,9 +543,6 @@
 	read_unlock_bh(&hci_cb_list_lock);
 }
 
-int hci_register_cb(struct hci_cb *hcb);
-int hci_unregister_cb(struct hci_cb *hcb);
-
 int hci_register_notifier(struct notifier_block *nb);
 int hci_unregister_notifier(struct notifier_block *nb);
 
@@ -589,6 +583,5 @@
 #define hci_req_unlock(d)	up(&d->req_lock)
 
 void hci_req_complete(struct hci_dev *hdev, int result);
-void hci_req_cancel(struct hci_dev *hdev, int err);
 
 #endif /* __HCI_CORE_H */
--- linux-2.6.10-rc3-mm1-full/net/bluetooth/hci_conn.c.old	2004-12-14 02:14:10.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/bluetooth/hci_conn.c	2004-12-14 02:14:15.000000000 +0100
@@ -53,7 +53,7 @@
 #define BT_DBG(D...)
 #endif
 
-void hci_acl_connect(struct hci_conn *conn)
+static void hci_acl_connect(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct inquiry_entry *ie;
--- linux-2.6.10-rc3-mm1-full/net/bluetooth/hci_core.c.old	2004-12-14 02:14:53.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/bluetooth/hci_core.c	2004-12-14 02:31:09.000000000 +0100
@@ -59,7 +59,7 @@
 static void hci_tx_task(unsigned long arg);
 static void hci_notify(struct hci_dev *hdev, int event);
 
-rwlock_t hci_task_lock = RW_LOCK_UNLOCKED;
+static rwlock_t hci_task_lock = RW_LOCK_UNLOCKED;
 
 /* HCI device list */
 LIST_HEAD(hci_dev_list);
@@ -106,7 +106,7 @@
 	}
 }
 
-void hci_req_cancel(struct hci_dev *hdev, int err)
+static void hci_req_cancel(struct hci_dev *hdev, int err)
 {
 	BT_DBG("%s err 0x%2.2x", hdev->name, err);
 
@@ -878,22 +878,6 @@
 }
 EXPORT_SYMBOL(hci_unregister_dev);
 
-/* Suspend HCI device */
-int hci_suspend_dev(struct hci_dev *hdev)
-{
-	hci_notify(hdev, HCI_DEV_SUSPEND);
-	return 0;
-}
-EXPORT_SYMBOL(hci_suspend_dev);
-
-/* Resume HCI device */
-int hci_resume_dev(struct hci_dev *hdev)
-{
-	hci_notify(hdev, HCI_DEV_RESUME);
-	return 0;
-}
-EXPORT_SYMBOL(hci_resume_dev);
-
 /* ---- Interface to upper protocols ---- */
 
 /* Register/Unregister protocols.
@@ -942,30 +926,6 @@
 }
 EXPORT_SYMBOL(hci_unregister_proto);
 
-int hci_register_cb(struct hci_cb *cb)
-{
-	BT_DBG("%p name %s", cb, cb->name);
-
-	write_lock_bh(&hci_cb_list_lock);
-	list_add(&cb->list, &hci_cb_list);
-	write_unlock_bh(&hci_cb_list_lock);
-
-	return 0;
-}
-EXPORT_SYMBOL(hci_register_cb);
-
-int hci_unregister_cb(struct hci_cb *cb)
-{
-	BT_DBG("%p name %s", cb, cb->name);
-
-	write_lock_bh(&hci_cb_list_lock);
-	list_del(&cb->list);
-	write_unlock_bh(&hci_cb_list_lock);
-
-	return 0;
-}
-EXPORT_SYMBOL(hci_unregister_cb);
-
 static int hci_send_frame(struct sk_buff *skb)
 {
 	struct hci_dev *hdev = (struct hci_dev *) skb->dev;
--- linux-2.6.10-rc3-mm1-full/net/bluetooth/hci_sock.c.old	2004-12-14 02:16:59.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/bluetooth/hci_sock.c	2004-12-14 02:17:59.000000000 +0100
@@ -447,7 +447,7 @@
 	goto done;
 }
 
-int hci_sock_setsockopt(struct socket *sock, int level, int optname, char __user *optval, int len)
+static int hci_sock_setsockopt(struct socket *sock, int level, int optname, char __user *optval, int len)
 {
 	struct hci_ufilter uf = { .opcode = 0 };
 	struct sock *sk = sock->sk;
@@ -514,7 +514,7 @@
 	return err;
 }
 
-int hci_sock_getsockopt(struct socket *sock, int level, int optname, char __user *optval, int __user *optlen)
+static int hci_sock_getsockopt(struct socket *sock, int level, int optname, char __user *optval, int __user *optlen)
 {
 	struct hci_ufilter uf;
 	struct sock *sk = sock->sk;
@@ -567,7 +567,7 @@
 	return 0;
 }
 
-struct proto_ops hci_sock_ops = {
+static struct proto_ops hci_sock_ops = {
 	.family		= PF_BLUETOOTH,
 	.owner		= THIS_MODULE,
 	.release	= hci_sock_release,
@@ -647,13 +647,13 @@
 	return NOTIFY_DONE;
 }
 
-struct net_proto_family hci_sock_family_ops = {
+static struct net_proto_family hci_sock_family_ops = {
 	.family	= PF_BLUETOOTH,
 	.owner	= THIS_MODULE,
 	.create	= hci_sock_create,
 };
 
-struct notifier_block hci_sock_nblock = {
+static struct notifier_block hci_sock_nblock = {
 	.notifier_call = hci_sock_dev_event
 };
 
--- linux-2.6.10-rc3-mm1-full/net/bluetooth/l2cap.c.old	2004-12-14 02:18:13.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/bluetooth/l2cap.c	2004-12-14 02:18:21.000000000 +0100
@@ -61,7 +61,7 @@
 
 static struct proto_ops l2cap_sock_ops;
 
-struct bt_sock_list l2cap_sk_list = {
+static struct bt_sock_list l2cap_sk_list = {
 	.lock = RW_LOCK_UNLOCKED
 };
 
--- linux-2.6.10-rc3-mm1-full/include/net/bluetooth/rfcomm.h.old	2004-12-14 02:19:37.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/net/bluetooth/rfcomm.h	2004-12-14 02:27:24.000000000 +0100
@@ -216,22 +216,6 @@
 #define RFCOMM_CFC_DISABLED 0
 #define RFCOMM_CFC_ENABLED  RFCOMM_MAX_CREDITS
 
-extern struct task_struct *rfcomm_thread;
-extern unsigned long rfcomm_event;
-
-static inline void rfcomm_schedule(uint event)
-{
-	if (!rfcomm_thread)
-		return;
-	//set_bit(event, &rfcomm_event);
-	set_bit(RFCOMM_SCHED_WAKEUP, &rfcomm_event);
-	wake_up_process(rfcomm_thread);
-}
-
-extern struct semaphore rfcomm_sem;
-#define rfcomm_lock()	down(&rfcomm_sem);
-#define rfcomm_unlock()	up(&rfcomm_sem);
-
 /* ---- RFCOMM DLCs (channels) ---- */
 struct rfcomm_dlc *rfcomm_dlc_alloc(int prio);
 void rfcomm_dlc_free(struct rfcomm_dlc *d);
@@ -271,11 +255,6 @@
 }
 
 /* ---- RFCOMM sessions ---- */
-struct rfcomm_session *rfcomm_session_add(struct socket *sock, int state);
-struct rfcomm_session *rfcomm_session_get(bdaddr_t *src, bdaddr_t *dst);
-struct rfcomm_session *rfcomm_session_create(bdaddr_t *src, bdaddr_t *dst, int *err);
-void   rfcomm_session_del(struct rfcomm_session *s);
-void   rfcomm_session_close(struct rfcomm_session *s, int err);
 void   rfcomm_session_getaddr(struct rfcomm_session *s, bdaddr_t *src, bdaddr_t *dst);
 
 static inline void rfcomm_session_hold(struct rfcomm_session *s)
@@ -283,12 +262,6 @@
 	atomic_inc(&s->refcnt);
 }
 
-static inline void rfcomm_session_put(struct rfcomm_session *s)
-{
-	if (atomic_dec_and_test(&s->refcnt))
-		rfcomm_session_del(s);
-}
-
 /* ---- RFCOMM chechsum ---- */
 extern u8 rfcomm_crc_table[];
 
--- linux-2.6.10-rc3-mm1-full/net/bluetooth/rfcomm/core.c.old	2004-12-14 02:19:43.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/bluetooth/rfcomm/core.c	2004-12-14 02:27:41.000000000 +0100
@@ -61,8 +61,12 @@
 struct proc_dir_entry *proc_bt_rfcomm;
 #endif
 
-struct task_struct *rfcomm_thread;
-DECLARE_MUTEX(rfcomm_sem);
+static struct task_struct *rfcomm_thread;
+
+static DECLARE_MUTEX(rfcomm_sem);
+#define rfcomm_lock()	down(&rfcomm_sem);
+#define rfcomm_unlock()	up(&rfcomm_sem);
+
 unsigned long rfcomm_event;
 
 static LIST_HEAD(session_list);
@@ -81,6 +85,10 @@
 
 static void rfcomm_process_connect(struct rfcomm_session *s);
 
+static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src, bdaddr_t *dst, int *err);
+static struct rfcomm_session *rfcomm_session_get(bdaddr_t *src, bdaddr_t *dst);
+static void rfcomm_session_del(struct rfcomm_session *s);
+
 /* ---- RFCOMM frame parsing macros ---- */
 #define __get_dlci(b)     ((b & 0xfc) >> 2)
 #define __get_channel(b)  ((b & 0xf8) >> 3)
@@ -111,6 +119,21 @@
 #define __get_rpn_stop_bits(line) (((line) >> 2) & 0x1)
 #define __get_rpn_parity(line)    (((line) >> 3) & 0x3)
 
+static inline void rfcomm_schedule(uint event)
+{
+	if (!rfcomm_thread)
+		return;
+	//set_bit(event, &rfcomm_event);
+	set_bit(RFCOMM_SCHED_WAKEUP, &rfcomm_event);
+	wake_up_process(rfcomm_thread);
+}
+
+static inline void rfcomm_session_put(struct rfcomm_session *s)
+{
+	if (atomic_dec_and_test(&s->refcnt))
+		rfcomm_session_del(s);
+}
+
 /* ---- RFCOMM FCS computation ---- */
 
 /* CRC on 2 bytes */
@@ -458,7 +481,7 @@
 }
 
 /* ---- RFCOMM sessions ---- */
-struct rfcomm_session *rfcomm_session_add(struct socket *sock, int state)
+static struct rfcomm_session *rfcomm_session_add(struct socket *sock, int state)
 {
 	struct rfcomm_session *s = kmalloc(sizeof(*s), GFP_KERNEL);
 	if (!s)
@@ -487,7 +510,7 @@
 	return s;
 }
 
-void rfcomm_session_del(struct rfcomm_session *s)
+static void rfcomm_session_del(struct rfcomm_session *s)
 {
 	int state = s->state;
 
@@ -505,7 +528,7 @@
 		module_put(THIS_MODULE);
 }
 
-struct rfcomm_session *rfcomm_session_get(bdaddr_t *src, bdaddr_t *dst)
+static struct rfcomm_session *rfcomm_session_get(bdaddr_t *src, bdaddr_t *dst)
 {
 	struct rfcomm_session *s;
 	struct list_head *p, *n;
@@ -521,7 +544,7 @@
 	return NULL;
 }
 
-void rfcomm_session_close(struct rfcomm_session *s, int err)
+static void rfcomm_session_close(struct rfcomm_session *s, int err)
 {
 	struct rfcomm_dlc *d;
 	struct list_head *p, *n;
@@ -542,7 +565,7 @@
 	rfcomm_session_put(s);
 }
 
-struct rfcomm_session *rfcomm_session_create(bdaddr_t *src, bdaddr_t *dst, int *err)
+static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src, bdaddr_t *dst, int *err)
 {
 	struct rfcomm_session *s = NULL;
 	struct sockaddr_l2 addr;
--- linux-2.6.10-rc3-mm1-full/net/bluetooth/rfcomm/sock.c.old	2004-12-14 02:28:14.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/bluetooth/rfcomm/sock.c	2004-12-14 02:28:33.000000000 +0100
@@ -393,7 +393,7 @@
 	return err;
 }
 
-int rfcomm_sock_listen(struct socket *sock, int backlog)
+static int rfcomm_sock_listen(struct socket *sock, int backlog)
 {
 	struct sock *sk = sock->sk;
 	int err = 0;
@@ -437,7 +437,7 @@
 	return err;
 }
 
-int rfcomm_sock_accept(struct socket *sock, struct socket *newsock, int flags)
+static int rfcomm_sock_accept(struct socket *sock, struct socket *newsock, int flags)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	struct sock *sk = sock->sk, *nsk;

