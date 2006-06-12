Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbWFLXfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbWFLXfK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 19:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWFLXfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 19:35:10 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:63413 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932462AbWFLXfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 19:35:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:x-mailer:mime-version:content-type;
        b=gt8uQsUptO1dX7u/hsBn6+vy1CrbybpssXJ+FffHbV4mX8oqsdlRFY38Po26k+ebit0lMin2dIjAdfCn0fQXs78BiW9KJIXO/Xx+ssNoD9JiXyI9iboPzcD8bFoa9UimcmytUtATJ+IWtlEZk5alW8UCJIDMuExLZCi0YiGUU6k=
Date: Tue, 13 Jun 2006 01:34:52 +0200
From: Laura Garcia <nevola@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] cpqarray: Cleanups about ida_proc_get_info
Message-ID: <20060613013452.2e237f63@enano>
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Tue__13_Jun_2006_01_34_52_+0200_hXqDaT5lgxyR1y=B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Multipart_Tue__13_Jun_2006_01_34_52_+0200_hXqDaT5lgxyR1y=B
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, this patch do some fixes about ida_proc_get_info().

	- Removes unused local variables
	- Eliminates possible null pointers
	- Rewrite spin locks order
	- Define unused CPQ_PROC_PRINT_QUEUES


Signed-off-by: Laura Garcia Liebana <nevola@gmail.com>

diff -Nru a/drivers/block/cpqarray.c b/drivers/block/cpqarray.c
--- a/drivers/block/cpqarray.c  2006-06-13 01:03:02.000000000 +0200
+++ b/drivers/block/cpqarray.c  2006-06-13 01:01:29.000000000 +0200
@@ -227,11 +227,11 @@
 /*
  * Report information about this controller.
  */
-static int ida_proc_get_info(char *buffer, char **start, off_t offset, int length, int *e
of, void *data)
+static int ida_proc_get_info(char *buffer, char **start, off_t offset, 
+                                       int length, int *eof, void *data)
 {
-       off_t pos = 0;
        off_t len = 0;
-       int size, i, ctlr;
+       int i, ctlr;
        ctlr_info_t *h = (ctlr_info_t*)data;
        drv_info_t *drv;
 #ifdef CPQ_PROC_PRINT_QUEUES
@@ -240,7 +240,7 @@
 #endif
 
        ctlr = h->ctlr;
-       size = sprintf(buffer, "%s:  Compaq %s Controller\n"
+       len += sprintf(buffer, "%s:  Compaq %s Controller\n"
                "       Board ID: 0x%08lx\n"
                "       Firmware Revision: %c%c%c%c\n"
                "       Controller Sig: 0x%08lx\n"
@@ -260,47 +260,43 @@
                h->log_drives, h->phys_drives,
                h->Qdepth, h->maxQsinceinit);
 
-       pos += size; len += size;
-       
-       size = sprintf(buffer+len, "Logical Drive Info:\n");
-       pos += size; len += size;
+       len += sprintf(buffer+len, "Logical Drive Info:\n");
 
        for(i=0; i<h->log_drives; i++) {
                drv = &h->drv[i];
-               size = sprintf(buffer+len, "ida/c%dd%d: blksz=%d nr_blks=%d\n",
+               len += sprintf(buffer+len, "ida/c%dd%d: blksz=%d nr_blks=%d\n",
                                ctlr, i, drv->blk_size, drv->nr_blks);
-               pos += size; len += size;
        }
 
 #ifdef CPQ_PROC_PRINT_QUEUES
-       spin_lock_irqsave(IDA_LOCK(h->ctlr), flags); 
-       size = sprintf(buffer+len, "\nCurrent Queues:\n");
-       pos += size; len += size;
+       len += sprintf(buffer+len, "\nCurrent Queues:\n");
+       spin_lock_irqsave(IDA_LOCK(ctlr), flags); 
 
        c = h->reqQ;
-       size = sprintf(buffer+len, "reqQ = %p", c); pos += size; len += size;
-       if (c) c=c->next;
-       while(c && c != h->reqQ) {
-               size = sprintf(buffer+len, "->%p", c);
-               pos += size; len += size;
+       if (c) {
+               len += sprintf(buffer+len, "reqQ = %p", c);
                c=c->next;
+               while(c && c != h->reqQ) {
+                       len += sprintf(buffer+len, "->%p", c);
+                       c=c->next;
+               }
        }
 
        c = h->cmpQ;
-       size = sprintf(buffer+len, "\ncmpQ = %p", c); pos += size; len += size;
-       if (c) c=c->next;
-       while(c && c != h->cmpQ) {
-               size = sprintf(buffer+len, "->%p", c);
-               pos += size; len += size;
+       if (c) {
+               len += sprintf(buffer+len, "\ncmpQ = %p", c);
                c=c->next;
+               while(c && c != h->cmpQ) {
+                       len += sprintf(buffer+len, "->%p", c);
+                       c=c->next;
+               }
        }
 
-       size = sprintf(buffer+len, "\n"); pos += size; len += size;
-       spin_unlock_irqrestore(IDA_LOCK(h->ctlr), flags); 
+       spin_unlock_irqrestore(IDA_LOCK(ctlr), flags); 
+       len += sprintf(buffer+len, "\n");
 #endif
-       size = sprintf(buffer+len, "nr_allocs = %d\nnr_frees = %d\n",
+       len += sprintf(buffer+len, "nr_allocs = %d\nnr_frees = %d\n",
                        h->nr_allocs, h->nr_frees);
-       pos += size; len += size;
 
        *eof = 1;
        *start = buffer+offset;
diff -Nru a/drivers/block/Kconfig b/drivers/block/Kconfig
--- a/drivers/block/Kconfig     2006-06-13 01:04:44.000000000 +0200
+++ b/drivers/block/Kconfig     2006-06-13 01:01:29.000000000 +0200
@@ -154,6 +154,13 @@
          supported by this driver, and for further information on the use of
          this driver.
 
+config CPQ_PROC_PRINT_QUEUES
+       bool "Print Smart Array Queues information"
+       depends on BLK_CPQ_DA
+       help
+         This option prints some extra information about Smart Array Queues
+         under proc filesystem.
+
 config BLK_CPQ_CISS_DA
        tristate "Compaq Smart Array 5xxx support"
        depends on PCI


--Multipart_Tue__13_Jun_2006_01_34_52_+0200_hXqDaT5lgxyR1y=B
Content-Type: application/octet-stream;
 name=cpqarray-ida_proc_get_info.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=cpqarray-ida_proc_get_info.patch

ZGlmZiAtTnJ1IGEvZHJpdmVycy9ibG9jay9jcHFhcnJheS5jIGIvZHJpdmVycy9ibG9jay9jcHFh
cnJheS5jCi0tLSBhL2RyaXZlcnMvYmxvY2svY3BxYXJyYXkuYwkyMDA2LTA2LTEzIDAxOjAzOjAy
LjAwMDAwMDAwMCArMDIwMAorKysgYi9kcml2ZXJzL2Jsb2NrL2NwcWFycmF5LmMJMjAwNi0wNi0x
MyAwMTowMToyOS4wMDAwMDAwMDAgKzAyMDAKQEAgLTIyNywxMSArMjI3LDExIEBACiAvKgogICog
UmVwb3J0IGluZm9ybWF0aW9uIGFib3V0IHRoaXMgY29udHJvbGxlci4KICAqLwotc3RhdGljIGlu
dCBpZGFfcHJvY19nZXRfaW5mbyhjaGFyICpidWZmZXIsIGNoYXIgKipzdGFydCwgb2ZmX3Qgb2Zm
c2V0LCBpbnQgbGVuZ3RoLCBpbnQgKmVvZiwgdm9pZCAqZGF0YSkKK3N0YXRpYyBpbnQgaWRhX3By
b2NfZ2V0X2luZm8oY2hhciAqYnVmZmVyLCBjaGFyICoqc3RhcnQsIG9mZl90IG9mZnNldCwgCisJ
CQkJCWludCBsZW5ndGgsIGludCAqZW9mLCB2b2lkICpkYXRhKQogewotCW9mZl90IHBvcyA9IDA7
CiAJb2ZmX3QgbGVuID0gMDsKLQlpbnQgc2l6ZSwgaSwgY3RscjsKKwlpbnQgaSwgY3RscjsKIAlj
dGxyX2luZm9fdCAqaCA9IChjdGxyX2luZm9fdCopZGF0YTsKIAlkcnZfaW5mb190ICpkcnY7CiAj
aWZkZWYgQ1BRX1BST0NfUFJJTlRfUVVFVUVTCkBAIC0yNDAsNyArMjQwLDcgQEAKICNlbmRpZgog
CiAJY3RsciA9IGgtPmN0bHI7Ci0Jc2l6ZSA9IHNwcmludGYoYnVmZmVyLCAiJXM6ICBDb21wYXEg
JXMgQ29udHJvbGxlclxuIgorCWxlbiArPSBzcHJpbnRmKGJ1ZmZlciwgIiVzOiAgQ29tcGFxICVz
IENvbnRyb2xsZXJcbiIKIAkJIiAgICAgICBCb2FyZCBJRDogMHglMDhseFxuIgogCQkiICAgICAg
IEZpcm13YXJlIFJldmlzaW9uOiAlYyVjJWMlY1xuIgogCQkiICAgICAgIENvbnRyb2xsZXIgU2ln
OiAweCUwOGx4XG4iCkBAIC0yNjAsNDcgKzI2MCw0MyBAQAogCQloLT5sb2dfZHJpdmVzLCBoLT5w
aHlzX2RyaXZlcywKIAkJaC0+UWRlcHRoLCBoLT5tYXhRc2luY2Vpbml0KTsKIAotCXBvcyArPSBz
aXplOyBsZW4gKz0gc2l6ZTsKLQkKLQlzaXplID0gc3ByaW50ZihidWZmZXIrbGVuLCAiTG9naWNh
bCBEcml2ZSBJbmZvOlxuIik7Ci0JcG9zICs9IHNpemU7IGxlbiArPSBzaXplOworCWxlbiArPSBz
cHJpbnRmKGJ1ZmZlcitsZW4sICJMb2dpY2FsIERyaXZlIEluZm86XG4iKTsKIAogCWZvcihpPTA7
IGk8aC0+bG9nX2RyaXZlczsgaSsrKSB7CiAJCWRydiA9ICZoLT5kcnZbaV07Ci0JCXNpemUgPSBz
cHJpbnRmKGJ1ZmZlcitsZW4sICJpZGEvYyVkZCVkOiBibGtzej0lZCBucl9ibGtzPSVkXG4iLAor
CQlsZW4gKz0gc3ByaW50ZihidWZmZXIrbGVuLCAiaWRhL2MlZGQlZDogYmxrc3o9JWQgbnJfYmxr
cz0lZFxuIiwKIAkJCQljdGxyLCBpLCBkcnYtPmJsa19zaXplLCBkcnYtPm5yX2Jsa3MpOwotCQlw
b3MgKz0gc2l6ZTsgbGVuICs9IHNpemU7CiAJfQogCiAjaWZkZWYgQ1BRX1BST0NfUFJJTlRfUVVF
VUVTCi0Jc3Bpbl9sb2NrX2lycXNhdmUoSURBX0xPQ0soaC0+Y3RsciksIGZsYWdzKTsgCi0Jc2l6
ZSA9IHNwcmludGYoYnVmZmVyK2xlbiwgIlxuQ3VycmVudCBRdWV1ZXM6XG4iKTsKLQlwb3MgKz0g
c2l6ZTsgbGVuICs9IHNpemU7CisJbGVuICs9IHNwcmludGYoYnVmZmVyK2xlbiwgIlxuQ3VycmVu
dCBRdWV1ZXM6XG4iKTsKKwlzcGluX2xvY2tfaXJxc2F2ZShJREFfTE9DSyhjdGxyKSwgZmxhZ3Mp
OyAKIAogCWMgPSBoLT5yZXFROwotCXNpemUgPSBzcHJpbnRmKGJ1ZmZlcitsZW4sICJyZXFRID0g
JXAiLCBjKTsgcG9zICs9IHNpemU7IGxlbiArPSBzaXplOwotCWlmIChjKSBjPWMtPm5leHQ7Ci0J
d2hpbGUoYyAmJiBjICE9IGgtPnJlcVEpIHsKLQkJc2l6ZSA9IHNwcmludGYoYnVmZmVyK2xlbiwg
Ii0+JXAiLCBjKTsKLQkJcG9zICs9IHNpemU7IGxlbiArPSBzaXplOworCWlmIChjKSB7CisJCWxl
biArPSBzcHJpbnRmKGJ1ZmZlcitsZW4sICJyZXFRID0gJXAiLCBjKTsKIAkJYz1jLT5uZXh0Owor
CQl3aGlsZShjICYmIGMgIT0gaC0+cmVxUSkgeworCQkJbGVuICs9IHNwcmludGYoYnVmZmVyK2xl
biwgIi0+JXAiLCBjKTsKKwkJCWM9Yy0+bmV4dDsKKwkJfQogCX0KIAogCWMgPSBoLT5jbXBROwot
CXNpemUgPSBzcHJpbnRmKGJ1ZmZlcitsZW4sICJcbmNtcFEgPSAlcCIsIGMpOyBwb3MgKz0gc2l6
ZTsgbGVuICs9IHNpemU7Ci0JaWYgKGMpIGM9Yy0+bmV4dDsKLQl3aGlsZShjICYmIGMgIT0gaC0+
Y21wUSkgewotCQlzaXplID0gc3ByaW50ZihidWZmZXIrbGVuLCAiLT4lcCIsIGMpOwotCQlwb3Mg
Kz0gc2l6ZTsgbGVuICs9IHNpemU7CisJaWYgKGMpIHsKKwkJbGVuICs9IHNwcmludGYoYnVmZmVy
K2xlbiwgIlxuY21wUSA9ICVwIiwgYyk7CiAJCWM9Yy0+bmV4dDsKKwkJd2hpbGUoYyAmJiBjICE9
IGgtPmNtcFEpIHsKKwkJCWxlbiArPSBzcHJpbnRmKGJ1ZmZlcitsZW4sICItPiVwIiwgYyk7CisJ
CQljPWMtPm5leHQ7CisJCX0KIAl9CiAKLQlzaXplID0gc3ByaW50ZihidWZmZXIrbGVuLCAiXG4i
KTsgcG9zICs9IHNpemU7IGxlbiArPSBzaXplOwotCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoSURB
X0xPQ0soaC0+Y3RsciksIGZsYWdzKTsgCisJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZShJREFfTE9D
SyhjdGxyKSwgZmxhZ3MpOyAKKwlsZW4gKz0gc3ByaW50ZihidWZmZXIrbGVuLCAiXG4iKTsKICNl
bmRpZgotCXNpemUgPSBzcHJpbnRmKGJ1ZmZlcitsZW4sICJucl9hbGxvY3MgPSAlZFxubnJfZnJl
ZXMgPSAlZFxuIiwKKwlsZW4gKz0gc3ByaW50ZihidWZmZXIrbGVuLCAibnJfYWxsb2NzID0gJWRc
bm5yX2ZyZWVzID0gJWRcbiIsCiAJCQloLT5ucl9hbGxvY3MsIGgtPm5yX2ZyZWVzKTsKLQlwb3Mg
Kz0gc2l6ZTsgbGVuICs9IHNpemU7CiAKIAkqZW9mID0gMTsKIAkqc3RhcnQgPSBidWZmZXIrb2Zm
c2V0OwpkaWZmIC1OcnUgYS9kcml2ZXJzL2Jsb2NrL0tjb25maWcgYi9kcml2ZXJzL2Jsb2NrL0tj
b25maWcKLS0tIGEvZHJpdmVycy9ibG9jay9LY29uZmlnCTIwMDYtMDYtMTMgMDE6MDQ6NDQuMDAw
MDAwMDAwICswMjAwCisrKyBiL2RyaXZlcnMvYmxvY2svS2NvbmZpZwkyMDA2LTA2LTEzIDAxOjAx
OjI5LjAwMDAwMDAwMCArMDIwMApAQCAtMTU0LDYgKzE1NCwxMyBAQAogCSAgc3VwcG9ydGVkIGJ5
IHRoaXMgZHJpdmVyLCBhbmQgZm9yIGZ1cnRoZXIgaW5mb3JtYXRpb24gb24gdGhlIHVzZSBvZgog
CSAgdGhpcyBkcml2ZXIuCiAKK2NvbmZpZyBDUFFfUFJPQ19QUklOVF9RVUVVRVMKKwlib29sICJQ
cmludCBTbWFydCBBcnJheSBRdWV1ZXMgaW5mb3JtYXRpb24iCisJZGVwZW5kcyBvbiBCTEtfQ1BR
X0RBCisJaGVscAorCSAgVGhpcyBvcHRpb24gcHJpbnRzIHNvbWUgZXh0cmEgaW5mb3JtYXRpb24g
YWJvdXQgU21hcnQgQXJyYXkgUXVldWVzCisJICB1bmRlciBwcm9jIGZpbGVzeXN0ZW0uCisKIGNv
bmZpZyBCTEtfQ1BRX0NJU1NfREEKIAl0cmlzdGF0ZSAiQ29tcGFxIFNtYXJ0IEFycmF5IDV4eHgg
c3VwcG9ydCIKIAlkZXBlbmRzIG9uIFBDSQo=

--Multipart_Tue__13_Jun_2006_01_34_52_+0200_hXqDaT5lgxyR1y=B--
