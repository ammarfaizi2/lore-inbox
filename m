Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266047AbSKGUy4>; Thu, 7 Nov 2002 15:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266018AbSKGUy4>; Thu, 7 Nov 2002 15:54:56 -0500
Received: from email.gcom.com ([206.221.230.194]:130 "EHLO gcom.com")
	by vger.kernel.org with ESMTP id <S266016AbSKGUyw>;
	Thu, 7 Nov 2002 15:54:52 -0500
Message-Id: <5.1.0.14.2.20021107145447.027905c8@localhost>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 07 Nov 2002 15:00:31 -0600
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>,
       Arjan van de Ven <arjanv@fenrus.demon.nl>
From: David Grothe <dave@gcom.com>
Subject: [PATCH] Linux-streams registration 2.5.46
Cc: hch@infradead.org, linux-kernel@vger.kernel.org,
       LiS <linux-streams@gsyc.escet.urjc.es>, Dave Miller <davem@redhat.com>,
       bidulock@openss7.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_708642383==_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_708642383==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

All:

I finally have LiS running on a 2.5 kernel.  Attached is the 2.5.46 version 
of the syscall registration patch that was submitted for inclusion in the 
2.4 kernel about a month ago.  It has been tested on an Intel platform.

The patch follows inline for easy perusal and is attached as a file for 
tab-preservation.

Comments welcome.  If it looks good will someone tell me to whom to direct 
it for inclusion in the kernel source?

Thanks,
-- Dave

--- arch/i386/kernel/entry.S.orig       2002-11-06 16:09:44.000000000 -0600
+++ arch/i386/kernel/entry.S    2002-11-06 16:28:23.000000000 -0600
@@ -671,8 +671,8 @@
         .long sys_capset        /* 185 */
         .long sys_sigaltstack
         .long sys_sendfile
-       .long sys_ni_syscall    /* reserved for streams1 */
-       .long sys_ni_syscall    /* reserved for streams2 */
+       .long sys_getpmsg       /* streams1 */
+       .long sys_putpmsg       /* streams2 */
         .long sys_vfork         /* 190 */
         .long sys_getrlimit
         .long sys_mmap2
--- kernel/sys.c.orig   2002-11-06 16:09:57.000000000 -0600
+++ kernel/sys.c        2002-11-06 16:30:46.000000000 -0600
@@ -195,6 +195,49 @@
         return notifier_chain_unregister(&reboot_notifier_list, nb);
  }

+static int (*do_putpmsg) (int, void *, void *, int, int) = NULL;
+static int (*do_getpmsg) (int, void *, void *, int, int) = NULL;
+
+static DECLARE_RWSEM(streams_call_sem);
+
+long asmlinkage
+sys_putpmsg(int fd, void *ctlptr, void *datptr, int band, int flags)
+{
+       int ret = -ENOSYS;
+       down_read(&streams_call_sem);   /* should return int, but doesn't */
+       if (do_putpmsg)
+               ret = (*do_putpmsg) (fd, ctlptr, datptr, band, flags);
+       up_read(&streams_call_sem);
+       return ret;
+}
+
+long asmlinkage
+sys_getpmsg(int fd, void *ctlptr, void *datptr, int band, int flags)
+{
+       int ret = -ENOSYS;
+       down_read(&streams_call_sem);   /* should return int, but doesn't */
+       if (do_getpmsg)
+               ret = (*do_getpmsg) (fd, ctlptr, datptr, band, flags);
+       up_read(&streams_call_sem);
+       return ret;
+}
+
+int
+register_streams_calls(int (*putpmsg) (int, void *, void *, int, int),
+                      int (*getpmsg) (int, void *, void *, int, int))
+{
+       int ret = -EBUSY;
+       down_write(&streams_call_sem);  /* should return int, but doesn't */
+       if (   (putpmsg == NULL || do_putpmsg == NULL)
+           && (getpmsg == NULL || do_getpmsg == NULL)) {
+               do_putpmsg = putpmsg;
+               do_getpmsg = getpmsg;
+               ret = 0;
+       }
+       up_write(&streams_call_sem);
+       return ret;
+}
+
  asmlinkage long sys_ni_syscall(void)
  {
         return -ENOSYS;
@@ -1386,3 +1429,4 @@
  EXPORT_SYMBOL(unregister_reboot_notifier);
  EXPORT_SYMBOL(in_group_p);
  EXPORT_SYMBOL(in_egroup_p);
+EXPORT_SYMBOL_GPL(register_streams_calls);
--- include/linux/sys.h.orig    2002-11-06 16:10:10.000000000 -0600
+++ include/linux/sys.h 2002-11-06 16:29:16.000000000 -0600
@@ -27,4 +27,16 @@
   * These are system calls that haven't been implemented yet
   * but have an entry in the table for future expansion..
   */
+
+/*
+ * These are registration routines for system calls that are
+ * implemented by loadable modules outside of the kernel
+ * source tree.
+ */
+#if !defined(__ASSEMBLY__)
+extern int
+register_streams_calls(int (*putpmsg) (int, void *, void *, int, int),
+                      int (*getpmsg) (int, void *, void *, int, int)) ;
+
+#endif                 /* __ASSEMBLY__ */
  #endif
--=====================_708642383==_
Content-Type: text/plain; name="streams-patch-i386-2.5.46.txt";
 x-mac-type="42494E41"; x-mac-creator="74747874"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="streams-patch-i386-2.5.46.txt"

LS0tIGFyY2gvaTM4Ni9rZXJuZWwvZW50cnkuUy5vcmlnCTIwMDItMTEtMDYgMTY6MDk6NDQuMDAw
MDAwMDAwIC0wNjAwCisrKyBhcmNoL2kzODYva2VybmVsL2VudHJ5LlMJMjAwMi0xMS0wNiAxNjoy
ODoyMy4wMDAwMDAwMDAgLTA2MDAKQEAgLTY3MSw4ICs2NzEsOCBAQAogCS5sb25nIHN5c19jYXBz
ZXQJLyogMTg1ICovCiAJLmxvbmcgc3lzX3NpZ2FsdHN0YWNrCiAJLmxvbmcgc3lzX3NlbmRmaWxl
Ci0JLmxvbmcgc3lzX25pX3N5c2NhbGwJLyogcmVzZXJ2ZWQgZm9yIHN0cmVhbXMxICovCi0JLmxv
bmcgc3lzX25pX3N5c2NhbGwJLyogcmVzZXJ2ZWQgZm9yIHN0cmVhbXMyICovCisJLmxvbmcgc3lz
X2dldHBtc2cJLyogc3RyZWFtczEgKi8KKwkubG9uZyBzeXNfcHV0cG1zZwkvKiBzdHJlYW1zMiAq
LwogCS5sb25nIHN5c192Zm9yawkJLyogMTkwICovCiAJLmxvbmcgc3lzX2dldHJsaW1pdAogCS5s
b25nIHN5c19tbWFwMgotLS0ga2VybmVsL3N5cy5jLm9yaWcJMjAwMi0xMS0wNiAxNjowOTo1Ny4w
MDAwMDAwMDAgLTA2MDAKKysrIGtlcm5lbC9zeXMuYwkyMDAyLTExLTA2IDE2OjMwOjQ2LjAwMDAw
MDAwMCAtMDYwMApAQCAtMTk1LDYgKzE5NSw0OSBAQAogCXJldHVybiBub3RpZmllcl9jaGFpbl91
bnJlZ2lzdGVyKCZyZWJvb3Rfbm90aWZpZXJfbGlzdCwgbmIpOwogfQogCitzdGF0aWMgaW50ICgq
ZG9fcHV0cG1zZykgKGludCwgdm9pZCAqLCB2b2lkICosIGludCwgaW50KSA9IE5VTEw7CitzdGF0
aWMgaW50ICgqZG9fZ2V0cG1zZykgKGludCwgdm9pZCAqLCB2b2lkICosIGludCwgaW50KSA9IE5V
TEw7CisKK3N0YXRpYyBERUNMQVJFX1JXU0VNKHN0cmVhbXNfY2FsbF9zZW0pOworCitsb25nIGFz
bWxpbmthZ2UKK3N5c19wdXRwbXNnKGludCBmZCwgdm9pZCAqY3RscHRyLCB2b2lkICpkYXRwdHIs
IGludCBiYW5kLCBpbnQgZmxhZ3MpCit7CisJaW50IHJldCA9IC1FTk9TWVM7CisJZG93bl9yZWFk
KCZzdHJlYW1zX2NhbGxfc2VtKTsJLyogc2hvdWxkIHJldHVybiBpbnQsIGJ1dCBkb2Vzbid0ICov
CisJaWYgKGRvX3B1dHBtc2cpCisJCXJldCA9ICgqZG9fcHV0cG1zZykgKGZkLCBjdGxwdHIsIGRh
dHB0ciwgYmFuZCwgZmxhZ3MpOworCXVwX3JlYWQoJnN0cmVhbXNfY2FsbF9zZW0pOworCXJldHVy
biByZXQ7Cit9CisKK2xvbmcgYXNtbGlua2FnZQorc3lzX2dldHBtc2coaW50IGZkLCB2b2lkICpj
dGxwdHIsIHZvaWQgKmRhdHB0ciwgaW50IGJhbmQsIGludCBmbGFncykKK3sKKwlpbnQgcmV0ID0g
LUVOT1NZUzsKKwlkb3duX3JlYWQoJnN0cmVhbXNfY2FsbF9zZW0pOwkvKiBzaG91bGQgcmV0dXJu
IGludCwgYnV0IGRvZXNuJ3QgKi8KKwlpZiAoZG9fZ2V0cG1zZykKKwkJcmV0ID0gKCpkb19nZXRw
bXNnKSAoZmQsIGN0bHB0ciwgZGF0cHRyLCBiYW5kLCBmbGFncyk7CisJdXBfcmVhZCgmc3RyZWFt
c19jYWxsX3NlbSk7CisJcmV0dXJuIHJldDsKK30KKworaW50CityZWdpc3Rlcl9zdHJlYW1zX2Nh
bGxzKGludCAoKnB1dHBtc2cpIChpbnQsIHZvaWQgKiwgdm9pZCAqLCBpbnQsIGludCksCisJCSAg
ICAgICBpbnQgKCpnZXRwbXNnKSAoaW50LCB2b2lkICosIHZvaWQgKiwgaW50LCBpbnQpKQorewor
CWludCByZXQgPSAtRUJVU1k7CisJZG93bl93cml0ZSgmc3RyZWFtc19jYWxsX3NlbSk7CS8qIHNo
b3VsZCByZXR1cm4gaW50LCBidXQgZG9lc24ndCAqLworCWlmICggICAocHV0cG1zZyA9PSBOVUxM
IHx8IGRvX3B1dHBtc2cgPT0gTlVMTCkKKwkgICAgJiYgKGdldHBtc2cgPT0gTlVMTCB8fCBkb19n
ZXRwbXNnID09IE5VTEwpKSB7CisJCWRvX3B1dHBtc2cgPSBwdXRwbXNnOworCQlkb19nZXRwbXNn
ID0gZ2V0cG1zZzsKKwkJcmV0ID0gMDsKKwl9CisJdXBfd3JpdGUoJnN0cmVhbXNfY2FsbF9zZW0p
OworCXJldHVybiByZXQ7Cit9CisKIGFzbWxpbmthZ2UgbG9uZyBzeXNfbmlfc3lzY2FsbCh2b2lk
KQogewogCXJldHVybiAtRU5PU1lTOwpAQCAtMTM4NiwzICsxNDI5LDQgQEAKIEVYUE9SVF9TWU1C
T0wodW5yZWdpc3Rlcl9yZWJvb3Rfbm90aWZpZXIpOwogRVhQT1JUX1NZTUJPTChpbl9ncm91cF9w
KTsKIEVYUE9SVF9TWU1CT0woaW5fZWdyb3VwX3ApOworRVhQT1JUX1NZTUJPTF9HUEwocmVnaXN0
ZXJfc3RyZWFtc19jYWxscyk7Ci0tLSBpbmNsdWRlL2xpbnV4L3N5cy5oLm9yaWcJMjAwMi0xMS0w
NiAxNjoxMDoxMC4wMDAwMDAwMDAgLTA2MDAKKysrIGluY2x1ZGUvbGludXgvc3lzLmgJMjAwMi0x
MS0wNiAxNjoyOToxNi4wMDAwMDAwMDAgLTA2MDAKQEAgLTI3LDQgKzI3LDE2IEBACiAgKiBUaGVz
ZSBhcmUgc3lzdGVtIGNhbGxzIHRoYXQgaGF2ZW4ndCBiZWVuIGltcGxlbWVudGVkIHlldAogICog
YnV0IGhhdmUgYW4gZW50cnkgaW4gdGhlIHRhYmxlIGZvciBmdXR1cmUgZXhwYW5zaW9uLi4KICAq
LworCisvKgorICogVGhlc2UgYXJlIHJlZ2lzdHJhdGlvbiByb3V0aW5lcyBmb3Igc3lzdGVtIGNh
bGxzIHRoYXQgYXJlCisgKiBpbXBsZW1lbnRlZCBieSBsb2FkYWJsZSBtb2R1bGVzIG91dHNpZGUg
b2YgdGhlIGtlcm5lbAorICogc291cmNlIHRyZWUuCisgKi8KKyNpZiAhZGVmaW5lZChfX0FTU0VN
QkxZX18pCitleHRlcm4gaW50CityZWdpc3Rlcl9zdHJlYW1zX2NhbGxzKGludCAoKnB1dHBtc2cp
IChpbnQsIHZvaWQgKiwgdm9pZCAqLCBpbnQsIGludCksCisJCSAgICAgICBpbnQgKCpnZXRwbXNn
KSAoaW50LCB2b2lkICosIHZvaWQgKiwgaW50LCBpbnQpKSA7CisKKyNlbmRpZgkJCS8qIF9fQVNT
RU1CTFlfXyAqLwogI2VuZGlmCg==
--=====================_708642383==_--

