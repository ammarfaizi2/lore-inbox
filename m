Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129164AbRDGSmm>; Sat, 7 Apr 2001 14:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129381AbRDGSmb>; Sat, 7 Apr 2001 14:42:31 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:56587 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129164AbRDGSmA>; Sat, 7 Apr 2001 14:42:00 -0400
Message-ID: <3ACF5F9B.AA42F1BD@t-online.de>
Date: Sat, 07 Apr 2001 20:42:35 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, mj@suse.cz, reinelt@eunet.at,
        twaugh@redhat.com, jgarzik@mandrakesoft.com
Subject: Re: PATCH for Broken PCI Multi-IO in 2.4.3 (serial+parport)
In-Reply-To: <3ACECA8F.FEC9439@eunet.at> <3ACED679.7E334234@mandrakesoft.com> <20010407111419.B530@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------E6E2E8BC61B34B223F8A3BE5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E6E2E8BC61B34B223F8A3BE5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Tim Waugh wrote:
> 
> On Sat, Apr 07, 2001 at 04:57:29AM -0400, Jeff Garzik wrote:
> 
> > Where is this patch available?  I haven't heard of an extension to the
> > pci id tables, so I wonder if it's really in the queue for the official
> > kernel.
> 
> It is.  <URL:http://people.redhat.com/twaugh/patches/>  The
> 'extension' is just 'more entries', AFAIR.
> 
> > > I'm afraid this is not a bug, but a design issue, and will be hard to
> > > solve. Maybe we need a flag for such devices which allows it to be
> > > claimed ba more thean one driver?
> >
> > Not so hard.
> 
> *sigh* Jeff, when I spoke to you about this last year you said
>  'tough', or words to that effect. :-(
> 
> > There is no need to register more than one driver per PCI device -- just
> > create a PCI driver whose probe routine registers serial and parallel,
> > and whose remove routine unregisters same.
> 
> *cough* modularity *cough*
> 
> Wnat to show us some elegant code that does that?

Hardware has always needed quirks (linux-2.4.3 has about 60 occurences
of the word "quirks", not to mention workaround, blacklist and other synonyms)!

Please apply this little patch instead of wasting time by finger-pointing
and arguing.

Martin, comments?


Regards, Gunther 



--- linux-2.4.3-orig/include/linux/pci.h        Wed Apr  4 19:46:49 2001
+++ linux/include/linux/pci.h   Sat Apr  7 20:01:51 2001
@@ -454,6 +454,9 @@
        void (*remove)(struct pci_dev *dev);    /* Device removed (NULL if not a hot-plug capable driver) */
        void (*suspend)(struct pci_dev *dev);   /* Device suspended */
        void (*resume)(struct pci_dev *dev);    /* Device woken up */
+       int multifunction_quirks;               /* Quirks for PCI serial+parport cards,
+                                                   here multiple drivers are allowed to register
+                                                   for the same pci id match */
 };


--- linux-2.4.3-orig/drivers/pci/pci.c  Wed Apr  4 19:46:46 2001
+++ linux/drivers/pci/pci.c     Sat Apr  7 19:59:47 2001
@@ -453,7 +453,7 @@

        list_add_tail(&drv->node, &pci_drivers);
        pci_for_each_dev(dev) {
-               if (!pci_dev_driver(dev))
+               if (!pci_dev_driver(dev) || drv->multifunction_quirks)
                        count += pci_announce_device(drv, dev);
        }
        return count;
--- linux-2.4.3-orig/drivers/parport/parport_pc.c       Wed Apr  4 19:46:46 2001
+++ linux/drivers/parport/parport_pc.c  Sat Apr  7 20:18:37 2001
@@ -2539,6 +2539,7 @@
        name:           "parport_pc",
        id_table:       parport_pc_pci_tbl,
        probe:          parport_pc_pci_probe,
+       multifunction_quirks: 1,
 };

 static int __init parport_pc_init_superio (void)
--- linux-2.4.3-orig/drivers/char/serial.c      Wed Apr  4 19:46:43 2001
+++ linux/drivers/char/serial.c Sat Apr  7 20:00:00 2001
@@ -4178,7 +4178,7 @@
        for (i=0; timedia_data[i].num; i++) {
                ids = timedia_data[i].ids;
                for (j=0; ids[j]; j++) {
-                       if (pci_get_subvendor(dev) == ids[j]) {
+                       if (pci_get_subdevice(dev) == ids[j]) {
                                board->num_ports = timedia_data[i].num;
                                return 0;
                        }
@@ -4718,6 +4718,7 @@
        probe:          serial_init_one,
        remove:        serial_remove_one,
        id_table:       serial_pci_tbl,
+       multifunction_quirks: 1,
 };
--------------E6E2E8BC61B34B223F8A3BE5
Content-Type: application/octet-stream;
 name="gmdiff-lx243-pci-multi_io"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="gmdiff-lx243-pci-multi_io"

LS0tIGxpbnV4LTIuNC4zLW9yaWcvaW5jbHVkZS9saW51eC9wY2kuaAlXZWQgQXByICA0IDE5
OjQ2OjQ5IDIwMDEKKysrIGxpbnV4L2luY2x1ZGUvbGludXgvcGNpLmgJU2F0IEFwciAgNyAy
MDowMTo1MSAyMDAxCkBAIC00NTQsNiArNDU0LDkgQEAKIAl2b2lkICgqcmVtb3ZlKShzdHJ1
Y3QgcGNpX2RldiAqZGV2KTsJLyogRGV2aWNlIHJlbW92ZWQgKE5VTEwgaWYgbm90IGEgaG90
LXBsdWcgY2FwYWJsZSBkcml2ZXIpICovCiAJdm9pZCAoKnN1c3BlbmQpKHN0cnVjdCBwY2lf
ZGV2ICpkZXYpOwkvKiBEZXZpY2Ugc3VzcGVuZGVkICovCiAJdm9pZCAoKnJlc3VtZSkoc3Ry
dWN0IHBjaV9kZXYgKmRldik7CS8qIERldmljZSB3b2tlbiB1cCAqLworCWludCBtdWx0aWZ1
bmN0aW9uX3F1aXJrczsJCS8qIFF1aXJrcyBmb3IgUENJIHNlcmlhbCtwYXJwb3J0IGNhcmRz
LAorCQkJCQkJICAgIGhlcmUgbXVsdGlwbGUgZHJpdmVycyBhcmUgYWxsb3dlZCB0byByZWdp
c3RlcgorCQkJCQkJICAgIGZvciB0aGUgc2FtZSBwY2kgaWQgbWF0Y2ggKi8KIH07CiAKIAot
LS0gbGludXgtMi40LjMtb3JpZy9kcml2ZXJzL3BjaS9wY2kuYwlXZWQgQXByICA0IDE5OjQ2
OjQ2IDIwMDEKKysrIGxpbnV4L2RyaXZlcnMvcGNpL3BjaS5jCVNhdCBBcHIgIDcgMTk6NTk6
NDcgMjAwMQpAQCAtNDUzLDcgKzQ1Myw3IEBACiAKIAlsaXN0X2FkZF90YWlsKCZkcnYtPm5v
ZGUsICZwY2lfZHJpdmVycyk7CiAJcGNpX2Zvcl9lYWNoX2RldihkZXYpIHsKLQkJaWYgKCFw
Y2lfZGV2X2RyaXZlcihkZXYpKQorCQlpZiAoIXBjaV9kZXZfZHJpdmVyKGRldikgfHwgZHJ2
LT5tdWx0aWZ1bmN0aW9uX3F1aXJrcykKIAkJCWNvdW50ICs9IHBjaV9hbm5vdW5jZV9kZXZp
Y2UoZHJ2LCBkZXYpOwogCX0KIAlyZXR1cm4gY291bnQ7Ci0tLSBsaW51eC0yLjQuMy1vcmln
L2RyaXZlcnMvcGFycG9ydC9wYXJwb3J0X3BjLmMJV2VkIEFwciAgNCAxOTo0Njo0NiAyMDAx
CisrKyBsaW51eC9kcml2ZXJzL3BhcnBvcnQvcGFycG9ydF9wYy5jCVNhdCBBcHIgIDcgMjA6
MTg6MzcgMjAwMQpAQCAtMjUzOSw2ICsyNTM5LDcgQEAKIAluYW1lOgkJInBhcnBvcnRfcGMi
LAogCWlkX3RhYmxlOglwYXJwb3J0X3BjX3BjaV90YmwsCiAJcHJvYmU6CQlwYXJwb3J0X3Bj
X3BjaV9wcm9iZSwKKwltdWx0aWZ1bmN0aW9uX3F1aXJrczogMSwKIH07CiAKIHN0YXRpYyBp
bnQgX19pbml0IHBhcnBvcnRfcGNfaW5pdF9zdXBlcmlvICh2b2lkKQotLS0gbGludXgtMi40
LjMtb3JpZy9kcml2ZXJzL2NoYXIvc2VyaWFsLmMJV2VkIEFwciAgNCAxOTo0Njo0MyAyMDAx
CisrKyBsaW51eC9kcml2ZXJzL2NoYXIvc2VyaWFsLmMJU2F0IEFwciAgNyAyMDowMDowMCAy
MDAxCkBAIC00MTc4LDcgKzQxNzgsNyBAQAogCWZvciAoaT0wOyB0aW1lZGlhX2RhdGFbaV0u
bnVtOyBpKyspIHsKIAkJaWRzID0gdGltZWRpYV9kYXRhW2ldLmlkczsKIAkJZm9yIChqPTA7
IGlkc1tqXTsgaisrKSB7Ci0JCQlpZiAocGNpX2dldF9zdWJ2ZW5kb3IoZGV2KSA9PSBpZHNb
al0pIHsKKwkJCWlmIChwY2lfZ2V0X3N1YmRldmljZShkZXYpID09IGlkc1tqXSkgewogCQkJ
CWJvYXJkLT5udW1fcG9ydHMgPSB0aW1lZGlhX2RhdGFbaV0ubnVtOwogCQkJCXJldHVybiAw
OwogCQkJfQpAQCAtNDcxOCw2ICs0NzE4LDcgQEAKICAgICAgICBwcm9iZTogICAgICAgICAg
c2VyaWFsX2luaXRfb25lLAogICAgICAgIHJlbW92ZToJICAgICAgIHNlcmlhbF9yZW1vdmVf
b25lLAogICAgICAgIGlkX3RhYmxlOiAgICAgICBzZXJpYWxfcGNpX3RibCwKKyAgICAgICBt
dWx0aWZ1bmN0aW9uX3F1aXJrczogMSwKIH07CiAKIAo=
--------------E6E2E8BC61B34B223F8A3BE5--

