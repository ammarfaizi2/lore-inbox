Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbTLUJmg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 04:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbTLUJmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 04:42:36 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:4507 "EHLO
	myware.akkadia.org") by vger.kernel.org with ESMTP id S262427AbTLUJmd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 04:42:33 -0500
Message-ID: <3FE56A97.3060901@redhat.com>
Date: Sun, 21 Dec 2003 01:40:39 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031216
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
CC: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] O_DIRECTORY|O_CREAT handling
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030605030707080304030809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030605030707080304030809
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The kernel currently handles open() calls with flags having at least
O_DIRECTORY|O_CREAT set strangely (to say the least).  It creates a
regular file, completely ignoring the O_DIRECTORY bit.  One can argue
that open() does not perform any real checking on the parameters and
that it is the programmers responsibility, but there is a twist.

Some programs create temporary directory which they afterward use as the
working directory or changed root.  I.e., we have code like this:

  mkdir ("/some/dirRANDOM");
  chdir ("/some/dirRANDOM");

or

  mkdir ("/some/dirRANDOM");
  fd = open ("/some/dirRANDOM", O_DIRECTORY);
  fchdir (fd);

or

  mkdir ("/some/dirRANDOM");
  chroot ("/some/dirRANDOM");

All these pieces of code have an obvious flaw, a race.  There is no
atomic way to do what we want.

Now combine these two problems.  How about making this work?

  fd = open ("/some/dirRANDOM", O_RDONLY|O_CREAT|O_DIRECTORY|O_EXCL, 0700);
  fchdir (fd);

(and similarly for a new interface fchroot which I can add to glibc).

I've attached a little patch which does just that.  Some comments on the
code:

 ~ if an existing directory is opened with O_RDWR open() returns
- -EISDIR.  I've mimicked this, allthough the error code might not be the
most obvious.

 ~ O_TRUNC is not allowed.


The small attached patch implements this proposal.  At least it does
what I want it to do, no idea what bugs I introduce.

- --
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/5WqW2ijCOnn/RHQRAjZEAJ9SxzM1O6B/hQZN5jabqSSzXXtZwQCdH2sd
hRr+ejRNAU4Cl9V8MXpBIYo=
=jXqY
-----END PGP SIGNATURE-----

--------------030605030707080304030809
Content-Type: text/plain;
 name="d-opendir"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="d-opendir"

LS0tIGxpbnV4LTIuNi9mcy9uYW1laS5jLW9wZW5kaXIJMjAwMy0xMi0yMCAyMTozMjo1MC4w
MDAwMDAwMDAgLTA4MDAKKysrIGxpbnV4LTIuNi9mcy9uYW1laS5jCTIwMDMtMTItMjEgMDE6
Mzc6MDkuMDAwMDAwMDAwIC0wODAwCkBAIC0xMjk1LDcgKzEyOTUsMTIgQEAKIAlpZiAoIWRl
bnRyeS0+ZF9pbm9kZSkgewogCQlpZiAoIUlTX1BPU0lYQUNMKGRpci0+ZF9pbm9kZSkpCiAJ
CQltb2RlICY9IH5jdXJyZW50LT5mcy0+dW1hc2s7Ci0JCWVycm9yID0gdmZzX2NyZWF0ZShk
aXItPmRfaW5vZGUsIGRlbnRyeSwgbW9kZSwgbmQpOworCQlpZiAodW5saWtlbHkoZmxhZyAm
IE9fRElSRUNUT1JZKSkgeworCQkJZXJyb3IgPSAtRUlTRElSOworCQkJaWYgKCEoZmxhZyAm
IEZNT0RFX1dSSVRFKSkKKwkJCQllcnJvciA9IHZmc19ta2RpcihkaXItPmRfaW5vZGUsIGRl
bnRyeSwgbW9kZSk7CisJCX0gZWxzZQorCQkJZXJyb3IgPSB2ZnNfY3JlYXRlKGRpci0+ZF9p
bm9kZSwgZGVudHJ5LCBtb2RlLCBuZCk7CiAJCXVwKCZkaXItPmRfaW5vZGUtPmlfc2VtKTsK
IAkJZHB1dChuZC0+ZGVudHJ5KTsKIAkJbmQtPmRlbnRyeSA9IGRlbnRyeTsKQEAgLTEzMzEs
NyArMTMzNiwxMSBAQAogCWRwdXQobmQtPmRlbnRyeSk7CiAJbmQtPmRlbnRyeSA9IGRlbnRy
eTsKIAllcnJvciA9IC1FSVNESVI7Ci0JaWYgKGRlbnRyeS0+ZF9pbm9kZSAmJiBTX0lTRElS
KGRlbnRyeS0+ZF9pbm9kZS0+aV9tb2RlKSkKKwkvKiBTaW5jZSB3ZSBhbGxvdyBjcmVhdGlu
ZyBkaXJlY3RvcmllcyB3aXRoIG9wZW4oMikgd2UgZm9yYmlkCisJICAgb3BlbmluZyBhbiBl
eGlzdGluZyBkaXJlY3Rvcnkgd2l0aCBPX0NSRUFUIG9ubHkgaWYgdGhlCisJICAgT19ESVJF
Q1RPUlkgZmxhZyBpcyBub3Qgc2V0IG9yIGlmIHRydW5jYXRpb24gaXMgcmVxdWVzdGVkLiAg
Ki8KKwlpZiAoZGVudHJ5LT5kX2lub2RlICYmIFNfSVNESVIoZGVudHJ5LT5kX2lub2RlLT5p
X21vZGUpICYmCisJICAgICghKGZsYWcgJiBPX0RJUkVDVE9SWSkgfHwgKGZsYWcgJiBPX1RS
VU5DKSkpCiAJCWdvdG8gZXhpdDsKIG9rOgogCWVycm9yID0gbWF5X29wZW4obmQsIGFjY19t
b2RlLCBmbGFnKTsK
--------------030605030707080304030809--
