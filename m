Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262173AbVHCJf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262173AbVHCJf6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 05:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbVHCJf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 05:35:57 -0400
Received: from sophia.inria.fr ([138.96.64.20]:26048 "EHLO sophia.inria.fr")
	by vger.kernel.org with ESMTP id S262173AbVHCJfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 05:35:55 -0400
Message-ID: <42F08FE6.8000601@yahoo.fr>
Date: Wed, 03 Aug 2005 11:35:34 +0200
From: Guillaume Chazarain <guichaz@yahoo.fr>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Wrong printk return value
Content-Type: multipart/mixed;
 boundary="------------060203090707070708000602"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0 (sophia.inria.fr [138.96.64.20]); Wed, 03 Aug 2005 11:35:35 +0200 (MEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060203090707070708000602
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

What's the true meaning of the printk return value?
Should it include the prioty prefix length of 3? and what about the timing
information? In both cases it was broken:

strace -e write echo 1 > /dev/kmsg
=> write(1, "1\n", 2)                      = 5

strace -e write echo "<1>1" > /dev/kmsg
=> write(1, "<1>1\n", 5)                   = 8

The returned length was "length of input string + 3", I made it "length
of printed string including any prefix".

Successful printk calls can have a return value different than the input
length (priority prefix, timing), so /bin/echo will still think there is 
an error.
So, to avoid breaking programs that assume write(buff, len) != len is an
error, /dev/kmsg should return the buffer length when the call succeeds.

The only drawback is that now it's no more possible to use /dev/kmsg to
check the printk return value :-(

-- 
Guillaume


--------------060203090707070708000602
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="diff"

LS0tIGxpbnV4LTIuNi4xMy1yYzUva2VybmVsL3ByaW50ay5jCisrKyBsaW51eC0yLjYuMTMt
cmM1L2tlcm5lbC9wcmludGsuYwpAQCAtNTUzLDcgKzU1Myw3IEBACiAJCQkJICAgcFsxXSA8
PSAnNycgJiYgcFsyXSA9PSAnPicpIHsKIAkJCQkJbG9nbGV2X2NoYXIgPSBwWzFdOwogCQkJ
CQlwICs9IDM7Ci0JCQkJCXByaW50ZWRfbGVuICs9IDM7CisJCQkJCXByaW50ZWRfbGVuIC09
IDM7CiAJCQkJfSBlbHNlIHsKIAkJCQkJbG9nbGV2X2NoYXIgPSBkZWZhdWx0X21lc3NhZ2Vf
bG9nbGV2ZWwKIAkJCQkJCSsgJzAnOwpAQCAtNTY4LDcgKzU2OCw3IEBACiAKIAkJCQlmb3Ig
KHRwID0gdGJ1ZjsgdHAgPCB0YnVmICsgdGxlbjsgdHArKykKIAkJCQkJZW1pdF9sb2dfY2hh
cigqdHApOwotCQkJCXByaW50ZWRfbGVuICs9IHRsZW4gLSAzOworCQkJCXByaW50ZWRfbGVu
ICs9IHRsZW47CiAJCQl9IGVsc2UgewogCQkJCWlmIChwWzBdICE9ICc8JyB8fCBwWzFdIDwg
JzAnIHx8CiAJCQkJICAgcFsxXSA+ICc3JyB8fCBwWzJdICE9ICc+JykgewpAQCAtNTc2LDgg
KzU3Niw4IEBACiAJCQkJCWVtaXRfbG9nX2NoYXIoZGVmYXVsdF9tZXNzYWdlX2xvZ2xldmVs
CiAJCQkJCQkrICcwJyk7CiAJCQkJCWVtaXRfbG9nX2NoYXIoJz4nKTsKKwkJCQkJcHJpbnRl
ZF9sZW4gKz0gMzsKIAkJCQl9Ci0JCQkJcHJpbnRlZF9sZW4gKz0gMzsKIAkJCX0KIAkJCWxv
Z19sZXZlbF91bmtub3duID0gMDsKIAkJCWlmICghKnApCi0tLSBsaW51eC0yLjYuMTMtcmM1
L2RyaXZlcnMvY2hhci9tZW0uYworKysgbGludXgtMi42LjEzLXJjNS9kcml2ZXJzL2NoYXIv
bWVtLmMKQEAgLTgxOSw3ICs4MTksNyBAQCBzdGF0aWMgc3NpemVfdCBrbXNnX3dyaXRlKHN0
cnVjdCBmaWxlICogCiAJCQkgIHNpemVfdCBjb3VudCwgbG9mZl90ICpwcG9zKQogewogCWNo
YXIgKnRtcDsKLQlpbnQgcmV0OworCXNzaXplX3QgcmV0OwogCiAJdG1wID0ga21hbGxvYyhj
b3VudCArIDEsIEdGUF9LRVJORUwpOwogCWlmICh0bXAgPT0gTlVMTCkKQEAgLTgyOCw2ICs4
MjgsOSBAQCBzdGF0aWMgc3NpemVfdCBrbXNnX3dyaXRlKHN0cnVjdCBmaWxlICogCiAJaWYg
KCFjb3B5X2Zyb21fdXNlcih0bXAsIGJ1ZiwgY291bnQpKSB7CiAJCXRtcFtjb3VudF0gPSAw
OwogCQlyZXQgPSBwcmludGsoIiVzIiwgdG1wKTsKKwkJaWYgKHJldCA+IGNvdW50KQorCQkJ
LyogcHJpbnRrIGNhbiBhZGQgYSBwcmVmaXggKi8KKwkJCXJldCA9IGNvdW50OwogCX0KIAlr
ZnJlZSh0bXApOwogCXJldHVybiByZXQ7Cg==
--------------060203090707070708000602--
