Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423086AbWJZJ6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423086AbWJZJ6K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 05:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423099AbWJZJ6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 05:58:09 -0400
Received: from barracuda.s2io.com ([72.1.205.138]:64981 "EHLO
	barracuda.s2io.com") by vger.kernel.org with ESMTP id S1423086AbWJZJ6G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 05:58:06 -0400
X-ASG-Debug-ID: 1161856683-24244-4-2
X-Barracuda-URL: http://72.1.205.138:8000/cgi-bin/mark.cgi
X-ASG-Whitelist: Client
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C6F8E4.D2F8B3F5"
X-ASG-Orig-Subj: RE: [PATCH] s2io: add PCI error recovery support
Subject: RE: [PATCH] s2io: add PCI error recovery support
Date: Thu, 26 Oct 2006 05:56:34 -0400
Message-ID: <78C9135A3D2ECE4B8162EBDCE82CAD77DC1ED7@nekter>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] s2io: add PCI error recovery support
Thread-Index: Acb4d4aj2JWIcEM8QPibTUongd4QqwAbDIeg
From: "Ananda Raju" <Ananda.Raju@neterion.com>
To: "Linas Vepstas" <linas@austin.ibm.com>
Cc: "Wen Xiong" <wenxiong@us.ibm.com>, <linux-kernel@vger.kernel.org>,
       <linux-pci@atrey.karlin.mff.cuni.cz>, <netdev@vger.kernel.org>,
       "Jeff Garzik" <jgarzik@pobox.com>, "Andrew Morton" <akpm@osdl.org>
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=3.5 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6F8E4.D2F8B3F5
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,=20
Can you try attached patch. The attached patch is simple. We set card
state as down in error_detecct() so that all entry points return error
and don't proceed further.

In slot_reset() we do s2io_card_down() will reset adapter.=20
In io_resume() we bringup the driver.=20

Ananda=20

-----Original Message-----
From: Linas Vepstas [mailto:linas@austin.ibm.com]=20
Sent: Wednesday, October 25, 2006 1:55 PM
To: Ananda Raju
Cc: Wen Xiong; linux-kernel@vger.kernel.org;
linux-pci@atrey.karlin.mff.cuni.cz; netdev@vger.kernel.org; Jeff Garzik;
Andrew Morton
Subject: Re: [PATCH] s2io: add PCI error recovery support

On Wed, Oct 25, 2006 at 10:11:24AM -0500, Linas Vepstas wrote:
>=20
> > Also we have to add following if statement in beginning of
s2io_isr().

Done, below,

> > If it is ok to do BAR0 read/write in error_detected() then patch is
OK.=20

I re-wrote that section to avoid doing I/O. It seems to work well,
and generates a few less messages in the process.  New, improved patch
below, please ack and send upstream if you like it.

--linas

This patch adds PCI error recovery support to the=20
s2io 10-Gigabit ethernet device driver.

Tested, seems to work well.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: Raghavendra Koushik <raghavendra.koushik@neterion.com>
Cc: Ananda Raju <Ananda.Raju@neterion.com>
Cc: Wen Xiong <wenxiong@us.ibm.com>

----
 drivers/net/s2io.c |  103
+++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/s2io.h |    5 ++
 2 files changed, 108 insertions(+)

Index: linux-2.6.19-rc1-git11/drivers/net/s2io.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19-rc1-git11.orig/drivers/net/s2io.c	2006-10-25
14:09:47.000000000 -0500
+++ linux-2.6.19-rc1-git11/drivers/net/s2io.c	2006-10-25
15:18:25.000000000 -0500
@@ -434,11 +434,18 @@ static struct pci_device_id s2io_tbl[] _
=20
 MODULE_DEVICE_TABLE(pci, s2io_tbl);
=20
+static struct pci_error_handlers s2io_err_handler =3D {
+	.error_detected =3D s2io_io_error_detected,
+	.slot_reset =3D s2io_io_slot_reset,
+	.resume =3D s2io_io_resume,
+};
+
 static struct pci_driver s2io_driver =3D {
       .name =3D "S2IO",
       .id_table =3D s2io_tbl,
       .probe =3D s2io_init_nic,
       .remove =3D __devexit_p(s2io_rem_nic),
+      .err_handler =3D &s2io_err_handler,
 };
=20
 /* A simplifier macro used both by init and free shared_mem Fns(). */
@@ -4171,6 +4178,11 @@ static irqreturn_t s2io_isr(int irq, voi
 	mac_info_t *mac_control;
 	struct config_param *config;
=20
+	if ((sp->pdev->error_state !=3D pci_channel_io_normal) &&
+		 (sp->pdev->error_state !=3D 0)) {
+		return IRQ_HANDLED;
+	}
+
 	atomic_inc(&sp->isr_cnt);
 	mac_control =3D &sp->mac_control;
 	config =3D &sp->config;
@@ -7564,3 +7576,94 @@ static void lro_append_pkt(nic_t *sp, lr
 	sp->mac_control.stats_info->sw_stat.clubbed_frms_cnt++;
 	return;
 }
+
+/**
+ * s2io_io_error_detected - called when PCI error is detected
+ * @pdev: Pointer to PCI device
+ * @state: The current pci conneection state
+ *
+ * This function is called after a PCI bus error affecting
+ * this device has been detected.
+ */
+static pci_ers_result_t s2io_io_error_detected(struct pci_dev *pdev,
pci_channel_state_t state)
+{
+	struct net_device *netdev =3D pci_get_drvdata(pdev);
+	nic_t *sp =3D netdev->priv;
+
+	netif_device_detach(netdev);
+
+	if (netif_running(netdev)) {
+		unsigned long flags;
+
+		/* The folowing is an abreviated subset of the
+		 * steps taken by s2io_card_down(), avoiding
+		 * steps that touch the card itself.
+		 */
+		del_timer_sync(&sp->alarm_timer);
+		atomic_set(&sp->card_state, CARD_DOWN);
+
+		/* Kill tasklet. */
+		tasklet_kill(&sp->task);
+
+		/* Free all Tx buffers */
+		spin_lock_irqsave(&sp->tx_lock, flags);
+		free_tx_buffers(sp);
+		spin_unlock_irqrestore(&sp->tx_lock, flags);
+
+		/* Free all Rx buffers */
+		spin_lock_irqsave(&sp->rx_lock, flags);
+		free_rx_buffers(sp);
+		spin_unlock_irqrestore(&sp->rx_lock, flags);
+=09
+		clear_bit(0, &(sp->link_state));
+		sp->device_close_flag =3D TRUE;	/* Device is shut down.
*/
+	}
+	pci_disable_device(pdev);
+
+	return PCI_ERS_RESULT_NEED_RESET;
+}
+
+/**
+ * s2io_io_slot_reset - called after the pci bus has been reset.
+ * @pdev: Pointer to PCI device
+ *
+ * Restart the card from scratch, as if from a cold-boot.
+ */
+static pci_ers_result_t s2io_io_slot_reset(struct pci_dev *pdev)
+{
+	struct net_device *netdev =3D pci_get_drvdata(pdev);
+	nic_t *sp =3D netdev->priv;
+
+	if (pci_enable_device(pdev)) {
+		printk(KERN_ERR "s2io: Cannot re-enable PCI device after
reset.\n");
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	pci_set_master(pdev);
+	s2io_reset(sp);
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+/**
+ * s2io_io_resume - called when traffic can start flowing again.
+ * @pdev: Pointer to PCI device
+ *
+ * This callback is called when the error recovery driver tells us that
+ * its OK to resume normal operation.
+ */
+static void s2io_io_resume(struct pci_dev *pdev)
+{
+	struct net_device *netdev =3D pci_get_drvdata(pdev);
+	nic_t *sp =3D netdev->priv;
+
+	if (netif_running(netdev)) {
+		if (s2io_card_up(sp)) {
+			printk(KERN_ERR "s2io: can't bring device back
up after reset\n");
+			return;
+		}
+	}
+
+	netif_device_attach(netdev);
+	netif_wake_queue(netdev);
+}
Index: linux-2.6.19-rc1-git11/drivers/net/s2io.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19-rc1-git11.orig/drivers/net/s2io.h	2006-10-25
14:09:47.000000000 -0500
+++ linux-2.6.19-rc1-git11/drivers/net/s2io.h	2006-10-25
14:11:05.000000000 -0500
@@ -1013,6 +1013,11 @@ static void queue_rx_frame(struct sk_buf
 static void update_L3L4_header(nic_t *sp, lro_t *lro);
 static void lro_append_pkt(nic_t *sp, lro_t *lro, struct sk_buff *skb,
u32 tcp_len);
=20
+static pci_ers_result_t s2io_io_error_detected(struct pci_dev *pdev,
+                                               pci_channel_state_t
state);
+static pci_ers_result_t s2io_io_slot_reset(struct pci_dev *pdev);
+static void s2io_io_resume(struct pci_dev *pdev);
+
 #define s2io_tcp_mss(skb) skb_shinfo(skb)->gso_size
 #define s2io_udp_mss(skb) skb_shinfo(skb)->gso_size
 #define s2io_offload_type(skb) skb_shinfo(skb)->gso_type


------_=_NextPart_001_01C6F8E4.D2F8B3F5
Content-Type: application/octet-stream;
	name="pci_err_rec.patch"
Content-Transfer-Encoding: base64
Content-Description: pci_err_rec.patch
Content-Disposition: attachment;
	filename="pci_err_rec.patch"

aGksIAoKVGhpcyBwYXRjaCBhZGRzIFBDSSBlcnJvciByZWNvdmVyeSBzdXBwb3J0IHRvIHRoZSAK
czJpbyAxMC1HaWdhYml0IGV0aGVybmV0IGRldmljZSBkcml2ZXIuIFRoaXMgaXMgbW9kaWZpZWQg
cGF0Y2ggYmFzZWQgb24gcHJldmlvdXMKc3VibWl0dGVkIGJ5IExpbmFzIFZlcHN0YXMgPGxpbmFz
QGF1c3Rpbi5pYm0uY29tPgoKU2lnbmVkLW9mZi1ieTogQW5hbmRhIFJhanUgPEFuYW5kYS5SYWp1
QG5ldGVyaW9uLmNvbT4KQ2M6IFdlbiBYaW9uZyA8d2VueGlvbmdAdXMuaWJtLmNvbT4KQ2M6IExp
bmFzIFZlcHN0YXMgPGxpbmFzQGF1c3Rpbi5pYm0uY29tPgotLS0KZGlmZiAtdXBOciBsaW51eC0y
LjYuMTktcmMxL2RyaXZlcnMvbmV0L3MyaW8uYyBwY2lfZXJyX3JlYy9kcml2ZXJzL25ldC9zMmlv
LmMKLS0tIGxpbnV4LTIuNi4xOS1yYzEvZHJpdmVycy9uZXQvczJpby5jCTIwMDYtMTAtMjYgMDI6
MjU6MzYuMDAwMDAwMDAwICswNTMwCisrKyBwY2lfZXJyX3JlYy9kcml2ZXJzL25ldC9zMmlvLmMJ
MjAwNi0xMC0yNiAwMzoyMDoyNi4wMDAwMDAwMDAgKzA1MzAKQEAgLTQzNCwxMSArNDM0LDE4IEBA
IHN0YXRpYyBzdHJ1Y3QgcGNpX2RldmljZV9pZCBzMmlvX3RibFtdIF8KIAogTU9EVUxFX0RFVklD
RV9UQUJMRShwY2ksIHMyaW9fdGJsKTsKIAorc3RhdGljIHN0cnVjdCBwY2lfZXJyb3JfaGFuZGxl
cnMgczJpb19lcnJfaGFuZGxlciA9IHsKKwkuZXJyb3JfZGV0ZWN0ZWQgPSBzMmlvX2lvX2Vycm9y
X2RldGVjdGVkLAorCS5zbG90X3Jlc2V0ID0gczJpb19pb19zbG90X3Jlc2V0LAorCS5yZXN1bWUg
PSBzMmlvX2lvX3Jlc3VtZSwKK307CisKIHN0YXRpYyBzdHJ1Y3QgcGNpX2RyaXZlciBzMmlvX2Ry
aXZlciA9IHsKICAgICAgIC5uYW1lID0gIlMySU8iLAogICAgICAgLmlkX3RhYmxlID0gczJpb190
YmwsCiAgICAgICAucHJvYmUgPSBzMmlvX2luaXRfbmljLAogICAgICAgLnJlbW92ZSA9IF9fZGV2
ZXhpdF9wKHMyaW9fcmVtX25pYyksCisgICAgICAuZXJyX2hhbmRsZXIgPSAmczJpb19lcnJfaGFu
ZGxlciwKIH07CiAKIC8qIEEgc2ltcGxpZmllciBtYWNybyB1c2VkIGJvdGggYnkgaW5pdCBhbmQg
ZnJlZSBzaGFyZWRfbWVtIEZucygpLiAqLwpAQCAtMjU4MCw2ICsyNTg3LDEwIEBAIHN0YXRpYyBp
bnQgczJpb19wb2xsKHN0cnVjdCBuZXRfZGV2aWNlICoKIAl1NjQgdmFsNjQgPSAweEZGRkZGRkZG
RkZGRkZGRkZVTEw7CiAJaW50IGk7CiAKKwlpZiAoYXRvbWljX3JlYWQoJm5pYy0+Y2FyZF9zdGF0
ZSkgPT0gQ0FSRF9ET1dOKSB7CisJCXJldHVybiAwOworCX0KKwogCWF0b21pY19pbmMoJm5pYy0+
aXNyX2NudCk7CiAJbWFjX2NvbnRyb2wgPSAmbmljLT5tYWNfY29udHJvbDsKIAljb25maWcgPSAm
bmljLT5jb25maWc7CkBAIC00MTc1LDYgKzQxODYsMTAgQEAgc3RhdGljIGlycXJldHVybl90IHMy
aW9faXNyKGludCBpcnEsIHZvaQogCW1hY19pbmZvX3QgKm1hY19jb250cm9sOwogCXN0cnVjdCBj
b25maWdfcGFyYW0gKmNvbmZpZzsKIAorCWlmIChhdG9taWNfcmVhZCgmc3AtPmNhcmRfc3RhdGUp
ID09IENBUkRfRE9XTikgeworCQlyZXR1cm4gSVJRX05PTkU7CisJfQorCiAJYXRvbWljX2luYygm
c3AtPmlzcl9jbnQpOwogCW1hY19jb250cm9sID0gJnNwLT5tYWNfY29udHJvbDsKIAljb25maWcg
PSAmc3AtPmNvbmZpZzsKQEAgLTc1NjgsMyArNzU4Myw3MSBAQCBzdGF0aWMgdm9pZCBscm9fYXBw
ZW5kX3BrdChuaWNfdCAqc3AsIGxyCiAJc3AtPm1hY19jb250cm9sLnN0YXRzX2luZm8tPnN3X3N0
YXQuY2x1YmJlZF9mcm1zX2NudCsrOwogCXJldHVybjsKIH0KKworLyoqCisgKiBzMmlvX2lvX2Vy
cm9yX2RldGVjdGVkIC0gY2FsbGVkIHdoZW4gUENJIGVycm9yIGlzIGRldGVjdGVkCisgKiBAcGRl
djogUG9pbnRlciB0byBQQ0kgZGV2aWNlCisgKiBAc3RhdGU6IFRoZSBjdXJyZW50IHBjaSBjb25u
ZWVjdGlvbiBzdGF0ZQorICoKKyAqIFRoaXMgZnVuY3Rpb24gaXMgY2FsbGVkIGFmdGVyIGEgUENJ
IGJ1cyBlcnJvciBhZmZlY3RpbmcKKyAqIHRoaXMgZGV2aWNlIGhhcyBiZWVuIGRldGVjdGVkLgor
ICovCitzdGF0aWMgcGNpX2Vyc19yZXN1bHRfdCBzMmlvX2lvX2Vycm9yX2RldGVjdGVkKHN0cnVj
dCBwY2lfZGV2ICpwZGV2LCBwY2lfY2hhbm5lbF9zdGF0ZV90IHN0YXRlKQoreworCXN0cnVjdCBu
ZXRfZGV2aWNlICpuZXRkZXYgPSBwY2lfZ2V0X2RydmRhdGEocGRldik7CisJbmljX3QgKnNwID0g
bmV0ZGV2LT5wcml2OworCisJbmV0aWZfZGV2aWNlX2RldGFjaChuZXRkZXYpOworCWF0b21pY19z
ZXQoJnNwLT5jYXJkX3N0YXRlLCBDQVJEX0RPV04pOworCXBjaV9kaXNhYmxlX2RldmljZShwZGV2
KTsKKworCXJldHVybiBQQ0lfRVJTX1JFU1VMVF9ORUVEX1JFU0VUOworfQorCisvKioKKyAqIHMy
aW9faW9fc2xvdF9yZXNldCAtIGNhbGxlZCBhZnRlciB0aGUgcGNpIGJ1cyBoYXMgYmVlbiByZXNl
dC4KKyAqIEBwZGV2OiBQb2ludGVyIHRvIFBDSSBkZXZpY2UKKyAqCisgKiBSZXN0YXJ0IHRoZSBj
YXJkIGZyb20gc2NyYXRjaCwgYXMgaWYgZnJvbSBhIGNvbGQtYm9vdC4KKyAqLworc3RhdGljIHBj
aV9lcnNfcmVzdWx0X3QgczJpb19pb19zbG90X3Jlc2V0KHN0cnVjdCBwY2lfZGV2ICpwZGV2KQor
eworCXN0cnVjdCBuZXRfZGV2aWNlICpuZXRkZXYgPSBwY2lfZ2V0X2RydmRhdGEocGRldik7CisJ
bmljX3QgKnNwID0gbmV0ZGV2LT5wcml2OworCisJaWYgKHBjaV9lbmFibGVfZGV2aWNlKHBkZXYp
KSB7CisJCXByaW50ayhLRVJOX0VSUiAiczJpbzogQ2Fubm90IHJlLWVuYWJsZSBQQ0kgZGV2aWNl
IGFmdGVyIHJlc2V0LlxuIik7CisJCXJldHVybiBQQ0lfRVJTX1JFU1VMVF9ESVNDT05ORUNUOwor
CX0KKworCXBjaV9zZXRfbWFzdGVyKHBkZXYpOworCWlmIChuZXRpZl9ydW5uaW5nKG5ldGRldikp
IHsKKwkJczJpb19jYXJkX2Rvd24oc3ApOworCQlzcC0+ZGV2aWNlX2Nsb3NlX2ZsYWcgPSBUUlVF
OwkvKiBEZXZpY2UgaXMgc2h1dCBkb3duLiAqLworCX0KKworCXJldHVybiBQQ0lfRVJTX1JFU1VM
VF9SRUNPVkVSRUQ7Cit9CisKKy8qKgorICogczJpb19pb19yZXN1bWUgLSBjYWxsZWQgd2hlbiB0
cmFmZmljIGNhbiBzdGFydCBmbG93aW5nIGFnYWluLgorICogQHBkZXY6IFBvaW50ZXIgdG8gUENJ
IGRldmljZQorICoKKyAqIFRoaXMgY2FsbGJhY2sgaXMgY2FsbGVkIHdoZW4gdGhlIGVycm9yIHJl
Y292ZXJ5IGRyaXZlciB0ZWxscyB1cyB0aGF0CisgKiBpdHMgT0sgdG8gcmVzdW1lIG5vcm1hbCBv
cGVyYXRpb24uCisgKi8KK3N0YXRpYyB2b2lkIHMyaW9faW9fcmVzdW1lKHN0cnVjdCBwY2lfZGV2
ICpwZGV2KQoreworCXN0cnVjdCBuZXRfZGV2aWNlICpuZXRkZXYgPSBwY2lfZ2V0X2RydmRhdGEo
cGRldik7CisJbmljX3QgKnNwID0gbmV0ZGV2LT5wcml2OworCisJaWYgKG5ldGlmX3J1bm5pbmco
bmV0ZGV2KSkgeworCQlpZiAoczJpb19jYXJkX3VwKHNwKSkgeworCQkJcHJpbnRrKEtFUk5fRVJS
ICJzMmlvOiBjYW4ndCBicmluZyBkZXZpY2UgYmFjayB1cCBhZnRlciByZXNldFxuIik7CisJCQly
ZXR1cm47CisJCX0KKwl9CisKKwluZXRpZl9kZXZpY2VfYXR0YWNoKG5ldGRldik7CisJbmV0aWZf
d2FrZV9xdWV1ZShuZXRkZXYpOworfQpkaWZmIC11cE5yIGxpbnV4LTIuNi4xOS1yYzEvZHJpdmVy
cy9uZXQvczJpby5oIHBjaV9lcnJfcmVjL2RyaXZlcnMvbmV0L3MyaW8uaAotLS0gbGludXgtMi42
LjE5LXJjMS9kcml2ZXJzL25ldC9zMmlvLmgJMjAwNi0xMC0yNiAwMjoyNTo0Mi4wMDAwMDAwMDAg
KzA1MzAKKysrIHBjaV9lcnJfcmVjL2RyaXZlcnMvbmV0L3MyaW8uaAkyMDA2LTEwLTI2IDAzOjA2
OjIwLjAwMDAwMDAwMCArMDUzMApAQCAtMTAxMyw2ICsxMDEzLDExIEBAIHN0YXRpYyB2b2lkIHF1
ZXVlX3J4X2ZyYW1lKHN0cnVjdCBza19idWYKIHN0YXRpYyB2b2lkIHVwZGF0ZV9MM0w0X2hlYWRl
cihuaWNfdCAqc3AsIGxyb190ICpscm8pOwogc3RhdGljIHZvaWQgbHJvX2FwcGVuZF9wa3Qobmlj
X3QgKnNwLCBscm9fdCAqbHJvLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCB1MzIgdGNwX2xlbik7CiAK
K3N0YXRpYyBwY2lfZXJzX3Jlc3VsdF90IHMyaW9faW9fZXJyb3JfZGV0ZWN0ZWQoc3RydWN0IHBj
aV9kZXYgKnBkZXYsCisJCQkJCQlwY2lfY2hhbm5lbF9zdGF0ZV90IHN0YXRlKTsKK3N0YXRpYyBw
Y2lfZXJzX3Jlc3VsdF90IHMyaW9faW9fc2xvdF9yZXNldChzdHJ1Y3QgcGNpX2RldiAqcGRldik7
CitzdGF0aWMgdm9pZCBzMmlvX2lvX3Jlc3VtZShzdHJ1Y3QgcGNpX2RldiAqcGRldik7CisKICNk
ZWZpbmUgczJpb190Y3BfbXNzKHNrYikgc2tiX3NoaW5mbyhza2IpLT5nc29fc2l6ZQogI2RlZmlu
ZSBzMmlvX3VkcF9tc3Moc2tiKSBza2Jfc2hpbmZvKHNrYiktPmdzb19zaXplCiAjZGVmaW5lIHMy
aW9fb2ZmbG9hZF90eXBlKHNrYikgc2tiX3NoaW5mbyhza2IpLT5nc29fdHlwZQo=

------_=_NextPart_001_01C6F8E4.D2F8B3F5--

