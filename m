Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWIZTpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWIZTpV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 15:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbWIZTpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 15:45:21 -0400
Received: from mail.aknet.ru ([82.179.72.26]:1553 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S932172AbWIZTpU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 15:45:20 -0400
Message-ID: <45198395.4050008@aknet.ru>
Date: Tue, 26 Sep 2006 23:46:29 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
       Ulrich Drepper <drepper@redhat.com>, Valdis.Kletnieks@vt.edu,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
References: <45150CD7.4010708@aknet.ru>	 <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com>	 <451555CB.5010006@aknet.ru>	 <Pine.LNX.4.64.0609231647420.29557@blonde.wat.veritas.com>	 <1159037913.24572.62.camel@localhost.localdomain>	 <45162BE5.2020100@aknet.ru> <1159106032.11049.12.camel@localhost.localdomain> <45169C0C.5010001@aknet.ru> <4516A8E3.4020100@redhat.com> <4516B2C8.4050202@aknet.ru> <4516B721.5070801@redhat.com>
In-Reply-To: <4516B721.5070801@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------020507060901060204020909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020507060901060204020909
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Guys.

Noone provided a reason for (or even tried to defend)
the fact that PROT_EXEC is rejected by "noexec" even
for MAP_PRIVATE, while, say, PROT_WRITE is *not* rejected
for "ro" filesystem for MAP_PRIVATE. What was argued is
only MAP_SHARED.
I take it as an indication that people basically agree
that "noexec" should not affect MAP_PRIVATE like that.
So how about the patch (like the attached one) which
changes only the behaveour of MAP_PRIVATE?

Reasons:
- MAP_PRIVATE should not behave like that, "ro" and PROT_WRITE
is a witness.
- This is not a security check - file-backed MAP_PRIVATE
can just be replaced with MAP_PRIVATE | MAP_ANONYMOUS
mmap and read().
- The programs (like AFAIK wine) use MAP_PRIVATE mmaps to
access the windows dlls, which are usually on a "noexec"
fat or ntfs partitions. Wine might be smart enough not to
break but fallback to read(), but this is slower and more
memory-consuming. Some other program may not be that smart
and break. So there is clearly a need for MAP_PRIVATE with
PROT_EXEC on the noexec partitions.

Please let me know why this patch should not be applied.


--------------020507060901060204020909
Content-Type: text/plain;
 name="mapx1.diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="mapx1.diff"

LS0tIGEvbW0vbW1hcC5jCTIwMDYtMDEtMjUgMTU6MDI6MjQuMDAwMDAwMDAwICswMzAwCisr
KyBiL21tL21tYXAuYwkyMDA2LTA5LTIxIDEzOjE5OjE1LjAwMDAwMDAwMCArMDQwMApAQCAt
OTAwLDcgKzkwMCw3IEBACiAJCWlmICghZmlsZS0+Zl9vcCB8fCAhZmlsZS0+Zl9vcC0+bW1h
cCkKIAkJCXJldHVybiAtRU5PREVWOwogCi0JCWlmICgocHJvdCAmIFBST1RfRVhFQykgJiYK
KwkJaWYgKChmbGFncyAmIE1BUF9TSEFSRUQpICYmIChwcm90ICYgUFJPVF9FWEVDKSAmJgog
CQkgICAgKGZpbGUtPmZfdmZzbW50LT5tbnRfZmxhZ3MgJiBNTlRfTk9FWEVDKSkKIAkJCXJl
dHVybiAtRVBFUk07CiAJfQpAQCAtOTExLDcgKzkxMSw4IEBACiAJICogIG1vdW50ZWQsIGlu
IHdoaWNoIGNhc2Ugd2UgZG9udCBhZGQgUFJPVF9FWEVDLikKIAkgKi8KIAlpZiAoKHByb3Qg
JiBQUk9UX1JFQUQpICYmIChjdXJyZW50LT5wZXJzb25hbGl0eSAmIFJFQURfSU1QTElFU19F
WEVDKSkKLQkJaWYgKCEoZmlsZSAmJiAoZmlsZS0+Zl92ZnNtbnQtPm1udF9mbGFncyAmIE1O
VF9OT0VYRUMpKSkKKwkJaWYgKCEoZmlsZSAmJiAoZmxhZ3MgJiBNQVBfU0hBUkVEKSAmJgor
CQkJCShmaWxlLT5mX3Zmc21udC0+bW50X2ZsYWdzICYgTU5UX05PRVhFQykpKQogCQkJcHJv
dCB8PSBQUk9UX0VYRUM7CiAKIAlpZiAoIWxlbikKLS0tIGEvbW0vbm9tbXUuYwkyMDA2LTA0
LTEyIDA5OjM3OjM0LjAwMDAwMDAwMCArMDQwMAorKysgYi9tbS9ub21tdS5jCTIwMDYtMDkt
MjEgMTM6MjE6MzIuMDAwMDAwMDAwICswNDAwCkBAIC00OTUsNyArNDk1LDcgQEAKIAogCQkv
KiBoYW5kbGUgZXhlY3V0YWJsZSBtYXBwaW5ncyBhbmQgaW1wbGllZCBleGVjdXRhYmxlCiAJ
CSAqIG1hcHBpbmdzICovCi0JCWlmIChmaWxlLT5mX3Zmc21udC0+bW50X2ZsYWdzICYgTU5U
X05PRVhFQykgeworCQlpZiAoKGZsYWdzICYgTUFQX1NIQVJFRCkgJiYgZmlsZS0+Zl92ZnNt
bnQtPm1udF9mbGFncyAmIE1OVF9OT0VYRUMpIHsKIAkJCWlmIChwcm90ICYgUFJPVF9FWEVD
KQogCQkJCXJldHVybiAtRVBFUk07CiAJCX0K
--------------020507060901060204020909--
