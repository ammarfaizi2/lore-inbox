Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280760AbRKOHIe>; Thu, 15 Nov 2001 02:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280762AbRKOHIZ>; Thu, 15 Nov 2001 02:08:25 -0500
Received: from spmx.securepipe.com ([64.73.37.194]:51674 "HELO
	spmx.securepipe.com") by vger.kernel.org with SMTP
	id <S280760AbRKOHIK>; Thu, 15 Nov 2001 02:08:10 -0500
Date: Thu, 15 Nov 2001 01:08:08 -0600 (EST)
From: "M.J. Pomraning" <mjp@pilcrow.madison.wi.us>
X-X-Sender: <mjp@alice.wi.securepipe.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] make sys_open respect FASYNC
Message-ID: <Pine.LNX.4.33.0111150019390.13207-200000@alice.wi.securepipe.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="168428044-816439665-1005808088=:13207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--168428044-816439665-1005808088=:13207
Content-Type: TEXT/PLAIN; charset=US-ASCII

Please roll your eyeballs over the following -- idea is to have open(blah,
O_ASYNC) work as expected (device permitting), and not to leave the caller
with an fd with a frustrated flag.

Successfully applied against 2.4.14.  Simple test case (for ttys) attached.
Previous post [1] has more about motivation and scope (incl. FIFOs) of this
somewhat obscure concern.

=============================
--- linux/fs/open.c.orig        Wed Nov 14 09:53:36 2001
+++ linux/fs/open.c     Wed Nov 14 15:34:33 2001
@@ -789,6 +789,15 @@
                        error = PTR_ERR(f);
                        if (IS_ERR(f))
                                goto out_error;
+                       /* handle open(foo, O_ASYNC|...) */
+                       if ((f->f_flags & FASYNC) &&
+                            f->f_op && f->f_op->fasync) {
+                               error = f->f_op->fasync(fd, f, 1);
+                               if (error < 0) {
+                                       filp_close(f, NULL);
+                                       goto out_error;
+                               }
+                       }
                        fd_install(fd, f);
                }
 out:
=============================

Notes:

[1] "open(O_ASYNC) sets futile flag"
    http://www.uwsg.indiana.edu/hypermail/linux/kernel/0111.1/1401.html

Regards,
Mike
-- 
MJ Pomraning
mjp@pilcrow.madison.wi.us

--168428044-816439665-1005808088=:13207
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="fasync-tty.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0111150108080.13207@alice.wi.securepipe.com>
Content-Description: 
Content-Disposition: attachment; filename="fasync-tty.c"

I2luY2x1ZGUgPHVuaXN0ZC5oPg0KI2luY2x1ZGUgPHNpZ25hbC5oPg0KI2lu
Y2x1ZGUgPHN0ZGlvLmg+DQojZGVmaW5lIF9fVVNFX0dOVQ0KI2luY2x1ZGUg
PGZjbnRsLmg+DQoNCi8qIG1qcEBwaWxjcm93Lm1hZGlzb24ud2kudXM7IDE1
IE5vdiAyMDAxICovDQoNCi8qIGdjYyAtbyBmYXN5bmMtdHR5IGZhc3luYy10
dHkuYyAqLw0KDQpzaWdfYXRvbWljX3QgZmxhZ19pbyA9IDA7DQoNCnZvaWQg
c2lnaW8oaW50IHNpZ25vKSB7DQogIGZsYWdfaW8gPSAxOw0KfQ0KDQp2b2lk
IHBkaWUoY2hhciAqZXJydGFnKSB7DQogIHBlcnJvcihlcnJ0YWcpOw0KICBl
eGl0KDEpOw0KfQ0KDQppbnQgbWFpbigpIHsNCiAgaW50IGZkOw0KICBjaGFy
IGJ1Zls1MTJdOw0KICBjaGFyICogdHR5Ow0KDQogIGlmIChzaWduYWwoU0lH
SU8sIHNpZ2lvKSA9PSBTSUdfRVJSKQ0KICAgIHBkaWUoInNpZ25hbCIpOw0K
DQogIHR0eSA9IHR0eW5hbWUoZmlsZW5vKHN0ZGluKSk7DQogIGlmICghdHR5
KQ0KICAgIHBkaWUoInR0eS9zdGRpbiIpOw0KDQogIGZkID0gb3Blbih0dHks
IE9fQVNZTkN8T19SRE9OTFkpOw0KICBpZiAoZmQgPT0gLTEpDQogICAgcGRp
ZSgib3BlbiIpOw0KDQogIGlmIChmY250bChmZCwgRl9TRVRPV04sIGdldHBp
ZCgpKSA9PSAtMSkNCiAgICBwZGllKCJGX1NFVE9XTiIpOw0KDQogIHByaW50
ZigiJXMgb3BlbigpZCBPX0FTWU5DLCBGX1NFVE9XTidkXG4iLCB0dHkpOw0K
DQogIHByaW50ZigiQSBsaW5lIG9mIGlucHV0LCBwbGVhc2UuLi5cbiIpOw0K
ICAodm9pZCkgZmdldHMoYnVmLCA1MTIsIHN0ZGluKTsNCg0KICBwcmludGYo
Ik9fQVNZTkMgc2V0PyAlc1xuIiwNCiAgICAgICAgIChmY250bChmZCwgRl9H
RVRGTCkgJiBPX0FTWU5DKSA/ICJZZXMiIDogIk5vIik7DQoNCiAgcHJpbnRm
KCJPX0FTWU5DIHJlc3BlY3RlZD8gJXNcbiIsDQogICAgICAgICBmbGFnX2lv
ID8gIlllcyIgOiAiTm8gKGJ1bW1lcikiKTsNCiAgZXhpdCgwKTsNCn0NCg==
--168428044-816439665-1005808088=:13207--
