Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314755AbSEPVmr>; Thu, 16 May 2002 17:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314787AbSEPVmq>; Thu, 16 May 2002 17:42:46 -0400
Received: from netmail.netcologne.de ([194.8.194.109]:24163 "EHLO
	netmail.netcologne.de") by vger.kernel.org with ESMTP
	id <S314755AbSEPVmo>; Thu, 16 May 2002 17:42:44 -0400
Message-Id: <200205162142.AWF00051@netmail.netcologne.de>
From: =?iso-8859-15?q?J=F6rg=20Prante?= <joergprante@gmx.de>
Reply-To: joergprante@gmx.de
Organization: Linux jungle 2.4.19-pre8 #4 Don Mai 9 23:37:47 CEST 2002 i686 unknown
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4.19pre8][RFC] remove-NFS-close-to-open from VFS (was Re: [PATCHSET] 2.4.19-pre8-jp12)
Date: Thu, 16 May 2002 23:40:19 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.44.0205161105520.5254-100000@alumno.inacap.cl>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_77484I023L9KXOH11AYC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_77484I023L9KXOH11AYC
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit


Hi!

Robinson Maureira Castillo <rmaureira@alumno.inacap.cl> wrote:
> On Thu, 16 May 2002, Tomas Szepe wrote:
> > > But the worst problem for is supermount:
> > > # mount -t supermount -o dev=/dev/cdrom none /mnt/cdrom
> > > # ls -l /mnt/cdrom
> > > ls: .: Stale NFS handle                (~or something similar)
> > > [...]                                  (and it lists the file)
> >
> > Hmmm.. I've been seeing this problem in the latest -ac kernels too.
> >
> > Basically, a while after mounting the CD a ls on any subdir of the
> > mount will complain about a 'stale NFS handle' and the device has
> > to be remounted.
> >
> > T.
>
> I'm getting the same with ftpfs, both in jp11 and jp12. Remounting doesn't
> change a thing, it just shows me the root tree, I can cd into directories
> if I know the name, but all I got is those nice 'stale NFS handle' as a
> response from ls

I traced it down. The trouble exists since 2.4.19-pre4. Trond Myklebust 
touched the VFS in order to send dentry revalidation events to NFS. 

http://www.geocrawler.com/archives/3/789/2002/3/100/8078826/

But Trond's patch conflicts with almost all non-standard virtual or remote 
mount file systems (supermount, cdfs, ftpfs, and maybe autofs). I don't know 
if the cdfs oops I observed now for a while is related.

Is it possible to leave the VFS layer untouched? Or restrict the dentry 
revalidation to NFS and let other remote file systems coexist, i.e. without 
revalidation calls? 

Or is it recommended to write fixes for the file systems stated above, 
because they now have wrong assumptions about the VFS behavior? 

Anyway, while these questions arise, I request to remove Trond's patch since 
the patch changes too much for 2.4 stable kernel series.

Attached is a revert patch against 2.4.19-pre8 for Marcelo.

Thanks 

Jörg

--------------Boundary-00=_77484I023L9KXOH11AYC
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="remove-NFS-close-to-open.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="remove-NFS-close-to-open.patch"

ZGlmZiAtdXJOIGxpbnV4LTIuNC4xOS1wcmUzL2ZzL25hbWVpLmMgbGludXgtL2ZzL25hbWVpLmMK
LS0tIGxpbnV4LTIuNC4xOS1wcmUzL2ZzL25hbWVpLmMJV2VkIE1hciAyMCAxNDowMzo1MCAyMDAy
CisrKyBsaW51eC9mcy9uYW1laS5jCVdlZCBNYXIgMjAgMTQ6MDQ6NDAgMjAwMgpAQCAtNDU3LDcg
KzQ1Nyw3IEBACiAJd2hpbGUgKCpuYW1lPT0nLycpCiAJCW5hbWUrKzsKIAlpZiAoISpuYW1lKQor
CQlnb3RvIHJldHVybl9iYXNlOwotCQlnb3RvIHJldHVybl9yZXZhbDsKIAogCWlub2RlID0gbmQt
PmRlbnRyeS0+ZF9pbm9kZTsKIAlpZiAoY3VycmVudC0+bGlua19jb3VudCkKQEAgLTU3Niw3ICs1
NzYsNyBAQAogCQkJCWlub2RlID0gbmQtPmRlbnRyeS0+ZF9pbm9kZTsKIAkJCQkvKiBmYWxsdGhy
b3VnaCAqLwogCQkJY2FzZSAxOgorCQkJCWdvdG8gcmV0dXJuX2Jhc2U7Ci0JCQkJZ290byByZXR1
cm5fcmV2YWw7CiAJCX0KIAkJaWYgKG5kLT5kZW50cnktPmRfb3AgJiYgbmQtPmRlbnRyeS0+ZF9v
cC0+ZF9oYXNoKSB7CiAJCQllcnIgPSBuZC0+ZGVudHJ5LT5kX29wLT5kX2hhc2gobmQtPmRlbnRy
eSwgJnRoaXMpOwpAQCAtNjI3LDE5ICs2MjcsNiBAQAogCQkJbmQtPmxhc3RfdHlwZSA9IExBU1Rf
RE9UOwogCQllbHNlIGlmICh0aGlzLmxlbiA9PSAyICYmIHRoaXMubmFtZVsxXSA9PSAnLicpCiAJ
CQluZC0+bGFzdF90eXBlID0gTEFTVF9ET1RET1Q7Ci1yZXR1cm5fcmV2YWw6Ci0JCS8qCi0JCSAq
IFdlIGJ5cGFzc2VkIHRoZSBvcmRpbmFyeSByZXZhbGlkYXRpb24gcm91dGluZXMuCi0JCSAqIENo
ZWNrIHRoZSBjYWNoZWQgZGVudHJ5IGZvciBzdGFsZW5lc3MuCi0JCSAqLwotCQlkZW50cnkgPSBu
ZC0+ZGVudHJ5OwotCQlpZiAoZGVudHJ5ICYmIGRlbnRyeS0+ZF9vcCAmJiBkZW50cnktPmRfb3At
PmRfcmV2YWxpZGF0ZSkgewotCQkJZXJyID0gLUVTVEFMRTsKLQkJCWlmICghZGVudHJ5LT5kX29w
LT5kX3JldmFsaWRhdGUoZGVudHJ5LCAwKSkgewotCQkJCWRfaW52YWxpZGF0ZShkZW50cnkpOwot
CQkJCWJyZWFrOwotCQkJfQotCQl9CiByZXR1cm5fYmFzZToKIAkJcmV0dXJuIDA7CiBvdXRfZHB1
dDoK

--------------Boundary-00=_77484I023L9KXOH11AYC--
