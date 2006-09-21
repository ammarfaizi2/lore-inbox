Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751447AbWIUSrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbWIUSrT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 14:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWIUSrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 14:47:19 -0400
Received: from mail.aknet.ru ([82.179.72.26]:2063 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1751447AbWIUSrS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 14:47:18 -0400
Message-ID: <4512DE7E.9090602@aknet.ru>
Date: Thu, 21 Sep 2006 22:48:30 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: question about MNT_NOEXEC and PROT_EXEC relation
Content-Type: multipart/mixed;
 boundary="------------000009080000040500040304"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000009080000040500040304
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

My question is inspired by the recent change in debian
scripts that resulted tmpfs to be mounted with "noexec".
That broke a few packages, namely UML and dosemu, see here:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=386945

Right now the kernel checks the MNT_NOEXEC flag and if it
is set, it rejects the PROT_EXEC file-based mappings.
My question is simple: why?

I have googled for an answer but failed to find any.
I have only found the related commit:
http://linux.bkbits.net:8080/linux-2.6/patch@1.1371.76.3
and some "post-factum" discussion:
http://lists.grok.org.uk/pipermail/full-disclosure/2004-January/015871.html
but the original discussion that preceeded the patch, I
was not able to find.

I can see the following problems with that approach:
1. It rejects both the MAP_SHARED and MAP_PRIVATE mappings.
How can it be usefull to reject the MAP_PRIVATE mapping, if
the one can just do the MAP_ANONYMOUS mapping with PROT_EXEC
set, and then simply read() the binary in?
2. It doesn't prevent mprotect() to be used to set PROT_EXEC
later on.
3. It doesn't check the file mode for the execute permission,
yet it checks MNT_NOEXEC - is this consistent?
4. It prevents tmpfs from being mounted with "noexec", and so,
in my eyes, doesn't add to security at all, and now also makes
some problems for debian.

Can someone please give a brief explanation of why such a
check is usefull? Or, in other words, why the attached patch
cannot be applied?


--------------000009080000040500040304
Content-Type: text/plain;
 name="mapx.diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="mapx.diff"

LS0tIGEvbW0vbW1hcC5jCTIwMDYtMDEtMjUgMTU6MDI6MjQuMDAwMDAwMDAwICswMzAwCisr
KyBiL21tL21tYXAuYwkyMDA2LTA5LTIxIDEzOjE5OjE1LjAwMDAwMDAwMCArMDQwMApAQCAt
ODk5LDEwICs4OTksNiBAQAogCiAJCWlmICghZmlsZS0+Zl9vcCB8fCAhZmlsZS0+Zl9vcC0+
bW1hcCkKIAkJCXJldHVybiAtRU5PREVWOwotCi0JCWlmICgocHJvdCAmIFBST1RfRVhFQykg
JiYKLQkJICAgIChmaWxlLT5mX3Zmc21udC0+bW50X2ZsYWdzICYgTU5UX05PRVhFQykpCi0J
CQlyZXR1cm4gLUVQRVJNOwogCX0KIAkvKgogCSAqIERvZXMgdGhlIGFwcGxpY2F0aW9uIGV4
cGVjdCBQUk9UX1JFQUQgdG8gaW1wbHkgUFJPVF9FWEVDPwpAQCAtOTExLDggKzkwNyw3IEBA
CiAJICogIG1vdW50ZWQsIGluIHdoaWNoIGNhc2Ugd2UgZG9udCBhZGQgUFJPVF9FWEVDLikK
IAkgKi8KIAlpZiAoKHByb3QgJiBQUk9UX1JFQUQpICYmIChjdXJyZW50LT5wZXJzb25hbGl0
eSAmIFJFQURfSU1QTElFU19FWEVDKSkKLQkJaWYgKCEoZmlsZSAmJiAoZmlsZS0+Zl92ZnNt
bnQtPm1udF9mbGFncyAmIE1OVF9OT0VYRUMpKSkKLQkJCXByb3QgfD0gUFJPVF9FWEVDOwor
CQlwcm90IHw9IFBST1RfRVhFQzsKIAogCWlmICghbGVuKQogCQlyZXR1cm4gLUVJTlZBTDsK
LS0tIGEvbW0vbm9tbXUuYwkyMDA2LTA0LTEyIDA5OjM3OjM0LjAwMDAwMDAwMCArMDQwMAor
KysgYi9tbS9ub21tdS5jCTIwMDYtMDktMjEgMTM6MjE6MzIuMDAwMDAwMDAwICswNDAwCkBA
IC00OTMsMTMgKzQ5Myw3IEBACiAJCQkJY2FwYWJpbGl0aWVzICY9IH5CRElfQ0FQX01BUF9E
SVJFQ1Q7CiAJCX0KIAotCQkvKiBoYW5kbGUgZXhlY3V0YWJsZSBtYXBwaW5ncyBhbmQgaW1w
bGllZCBleGVjdXRhYmxlCi0JCSAqIG1hcHBpbmdzICovCi0JCWlmIChmaWxlLT5mX3Zmc21u
dC0+bW50X2ZsYWdzICYgTU5UX05PRVhFQykgewotCQkJaWYgKHByb3QgJiBQUk9UX0VYRUMp
Ci0JCQkJcmV0dXJuIC1FUEVSTTsKLQkJfQotCQllbHNlIGlmICgocHJvdCAmIFBST1RfUkVB
RCkgJiYgIShwcm90ICYgUFJPVF9FWEVDKSkgeworCQlpZiAoKHByb3QgJiBQUk9UX1JFQUQp
ICYmICEocHJvdCAmIFBST1RfRVhFQykpIHsKIAkJCS8qIGhhbmRsZSBpbXBsaWNhdGlvbiBv
ZiBQUk9UX0VYRUMgYnkgUFJPVF9SRUFEICovCiAJCQlpZiAoY3VycmVudC0+cGVyc29uYWxp
dHkgJiBSRUFEX0lNUExJRVNfRVhFQykgewogCQkJCWlmIChjYXBhYmlsaXRpZXMgJiBCRElf
Q0FQX0VYRUNfTUFQKQo=
--------------000009080000040500040304--
