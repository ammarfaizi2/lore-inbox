Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268596AbRHCKrJ>; Fri, 3 Aug 2001 06:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268640AbRHCKqu>; Fri, 3 Aug 2001 06:46:50 -0400
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:1635 "EHLO
	alloc.wat.veritas.com") by vger.kernel.org with ESMTP
	id <S268596AbRHCKql>; Fri, 3 Aug 2001 06:46:41 -0400
Date: Fri, 3 Aug 2001 11:48:01 +0100 (BST)
From: Mark Hemment <markhe@veritas.com>
X-X-Sender: <markhe@alloc.wat.veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: booting SMP P6 kernel on P4 hangs.
In-Reply-To: <200107311757.f6VHvWH01678@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0108031140410.26125-200000@alloc.wat.veritas.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="168461241-1288155529-996835379=:26125"
Content-ID: <Pine.LNX.4.33.0108031143210.26125@alloc.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--168461241-1288155529-996835379=:26125
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.33.0108031143211.26125@alloc.wat.veritas.com>

Hi,

On Tue, 31 Jul 2001, Linus Torvalds wrote:
> In article <Pine.LNX.4.21.0107310705580.1374-100000@penguin.homenet> you write:
> >
> >Isn't SMP P6 kernel supposed to boot fine on a P4? Btw, booting with
> >"nosmp" works but booting with "noapic" hangs just the same.
>
> It should boot, and it looks like the problem may be a bad MP table.


  The problem is the MP table contains no configuration blocks, and a zero
local APIC address.  I've attached the full boot messages.

  The work around is trap that there are no config blocks, and fall back
to UP.  Patch attached.

Mark



diff -ur -X dontdiff linux-2.4.7/arch/i386/kernel/apic.c p4-2.4.7/arch/i386/kernel/apic.c
--- linux-2.4.7/arch/i386/kernel/apic.c	Wed Jun 20 18:06:38 2001
+++ p4-2.4.7/arch/i386/kernel/apic.c	Fri Aug  3 11:10:55 2001
@@ -345,9 +345,8 @@
 {
 	unsigned long apic_phys;

-	if (smp_found_config) {
-		apic_phys = mp_lapic_addr;
-	} else {
+	apic_phys = mp_lapic_addr;
+	if (!apic_phys) {
 		/*
 		 * set up a fake all zeroes page to simulate the
 		 * local APIC and another one for the IO-APIC. We
diff -ur -X dontdiff linux-2.4.7/arch/i386/kernel/mpparse.c p4-2.4.7/arch/i386/kernel/mpparse.c
--- linux-2.4.7/arch/i386/kernel/mpparse.c	Tue Jun 12 02:15:27 2001
+++ p4-2.4.7/arch/i386/kernel/mpparse.c	Fri Aug  3 11:04:18 2001
@@ -306,6 +306,23 @@
 	mp_lapic_addr = mpc->mpc_lapic;

 	/*
+	 * Buggy BIOS work around.
+	 * Some BIOSes report an MP table, with correct signature, checksum,
+	 * etc, but with no configuration blocks.
+	 * In this case fall back to UP.
+	 *
+	 * Note: On a system which showed this problem, the local APIC
+	 * address was given as NULL.  This may not be the case for all
+	 * systems, so take the address (incase it is valid) and check it
+	 * init_apic_mappings().
+	 */
+	if (count >= mpc->mpc_length) {
+		printk("Short mptable - assuming UP system\n");
+		smp_found_config = 0;
+		return 1;
+	}
+
+	/*
 	 *	Now process the configuration blocks.
 	 */
 	while (count < mpc->mpc_length) {

--168461241-1288155529-996835379=:26125
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME=bootmsg
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0108031142590.26125@alloc.wat.veritas.com>
Content-Description: bootmsg
Content-Disposition: ATTACHMENT; FILENAME=bootmsg

TGludXggdmVyc2lvbiAyLjQuNy1WeE9TIChyb290QGVpbnN0ZWluKSAoZ2Nj
IHZlcnNpb24gZWdjcy0yLjkxLjY2DQoxOTk5MDMxNC9MaW4NCnggKGVnY3Mt
MS4xLjIgcmVsZWFzZSkpICMxIFNNUCBTdW4gSnVsIDI5IDE3OjA3OjUwIEJT
VCAyMDAxDQpCSU9TLXByb3ZpZGVkIHBoeXNpY2FsIFJBTSBtYXA6DQogQklP
Uy1lODIwOiAwMDAwMDAwMDAwMDAwMDAwIC0gMDAwMDAwMDAwMDBhMDAwMCAo
dXNhYmxlKQ0KIEJJT1MtZTgyMDogMDAwMDAwMDAwMDBmMDAwMCAtIDAwMDAw
MDAwMDAxMDAwMDAgKHJlc2VydmVkKQ0KIEJJT1MtZTgyMDogMDAwMDAwMDAw
MDEwMDAwMCAtIDAwMDAwMDAwMGZmODcwMDAgKHVzYWJsZSkNCiBCSU9TLWU4
MjA6IDAwMDAwMDAwMGZmODcwMDAgLSAwMDAwMDAwMDBmZmE2MDAwIChBQ1BJ
IGRhdGEpDQogQklPUy1lODIwOiAwMDAwMDAwMDBmZmE2MDAwIC0gMDAwMDAw
MDAxMDAwMDAwMCAocmVzZXJ2ZWQpDQogQklPUy1lODIwOiAwMDAwMDAwMGZl
YzAwMDAwIC0gMDAwMDAwMDBmZWMxMDAwMCAocmVzZXJ2ZWQpDQogQklPUy1l
ODIwOiAwMDAwMDAwMGZlZTAwMDAwIC0gMDAwMDAwMDBmZWUxMDAwMCAocmVz
ZXJ2ZWQpDQogQklPUy1lODIwOiAwMDAwMDAwMGZmYjAwMDAwIC0gMDAwMDAw
MDEwMDAwMDAwMCAocmVzZXJ2ZWQpDQpTY2FuIFNNUCBmcm9tIDQwMDAwMDAw
IGZvciAxMDI0IGJ5dGVzLg0KU2NhbiBTTVAgZnJvbSA0MDA5ZmMwMCBmb3Ig
MTAyNCBieXRlcy4NClNjYW4gU01QIGZyb20gNDAwZjAwMDAgZm9yIDY1NTM2
IGJ5dGVzLg0KZm91bmQgU01QIE1QLXRhYmxlIGF0IDAwMGZlNzEwDQpobSwg
cGFnZSAwMDBmZTAwMCByZXNlcnZlZCB0d2ljZS4NCmhtLCBwYWdlIDAwMGZm
MDAwIHJlc2VydmVkIHR3aWNlLg0KaG0sIHBhZ2UgMDAwZjAwMDAgcmVzZXJ2
ZWQgdHdpY2UuDQpPbiBub2RlIDAgdG90YWxwYWdlczogNjU0MTUNCnpvbmUo
MCk6IDQwOTYgcGFnZXMuDQp6b25lKDEpOiA2MTMxOSBwYWdlcy4NCnpvbmUo
Mik6IDAgcGFnZXMuDQpJbnRlbCBNdWx0aVByb2Nlc3NvciBTcGVjaWZpY2F0
aW9uIHYxLjQNCiAgICBJTUNSIGFuZCBQSUMgY29tcGF0aWJpbGl0eSBtb2Rl
Lg0KT0VNIElEOiBERUxMICAgICBQcm9kdWN0IElEOiBXUyAzMzAgICAgICAg
QVBJQyBhdDogMHgwDQpCSU9TIGJ1Zywgbm8gZXhwbGljaXQgSVJRIGVudHJp
ZXMsIHVzaW5nIGRlZmF1bHQgbXB0YWJsZS4gKHRlbGwgeW91ciBodw0KdmVu
ZG9yKQ0KQnVzICMwIGlzIElTQQ0KSW50OiB0eXBlIDAsIHBvbCAwLCB0cmln
IDAsIGJ1cyAwLCBJUlEgMDAsIEFQSUMgSUQgMCwgQVBJQyBJTlQgMDINCklu
dDogdHlwZSAwLCBwb2wgMCwgdHJpZyAwLCBidXMgMCwgSVJRIDAxLCBBUElD
IElEIDAsIEFQSUMgSU5UIDAxDQpJbnQ6IHR5cGUgMCwgcG9sIDAsIHRyaWcg
MCwgYnVzIDAsIElSUSAwMywgQVBJQyBJRCAwLCBBUElDIElOVCAwMw0KSW50
OiB0eXBlIDAsIHBvbCAwLCB0cmlnIDAsIGJ1cyAwLCBJUlEgMDQsIEFQSUMg
SUQgMCwgQVBJQyBJTlQgMDQNCkludDogdHlwZSAwLCBwb2wgMCwgdHJpZyAw
LCBidXMgMCwgSVJRIDA1LCBBUElDIElEIDAsIEFQSUMgSU5UIDA1DQpJbnQ6
IHR5cGUgMCwgcG9sIDAsIHRyaWcgMCwgYnVzIDAsIElSUSAwNiwgQVBJQyBJ
RCAwLCBBUElDIElOVCAwNg0KSW50OiB0eXBlIDAsIHBvbCAwLCB0cmlnIDAs
IGJ1cyAwLCBJUlEgMDcsIEFQSUMgSUQgMCwgQVBJQyBJTlQgMDcNCkludDog
dHlwZSAwLCBwb2wgMCwgdHJpZyAwLCBidXMgMCwgSVJRIDA4LCBBUElDIElE
IDAsIEFQSUMgSU5UIDA4DQpJbnQ6IHR5cGUgMCwgcG9sIDAsIHRyaWcgMCwg
YnVzIDAsIElSUSAwOSwgQVBJQyBJRCAwLCBBUElDIElOVCAwOQ0KSW50OiB0
eXBlIDAsIHBvbCAwLCB0cmlnIDAsIGJ1cyAwLCBJUlEgMGEsIEFQSUMgSUQg
MCwgQVBJQyBJTlQgMGENCkludDogdHlwZSAwLCBwb2wgMCwgdHJpZyAwLCBi
dXMgMCwgSVJRIDBiLCBBUElDIElEIDAsIEFQSUMgSU5UIDBiDQpJbnQ6IHR5
cGUgMCwgcG9sIDAsIHRyaWcgMCwgYnVzIDAsIElSUSAwYywgQVBJQyBJRCAw
LCBBUElDIElOVCAwYw0KSW50OiB0eXBlIDAsIHBvbCAwLCB0cmlnIDAsIGJ1
cyAwLCBJUlEgMGQsIEFQSUMgSUQgMCwgQVBJQyBJTlQgMGQNCkludDogdHlw
ZSAwLCBwb2wgMCwgdHJpZyAwLCBidXMgMCwgSVJRIDBlLCBBUElDIElEIDAs
IEFQSUMgSU5UIDBlDQpJbnQ6IHR5cGUgMCwgcG9sIDAsIHRyaWcgMCwgYnVz
IDAsIElSUSAwZiwgQVBJQyBJRCAwLCBBUElDIElOVCAwZg0KSW50OiB0eXBl
IDMsIHBvbCAwLCB0cmlnIDAsIGJ1cyAwLCBJUlEgMDAsIEFQSUMgSUQgMCwg
QVBJQyBJTlQgMDANClByb2Nlc3NvcnM6IDANCm1hcHBlZCBBUElDIHRvIGZm
ZmZlMDAwICgwMDAwMDAwMCkNCktlcm5lbCBjb21tYW5kIGxpbmU6IGF1dG8g
Qk9PVF9JTUFHRT1saW51eC1ub3BhZSBybyByb290PTMwNQ0KQk9PVF9GSUxF
PS9ib290L3ZtDQppbnV6LTIuNC43LW5vcGFlIGNvbnNvbGU9dHR5UzAsOTYw
MCBjb25zb2xlPXR0eTANCkluaXRpYWxpemluZyBDUFUjMA0KRGV0ZWN0ZWQg
MTI4NS4zNTkgTUh6IHByb2Nlc3Nvci4NCkNvbnNvbGU6IGNvbG91ciBWR0Er
IDgweDI1DQpDYWxpYnJhdGluZyBkZWxheSBsb29wLi4uIDI1NjIuNDUgQm9n
b01JUFMNCk1lbW9yeTogMjUzNjMyay8yNjE2NjBrIGF2YWlsYWJsZSAoMTQ0
NWsga2VybmVsIGNvZGUsIDc2NDRrIHJlc2VydmVkLCAxMTM5aw0KZGF0DQos
IDM1MmsgaW5pdCwgMGsgaGlnaG1lbSkNCmtkYiB2ZXJzaW9uIDEuOCBieSBT
Y290dCBMdXJuZGFsLCBLZWl0aCBPd2Vucy4gQ29weXJpZ2h0IFNHSSwgQWxs
IFJpZ2h0cw0KUmVzZXJ2DQpkDQpEZW50cnktY2FjaGUgaGFzaCB0YWJsZSBl
bnRyaWVzOiAzMjc2OCAob3JkZXI6IDYsIDI2MjE0NCBieXRlcykNCklub2Rl
LWNhY2hlIGhhc2ggdGFibGUgZW50cmllczogMTYzODQgKG9yZGVyOiA1LCAx
MzEwNzIgYnl0ZXMpDQpNb3VudC1jYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6
IDQwOTYgKG9yZGVyOiAzLCAzMjc2OCBieXRlcykNCkJ1ZmZlci1jYWNoZSBo
YXNoIHRhYmxlIGVudHJpZXM6IDE2Mzg0IChvcmRlcjogNCwgNjU1MzYgYnl0
ZXMpDQpQYWdlLWNhY2hlIGhhc2ggdGFibGUgZW50cmllczogNjU1MzYgKG9y
ZGVyOiA2LCAyNjIxNDQgYnl0ZXMpDQpDUFU6IEwxIEkgY2FjaGU6IDEySywg
TDEgRCBjYWNoZTogOEsNCkNQVTogTDIgY2FjaGU6IDI1NksNCkludGVsIG1h
Y2hpbmUgY2hlY2sgYXJjaGl0ZWN0dXJlIHN1cHBvcnRlZC4NCkludGVsIG1h
Y2hpbmUgY2hlY2sgcmVwb3J0aW5nIGVuYWJsZWQgb24gQ1BVIzAuDQpFbmFi
bGluZyBmYXN0IEZQVSBzYXZlIGFuZCByZXN0b3JlLi4uIGRvbmUuDQpFbmFi
bGluZyB1bm1hc2tlZCBTSU1EIEZQVSBleGNlcHRpb24gc3VwcG9ydC4uLiBk
b25lLg0KQ2hlY2tpbmcgJ2hsdCcgaW5zdHJ1Y3Rpb24uLi4gT0suDQpQT1NJ
WCBjb25mb3JtYW5jZSB0ZXN0aW5nIGJ5IFVOSUZJWA0KbXRycjogdjEuNDAg
KDIwMDEwMzI3KSBSaWNoYXJkIEdvb2NoIChyZ29vY2hAYXRuZi5jc2lyby5h
dSkNCm10cnI6IGRldGVjdGVkIG10cnIgdHlwZTogSW50ZWwNCkNQVTogTDEg
SSBjYWNoZTogMTJLLCBMMSBEIGNhY2hlOiA4Sw0KQ1BVOiBMMiBjYWNoZTog
MjU2Sw0KSW50ZWwgbWFjaGluZSBjaGVjayByZXBvcnRpbmcgZW5hYmxlZCBv
biBDUFUjMC4NCkNQVTA6IEludGVsKFIpIFBlbnRpdW0oUikgNCBDUFUgMTMw
ME1IeiBzdGVwcGluZyAwYQ0KcGVyLUNQVSB0aW1lc2xpY2UgY3V0b2ZmOiA3
MzEuNDkgdXNlY3MuDQp3ZWlyZCwgYm9vdCBDUFUgKCMwKSBub3QgbGlzdGVk
IGJ5IHRoZSBCSU9TLg0KR2V0dGluZyBWRVJTSU9OOiBmMDAwYWNkZQ0KR2V0
dGluZyBWRVJTSU9OOiBmMGZmYWMyMQ0KbGVhdmluZyBQSUMgbW9kZSwgZW5h
Ymxpbmcgc3ltbWV0cmljIElPIG1vZGUuDQplbmFibGVkIEV4dElOVCBvbiBD
UFUjMA0KRVNSIHZhbHVlIGJlZm9yZSBlbmFibGluZyB2ZWN0b3I6IDAwMDAw
MDAwDQpFU1IgdmFsdWUgYWZ0ZXIgZW5hYmxpbmcgdmVjdG9yOiAwMDAwMDAw
MA0KQ1BVIHByZXNlbnQgbWFwOiAxDQpCZWZvcmUgYm9nb21pcHMuDQpFcnJv
cjogb25seSBvbmUgcHJvY2Vzc29yIGZvdW5kLg0KQm9vdCBkb25lLg0KRU5B
QkxJTkcgSU8tQVBJQyBJUlFzDQpTeW5jaHJvbml6aW5nIEFyYiBJRHMuDQou
LlRJTUVSOiB2ZWN0b3I9MzEgcGluMT0yIHBpbjI9MA0KYWN0aXZhdGluZyBO
TUkgV2F0Y2hkb2cgLi4uIGRvbmUuDQpDUFUjMCBOTUkgYXBwZWFycyB0byBi
ZSBzdHVjay4NCnRlc3RpbmcgdGhlIElPIEFQSUMuLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLg0KLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
IGRvbmUuDQpjYWxpYnJhdGluZyBBUElDIHRpbWVyIC4uLg0KLi4uLi4gQ1BV
IGNsb2NrIHNwZWVkIGlzIDEyODUuMzY2NyBNSHouDQouLi4uLiBob3N0IGJ1
cyBjbG9jayBzcGVlZCBpcyAwLjAwMDAgTUh6Lg0KY3B1OiAwLCBjbG9ja3M6
IDAsIHNsaWNlOiAwDQo=
--168461241-1288155529-996835379=:26125--
