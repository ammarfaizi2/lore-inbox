Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261784AbSJ2MIC>; Tue, 29 Oct 2002 07:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261842AbSJ2MIC>; Tue, 29 Oct 2002 07:08:02 -0500
Received: from elin.scali.no ([62.70.89.10]:28687 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S261784AbSJ2MHt>;
	Tue, 29 Oct 2002 07:07:49 -0500
Date: Tue, 29 Oct 2002 13:15:50 +0100 (CET)
From: Steffen Persvold <sp@scali.com>
X-X-Sender: sp@sp-laptop.isdn.scali.no
To: linux-kernel@vger.kernel.org
cc: mingo@redhat.com
Subject: kernel BUG in page_alloc.c (rmqueue function)
In-Reply-To: <E1868uX-0000Q8-00@trivadis.com>
Message-ID: <Pine.LNX.4.44.0210281339131.32465-200000@sp-laptop.isdn.scali.no>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463794943-562157986-1035893750=:1944"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463794943-562157986-1035893750=:1944
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi all,

Lately I've been struggeling with kernels Oopsing in page_alloc.c, 
rmqueue() function. The line which triggers the Oops is actually in 
expand() which is inlined from rmqueue() (and others). In my kernel source 
(2.4.20-pre11), expand looks like this :

#define MARK_USED(index, order, area) \
        __change_bit((index) >> (1+(order)), (area)->map)

static inline struct page * expand (zone_t *zone, struct page *page,
         unsigned long index, int low, int high, free_area_t * area)
{
        unsigned long size = 1 << high;

        while (high > low) {
                if (BAD_RANGE(zone,page))
                        BUG();
                area--;
                high--;
                size >>= 1;
                list_add(&(page)->list, &(area)->free_list);
                MARK_USED(index, high, area);
                index += size;
                page += size;
        }
        if (BAD_RANGE(zone,page))
                BUG();
        return page;
}

The line that triggers the BUG is the last BAD_RANGE check. The module 
that calls __alloc_pages() is doing it in the following way :

addr = __get_free_page(GFP_KERNEL);

and frees the page with free_page(addr);

The machine configuration is RedHat 7.3 (gcc-2.96-110, 
binutils-2.11.93.0.2-11), 2 Xeon processors @ 2.2 GHz and 2GB RAM.

The module in question is not a part of the kernel tree, but the source is 
available if someone is interested. However, I'm really interrested in 
situations that could cause BAD_RANGE() to fail (since it is commented 
with a "Temporary debugging check") because of the above usage (which 
seems very straight forward to me).

The really strange thing is that the problem seem to disappear if I apply 
the per_cpu_pages patch by Ingo Molnar as found in the RedHat 
2.4.18-17.7.x kernel with a few modifications to make it fit on 
2.4.20-pre11 (attached).

Any help greatly appreciated.

Thanks,
 -- 
  Steffen Persvold   |       Scali AS      
 mailto:sp@scali.com |  http://www.scali.com
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY




---1463794943-562157986-1035893750=:1944
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="linux-2.4.20-pre11-per-cpu-pages.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0210291315500.1944@sp-laptop.isdn.scali.no>
Content-Description: 
Content-Disposition: attachment; filename="linux-2.4.20-pre11-per-cpu-pages.patch"

LS0tIGxpbnV4LTIuNC4yMC1wcmUxMS9pbmNsdWRlL2xpbnV4L21tem9uZS5o
Lm9sZAlNb24gT2N0IDI4IDE3OjMyOjM0IDIwMDINCisrKyBsaW51eC0yLjQu
MjAtcHJlMTEvaW5jbHVkZS9saW51eC9tbXpvbmUuaAlNb24gT2N0IDI4IDA2
OjQwOjU5IDIwMDINCkBAIC0yNiw2ICsyNiwxNCBAQA0KIA0KIHN0cnVjdCBw
Z2xpc3RfZGF0YTsNCiANCisjZGVmaW5lIE1BWF9QRVJfQ1BVX1BBR0VTIDUx
Mg0KKw0KK3R5cGVkZWYgc3RydWN0IHBlcl9jcHVfcGFnZXNfcyB7DQorCWlu
dCBucl9wYWdlczsNCisJaW50IG1heF9ucl9wYWdlczsNCisJc3RydWN0IGxp
c3RfaGVhZCBoZWFkOw0KK30gX19hdHRyaWJ1dGVfXygoYWxpZ25lZChMMV9D
QUNIRV9CWVRFUykpKSBwZXJfY3B1X3Q7DQorDQogLyoNCiAgKiBPbiBtYWNo
aW5lcyB3aGVyZSBpdCBpcyBuZWVkZWQgKGVnIFBDcykgd2UgZGl2aWRlIHBo
eXNpY2FsIG1lbW9yeQ0KICAqIGludG8gbXVsdGlwbGUgcGh5c2ljYWwgem9u
ZXMuIE9uIGEgUEMgd2UgaGF2ZSAzIHpvbmVzOg0KQEAgLTM4LDYgKzQ2LDcg
QEANCiAJLyoNCiAJICogQ29tbW9ubHkgYWNjZXNzZWQgZmllbGRzOg0KIAkg
Ki8NCisJcGVyX2NwdV90CQljcHVfcGFnZXMgW05SX0NQVVNdOw0KIAlzcGlu
bG9ja190CQlsb2NrOw0KIAl1bnNpZ25lZCBsb25nCQlmcmVlX3BhZ2VzOw0K
IAl1bnNpZ25lZCBsb25nCQlwYWdlc19taW4sIHBhZ2VzX2xvdywgcGFnZXNf
aGlnaDsNCi0tLSBsaW51eC0yLjQuMjAtcHJlMTEvbW0vcGFnZV9hbGxvYy5j
Lm9sZAlNb24gT2N0IDI4IDA2OjE4OjIyIDIwMDINCisrKyBsaW51eC0yLjQu
MjAtcHJlMTEvbW0vcGFnZV9hbGxvYy5jCU1vbiBPY3QgMjggMDY6MzU6MjQg
MjAwMg0KQEAgLTEwLDYgKzEwLDcgQEANCiAgKiAgUmVzaGFwZWQgaXQgdG8g
YmUgYSB6b25lZCBhbGxvY2F0b3IsIEluZ28gTW9sbmFyLCBSZWQgSGF0LCAx
OTk5DQogICogIERpc2NvbnRpZ3VvdXMgbWVtb3J5IHN1cHBvcnQsIEthbm9q
IFNhcmNhciwgU0dJLCBOb3YgMTk5OQ0KICAqICBab25lIGJhbGFuY2luZywg
S2Fub2ogU2FyY2FyLCBTR0ksIEphbiAyMDAwDQorICogIFBlci1DUFUgcGFn
ZSBwb29sLCBJbmdvIE1vbG5hciwgUmVkIEhhdCwgMjAwMSwgMjAwMg0KICAq
Lw0KIA0KICNpbmNsdWRlIDxsaW51eC9jb25maWcuaD4NCkBAIC0yMSw2ICsy
Miw3IEBADQogI2luY2x1ZGUgPGxpbnV4L2Jvb3RtZW0uaD4NCiAjaW5jbHVk
ZSA8bGludXgvc2xhYi5oPg0KICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4N
CisjaW5jbHVkZSA8bGludXgvc21wLmg+DQogDQogaW50IG5yX3N3YXBfcGFn
ZXM7DQogaW50IG5yX2FjdGl2ZV9wYWdlczsNCkBAIC01NCw2ICs1Niw3MyBA
QA0KICkNCiANCiAvKg0KKyAqIElubGluZSBmdW5jdGlvbnMgdG8gY29udHJv
bCBzb21lIGJhbGFuY2luZyBpbiB0aGUgVk0uDQorICoNCisgKiBOb3RlIHRo
YXQgd2UgZG8gYm90aCBnbG9iYWwgYW5kIHBlci16b25lIGJhbGFuY2luZywg
d2l0aA0KKyAqIG1vc3Qgb2YgdGhlIGJhbGFuY2luZyBkb25lIGdsb2JhbGx5
Lg0KKyAqLw0KKyNkZWZpbmUgUExFTlRZX0ZBQ1RPUiAgIDINCisjZGVmaW5l
IEFMTF9aT05FUyAgICAgICBOVUxMDQorI2RlZmluZSBBTllfWk9ORSAgICAg
ICAgKHN0cnVjdCB6b25lX3N0cnVjdCAqKSh+MFVMKQ0KKyNkZWZpbmUgSU5B
Q1RJVkVfRkFDVE9SIDUNCisNCisjZGVmaW5lIFZNX01JTiAgMA0KKyNkZWZp
bmUgVk1fTE9XICAxDQorI2RlZmluZSBWTV9ISUdIIDINCisjZGVmaW5lIFZN
X1BMRU5UWSAzDQorc3RhdGljIGlubGluZSBpbnQgem9uZV9mcmVlX2xpbWl0
KHN0cnVjdCB6b25lX3N0cnVjdCAqIHpvbmUsIGludCBsaW1pdCkNCit7DQor
CWludCBmcmVlLCB0YXJnZXQsIGRlbHRhOw0KKw0KKwkvKiBUaGlzIGlzIHJl
YWxseSBuYXN0eSwgYnV0IEdDQyBzaG91bGQgY29tcGxldGVseSBvcHRpbWlz
ZSBpdCBhd2F5LiAqLw0KKwlpZiAobGltaXQgPT0gVk1fTUlOKQ0KKwkJdGFy
Z2V0ID0gem9uZS0+cGFnZXNfbWluOw0KKwllbHNlIGlmIChsaW1pdCA9PSBW
TV9MT1cpDQorCQl0YXJnZXQgPSB6b25lLT5wYWdlc19sb3c7DQorCWVsc2Ug
aWYgKGxpbWl0ID09IFZNX0hJR0gpDQorCQl0YXJnZXQgPSB6b25lLT5wYWdl
c19oaWdoOw0KKwllbHNlDQorCQl0YXJnZXQgPSB6b25lLT5wYWdlc19oaWdo
ICogUExFTlRZX0ZBQ1RPUjsNCisNCisJZnJlZSA9IHpvbmUtPmZyZWVfcGFn
ZXM7DQorCWRlbHRhID0gdGFyZ2V0IC0gZnJlZTsNCisNCisJcmV0dXJuIGRl
bHRhOw0KK30NCisNCitzdGF0aWMgaW5saW5lIGludCBmcmVlX2xpbWl0KHN0
cnVjdCB6b25lX3N0cnVjdCAqIHpvbmUsIGludCBsaW1pdCkNCit7DQorCWlu
dCBzaG9ydGFnZSA9IDAsIGxvY2FsOw0KKw0KKwlpZiAoem9uZSA9PSBBTExf
Wk9ORVMpIHsNCisJCWZvcl9lYWNoX3pvbmUoem9uZSkNCisJCQlzaG9ydGFn
ZSArPSB6b25lX2ZyZWVfbGltaXQoem9uZSwgbGltaXQpOw0KKwl9IGVsc2Ug
aWYgKHpvbmUgPT0gQU5ZX1pPTkUpIHsNCisJCWZvcl9lYWNoX3pvbmUoem9u
ZSkgew0KKwkJCWxvY2FsID0gem9uZV9mcmVlX2xpbWl0KHpvbmUsIGxpbWl0
KTsNCisJCQlzaG9ydGFnZSArPSBtYXgobG9jYWwsIDApOw0KKwkJfQ0KKwl9
IGVsc2Ugew0KKwkJc2hvcnRhZ2UgPSB6b25lX2ZyZWVfbGltaXQoem9uZSwg
bGltaXQpOw0KKwl9DQorDQorCXJldHVybiBzaG9ydGFnZTsNCit9DQorDQor
LyoNCisgKiBmcmVlX2hpZ2ggLSB0ZXN0IGlmIGFtb3VudCBvZiBmcmVlIHBh
Z2VzIGlzIGxlc3MgdGhhbiBpZGVhbA0KKyAqIEB6b25lOiB6b25lIHRvIHRl
c3QsIEFMTF9aT05FUyB0byB0ZXN0IG1lbW9yeSBnbG9iYWxseQ0KKyAqDQor
ICogUmV0dXJucyBhIHBvc2l0aXZlIHZhbHVlIGlmIHRoZSBudW1iZXIgb2Yg
ZnJlZSBhbmQgY2xlYW4NCisgKiBwYWdlcyBpcyBiZWxvdyBrc3dhcGQncyB0
YXJnZXQsIHplcm8gb3IgbmVnYXRpdmUgaWYgd2UNCisgKiBoYXZlIG1vcmUg
dGhhbiBlbm91Z2ggZnJlZSBhbmQgY2xlYW4gcGFnZXMuDQorICovDQorc3Rh
dGljIGlubGluZSBpbnQgZnJlZV9oaWdoKHN0cnVjdCB6b25lX3N0cnVjdCAq
IHpvbmUpDQorew0KKwlyZXR1cm4gZnJlZV9saW1pdCh6b25lLCBWTV9ISUdI
KTsNCit9DQorDQorLyoNCiAgKiBGcmVlaW5nIGZ1bmN0aW9uIGZvciBhIGJ1
ZGR5IHN5c3RlbSBhbGxvY2F0b3IuDQogICogQ29udHJhcnkgdG8gcHJpb3Ig
Y29tbWVudHMsIHRoaXMgaXMgKk5PVCogaGFpcnksIGFuZCB0aGVyZQ0KICAq
IGlzIG5vIHJlYXNvbiBmb3IgYW55b25lIG5vdCB0byB1bmRlcnN0YW5kIGl0
Lg0KQEAgLTg0LDYgKzE1Myw3IEBADQogCXVuc2lnbmVkIGxvbmcgaW5kZXgs
IHBhZ2VfaWR4LCBtYXNrLCBmbGFnczsNCiAJZnJlZV9hcmVhX3QgKmFyZWE7
DQogCXN0cnVjdCBwYWdlICpiYXNlOw0KKwlwZXJfY3B1X3QgKnBlcl9jcHU7
DQogCXpvbmVfdCAqem9uZTsNCiANCiAJLyoNCkBAIC05Niw2ICsxNjYsMTMg
QEANCiAJCWxydV9jYWNoZV9kZWwocGFnZSk7DQogCX0NCiANCisJLyoNCisJ
ICogVGhpcyBsYXRlIGNoZWNrIGlzIHNhZmUgYmVjYXVzZSByZXNlcnZlZCBw
YWdlcyBkbyBub3QNCisJICogaGF2ZSBhIHZhbGlkIHBhZ2UtPmNvdW50LiBU
aGlzIHRyaWNrIGF2b2lkcyBvdmVyaGVhZA0KKwkgKiBpbiBfX2ZyZWVfcGFn
ZXMoKS4NCisJICovDQorCWlmIChQYWdlUmVzZXJ2ZWQocGFnZSkpDQorCQly
ZXR1cm47DQogCWlmIChwYWdlLT5idWZmZXJzKQ0KIAkJQlVHKCk7DQogCWlm
IChwYWdlLT5tYXBwaW5nKQ0KQEAgLTEyMyw4ICsyMDAsMTkgQEANCiANCiAJ
YXJlYSA9IHpvbmUtPmZyZWVfYXJlYSArIG9yZGVyOw0KIA0KLQlzcGluX2xv
Y2tfaXJxc2F2ZSgmem9uZS0+bG9jaywgZmxhZ3MpOw0KKwlwZXJfY3B1ID0g
em9uZS0+Y3B1X3BhZ2VzICsgc21wX3Byb2Nlc3Nvcl9pZCgpOw0KKw0KKwlf
X3NhdmVfZmxhZ3MoZmxhZ3MpOw0KKwlfX2NsaSgpOw0KKwlpZiAoIW9yZGVy
ICYmIChwZXJfY3B1LT5ucl9wYWdlcyA8IHBlcl9jcHUtPm1heF9ucl9wYWdl
cykgJiYgKGZyZWVfaGlnaCh6b25lKTw9MCkpIHsNCisJCWxpc3RfYWRkKCZw
YWdlLT5saXN0LCAmcGVyX2NwdS0+aGVhZCk7DQorCQlwZXJfY3B1LT5ucl9w
YWdlcysrOw0KKwkJX19yZXN0b3JlX2ZsYWdzKGZsYWdzKTsNCisJCXJldHVy
bjsNCisJfQ0KIA0KKwlzcGluX2xvY2soJnpvbmUtPmxvY2spOw0KKwkNCiAJ
em9uZS0+ZnJlZV9wYWdlcyAtPSBtYXNrOw0KIA0KIAl3aGlsZSAobWFzayAr
ICgxIDw8IChNQVhfT1JERVItMSkpKSB7DQpAQCAtMTk4LDEzICsyODYsMzEg
QEANCiBzdGF0aWMgRkFTVENBTEwoc3RydWN0IHBhZ2UgKiBybXF1ZXVlKHpv
bmVfdCAqem9uZSwgdW5zaWduZWQgaW50IG9yZGVyKSk7DQogc3RhdGljIHN0
cnVjdCBwYWdlICogcm1xdWV1ZSh6b25lX3QgKnpvbmUsIHVuc2lnbmVkIGlu
dCBvcmRlcikNCiB7DQorCXBlcl9jcHVfdCAqcGVyX2NwdSA9IHpvbmUtPmNw
dV9wYWdlcyArIHNtcF9wcm9jZXNzb3JfaWQoKTsNCiAJZnJlZV9hcmVhX3Qg
KiBhcmVhID0gem9uZS0+ZnJlZV9hcmVhICsgb3JkZXI7DQogCXVuc2lnbmVk
IGludCBjdXJyX29yZGVyID0gb3JkZXI7DQogCXN0cnVjdCBsaXN0X2hlYWQg
KmhlYWQsICpjdXJyOw0KIAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KIAlzdHJ1
Y3QgcGFnZSAqcGFnZTsNCisJaW50IHRocmVzaG9sZCA9IDA7DQorDQorCWlm
ICghKGN1cnJlbnQtPmZsYWdzICYgUEZfTUVNQUxMT0MpKSB0aHJlc2hvbGQg
PSBwZXJfY3B1LT5tYXhfbnJfcGFnZXMvODsNCisJX19zYXZlX2ZsYWdzKGZs
YWdzKTsNCisJX19jbGkoKTsNCisNCisJaWYgKCFvcmRlciAmJiAocGVyX2Nw
dS0+bnJfcGFnZXM+dGhyZXNob2xkKSkgew0KKwkJaWYgKGxpc3RfZW1wdHko
JnBlcl9jcHUtPmhlYWQpKQ0KKwkJCUJVRygpOw0KKwkJcGFnZSA9IGxpc3Rf
ZW50cnkocGVyX2NwdS0+aGVhZC5uZXh0LCBzdHJ1Y3QgcGFnZSwgbGlzdCk7
DQorCQlsaXN0X2RlbCgmcGFnZS0+bGlzdCk7DQorCQlwZXJfY3B1LT5ucl9w
YWdlcy0tOw0KKwkJX19yZXN0b3JlX2ZsYWdzKGZsYWdzKTsNCiANCi0Jc3Bp
bl9sb2NrX2lycXNhdmUoJnpvbmUtPmxvY2ssIGZsYWdzKTsNCisJCXNldF9w
YWdlX2NvdW50KHBhZ2UsIDEpOw0KKwkJcmV0dXJuIHBhZ2U7DQorCX0NCisN
CisJc3Bpbl9sb2NrKCZ6b25lLT5sb2NrKTsNCiAJZG8gew0KIAkJaGVhZCA9
ICZhcmVhLT5mcmVlX2xpc3Q7DQogCQljdXJyID0gaGVhZC0+bmV4dDsNCkBA
IC00NTAsNyArNTU2LDcgQEANCiANCiB2b2lkIF9fZnJlZV9wYWdlcyhzdHJ1
Y3QgcGFnZSAqcGFnZSwgdW5zaWduZWQgaW50IG9yZGVyKQ0KIHsNCi0JaWYg
KCFQYWdlUmVzZXJ2ZWQocGFnZSkgJiYgcHV0X3BhZ2VfdGVzdHplcm8ocGFn
ZSkpDQorCWlmIChwdXRfcGFnZV90ZXN0emVybyhwYWdlKSkNCiAJCV9fZnJl
ZV9wYWdlc19vayhwYWdlLCBvcmRlcik7DQogfQ0KIA0KQEAgLTcyNiw2ICs4
MzIsNyBAQA0KIA0KIAlvZmZzZXQgPSBsbWVtX21hcCAtIG1lbV9tYXA7CQ0K
IAlmb3IgKGogPSAwOyBqIDwgTUFYX05SX1pPTkVTOyBqKyspIHsNCisJCWlu
dCBrOw0KIAkJem9uZV90ICp6b25lID0gcGdkYXQtPm5vZGVfem9uZXMgKyBq
Ow0KIAkJdW5zaWduZWQgbG9uZyBtYXNrOw0KIAkJdW5zaWduZWQgbG9uZyBz
aXplLCByZWFsc2l6ZTsNCkBAIC03MzgsNiArODQ1LDE4IEBADQogCQlwcmlu
dGsoInpvbmUoJWx1KTogJWx1IHBhZ2VzLlxuIiwgaiwgc2l6ZSk7DQogCQl6
b25lLT5zaXplID0gc2l6ZTsNCiAJCXpvbmUtPm5hbWUgPSB6b25lX25hbWVz
W2pdOw0KKw0KKwkJZm9yIChrID0gMDsgayA8IE5SX0NQVVM7IGsrKykgew0K
KwkJCXBlcl9jcHVfdCAqcGVyX2NwdSA9IHpvbmUtPmNwdV9wYWdlcyArIGs7
DQorDQorCQkJSU5JVF9MSVNUX0hFQUQoJnBlcl9jcHUtPmhlYWQpOw0KKwkJ
CXBlcl9jcHUtPm1heF9ucl9wYWdlcyA9IHJlYWxzaXplIC8gc21wX251bV9j
cHVzIC8gMTI4Ow0KKwkJCWlmIChwZXJfY3B1LT5tYXhfbnJfcGFnZXMgPiBN
QVhfUEVSX0NQVV9QQUdFUykNCisJCQkJcGVyX2NwdS0+bWF4X25yX3BhZ2Vz
ID0gTUFYX1BFUl9DUFVfUEFHRVM7DQorCQkJZWxzZQ0KKwkJCQlpZiAoIXBl
cl9jcHUtPm1heF9ucl9wYWdlcykNCisJCQkJCXBlcl9jcHUtPm1heF9ucl9w
YWdlcyA9IDE7DQorCQl9DQogCQl6b25lLT5sb2NrID0gU1BJTl9MT0NLX1VO
TE9DS0VEOw0KIAkJem9uZS0+em9uZV9wZ2RhdCA9IHBnZGF0Ow0KIAkJem9u
ZS0+ZnJlZV9wYWdlcyA9IDA7DQo=
---1463794943-562157986-1035893750=:1944--
