Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263052AbTIHQzW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 12:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbTIHQzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 12:55:21 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:23959 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S263052AbTIHQzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 12:55:00 -0400
Date: Mon, 8 Sep 2003 12:52:02 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: [BK PATCH] build: config vs. everything else
Message-ID: <Pine.GSO.4.33.0309081241130.13584-200000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-440155785-1063039922=:13584"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-440155785-1063039922=:13584
Content-Type: TEXT/PLAIN; charset=US-ASCII

I've long wondered why make {anything}config followed by building anything
else would rebuild a number of mostly unrelated things in scripts.  So,
I dug into it (oh, what an ugly web...)

The Story:
The rules for config (and %config) depend on "scripts" which will build
basically everything in scripts.  However, there are two problems with this.
First, *config only NEEDS fixdep.  Second, the complete build environment is
not setup at config time, so the compiler settings are not consistant.  To
illustrate the point, compare scripts/.empty.o.cmd after a "make config" and
"make image" (zImage, whatever)

The "bk send" is attached.  Below is the diff.  Excuse the "@/bin/true"...
It's the fastest way to get make to shutup.

--Ricky

--- 1.425/Makefile	Tue Sep  2 15:13:35 2003
+++ 1.426/Makefile	Fri Sep  5 22:25:25 2003
@@ -259,12 +259,13 @@

 # Helpers built in scripts/

-scripts/docproc scripts/fixdep scripts/split-include : scripts ;
+scripts/docproc scripts/split-include : scripts ;

-.PHONY: scripts
+.PHONY: scripts scripts/fixdep
 scripts:
 	$(Q)$(MAKE) $(build)=scripts
-
+scripts/fixdep:
+	$(Q)$(MAKE) $(build)=scripts fixdep

 # To make sure we do not include .config for any of the *config targets
 # catch them early, and hand them over to scripts/kconfig/Makefile
@@ -342,8 +343,8 @@

 # If .config is newer than include/linux/autoconf.h, someone tinkered
 # with it and forgot to run make oldconfig
-include/linux/autoconf.h: scripts/fixdep .config
-	$(Q)$(MAKE) $(build)=scripts/kconfig silentoldconfig
+include/linux/autoconf.h: .config
+	$(Q)$(MAKE) -f $(TOPDIR)/Makefile silentoldconfig

 endif


--- 1.34/scripts/Makefile	Tue Mar 18 13:19:44 2003
+++ 1.35/scripts/Makefile	Fri Sep  5 22:25:25 2003
@@ -22,6 +22,9 @@
 # fixdep is needed to compile other host programs
 $(addprefix $(obj)/,$(filter-out fixdep,$(always)) $(subdir-y)): $(obj)/fixdep

+fixdep: $(obj)/fixdep
+	@/bin/true
+
 # dependencies on generated files need to be listed explicitly

 $(obj)/modpost.o $(obj)/file2alias.o: $(obj)/elfconfig.h
@@ -33,3 +36,4 @@
 	$(call if_changed,elfconfig)

 targets += elfconfig.h
+

--- 1.9/scripts/kconfig/Makefile	Sun Aug 31 19:13:49 2003
+++ 1.10/scripts/kconfig/Makefile	Fri Sep  5 22:25:25 2003
@@ -21,7 +21,7 @@
 	$< -o arch/$(ARCH)/Kconfig

 silentoldconfig: $(obj)/conf
-	$< -s arch/$(ARCH)/Kconfig
+	$(Q)$< -s arch/$(ARCH)/Kconfig

 .PHONY: randconfig allyesconfig allnoconfig allmodconfig defconfig


--- 1.9/scripts/kconfig/conf.c	Fri Jun  6 10:51:38 2003
+++ 1.10/scripts/kconfig/conf.c	Fri Sep  5 22:25:25 2003
@@ -532,7 +532,8 @@
 		}
 		break;
 	case ask_silent:
-		if (stat(".config", &tmpstat)) {
+		name = ".config";
+		if (stat(name, &tmpstat)) {
 			printf("***\n"
 				"*** You have not yet configured your kernel!\n"
 				"***\n"
@@ -541,6 +542,8 @@
 				"***\n");
 			exit(1);
 		}
+		conf_read(name);
+		break;
 	case ask_all:
 	case ask_new:
 		conf_read(NULL);


---559023410-440155785-1063039922=:13584
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="build.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0309081252020.13584@sweetums.bluetronic.net>
Content-Description: BK send patch
Content-Disposition: attachment; filename="build.patch"

VGhpcyBCaXRLZWVwZXIgcGF0Y2ggY29udGFpbnMgdGhlIGZvbGxvd2luZyBj
aGFuZ2VzZXRzOg0KMS4xMTY1DQoNCiMgVGhpcyBpcyBhIEJpdEtlZXBlciBw
YXRjaC4gIFdoYXQgZm9sbG93cyBhcmUgdGhlIHVuaWZpZWQgZGlmZnMgZm9y
IHRoZQ0KIyBzZXQgb2YgZGVsdGFzIGNvbnRhaW5lZCBpbiB0aGUgcGF0Y2gu
ICBUaGUgcmVzdCBvZiB0aGUgcGF0Y2gsIHRoZSBwYXJ0DQojIHRoYXQgQml0
S2VlcGVyIGNhcmVzIGFib3V0LCBpcyBiZWxvdyB0aGVzZSBkaWZmcy4NCiMg
VXNlcjoJamZiZWFtDQojIEhvc3Q6CXRyb3ouY29tDQojIFJvb3Q6CS91c3Iv
c3JjL2xpbnV4LTIuNi1iaw0KDQojDQojLS0tIDEuNDI1L01ha2VmaWxlCVR1
ZSBTZXAgIDIgMTU6MTM6MzUgMjAwMw0KIysrKyAxLjQyNi9NYWtlZmlsZQlG
cmkgU2VwICA1IDIyOjI1OjI1IDIwMDMNCiNAQCAtMjU5LDEyICsyNTksMTMg
QEANCiMgDQojICMgSGVscGVycyBidWlsdCBpbiBzY3JpcHRzLw0KIyANCiMt
c2NyaXB0cy9kb2Nwcm9jIHNjcmlwdHMvZml4ZGVwIHNjcmlwdHMvc3BsaXQt
aW5jbHVkZSA6IHNjcmlwdHMgOw0KIytzY3JpcHRzL2RvY3Byb2Mgc2NyaXB0
cy9zcGxpdC1pbmNsdWRlIDogc2NyaXB0cyA7DQojIA0KIy0uUEhPTlk6IHNj
cmlwdHMNCiMrLlBIT05ZOiBzY3JpcHRzIHNjcmlwdHMvZml4ZGVwDQojIHNj
cmlwdHM6DQojIAkkKFEpJChNQUtFKSAkKGJ1aWxkKT1zY3JpcHRzDQojLQ0K
IytzY3JpcHRzL2ZpeGRlcDoNCiMrCSQoUSkkKE1BS0UpICQoYnVpbGQpPXNj
cmlwdHMgZml4ZGVwDQojIA0KIyAjIFRvIG1ha2Ugc3VyZSB3ZSBkbyBub3Qg
aW5jbHVkZSAuY29uZmlnIGZvciBhbnkgb2YgdGhlICpjb25maWcgdGFyZ2V0
cw0KIyAjIGNhdGNoIHRoZW0gZWFybHksIGFuZCBoYW5kIHRoZW0gb3ZlciB0
byBzY3JpcHRzL2tjb25maWcvTWFrZWZpbGUNCiNAQCAtMzQyLDggKzM0Myw4
IEBADQojIA0KIyAjIElmIC5jb25maWcgaXMgbmV3ZXIgdGhhbiBpbmNsdWRl
L2xpbnV4L2F1dG9jb25mLmgsIHNvbWVvbmUgdGlua2VyZWQNCiMgIyB3aXRo
IGl0IGFuZCBmb3Jnb3QgdG8gcnVuIG1ha2Ugb2xkY29uZmlnDQojLWluY2x1
ZGUvbGludXgvYXV0b2NvbmYuaDogc2NyaXB0cy9maXhkZXAgLmNvbmZpZw0K
Iy0JJChRKSQoTUFLRSkgJChidWlsZCk9c2NyaXB0cy9rY29uZmlnIHNpbGVu
dG9sZGNvbmZpZw0KIytpbmNsdWRlL2xpbnV4L2F1dG9jb25mLmg6IC5jb25m
aWcNCiMrCSQoUSkkKE1BS0UpIC1mICQoVE9QRElSKS9NYWtlZmlsZSBzaWxl
bnRvbGRjb25maWcNCiMgDQojIGVuZGlmDQojIA0KIw0KIy0tLSAxLjM0L3Nj
cmlwdHMvTWFrZWZpbGUJVHVlIE1hciAxOCAxMzoxOTo0NCAyMDAzDQojKysr
IDEuMzUvc2NyaXB0cy9NYWtlZmlsZQlGcmkgU2VwICA1IDIyOjI1OjI1IDIw
MDMNCiNAQCAtMjIsNiArMjIsOSBAQA0KIyAjIGZpeGRlcCBpcyBuZWVkZWQg
dG8gY29tcGlsZSBvdGhlciBob3N0IHByb2dyYW1zDQojICQoYWRkcHJlZml4
ICQob2JqKS8sJChmaWx0ZXItb3V0IGZpeGRlcCwkKGFsd2F5cykpICQoc3Vi
ZGlyLXkpKTogJChvYmopL2ZpeGRlcA0KIyANCiMrZml4ZGVwOiAkKG9iaikv
Zml4ZGVwDQojKwlAL2Jpbi90cnVlDQojKw0KIyAjIGRlcGVuZGVuY2llcyBv
biBnZW5lcmF0ZWQgZmlsZXMgbmVlZCB0byBiZSBsaXN0ZWQgZXhwbGljaXRs
eQ0KIyANCiMgJChvYmopL21vZHBvc3QubyAkKG9iaikvZmlsZTJhbGlhcy5v
OiAkKG9iaikvZWxmY29uZmlnLmgNCiNAQCAtMzMsMyArMzYsNCBAQA0KIyAJ
JChjYWxsIGlmX2NoYW5nZWQsZWxmY29uZmlnKQ0KIyANCiMgdGFyZ2V0cyAr
PSBlbGZjb25maWcuaA0KIysNCiMNCiMtLS0gMS45L3NjcmlwdHMva2NvbmZp
Zy9NYWtlZmlsZQlTdW4gQXVnIDMxIDE5OjEzOjQ5IDIwMDMNCiMrKysgMS4x
MC9zY3JpcHRzL2tjb25maWcvTWFrZWZpbGUJRnJpIFNlcCAgNSAyMjoyNToy
NSAyMDAzDQojQEAgLTIxLDcgKzIxLDcgQEANCiMgCSQ8IC1vIGFyY2gvJChB
UkNIKS9LY29uZmlnDQojIA0KIyBzaWxlbnRvbGRjb25maWc6ICQob2JqKS9j
b25mDQojLQkkPCAtcyBhcmNoLyQoQVJDSCkvS2NvbmZpZw0KIysJJChRKSQ8
IC1zIGFyY2gvJChBUkNIKS9LY29uZmlnDQojIA0KIyAuUEhPTlk6IHJhbmRj
b25maWcgYWxseWVzY29uZmlnIGFsbG5vY29uZmlnIGFsbG1vZGNvbmZpZyBk
ZWZjb25maWcNCiMgDQojDQojLS0tIDEuOS9zY3JpcHRzL2tjb25maWcvY29u
Zi5jCUZyaSBKdW4gIDYgMTA6NTE6MzggMjAwMw0KIysrKyAxLjEwL3Njcmlw
dHMva2NvbmZpZy9jb25mLmMJRnJpIFNlcCAgNSAyMjoyNToyNSAyMDAzDQoj
QEAgLTUzMiw3ICs1MzIsOCBAQA0KIyAJCX0NCiMgCQlicmVhazsNCiMgCWNh
c2UgYXNrX3NpbGVudDoNCiMtCQlpZiAoc3RhdCgiLmNvbmZpZyIsICZ0bXBz
dGF0KSkgew0KIysJCW5hbWUgPSAiLmNvbmZpZyI7DQojKwkJaWYgKHN0YXQo
bmFtZSwgJnRtcHN0YXQpKSB7DQojIAkJCXByaW50ZigiKioqXG4iDQojIAkJ
CQkiKioqIFlvdSBoYXZlIG5vdCB5ZXQgY29uZmlndXJlZCB5b3VyIGtlcm5l
bCFcbiINCiMgCQkJCSIqKipcbiINCiNAQCAtNTQxLDYgKzU0Miw4IEBADQoj
IAkJCQkiKioqXG4iKTsNCiMgCQkJZXhpdCgxKTsNCiMgCQl9DQojKwkJY29u
Zl9yZWFkKG5hbWUpOw0KIysJCWJyZWFrOw0KIyAJY2FzZSBhc2tfYWxsOg0K
IyAJY2FzZSBhc2tfbmV3Og0KIyAJCWNvbmZfcmVhZChOVUxMKTsNCiMNCg0K
IyBEaWZmIGNoZWNrc3VtPTZhMTI5ZDZhDQoNCg0KIyBQYXRjaCB2ZXJzOgkx
LjMNCiMgUGF0Y2ggdHlwZToJUkVHVUxBUg0KDQo9PSBDaGFuZ2VTZXQgPT0N
CnRvcnZhbGRzQGF0aGxvbi50cmFuc21ldGEuY29tfENoYW5nZVNldHwyMDAy
MDIwNTE3MzA1NnwxNjA0N3xjMWQxMWE0MWVkMDI0ODY0DQpqZmJlYW1AdHJv
ei5jb218Q2hhbmdlU2V0fDIwMDMwOTA2MDA1NzU0fDE0ODY0DQpEIDEuMTE2
NSAwMy8wOS8wNSAyMjoyNTo1Ni0wNDowMCBqZmJlYW1AdHJvei5jb20gKzQg
LTANCkIgdG9ydmFsZHNAYXRobG9uLnRyYW5zbWV0YS5jb218Q2hhbmdlU2V0
fDIwMDIwMjA1MTczMDU2fDE2MDQ3fGMxZDExYTQxZWQwMjQ4NjQNCkMNCmMg
W1BBVENIXSBjb25zaXN0ZW50ICJzY3JpcHRzIiBidWlsZA0KYyANCmMgICBU
aGUgY29uZmlnIHRhcmdldHMgZGVwZW5kIG9uICJzY3JpcHRzIi4gIEhvd2V2
ZXIsIGZpeGRlcCBpcyB0aGUgb25seSB0b29sIGFjdHVhbGx5DQpjIHJlcXVp
cmVkLiAgQXQgY29uZmlnIHRpbWUsIGEgZnVsbCB0YXJnZXQgYnVpbGQgZW52
aXJvbm1lbnQgaXMgbm90IHNldHVwLiAgVGh1cywNCmMgc2NyaXB0cy9lbXB0
eS5vIChldC4gYWwuKSB3aWxsIGJlIHJlY29tcGlsZWQgYmV0d2VlbiBhbnkg
dGFyZ2V0IGJ1aWxkIGFuZCBjb25maWcNCmMgYnVpbGQuDQpLIDk4MzQNClAg
Q2hhbmdlU2V0DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCg0KMGEwDQo+IHRvcnZhbGRzQGF0aGxvbi50cmFu
c21ldGEuY29tfHNjcmlwdHMvTWFrZWZpbGV8MjAwMjAyMDUxNzQwMzV8MzIy
ODl8OTZiOTUwYzY5MzQyY2U3NyBqZmJlYW1AdHJvei5jb218c2NyaXB0cy9N
YWtlZmlsZXwyMDAzMDkwNjAyMjUyNXw0MTU5Mg0KPiB6aXBwZWxAbGludXgt
bTY4ay5vcmdbdG9ydmFsZHNdfHNjcmlwdHMva2NvbmZpZy9NYWtlZmlsZXwy
MDAyMTAzMDA0MzIxM3wxNTI4OHw1YmQxMTUyNjYxZTdlOTMzIGpmYmVhbUB0
cm96LmNvbXxzY3JpcHRzL2tjb25maWcvTWFrZWZpbGV8MjAwMzA5MDYwMjI1
MjV8MzIyMjANCj4gdG9ydmFsZHNAYXRobG9uLnRyYW5zbWV0YS5jb218TWFr
ZWZpbGV8MjAwMjAyMDUxNzM5Mzh8MDA4NzZ8ZDZhZDljMWE4ZDU5NWE1IGpm
YmVhbUB0cm96LmNvbXxNYWtlZmlsZXwyMDAzMDkwNjAyMjUyNXwxNDU3Mw0K
PiB6aXBwZWxAbGludXgtbTY4ay5vcmdbdG9ydmFsZHNdfHNjcmlwdHMva2Nv
bmZpZy9jb25mLmN8MjAwMjEwMzAwNDMyMTN8MjY1NjF8OGI5ZDFlMGEzNmFk
YWJiNSBqZmJlYW1AdHJvei5jb218c2NyaXB0cy9rY29uZmlnL2NvbmYuY3wy
MDAzMDkwNjAyMjUyNXwwMTgwMg0KDQo9PSBNYWtlZmlsZSA9PQ0KdG9ydmFs
ZHNAYXRobG9uLnRyYW5zbWV0YS5jb218TWFrZWZpbGV8MjAwMjAyMDUxNzM5
Mzh8MDA4NzZ8ZDZhZDljMWE4ZDU5NWE1DQpqZmJlYW1Ac3BhY2VtZWF0LnRy
b3ouY29tfE1ha2VmaWxlfDIwMDMwOTAyMTkxMzM1fDEyNDAwDQpEIDEuNDI2
IDAzLzA5LzA1IDIyOjI1OjI1LTA0OjAwIGpmYmVhbUB0cm96LmNvbSArNiAt
NQ0KQiB0b3J2YWxkc0BhdGhsb24udHJhbnNtZXRhLmNvbXxDaGFuZ2VTZXR8
MjAwMjAyMDUxNzMwNTZ8MTYwNDd8YzFkMTFhNDFlZDAyNDg2NA0KQw0KYyBz
ZXBhcmF0ZSBmaXhkZXAgZnJvbSAic2NyaXB0cyIgYW5kIG1ha2UgaXQgYW4g
aW5kZXBlbmRhbnQgdGFyZ2V0DQpLIDE0NTczDQpPIC1ydy1ydy1yLS0NClAg
TWFrZWZpbGUNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KDQpEMjYyIDENCkkyNjIgMQ0Kc2NyaXB0cy9kb2Nw
cm9jIHNjcmlwdHMvc3BsaXQtaW5jbHVkZSA6IHNjcmlwdHMgOw0KRDI2NCAx
DQpJMjY0IDENCi5QSE9OWTogc2NyaXB0cyBzY3JpcHRzL2ZpeGRlcA0KRDI2
NyAxDQpJMjY3IDINCnNjcmlwdHMvZml4ZGVwOg0KCSQoUSkkKE1BS0UpICQo
YnVpbGQpPXNjcmlwdHMgZml4ZGVwDQpEMzQ1IDINCkkzNDYgMg0KaW5jbHVk
ZS9saW51eC9hdXRvY29uZi5oOiAuY29uZmlnDQoJJChRKSQoTUFLRSkgLWYg
JChUT1BESVIpL01ha2VmaWxlIHNpbGVudG9sZGNvbmZpZw0KDQo9PSBzY3Jp
cHRzL01ha2VmaWxlID09DQp0b3J2YWxkc0BhdGhsb24udHJhbnNtZXRhLmNv
bXxzY3JpcHRzL01ha2VmaWxlfDIwMDIwMjA1MTc0MDM1fDMyMjg5fDk2Yjk1
MGM2OTM0MmNlNzcNCmpzaW1tb25zQG1heHdlbGwuZWFydGhsaW5rLm5ldHxz
Y3JpcHRzL01ha2VmaWxlfDIwMDMwMzE4MTgxOTQ0fDM4Nzc1DQpEIDEuMzUg
MDMvMDkvMDUgMjI6MjU6MjUtMDQ6MDAgamZiZWFtQHRyb3ouY29tICs0IC0w
DQpCIHRvcnZhbGRzQGF0aGxvbi50cmFuc21ldGEuY29tfENoYW5nZVNldHwy
MDAyMDIwNTE3MzA1NnwxNjA0N3xjMWQxMWE0MWVkMDI0ODY0DQpDDQpjIGZp
eGRlcCB0YXJnZXQNCksgNDE1OTINCk8gLXJ3LXJ3LXItLQ0KUCBzY3JpcHRz
L01ha2VmaWxlDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCg0KSTI0IDMNCmZpeGRlcDogJChvYmopL2ZpeGRl
cA0KCUAvYmluL3RydWUNClwNCkkzNSAxDQpcDQoNCj09IHNjcmlwdHMva2Nv
bmZpZy9NYWtlZmlsZSA9PQ0KemlwcGVsQGxpbnV4LW02OGsub3JnW3RvcnZh
bGRzXXxzY3JpcHRzL2tjb25maWcvTWFrZWZpbGV8MjAwMjEwMzAwNDMyMTN8
MTUyODh8NWJkMTE1MjY2MWU3ZTkzMw0KYWtwbUBvc2RsLm9yZ1t0b3J2YWxk
c118c2NyaXB0cy9rY29uZmlnL01ha2VmaWxlfDIwMDMwOTAxMDEyNTM1fDMy
MDIyDQpEIDEuMTAgMDMvMDkvMDUgMjI6MjU6MjUtMDQ6MDAgamZiZWFtQHRy
b3ouY29tICsxIC0xDQpCIHRvcnZhbGRzQGF0aGxvbi50cmFuc21ldGEuY29t
fENoYW5nZVNldHwyMDAyMDIwNTE3MzA1NnwxNjA0N3xjMWQxMWE0MWVkMDI0
ODY0DQpDDQpjIG1ha2Ugc2lsZW50b2xkY29uZmlnIG9iZXkgS0JVSUxEX1ZF
UkJPU0UNCksgMzIyMjANCk8gLXJ3LXJ3LXItLQ0KUCBzY3JpcHRzL2tjb25m
aWcvTWFrZWZpbGUNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KDQpEMjQgMQ0KSTI0IDENCgkkKFEpJDwgLXMg
YXJjaC8kKEFSQ0gpL0tjb25maWcNCg0KPT0gc2NyaXB0cy9rY29uZmlnL2Nv
bmYuYyA9PQ0KemlwcGVsQGxpbnV4LW02OGsub3JnW3RvcnZhbGRzXXxzY3Jp
cHRzL2tjb25maWcvY29uZi5jfDIwMDIxMDMwMDQzMjEzfDI2NTYxfDhiOWQx
ZTBhMzZhZGFiYjUNCnppcHBlbEBsaW51eC1tNjhrLm9yZ1t0b3J2YWxkc118
c2NyaXB0cy9rY29uZmlnL2NvbmYuY3wyMDAzMDYwNjE1MTg1MHw2NDE3NA0K
RCAxLjEwIDAzLzA5LzA1IDIyOjI1OjI1LTA0OjAwIGpmYmVhbUB0cm96LmNv
bSArNCAtMQ0KQiB0b3J2YWxkc0BhdGhsb24udHJhbnNtZXRhLmNvbXxDaGFu
Z2VTZXR8MjAwMjAyMDUxNzMwNTZ8MTYwNDd8YzFkMTFhNDFlZDAyNDg2NA0K
Qw0KYyBtYWtlIHNpbGVudG9sZGNvbmZpZyBhY3R1YWxseSBzaWxlbnQNCksg
MTgwMg0KTyAtcnctcnctci0tDQpQIHNjcmlwdHMva2NvbmZpZy9jb25mLmMN
Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KDQpENTM1IDENCkk1MzUgMg0KCQluYW1lID0gIi5jb25maWciOw0K
CQlpZiAoc3RhdChuYW1lLCAmdG1wc3RhdCkpIHsNCkk1NDMgMg0KCQljb25m
X3JlYWQobmFtZSk7DQoJCWJyZWFrOw0KDQojIFBhdGNoIGNoZWNrc3VtPWI0
NmMzMGRlDQo=
---559023410-440155785-1063039922=:13584--
