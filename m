Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbVIFJqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbVIFJqK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 05:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbVIFJqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 05:46:10 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:26453
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S964785AbVIFJqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 05:46:08 -0400
Message-Id: <431D81B80200007800023FBD@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Tue, 06 Sep 2005 11:47:04 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix split-include dependency
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartDBF98888.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartDBF98888.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

Splitting of autoconf.h requires that split-include was built before,
and
needs to be-re-done when split-include changes. This dependency was
previously missing. Additionally, since autoconf.h is (suppoosed to
be)
generated as a side effect of executing config targets, include/linux
should be created prior to running the respective sub-make.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- /home/jbeulich/tmp/linux-2.6.13/Makefile	2005-08-29
01:41:01.000000000 +0200
+++ 2.6.13/Makefile	2005-08-29 09:50:38.000000000 +0200
@@ -385,6 +385,9 @@ RCS_TAR_IGNORE := --exclude SCCS --exclu
 scripts_basic:
 	$(Q)$(MAKE) $(build)=scripts/basic
 
+# To avoid any implicit rule to kick in, define an empty command.
+scripts/basic/%: scripts_basic ;
+
 .PHONY: outputmakefile
 # outputmakefile generate a Makefile to be placed in output directory,
if
 # using a seperate output directory. This allows convinient use
@@ -447,9 +450,8 @@ ifeq ($(config-targets),1)
 include $(srctree)/arch/$(ARCH)/Makefile
 export KBUILD_DEFCONFIG
 
-config: scripts_basic outputmakefile FORCE
-	$(Q)$(MAKE) $(build)=scripts/kconfig $@
-%config: scripts_basic outputmakefile FORCE
+config %config: scripts_basic outputmakefile FORCE
+	$(Q)mkdir -p include/linux
 	$(Q)$(MAKE) $(build)=scripts/kconfig $@
 
 else
@@ -815,7 +817,7 @@ include/asm:
 
 # 	Split autoconf.h into include/linux/config/*
 
-include/config/MARKER: include/linux/autoconf.h
+include/config/MARKER: scripts/basic/split-include
include/linux/autoconf.h
 	@echo '  SPLIT   include/linux/autoconf.h -> include/config/*'
 	@scripts/basic/split-include include/linux/autoconf.h
include/config
 	@touch $@


--=__PartDBF98888.0__=
Content-Type: application/octet-stream; name="linux-2.6.13-split-include-dep.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.13-split-include-dep.patch"

KE5vdGU6IFBhdGNoIGFsc28gYXR0YWNoZWQgYmVjYXVzZSB0aGUgaW5saW5lIHZlcnNpb24gaXMg
Y2VydGFpbiB0byBnZXQKbGluZSB3cmFwcGVkLikKClNwbGl0dGluZyBvZiBhdXRvY29uZi5oIHJl
cXVpcmVzIHRoYXQgc3BsaXQtaW5jbHVkZSB3YXMgYnVpbHQgYmVmb3JlLCBhbmQKbmVlZHMgdG8g
YmUtcmUtZG9uZSB3aGVuIHNwbGl0LWluY2x1ZGUgY2hhbmdlcy4gVGhpcyBkZXBlbmRlbmN5IHdh
cwpwcmV2aW91c2x5IG1pc3NpbmcuIEFkZGl0aW9uYWxseSwgc2luY2UgYXV0b2NvbmYuaCBpcyAo
c3VwcG9vc2VkIHRvIGJlKQpnZW5lcmF0ZWQgYXMgYSBzaWRlIGVmZmVjdCBvZiBleGVjdXRpbmcg
Y29uZmlnIHRhcmdldHMsIGluY2x1ZGUvbGludXgKc2hvdWxkIGJlIGNyZWF0ZWQgcHJpb3IgdG8g
cnVubmluZyB0aGUgcmVzcGVjdGl2ZSBzdWItbWFrZS4KClNpZ25lZC1vZmYtYnk6IEphbiBCZXVs
aWNoIDxqYmV1bGljaEBub3ZlbGwuY29tPgoKLS0tIC9ob21lL2piZXVsaWNoL3RtcC9saW51eC0y
LjYuMTMvTWFrZWZpbGUJMjAwNS0wOC0yOSAwMTo0MTowMS4wMDAwMDAwMDAgKzAyMDAKKysrIDIu
Ni4xMy9NYWtlZmlsZQkyMDA1LTA4LTI5IDA5OjUwOjM4LjAwMDAwMDAwMCArMDIwMApAQCAtMzg1
LDYgKzM4NSw5IEBAIFJDU19UQVJfSUdOT1JFIDo9IC0tZXhjbHVkZSBTQ0NTIC0tZXhjbHUKIHNj
cmlwdHNfYmFzaWM6CiAJJChRKSQoTUFLRSkgJChidWlsZCk9c2NyaXB0cy9iYXNpYwogCisjIFRv
IGF2b2lkIGFueSBpbXBsaWNpdCBydWxlIHRvIGtpY2sgaW4sIGRlZmluZSBhbiBlbXB0eSBjb21t
YW5kLgorc2NyaXB0cy9iYXNpYy8lOiBzY3JpcHRzX2Jhc2ljIDsKKwogLlBIT05ZOiBvdXRwdXRt
YWtlZmlsZQogIyBvdXRwdXRtYWtlZmlsZSBnZW5lcmF0ZSBhIE1ha2VmaWxlIHRvIGJlIHBsYWNl
ZCBpbiBvdXRwdXQgZGlyZWN0b3J5LCBpZgogIyB1c2luZyBhIHNlcGVyYXRlIG91dHB1dCBkaXJl
Y3RvcnkuIFRoaXMgYWxsb3dzIGNvbnZpbmllbnQgdXNlCkBAIC00NDcsOSArNDUwLDggQEAgaWZl
cSAoJChjb25maWctdGFyZ2V0cyksMSkKIGluY2x1ZGUgJChzcmN0cmVlKS9hcmNoLyQoQVJDSCkv
TWFrZWZpbGUKIGV4cG9ydCBLQlVJTERfREVGQ09ORklHCiAKLWNvbmZpZzogc2NyaXB0c19iYXNp
YyBvdXRwdXRtYWtlZmlsZSBGT1JDRQotCSQoUSkkKE1BS0UpICQoYnVpbGQpPXNjcmlwdHMva2Nv
bmZpZyAkQAotJWNvbmZpZzogc2NyaXB0c19iYXNpYyBvdXRwdXRtYWtlZmlsZSBGT1JDRQorY29u
ZmlnICVjb25maWc6IHNjcmlwdHNfYmFzaWMgb3V0cHV0bWFrZWZpbGUgRk9SQ0UKKwkkKFEpbWtk
aXIgLXAgaW5jbHVkZS9saW51eAogCSQoUSkkKE1BS0UpICQoYnVpbGQpPXNjcmlwdHMva2NvbmZp
ZyAkQAogCiBlbHNlCkBAIC04MTUsNyArODE3LDcgQEAgaW5jbHVkZS9hc206CiAKICMgCVNwbGl0
IGF1dG9jb25mLmggaW50byBpbmNsdWRlL2xpbnV4L2NvbmZpZy8qCiAKLWluY2x1ZGUvY29uZmln
L01BUktFUjogaW5jbHVkZS9saW51eC9hdXRvY29uZi5oCitpbmNsdWRlL2NvbmZpZy9NQVJLRVI6
IHNjcmlwdHMvYmFzaWMvc3BsaXQtaW5jbHVkZSBpbmNsdWRlL2xpbnV4L2F1dG9jb25mLmgKIAlA
ZWNobyAnICBTUExJVCAgIGluY2x1ZGUvbGludXgvYXV0b2NvbmYuaCAtPiBpbmNsdWRlL2NvbmZp
Zy8qJwogCUBzY3JpcHRzL2Jhc2ljL3NwbGl0LWluY2x1ZGUgaW5jbHVkZS9saW51eC9hdXRvY29u
Zi5oIGluY2x1ZGUvY29uZmlnCiAJQHRvdWNoICRACg==

--=__PartDBF98888.0__=--
