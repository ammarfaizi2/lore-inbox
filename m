Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266730AbUGLFRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266730AbUGLFRh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 01:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266731AbUGLFRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 01:17:37 -0400
Received: from web12825.mail.yahoo.com ([216.136.174.206]:52600 "HELO
	web12825.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266730AbUGLFRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 01:17:17 -0400
Message-ID: <20040712051716.91417.qmail@web12825.mail.yahoo.com>
Date: Sun, 11 Jul 2004 22:17:16 -0700 (PDT)
From: Shantanu Goel <sgoel01@yahoo.com>
Subject: VM regression in 2.6.7-bk20
To: Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1713367119-1089609436=:91377"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1713367119-1089609436=:91377
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

Hi,

I believe there is VM regression due to the recent
changes to the page scanner.  It stems from the fact
that shrink_zone() limits # pages reclaimed in one go
to SWAP_CLUSTER_MAX instead of basing it on the memory
shortfall which causes increased pressure on the lower
zones.  I first noticed this while running my normal
workstation workload.  The machine seemed to swap more
than I expected because the # mapped pages was only
about 30%.  I noticed the DMA zone was being scanned
very frequently while running a script that monitored
/proc/vmstat. The "swappiness" value was the default
60.  Unfortunately, I failed to save the output so if
the statistics below are insufficient evidence, I can
reboot the stock kernel and get the output.

Below are the VM statistics for stock 2.6.7-bk20 and
modified 2.6.7-bk20 which sets sc.nr_to_reclaim to
zone->pages_high - zone->free_pages.  The statistics
were collected by a perl script that read /proc/vmstat
before and after running the benchmark and printing
the difference.  "swappiness" was again the default
value 60 in both cases.  I used kernbench with options
"-H -M" using the source for 2.6.0 so only the optimal
load (-j16) was run.  The machine has 2x2.0Ghz Xeons
with HT enabled and I manually booted it with mem=256M
though it has 1GB of memory.

                         modified     stock
pgscan_kswapd_normal     750420       655116
pgscan_direct_normal     561924       497640
pgscan_kswapd_dma        121903       390318
pgscan_direct_dma         78258       153638
pgsteal_normal           631517       575534
pgsteal_dma               67128       125950

Notice that the stock kernel scanned the DMA zone
about 3 times as often than the modified one, and
allocated twice as much memory from the DMA zone.

The modification I made is attached below.  This is
not meant for inclusion as the sysctls (limit_reclaim,
slow_scan) are for testing only.  Please ignore the
slow_scan stuff.  It was disabled during the tests
above and is something I was playing with on the side.
 The scanner used the stock algorithm in both cases
for deciding how much of the active/inactive lists to
scan.
I used limit_reclaim to enable/disable the stock
reclaim behaviour.

Thanks,
Shantanu



		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - Send 10MB messages!
http://promotions.yahoo.com/new_mail 
--0-1713367119-1089609436=:91377
Content-Type: application/octet-stream; name="vmscan.patch"
Content-Transfer-Encoding: base64
Content-Description: vmscan.patch
Content-Disposition: attachment; filename="vmscan.patch"

LS0tIC5vcmlnL2luY2x1ZGUvbGludXgvc3dhcC5oCTIwMDQtMDctMTIgMDE6
MDU6MjAuOTQxMzIyNDAyIC0wNDAwCisrKyAyLjYuNy1iazIwLXZtL2luY2x1
ZGUvbGludXgvc3dhcC5oCTIwMDQtMDctMTEgMTI6MDM6NDEuMDAwMDAwMDAw
IC0wNDAwCkBAIC0xNzUsNiArMTc1LDggQEAKIGV4dGVybiBpbnQgdHJ5X3Rv
X2ZyZWVfcGFnZXMoc3RydWN0IHpvbmUgKiosIHVuc2lnbmVkIGludCwgdW5z
aWduZWQgaW50KTsKIGV4dGVybiBpbnQgc2hyaW5rX2FsbF9tZW1vcnkoaW50
KTsKIGV4dGVybiBpbnQgdm1fc3dhcHBpbmVzczsKK2V4dGVybiBpbnQgdm1f
c2xvd19zY2FuOworZXh0ZXJuIGludCB2bV9saW1pdF9yZWNsYWltOwogCiAj
aWZkZWYgQ09ORklHX01NVQogLyogbGludXgvbW0vc2htZW0uYyAqLwotLS0g
Lm9yaWcvaW5jbHVkZS9saW51eC9zeXNjdGwuaAkyMDA0LTA3LTEyIDAxOjA1
OjIxLjA5OTMwNzQyNCAtMDQwMAorKysgMi42LjctYmsyMC12bS9pbmNsdWRl
L2xpbnV4L3N5c2N0bC5oCTIwMDQtMDctMTEgMTI6MDI6NTYuMDAwMDAwMDAw
IC0wNDAwCkBAIC0xNjUsNiArMTY1LDggQEAKIAlWTV9CTE9DS19EVU1QPTI0
LAkvKiBibG9jayBkdW1wIG1vZGUgKi8KIAlWTV9IVUdFVExCX0dST1VQPTI1
LAkvKiBwZXJtaXR0ZWQgaHVnZXRsYiBncm91cCAqLwogCVZNX1ZGU19DQUNI
RV9QUkVTU1VSRT0yNiwgLyogZGNhY2hlL2ljYWNoZSByZWNsYWltIHByZXNz
dXJlICovCisJVk1fU0xPV19TQ0FOPTI3LAkvKiBzY2FuIGFjdGl2ZSBsaXN0
IHZlcnkgc2xvd2x5ICovCisJVk1fTElNSVRfUkVDTEFJTSwJLyogbGltaXQg
cmVjbGFpbSB0byBTV0FQX0NMVVNURVJfTUFYICovCiB9OwogCiAKLS0tIC5v
cmlnL2tlcm5lbC9zeXNjdGwuYwkyMDA0LTA3LTEyIDAxOjA1OjIxLjE5MzI5
ODUxMiAtMDQwMAorKysgMi42LjctYmsyMC12bS9rZXJuZWwvc3lzY3RsLmMJ
MjAwNC0wNy0xMSAxMjowMzoyNy4wMDAwMDAwMDAgLTA0MDAKQEAgLTc4OSw2
ICs3ODksMjYgQEAKIAkJLnN0cmF0ZWd5CT0gJnN5c2N0bF9pbnR2ZWMsCiAJ
CS5leHRyYTEJCT0gJnplcm8sCiAJfSwKKwl7CisJCS5jdGxfbmFtZQk9IFZN
X1NMT1dfU0NBTiwKKwkJLnByb2NuYW1lCT0gInNsb3dfc2NhbiIsCisJCS5k
YXRhCQk9ICZ2bV9zbG93X3NjYW4sCisJCS5tYXhsZW4JCT0gc2l6ZW9mKHZt
X3Nsb3dfc2NhbiksCisJCS5tb2RlCQk9IDA2NDQsCisJCS5wcm9jX2hhbmRs
ZXIJPSAmcHJvY19kb2ludHZlYywKKwkJLnN0cmF0ZWd5CT0gJnN5c2N0bF9p
bnR2ZWMsCisJCS5leHRyYTEJCT0gJnplcm8sCisJfSwKKwl7CisJCS5jdGxf
bmFtZQk9IFZNX0xJTUlUX1JFQ0xBSU0sCisJCS5wcm9jbmFtZQk9ICJsaW1p
dF9yZWNsYWltIiwKKwkJLmRhdGEJCT0gJnZtX2xpbWl0X3JlY2xhaW0sCisJ
CS5tYXhsZW4JCT0gc2l6ZW9mKHZtX2xpbWl0X3JlY2xhaW0pLAorCQkubW9k
ZQkJPSAwNjQ0LAorCQkucHJvY19oYW5kbGVyCT0gJnByb2NfZG9pbnR2ZWMs
CisJCS5zdHJhdGVneQk9ICZzeXNjdGxfaW50dmVjLAorCQkuZXh0cmExCQk9
ICZ6ZXJvLAorCX0sCiAJeyAuY3RsX25hbWUgPSAwIH0KIH07CiAKLS0tIC5v
cmlnL21tL3Ztc2Nhbi5jCTIwMDQtMDctMTIgMDE6MDU6MjEuMzU5MjgyNzc1
IC0wNDAwCisrKyAyLjYuNy1iazIwLXZtL21tL3Ztc2Nhbi5jCTIwMDQtMDct
MTEgMTQ6MzM6MTYuNTg2MDQ2MTgzIC0wNDAwCkBAIC0xMTksNiArMTE5LDgg
QEAKICAqIEZyb20gMCAuLiAxMDAuICBIaWdoZXIgbWVhbnMgbW9yZSBzd2Fw
cHkuCiAgKi8KIGludCB2bV9zd2FwcGluZXNzID0gNjA7CitpbnQgdm1fc2xv
d19zY2FuID0gMDsKK2ludCB2bV9saW1pdF9yZWNsYWltID0gMDsKIHN0YXRp
YyBsb25nIHRvdGFsX21lbW9yeTsKIAogc3RhdGljIExJU1RfSEVBRChzaHJp
bmtlcl9saXN0KTsKQEAgLTgwMSwyNSArODAzLDMzIEBACiAJdW5zaWduZWQg
bG9uZyBucl9hY3RpdmU7CiAJdW5zaWduZWQgbG9uZyBucl9pbmFjdGl2ZTsK
IAotCS8qCi0JICogQWRkIG9uZSB0byBgbnJfdG9fc2NhbicganVzdCB0byBt
YWtlIHN1cmUgdGhhdCB0aGUga2VybmVsIHdpbGwKLQkgKiBzbG93bHkgc2lm
dCB0aHJvdWdoIHRoZSBhY3RpdmUgbGlzdC4KLQkgKi8KLQl6b25lLT5ucl9z
Y2FuX2FjdGl2ZSArPSAoem9uZS0+bnJfYWN0aXZlID4+IHNjLT5wcmlvcml0
eSkgKyAxOwotCW5yX2FjdGl2ZSA9IHpvbmUtPm5yX3NjYW5fYWN0aXZlOwot
CWlmIChucl9hY3RpdmUgPj0gU1dBUF9DTFVTVEVSX01BWCkKKwlpZiAodm1f
c2xvd19zY2FuKSB7CisJCXVuc2lnbmVkIGxvbmcgbnIgPSAoem9uZS0+bnJf
YWN0aXZlICsgem9uZS0+bnJfaW5hY3RpdmUpID4+IHNjLT5wcmlvcml0eTsK
KwkJbnJfaW5hY3RpdmUgPSBtaW4obnIsIHpvbmUtPm5yX2luYWN0aXZlKTsK
KwkJbnJfYWN0aXZlID0gbnIgLSBucl9pbmFjdGl2ZTsKIAkJem9uZS0+bnJf
c2Nhbl9hY3RpdmUgPSAwOwotCWVsc2UKLQkJbnJfYWN0aXZlID0gMDsKLQot
CXpvbmUtPm5yX3NjYW5faW5hY3RpdmUgKz0gKHpvbmUtPm5yX2luYWN0aXZl
ID4+IHNjLT5wcmlvcml0eSkgKyAxOwotCW5yX2luYWN0aXZlID0gem9uZS0+
bnJfc2Nhbl9pbmFjdGl2ZTsKLQlpZiAobnJfaW5hY3RpdmUgPj0gU1dBUF9D
TFVTVEVSX01BWCkKIAkJem9uZS0+bnJfc2Nhbl9pbmFjdGl2ZSA9IDA7Ci0J
ZWxzZQotCQlucl9pbmFjdGl2ZSA9IDA7CisJfSBlbHNlIHsKKwkJLyoKKwkJ
ICogQWRkIG9uZSB0byBgbnJfdG9fc2NhbicganVzdCB0byBtYWtlIHN1cmUg
dGhhdCB0aGUga2VybmVsIHdpbGwKKwkJICogc2xvd2x5IHNpZnQgdGhyb3Vn
aCB0aGUgYWN0aXZlIGxpc3QuCisJCSAqLworCQl6b25lLT5ucl9zY2FuX2Fj
dGl2ZSArPSAoem9uZS0+bnJfYWN0aXZlID4+IHNjLT5wcmlvcml0eSkgKyAx
OworCQlucl9hY3RpdmUgPSB6b25lLT5ucl9zY2FuX2FjdGl2ZTsKKwkJaWYg
KG5yX2FjdGl2ZSA+PSBTV0FQX0NMVVNURVJfTUFYKQorCQkJem9uZS0+bnJf
c2Nhbl9hY3RpdmUgPSAwOworCQllbHNlCisJCQlucl9hY3RpdmUgPSAwOwog
Ci0Jc2MtPm5yX3RvX3JlY2xhaW0gPSBTV0FQX0NMVVNURVJfTUFYOworCQl6
b25lLT5ucl9zY2FuX2luYWN0aXZlICs9ICh6b25lLT5ucl9pbmFjdGl2ZSA+
PiBzYy0+cHJpb3JpdHkpICsgMTsKKwkJbnJfaW5hY3RpdmUgPSB6b25lLT5u
cl9zY2FuX2luYWN0aXZlOworCQlpZiAobnJfaW5hY3RpdmUgPj0gU1dBUF9D
TFVTVEVSX01BWCkKKwkJCXpvbmUtPm5yX3NjYW5faW5hY3RpdmUgPSAwOwor
CQllbHNlCisJCQlucl9pbmFjdGl2ZSA9IDA7CisJfQorCWlmICh2bV9saW1p
dF9yZWNsYWltKQorCQlzYy0+bnJfdG9fcmVjbGFpbSA9IFNXQVBfQ0xVU1RF
Ul9NQVg7CiAKIAl3aGlsZSAobnJfYWN0aXZlIHx8IG5yX2luYWN0aXZlKSB7
CiAJCWlmIChucl9hY3RpdmUpIHsKQEAgLTkwMCw2ICs5MTAsNyBAQAogCiAJ
c2MuZ2ZwX21hc2sgPSBnZnBfbWFzazsKIAlzYy5tYXlfd3JpdGVwYWdlID0g
MDsKKwlzYy5ucl90b19yZWNsYWltID0gU1dBUF9DTFVTVEVSX01BWDsKIAog
CWluY19wYWdlX3N0YXRlKGFsbG9jc3RhbGwpOwogCkBAIC05MTcsMTIgKzky
OCwxMiBAQAogCQkJc2MubnJfcmVjbGFpbWVkICs9IHJlY2xhaW1fc3RhdGUt
PnJlY2xhaW1lZF9zbGFiOwogCQkJcmVjbGFpbV9zdGF0ZS0+cmVjbGFpbWVk
X3NsYWIgPSAwOwogCQl9Ci0JCWlmIChzYy5ucl9yZWNsYWltZWQgPj0gU1dB
UF9DTFVTVEVSX01BWCkgeworCQl0b3RhbF9zY2FubmVkICs9IHNjLm5yX3Nj
YW5uZWQ7CisJCXRvdGFsX3JlY2xhaW1lZCArPSBzYy5ucl9yZWNsYWltZWQ7
CisJCWlmICh0b3RhbF9yZWNsYWltZWQgPj0gU1dBUF9DTFVTVEVSX01BWCkg
ewogCQkJcmV0ID0gMTsKIAkJCWdvdG8gb3V0OwogCQl9Ci0JCXRvdGFsX3Nj
YW5uZWQgKz0gc2MubnJfc2Nhbm5lZDsKLQkJdG90YWxfcmVjbGFpbWVkICs9
IHNjLm5yX3JlY2xhaW1lZDsKIAogCQkvKgogCQkgKiBUcnkgdG8gd3JpdGUg
YmFjayBhcyBtYW55IHBhZ2VzIGFzIHdlIGp1c3Qgc2Nhbm5lZC4gIFRoaXMK
QEAgLTEwMzksNyArMTA1MCwxMSBAQAogCQkJaWYgKG5yX3BhZ2VzID09IDAp
IHsJLyogTm90IHNvZnR3YXJlIHN1c3BlbmQgKi8KIAkJCQlpZiAoem9uZS0+
ZnJlZV9wYWdlcyA8PSB6b25lLT5wYWdlc19oaWdoKQogCQkJCQlhbGxfem9u
ZXNfb2sgPSAwOwotCQkJfQorCQkJCXNjLm5yX3RvX3JlY2xhaW0gPSB6b25l
LT5wYWdlc19oaWdoIC0gem9uZS0+ZnJlZV9wYWdlczsKKwkJCQlpZiAoc2Mu
bnJfdG9fcmVjbGFpbSA8IFNXQVBfQ0xVU1RFUl9NQVgpCisJCQkJCXNjLm5y
X3RvX3JlY2xhaW0gPSBTV0FQX0NMVVNURVJfTUFYOworCQkJfSBlbHNlCisJ
CQkJc2MubnJfdG9fcmVjbGFpbSA9IG5yX3BhZ2VzOwogCQkJem9uZS0+dGVt
cF9wcmlvcml0eSA9IHByaW9yaXR5OwogCQkJaWYgKHpvbmUtPnByZXZfcHJp
b3JpdHkgPiBwcmlvcml0eSkKIAkJCQl6b25lLT5wcmV2X3ByaW9yaXR5ID0g
cHJpb3JpdHk7Cg==

--0-1713367119-1089609436=:91377--
