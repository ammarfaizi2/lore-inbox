Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265736AbTBBXXE>; Sun, 2 Feb 2003 18:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265777AbTBBXXE>; Sun, 2 Feb 2003 18:23:04 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:45718 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S265736AbTBBXXB>; Sun, 2 Feb 2003 18:23:01 -0500
Date: Mon, 3 Feb 2003 00:32:30 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: 2.4, 2.5: SMP race: __sync_single_inode vs. __mark_inode_dirty
Message-ID: <Pine.LNX.4.44.0302022203560.1545-300000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1908636959-940758646-1044226109=:7269"
Content-ID: <Pine.LNX.4.44.0302030013300.16153@artax.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1908636959-940758646-1044226109=:7269
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44.0302030013301.16153@artax.karlin.mff.cuni.cz>

Hi.

there's a SMP race condition between __sync_single_inode (or __sync_one on
2.4.20) and __mark_inode_dirty. __mark_inode_dirty doesn't take inode
spinlock. As we know -- unless you take a spinlock or use barrier,
processor can change order of instructions.

CPU 1

modify inode
(but modifications are in cpu-local
buffer and do not go to bus)

calls
__mark_inode_dirty
it sees I_DIRTY and exits immediatelly
					CPU 2
					takes spinlock
					calls __sync_single_inode
					inode->i_state &= ~I_DIRTY
					writes the inode (but does not see
					modifications by CPU 1 yet)

CPU 1 flushes its write buffer to the bus
inode is already written, clean, modifications
done by CPU1 are lost

The easiest fix would be to move the test inside spinlock in
__mark_inode_dirty; if you do not want to suffer from performance loss,
use the attached patches that use memory barriers to ensure ordering of
reads and writes.

Mikulas




--1908636959-940758646-1044226109=:7269
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME=PATCH-SMP-RACE-2-4
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0302030016210.16153@artax.karlin.mff.cuni.cz>
Content-Description: 2.4 patch
Content-Disposition: ATTACHMENT; FILENAME=PATCH-SMP-RACE-2-4

LS0tIGxpbnV4L2ZzL2lub2RlLmNfCVNhdCBBdWcgIDMgMDE6Mzk6NDQgMjAw
Mg0KKysrIGxpbnV4L2ZzL2lub2RlLmMJU3VuIEZlYiAgMiAyMzoyMTo0MCAy
MDAzDQpAQCAtMTQ3LDYgKzE0NywxMCBAQA0KIAkJCXNiLT5zX29wLT5kaXJ0
eV9pbm9kZShpbm9kZSk7DQogCX0NCiANCisJLyogbWFrZSBzdXJlIHRoYXQg
Y2hhbmdlcyBhcmUgc2VlbiBieSBhbGwgY3B1cyBiZWZvcmUgd2UgdGVzdCBp
X3N0YXRlDQorCQktLSBtaWt1bGFzICovDQorCXNtcF9tYigpOw0KKw0KIAkv
KiBhdm9pZCB0aGUgbG9ja2luZyBpZiB3ZSBjYW4gKi8NCiAJaWYgKChpbm9k
ZS0+aV9zdGF0ZSAmIGZsYWdzKSA9PSBmbGFncykNCiAJCXJldHVybjsNCkBA
IC0yMTksNiArMjIzLDExIEBADQogCWRpcnR5ID0gaW5vZGUtPmlfc3RhdGUg
JiBJX0RJUlRZOw0KIAlpbm9kZS0+aV9zdGF0ZSB8PSBJX0xPQ0s7DQogCWlu
b2RlLT5pX3N0YXRlICY9IH5JX0RJUlRZOw0KKw0KKwlzbXBfcm1iKCk7IC8q
IG1hcmtfaW5vZGVfZGlydHkgZG9lc24ndCB0YWtlIHNwaW5sb2NrLCBtYWtl
IHN1cmUNCisJCXRoYXQgaW5vZGUgaXMgbm90IHJlYWQgc3BlY3VsYXRpdmVs
eSBieSB0aGlzIGNwdQ0KKwkJYmVmb3JlICY9IH5JX0RJUlRZICAtLSBtaWt1
bGFzICovDQorDQogCXNwaW5fdW5sb2NrKCZpbm9kZV9sb2NrKTsNCiANCiAJ
ZmlsZW1hcF9mZGF0YXN5bmMoaW5vZGUtPmlfbWFwcGluZyk7DQo=
--1908636959-940758646-1044226109=:7269
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME=PATCH-SMP-RACE-2-5
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0302030016211.16153@artax.karlin.mff.cuni.cz>
Content-Description: 2.5 patch
Content-Disposition: ATTACHMENT; FILENAME=PATCH-SMP-RACE-2-5

LS0tIGxpbnV4L2ZzL2ZzLXdyaXRlYmFjay5jXwlGcmkgSmFuIDE3IDAzOjIz
OjAwIDIwMDMNCisrKyBsaW51eC9mcy9mcy13cml0ZWJhY2suYwlTdW4gRmVi
ICAyIDIzOjIyOjAwIDIwMDMNCkBAIC02MSw2ICs2MSwxMCBAQA0KIAkJCXNi
LT5zX29wLT5kaXJ0eV9pbm9kZShpbm9kZSk7DQogCX0NCiANCisJLyogbWFr
ZSBzdXJlIHRoYXQgY2hhbmdlcyBhcmUgc2VlbiBieSBhbGwgY3B1cyBiZWZv
cmUgd2UgdGVzdCBpX3N0YXRlDQorCQktLSBtaWt1bGFzICovDQorCXNtcF9t
YigpOw0KKw0KIAkvKiBhdm9pZCB0aGUgbG9ja2luZyBpZiB3ZSBjYW4gKi8N
CiAJaWYgKChpbm9kZS0+aV9zdGF0ZSAmIGZsYWdzKSA9PSBmbGFncykNCiAJ
CXJldHVybjsNCkBAIC0xMzUsNiArMTM5LDExIEBADQogCWRpcnR5ID0gaW5v
ZGUtPmlfc3RhdGUgJiBJX0RJUlRZOw0KIAlpbm9kZS0+aV9zdGF0ZSB8PSBJ
X0xPQ0s7DQogCWlub2RlLT5pX3N0YXRlICY9IH5JX0RJUlRZOw0KKw0KKwkv
KiBzbXBfcm1iKCk7IG5vdGU6IGlmIHlvdSByZW1vdmUgd3JpdGVfbG9jayBi
ZWxvdywgeW91IG11c3QgYWRkIHRoaXMuDQorCQltYXJrX2lub2RlX2RpcnR5
IGRvZXNuJ3QgdGFrZSBzcGlubG9jaywgbWFrZSBzdXJlDQorCQl0aGF0IGlu
b2RlIGlzIG5vdCByZWFkIHNwZWN1bGF0aXZlbHkgYnkgdGhpcyBjcHUNCisJ
CWJlZm9yZSAmPSB+SV9ESVJUWSAgLS0gbWlrdWxhcyAqLw0KIA0KIAl3cml0
ZV9sb2NrKCZtYXBwaW5nLT5wYWdlX2xvY2spOw0KIAlpZiAod2FpdCB8fCAh
d2JjLT5mb3Jfa3VwZGF0ZSB8fCBsaXN0X2VtcHR5KCZtYXBwaW5nLT5pb19w
YWdlcykpDQo=
--1908636959-940758646-1044226109=:7269--
