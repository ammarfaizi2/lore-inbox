Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265431AbUGNEMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265431AbUGNEMQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 00:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265500AbUGNEMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 00:12:15 -0400
Received: from web13708.mail.yahoo.com ([216.136.175.141]:51294 "HELO
	web13708.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265431AbUGNELv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 00:11:51 -0400
Message-ID: <20040714041147.87993.qmail@web13708.mail.yahoo.com>
Date: Tue, 13 Jul 2004 21:11:47 -0700 (PDT)
From: Martins Krikis <mkrikis@yahoo.com>
Subject: [RFC][PATCH] ataraid_end_request hides errors (all? 2.4 kernels)
To: linux-kernel@vger.kernel.org
Cc: mkrikis@yahoo.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-733489887-1089778307=:22468"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-733489887-1089778307=:22468
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

I know that interest in 2.4 kernels and ataraid at this point
is probably minimal, and I myself don't use ataraid_end_request.

However, I would appreciate if somebody could tell me whether a
patch like the one attached is acceptable or whether the use of
the BH_PrivateStart flag (style issues aside) can introduce any
new problems. In particular, I've noticed that ext3 and xfs also
use this flag.

The bug that the patch attempts to solve is the following.
Ataraid_end_request() uses the success/failure of the last
one of component I/Os as the success/failure of the complete
I/O (to a RAID volume). Thus, even if all the first components
fail, as long as the last one succeeds, it will report the
complete I/O as a success, and the user will not even get
an indication of any errors. The code is used by all ataraid
subdrivers except iswraid, as far as I know.

If using the BH_PrivateStart is not appropriate in this module,
a different free bit from b_state can be chosen. Protection
against component-I/O failure can also be achieved by introducing
a new field in ataraid_bh_private. Ideally the subdrivers would
also clear the flag/field, although for a truly unused flag
in b_state this can be skipped, so a flag-based solution can
be both quicker and need no extra space, I think.

Anyway, I'm very interested to hear whether anybody cares
and whether it is OK to use BH_PrivateStart in block device
drivers.

Thanks,

  Martins Krikis



		
__________________________________
Do you Yahoo!?
Take Yahoo! Mail with you! Get it on your mobile phone.
http://mobile.yahoo.com/maildemo 
--0-733489887-1089778307=:22468
Content-Type: application/octet-stream; name="ataraid.patch"
Content-Transfer-Encoding: base64
Content-Description: ataraid.patch
Content-Disposition: attachment; filename="ataraid.patch"

LS0tIGxpbnV4L2RyaXZlcnMvaWRlL3JhaWQvYXRhcmFpZC5jLm9yaWcJMjAw
NC0wNy0xMyAyMzo0NToyMS4wMDAwMDAwMDAgLTA0MDAKKysrIGxpbnV4L2Ry
aXZlcnMvaWRlL3JhaWQvYXRhcmFpZC5jCTIwMDQtMDctMTMgMjM6NDU6MzIu
MDAwMDAwMDAwIC0wNDAwCkBAIC0xNTMsNyArMTUzLDE0IEBAIHZvaWQgYXRh
cmFpZF9lbmRfcmVxdWVzdChzdHJ1Y3QgYnVmZmVyX2gKIAlpZiAocHJpdmF0
ZT09TlVMTCkKIAkJQlVHKCk7CiAKKwlpZiAoIXVwdG9kYXRlKSAvKiByZWNv
cmQgZmFpbHVyZXMgb2YgY29tcG9uZW50cyBvZiB0aGUgb3JpZ2luYWwgSS9P
ICovCisJCXNldF9iaXQoQkhfUHJpdmF0ZVN0YXJ0LCAmcHJpdmF0ZS0+cGFy
ZW50LT5iX3N0YXRlKTsKKwkKIAlpZiAoYXRvbWljX2RlY19hbmRfdGVzdCgm
cHJpdmF0ZS0+Y291bnQpKSB7CisJCWlmICh0ZXN0X2JpdChCSF9Qcml2YXRl
U3RhcnQsICZwcml2YXRlLT5wYXJlbnQtPmJfc3RhdGUpKSB7CisJCQl1cHRv
ZGF0ZSA9IDA7IC8qIGZhaWwgdGhlIGNvbXBsZXRlZCBvcmlnaW5hbCBJL08g
Ki8KKwkJCWNsZWFyX2JpdChCSF9Qcml2YXRlU3RhcnQsICZwcml2YXRlLT5w
YXJlbnQtPmJfc3RhdGUpOworCQl9CiAJCXByaXZhdGUtPnBhcmVudC0+Yl9l
bmRfaW8ocHJpdmF0ZS0+cGFyZW50LHVwdG9kYXRlKTsKIAkJcHJpdmF0ZS0+
cGFyZW50ID0gTlVMTDsKIAkJa2ZyZWUocHJpdmF0ZSk7CkBAIC0xOTQsNiAr
MjAxLDggQEAgc3RhdGljIHZvaWQgYXRhcmFpZF9zcGxpdF9yZXF1ZXN0KHJl
cXVlcwogCiAJYmgyLT5iX2RhdGEgKz0gIGJoLT5iX3NpemUvMjsKIAorCWNs
ZWFyX2JpdChCSF9Qcml2YXRlU3RhcnQsICZiaC0+Yl9zdGF0ZSk7IC8qIHRo
aXMgYml0IHRyYWNrcyBzdWNjZXNzICovCisKIAlnZW5lcmljX21ha2VfcmVx
dWVzdChydyxiaDEpOwogCWdlbmVyaWNfbWFrZV9yZXF1ZXN0KHJ3LGJoMik7
CiB9Cg==

--0-733489887-1089778307=:22468--
