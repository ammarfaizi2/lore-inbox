Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265023AbSKSBgS>; Mon, 18 Nov 2002 20:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265085AbSKSBgS>; Mon, 18 Nov 2002 20:36:18 -0500
Received: from mtiwmhc13.worldnet.att.net ([204.127.131.117]:63885 "EHLO
	mtiwmhc13.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S265023AbSKSBgP>; Mon, 18 Nov 2002 20:36:15 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_=XFMail.1.5.3.Linux:20021118172026:2888=_"
Message-ID: <XFMail.20021118171621.f.duncan.m.haldane@worldnet.att.net>
X-Mailer: XFMail 1.5.3 on Linux
X-Priority: 3 (Normal)
Date: Mon, 18 Nov 2002 20:42:10 -0500 (EST)
From: Duncan Haldane <f.duncan.m.haldane@worldnet.att.net>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] cpia 2.4.20-rc2 fix camera registration bug introduced in 2.4.13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format
--_=XFMail.1.5.3.Linux:20021118172026:2888=_
Content-Type: text/plain; charset=us-ascii

Hi
I'm the cpia driver maintainer.
If it is still possible to get this small patch into 2.4.20...it would be good.

Perhaps Alan could suggest to Marcelo to include this in 2.4.20?

It fixes a bug that someone inadvertently introduced into the cpia driver when
doing spin_locking changes in 2.4.13.   (only a local copy of the camera list
was modified after that bug was introduced).  This fix restores the pre-2.4.13
behavior.   (The cam list will be implementation will be replaced by LIST_HEAD()
in the future).  

An incorrectly-placed spin_unlock() is also moved, as is a request_module().
(The incorrect spin_unlock placement caused a core dump in 2.5.4x. when
the cpia_pp module was unloaded, I don't know if it did bad things in 2.4.x)


Duncan Haldane


(patch is attached as well)
diff -uNr linux-2.4.20-rc2/drivers/media/video/cpia.c
linux-2.4.20-rc2-cpia_fix/drivers/media/video/cpia.c
--- linux-2.4.20-rc2/drivers/media/video/cpia.c Sun Nov 10 11:34:28 2002
+++ linux-2.4.20-rc2-cpia_fix/drivers/media/video/cpia.c        Mon Nov 18
16:43:37 2002
@@ -3313,9 +3313,6 @@
        proc_cpia_create();
 #endif
 
-#ifdef CONFIG_VIDEO_CPIA_PP
-       cpia_pp_init();
-#endif
 #ifdef CONFIG_KMOD
 #ifdef CONFIG_VIDEO_CPIA_PP_MODULE
        request_module("cpia_pp");
@@ -3325,6 +3322,10 @@
        request_module("cpia_usb");
 #endif
 #endif /* CONFIG_KMOD */
+
+#ifdef CONFIG_VIDEO_CPIA_PP
+       cpia_pp_init();
+#endif
 #ifdef CONFIG_VIDEO_CPIA_USB
        cpia_usb_init();
 #endif
diff -uNr linux-2.4.20-rc2/drivers/media/video/cpia.h
linux-2.4.20-rc2-cpia_fix/drivers/media/video/cpia.h
--- linux-2.4.20-rc2/drivers/media/video/cpia.h Sun Nov 10 11:34:28 2002
+++ linux-2.4.20-rc2-cpia_fix/drivers/media/video/cpia.h        Mon Nov 18
16:43:38 2002
@@ -400,15 +400,20 @@
       (p)&0x80?1:0, (p)&0x40?1:0, (p)&0x20?1:0, (p)&0x10?1:0,\
         (p)&0x08?1:0, (p)&0x04?1:0, (p)&0x02?1:0, (p)&0x01?1:0);
 
-static inline void cpia_add_to_list(struct cam_data* l, struct cam_data* drv)
+static inline void cpia_add_to_list(struct cam_data** l, struct cam_data**
drv_p)
 {
-       drv->next = l;
-       drv->previous = &l;
-       l = drv;
+       struct cam_data* drv;
+       drv = *drv_p;
+       drv->next = *l;
+       drv->previous = l;
+       *l = drv;
 }
 
-static inline void cpia_remove_from_list(struct cam_data* drv)
+
+static inline void cpia_remove_from_list(struct cam_data** drv_p)
 {
+       struct cam_data* drv;
+       drv = *drv_p;
        if (drv->previous != NULL) {
                if (drv->next != NULL)
                        drv->next->previous = drv->previous;
diff -uNr linux-2.4.20-rc2/drivers/media/video/cpia_pp.c
linux-2.4.20-rc2-cpia_fix/drivers/media/video/cpia_pp.c
--- linux-2.4.20-rc2/drivers/media/video/cpia_pp.c      Sun Nov 10 11:34:28 2002
+++ linux-2.4.20-rc2-cpia_fix/drivers/media/video/cpia_pp.c     Mon Nov 18
16:43:38 2002
@@ -566,7 +566,7 @@
                return -ENXIO;
        }
        spin_lock( &cam_list_lock_pp );
-       cpia_add_to_list(cam_list, cpia);
+       cpia_add_to_list(&cam_list, &cpia);
        spin_unlock( &cam_list_lock_pp );
 
        return 0;
@@ -580,8 +580,7 @@
        for(cpia = cam_list; cpia != NULL; cpia = cpia->next) {
                struct pp_cam_entry *cam = cpia->lowlevel_data;
                if (cam && cam->port->number == port->number) {
-                       cpia_remove_from_list(cpia);
-                       spin_unlock( &cam_list_lock_pp );                       
+                       cpia_remove_from_list(&cpia);
                        cpia_unregister_camera(cpia);
                        
                        if(cam->open_count > 0) {
@@ -595,6 +594,7 @@
                        break;
                }
        }
+       spin_unlock( &cam_list_lock_pp );                       
 }
 
 static void cpia_pp_attach (struct parport *port)
diff -uNr linux-2.4.20-rc2/drivers/media/video/cpia_usb.c
linux-2.4.20-rc2-cpia_fix/drivers/media/video/cpia_usb.c
--- linux-2.4.20-rc2/drivers/media/video/cpia_usb.c     Sun Nov 10 11:34:28 2002
+++ linux-2.4.20-rc2-cpia_fix/drivers/media/video/cpia_usb.c    Mon Nov 18
16:43:39 2002
@@ -540,7 +540,7 @@
        }
 
        spin_lock( &cam_list_lock_usb );
-       cpia_add_to_list(cam_list, cam);
+       cpia_add_to_list(&cam_list, &cam);
        spin_unlock( &cam_list_lock_usb );
 
        return cam;
@@ -587,7 +587,7 @@
        struct usb_cpia *ucpia = (struct usb_cpia *) cam->lowlevel_data;
   
        spin_lock( &cam_list_lock_usb );
-       cpia_remove_from_list(cam);
+       cpia_remove_from_list(&cam);
        spin_unlock( &cam_list_lock_usb );
        
        /* Don't even try to reset the altsetting if we're disconnected */





----------------------------------
E-Mail: Duncan Haldane <f.duncan.m.haldane@worldnet.att.net>
Date: 18-Nov-2002
Time: 16:52:46

This message was sent by XFMail
----------------------------------

--_=XFMail.1.5.3.Linux:20021118172026:2888=_
Content-Disposition: attachment; filename="linux-2.4.20-rc2-cpia_fix.patch"
Content-Transfer-Encoding: base64
Content-Description: linux-2.4.20-rc2-cpia_fix.patch
Content-Type: application/octet-stream;
 name=linux-2.4.20-rc2-cpia_fix.patch; SizeOnDisk=3384

ZGlmZiAtdU5yIGxpbnV4LTIuNC4yMC1yYzIvZHJpdmVycy9tZWRpYS92aWRlby9jcGlhLmMgbGlu
dXgtMi40LjIwLXJjMi1jcGlhX2ZpeC9kcml2ZXJzL21lZGlhL3ZpZGVvL2NwaWEuYwotLS0gbGlu
dXgtMi40LjIwLXJjMi9kcml2ZXJzL21lZGlhL3ZpZGVvL2NwaWEuYwlTdW4gTm92IDEwIDExOjM0
OjI4IDIwMDIKKysrIGxpbnV4LTIuNC4yMC1yYzItY3BpYV9maXgvZHJpdmVycy9tZWRpYS92aWRl
by9jcGlhLmMJTW9uIE5vdiAxOCAxNjo0MzozNyAyMDAyCkBAIC0zMzEzLDkgKzMzMTMsNiBAQAog
CXByb2NfY3BpYV9jcmVhdGUoKTsKICNlbmRpZgogCi0jaWZkZWYgQ09ORklHX1ZJREVPX0NQSUFf
UFAKLQljcGlhX3BwX2luaXQoKTsKLSNlbmRpZgogI2lmZGVmIENPTkZJR19LTU9ECiAjaWZkZWYg
Q09ORklHX1ZJREVPX0NQSUFfUFBfTU9EVUxFCiAJcmVxdWVzdF9tb2R1bGUoImNwaWFfcHAiKTsK
QEAgLTMzMjUsNiArMzMyMiwxMCBAQAogCXJlcXVlc3RfbW9kdWxlKCJjcGlhX3VzYiIpOwogI2Vu
ZGlmCiAjZW5kaWYJLyogQ09ORklHX0tNT0QgKi8KKworI2lmZGVmIENPTkZJR19WSURFT19DUElB
X1BQCisJY3BpYV9wcF9pbml0KCk7CisjZW5kaWYKICNpZmRlZiBDT05GSUdfVklERU9fQ1BJQV9V
U0IKIAljcGlhX3VzYl9pbml0KCk7CiAjZW5kaWYKZGlmZiAtdU5yIGxpbnV4LTIuNC4yMC1yYzIv
ZHJpdmVycy9tZWRpYS92aWRlby9jcGlhLmggbGludXgtMi40LjIwLXJjMi1jcGlhX2ZpeC9kcml2
ZXJzL21lZGlhL3ZpZGVvL2NwaWEuaAotLS0gbGludXgtMi40LjIwLXJjMi9kcml2ZXJzL21lZGlh
L3ZpZGVvL2NwaWEuaAlTdW4gTm92IDEwIDExOjM0OjI4IDIwMDIKKysrIGxpbnV4LTIuNC4yMC1y
YzItY3BpYV9maXgvZHJpdmVycy9tZWRpYS92aWRlby9jcGlhLmgJTW9uIE5vdiAxOCAxNjo0Mzoz
OCAyMDAyCkBAIC00MDAsMTUgKzQwMCwyMCBAQAogICAgICAgKHApJjB4ODA/MTowLCAocCkmMHg0
MD8xOjAsIChwKSYweDIwPzE6MCwgKHApJjB4MTA/MTowLFwKICAgICAgICAgKHApJjB4MDg/MTow
LCAocCkmMHgwND8xOjAsIChwKSYweDAyPzE6MCwgKHApJjB4MDE/MTowKTsKIAotc3RhdGljIGlu
bGluZSB2b2lkIGNwaWFfYWRkX3RvX2xpc3Qoc3RydWN0IGNhbV9kYXRhKiBsLCBzdHJ1Y3QgY2Ft
X2RhdGEqIGRydikKK3N0YXRpYyBpbmxpbmUgdm9pZCBjcGlhX2FkZF90b19saXN0KHN0cnVjdCBj
YW1fZGF0YSoqIGwsIHN0cnVjdCBjYW1fZGF0YSoqIGRydl9wKQogewotCWRydi0+bmV4dCA9IGw7
Ci0JZHJ2LT5wcmV2aW91cyA9ICZsOwotCWwgPSBkcnY7CisJc3RydWN0IGNhbV9kYXRhKiBkcnY7
CisJZHJ2ID0gKmRydl9wOworCWRydi0+bmV4dCA9ICpsOworCWRydi0+cHJldmlvdXMgPSBsOwor
CSpsID0gZHJ2OwogfQogCi1zdGF0aWMgaW5saW5lIHZvaWQgY3BpYV9yZW1vdmVfZnJvbV9saXN0
KHN0cnVjdCBjYW1fZGF0YSogZHJ2KQorCitzdGF0aWMgaW5saW5lIHZvaWQgY3BpYV9yZW1vdmVf
ZnJvbV9saXN0KHN0cnVjdCBjYW1fZGF0YSoqIGRydl9wKQogeworCXN0cnVjdCBjYW1fZGF0YSog
ZHJ2OworCWRydiA9ICpkcnZfcDsKIAlpZiAoZHJ2LT5wcmV2aW91cyAhPSBOVUxMKSB7CiAJCWlm
IChkcnYtPm5leHQgIT0gTlVMTCkKIAkJCWRydi0+bmV4dC0+cHJldmlvdXMgPSBkcnYtPnByZXZp
b3VzOwpkaWZmIC11TnIgbGludXgtMi40LjIwLXJjMi9kcml2ZXJzL21lZGlhL3ZpZGVvL2NwaWFf
cHAuYyBsaW51eC0yLjQuMjAtcmMyLWNwaWFfZml4L2RyaXZlcnMvbWVkaWEvdmlkZW8vY3BpYV9w
cC5jCi0tLSBsaW51eC0yLjQuMjAtcmMyL2RyaXZlcnMvbWVkaWEvdmlkZW8vY3BpYV9wcC5jCVN1
biBOb3YgMTAgMTE6MzQ6MjggMjAwMgorKysgbGludXgtMi40LjIwLXJjMi1jcGlhX2ZpeC9kcml2
ZXJzL21lZGlhL3ZpZGVvL2NwaWFfcHAuYwlNb24gTm92IDE4IDE2OjQzOjM4IDIwMDIKQEAgLTU2
Niw3ICs1NjYsNyBAQAogCQlyZXR1cm4gLUVOWElPOwogCX0KIAlzcGluX2xvY2soICZjYW1fbGlz
dF9sb2NrX3BwICk7Ci0JY3BpYV9hZGRfdG9fbGlzdChjYW1fbGlzdCwgY3BpYSk7CisJY3BpYV9h
ZGRfdG9fbGlzdCgmY2FtX2xpc3QsICZjcGlhKTsKIAlzcGluX3VubG9jayggJmNhbV9saXN0X2xv
Y2tfcHAgKTsKIAogCXJldHVybiAwOwpAQCAtNTgwLDggKzU4MCw3IEBACiAJZm9yKGNwaWEgPSBj
YW1fbGlzdDsgY3BpYSAhPSBOVUxMOyBjcGlhID0gY3BpYS0+bmV4dCkgewogCQlzdHJ1Y3QgcHBf
Y2FtX2VudHJ5ICpjYW0gPSBjcGlhLT5sb3dsZXZlbF9kYXRhOwogCQlpZiAoY2FtICYmIGNhbS0+
cG9ydC0+bnVtYmVyID09IHBvcnQtPm51bWJlcikgewotCQkJY3BpYV9yZW1vdmVfZnJvbV9saXN0
KGNwaWEpOwotCQkJc3Bpbl91bmxvY2soICZjYW1fbGlzdF9sb2NrX3BwICk7CQkJCisJCQljcGlh
X3JlbW92ZV9mcm9tX2xpc3QoJmNwaWEpOwogCQkJY3BpYV91bnJlZ2lzdGVyX2NhbWVyYShjcGlh
KTsKIAkJCQogCQkJaWYoY2FtLT5vcGVuX2NvdW50ID4gMCkgewpAQCAtNTk1LDYgKzU5NCw3IEBA
CiAJCQlicmVhazsKIAkJfQogCX0KKwlzcGluX3VubG9jayggJmNhbV9saXN0X2xvY2tfcHAgKTsJ
CQkKIH0KIAogc3RhdGljIHZvaWQgY3BpYV9wcF9hdHRhY2ggKHN0cnVjdCBwYXJwb3J0ICpwb3J0
KQpkaWZmIC11TnIgbGludXgtMi40LjIwLXJjMi9kcml2ZXJzL21lZGlhL3ZpZGVvL2NwaWFfdXNi
LmMgbGludXgtMi40LjIwLXJjMi1jcGlhX2ZpeC9kcml2ZXJzL21lZGlhL3ZpZGVvL2NwaWFfdXNi
LmMKLS0tIGxpbnV4LTIuNC4yMC1yYzIvZHJpdmVycy9tZWRpYS92aWRlby9jcGlhX3VzYi5jCVN1
biBOb3YgMTAgMTE6MzQ6MjggMjAwMgorKysgbGludXgtMi40LjIwLXJjMi1jcGlhX2ZpeC9kcml2
ZXJzL21lZGlhL3ZpZGVvL2NwaWFfdXNiLmMJTW9uIE5vdiAxOCAxNjo0MzozOSAyMDAyCkBAIC01
NDAsNyArNTQwLDcgQEAKIAl9CiAKIAlzcGluX2xvY2soICZjYW1fbGlzdF9sb2NrX3VzYiApOwot
CWNwaWFfYWRkX3RvX2xpc3QoY2FtX2xpc3QsIGNhbSk7CisJY3BpYV9hZGRfdG9fbGlzdCgmY2Ft
X2xpc3QsICZjYW0pOwogCXNwaW5fdW5sb2NrKCAmY2FtX2xpc3RfbG9ja191c2IgKTsKIAogCXJl
dHVybiBjYW07CkBAIC01ODcsNyArNTg3LDcgQEAKIAlzdHJ1Y3QgdXNiX2NwaWEgKnVjcGlhID0g
KHN0cnVjdCB1c2JfY3BpYSAqKSBjYW0tPmxvd2xldmVsX2RhdGE7CiAgIAogCXNwaW5fbG9jaygg
JmNhbV9saXN0X2xvY2tfdXNiICk7Ci0JY3BpYV9yZW1vdmVfZnJvbV9saXN0KGNhbSk7CisJY3Bp
YV9yZW1vdmVfZnJvbV9saXN0KCZjYW0pOwogCXNwaW5fdW5sb2NrKCAmY2FtX2xpc3RfbG9ja191
c2IgKTsKIAkKIAkvKiBEb24ndCBldmVuIHRyeSB0byByZXNldCB0aGUgYWx0c2V0dGluZyBpZiB3
ZSdyZSBkaXNjb25uZWN0ZWQgKi8K

--_=XFMail.1.5.3.Linux:20021118172026:2888=_--
End of MIME message
