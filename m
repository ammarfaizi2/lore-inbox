Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132517AbRDDXBP>; Wed, 4 Apr 2001 19:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132518AbRDDXBF>; Wed, 4 Apr 2001 19:01:05 -0400
Received: from fungus.teststation.com ([212.32.186.211]:52400 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S132517AbRDDXA6>; Wed, 4 Apr 2001 19:00:58 -0400
Date: Thu, 5 Apr 2001 01:00:15 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
To: Xuan Baldauf <xuan--lkml@baldauf.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] smbfs: caching problems
In-Reply-To: <3AC68228.E9D8161B@baldauf.org>
Message-ID: <Pine.LNX.4.30.0104050032430.16277-200000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463780587-1583793787-986424796=:16277"
Content-ID: <Pine.LNX.4.30.0104050053290.16277@cola.teststation.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463780587-1583793787-986424796=:16277
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.30.0104050053291.16277@cola.teststation.com>

On Sun, 1 Apr 2001, Xuan Baldauf wrote:

> there is something wrong with smbfs caching which makes my
> applications fail. The behaviour happens with
> linux-2.4.3-pre4 and linux-2.4.3-final.
> 
> Consider following shell script: (where /mnt/n is a
> smbmounted smb share from a Win98SE box)

Try the attached patch, as a workaround.

Not really sure what is happening, but it seems like win98se isn't
updating the filesize immediately (?).

After truncating the file to 0 bytes the server still returns the old size
(516) when asked (smb_proc_getattr). Somewhere that causes something to
keep the pages for the file (smb_revalidate?) or simply be confused on the
length of the file (508).

I don't understand how as vmtruncate should have thrown out the old stuff
already ... maybe the same page is reused and the last bytes (that
shouldn't be in the file) remain from the last write.

It works with NT4 and Samba, they both return the expected 0 bytes after
truncating to 0. refresh = 0 will not ask and instead run with the 0 byte
length that vmtruncate has set.

/Urban

---1463780587-1583793787-986424796=:16277
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="smbfs-2.4.3-notify.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0104050053160.16277@cola.teststation.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="smbfs-2.4.3-notify.patch"

ZGlmZiAtdXJOIC1YIGV4Y2x1ZGUgbGludXgtMi40LjMtb3JpZy9mcy9zbWJm
cy9pbm9kZS5jIGxpbnV4LTIuNC4zLXNtYmZzL2ZzL3NtYmZzL2lub2RlLmMN
Ci0tLSBsaW51eC0yLjQuMy1vcmlnL2ZzL3NtYmZzL2lub2RlLmMJU2F0IE1h
ciAzMSAxOToxMTo1MyAyMDAxDQorKysgbGludXgtMi40LjMtc21iZnMvZnMv
c21iZnMvaW5vZGUuYwlUaHUgQXByICA1IDAwOjMyOjA3IDIwMDENCkBAIC0y
MzQsOSArMjM0LDEwIEBADQogCWxhc3Rfc3ogICA9IGlub2RlLT5pX3NpemU7
DQogCWVycm9yID0gc21iX3JlZnJlc2hfaW5vZGUoZGVudHJ5KTsNCiAJaWYg
KGVycm9yIHx8IGlub2RlLT5pX210aW1lICE9IGxhc3RfdGltZSB8fCBpbm9k
ZS0+aV9zaXplICE9IGxhc3Rfc3opIHsNCi0JCVZFUkJPU0UoIiVzLyVzIGNo
YW5nZWQsIG9sZD0lbGQsIG5ldz0lbGRcbiIsDQorCQlWRVJCT1NFKCIlcy8l
cyBjaGFuZ2VkLCBvbGQ9JWxkLCBuZXc9JWxkLCBvc3o9JWxkLCBzej0lbGRc
biIsDQogCQkJREVOVFJZX1BBVEgoZGVudHJ5KSwNCi0JCQkobG9uZykgbGFz
dF90aW1lLCAobG9uZykgaW5vZGUtPmlfbXRpbWUpOw0KKwkJCShsb25nKSBs
YXN0X3RpbWUsIChsb25nKSBpbm9kZS0+aV9tdGltZSwNCisJCQkobG9uZykg
bGFzdF9zeiwgKGxvbmcpIGlub2RlLT5pX3NpemUpOw0KIA0KIAkJaWYgKCFT
X0lTRElSKGlub2RlLT5pX21vZGUpKQ0KIAkJCWludmFsaWRhdGVfaW5vZGVf
cGFnZXMoaW5vZGUpOw0KQEAgLTU1MCw3ICs1NTEsNyBAQA0KIAkJaWYgKGVy
cm9yKQ0KIAkJCWdvdG8gb3V0Ow0KIAkJdm10cnVuY2F0ZShpbm9kZSwgYXR0
ci0+aWFfc2l6ZSk7DQotCQlyZWZyZXNoID0gMTsNCisJCXJlZnJlc2ggPSAw
Ow0KIAl9DQogDQogCS8qDQo=
---1463780587-1583793787-986424796=:16277--
