Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964975AbWDHOrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbWDHOrT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 10:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbWDHOrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 10:47:19 -0400
Received: from wproxy.gmail.com ([64.233.184.228]:64204 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964975AbWDHOrS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 10:47:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=kFDiOxOIgyQ573Yau8A2BgJ7istbKACuRLKHxs32lIrfw8XBd29ivwhydN7SNEYZw6pspdtVx9qEy2cCHtcV6AO+USRloH44he02+51294BealikpGl+lXPop+0kZn6SWk10tt/WbzXqZtEl5j2MdASS/9rBmi+Cmj+NC72oId0=
Message-ID: <5a4c581d0604080747w61464d48k5480391d98b2bc47@mail.gmail.com>
Date: Sat, 8 Apr 2006 16:47:18 +0200
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: 40% IDE performance regression going from FC3 to FC5 with same kernel
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_26770_31599384.1144507638031"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_26770_31599384.1144507638031
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I'll be filing a FC5 performance bug for this but would like an opinion
 from the IDE kernel people just in case this has already been seen...

I just upgraded my home K7-800, 512MB RAM box from FC3 to FC5
 and noticed a disk performance slowdown while copying files around.

System has two 160GB disks, a Samsung SP1604N 2MB cache and
 a Maxtor 6Y160P0 8MB cache; both disks appear to be almost 2x
 slower both on hdparm -t tests (17-19MB/s against 33/35 MB/s) and
 on dd tests, like this:

FC3
[root@donkey tmp]# time dd if=3D/dev/hda of=3D/dev/null skip=3D200 bs=3D102=
4k count=3D200
200+0 records in
200+0 records out

real    0m4.623s
user    0m0.004s
sys     0m1.308s

FC5
[root@donkey tmp]#  time dd if=3D/dev/hda of=3D/dev/null skip=3D200 bs=3D10=
24k count=3D200
200+0 records in
200+0 records out
209715200 bytes (210 MB) copied, 9.67808 seconds, 21.7 MB/s

real    0m9.683s
user    0m0.008s
sys     0m1.400s


The initial tests were my last FC3 self-compiled kernel (2.6.16-rc5-git8)
 vs FC5's 2.6.16-1.2080_FC5 kernel; so just to be sure, I copied over
 from my FC3 partition the 2.6.16-rc5-git8 kernel and its config file,
 and rebuilt it under FC5, with just a few differences for the new USB
 2.0 disk I added to a PCI controller I just put in, namely

[root@donkey linux-2.6.16-rc5-git8]# diff .config
/fc3/usr/src/linux-2.6.16-rc5-git8/.config
4c4
< # Fri Apr  7 03:58:23 2006
---
> # Mon Mar  6 22:49:32 2006
1110,1112c1110
< CONFIG_USB_EHCI_HCD=3Dm
< CONFIG_USB_EHCI_SPLIT_ISO=3Dy
< CONFIG_USB_EHCI_ROOT_HUB_TT=3Dy
---
> # CONFIG_USB_EHCI_HCD is not set
1115c1113
< CONFIG_USB_UHCI_HCD=3Dm
---
> CONFIG_USB_UHCI_HCD=3Dy
1218d1215
< # CONFIG_USB_SISUSBVGA is not set

The result is unexpected - performance delta is still there. Concatenating
 output from hdparm -i /dev/hda and hdparm /dev/hda for the same kernel
 under FC3 and FC5, the only difference is

[root@donkey ~]# diff /tmp/hdparm.out.2616rc2git8-fc5
/tmp/hdparm.out.2616rc2git8
14c14
<  Drive conforms to: (null):  ATA/ATAPI-1 ATA/ATAPI-2 ATA/ATAPI-3
ATA/ATAPI-4 ATA/ATAPI-5 ATA/ATAPI-6 ATA/ATAPI-7
---
>  Drive conforms to: (null):
27c27
<  geometry     =3D 19457/255/63, sectors =3D 312581808, start =3D 0
---
>  geometry     =3D 19457/255/63, sectors =3D 160041885696, start =3D 0

I'll try now and rebuild a 2.6.16-rc5-git8 kernel under FC5 with the
 FC3 GCC and see whether that is responsible for the performance
 drop... of course if anyone has any idea about what's going on, I
 will be happy to try out stuff. Attaching hdparm output from the FC5
 2.6.16-rc5-git8 just to show that there is DMA etc. all configured fine.


Thanks in advance, ciao,

--alessandro

 "Dreamer ? Each one of us is a dreamer. We just push it down deep because
   we are repeatedly told that we are not allowed to dream in real life"
     (Reinhold Ziegler)

------=_Part_26770_31599384.1144507638031
Content-Type: application/octet-stream; name="hdparm.out.2616rc5git8-fc5"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="hdparm.out.2616rc5git8-fc5"
X-Attachment-Id: f_els2b305

Ci9kZXYvaGRhOgoKIE1vZGVsPVNBTVNVTkcgU1AxNjA0TiwgRndSZXY9VE0xMDAtMjQsIFNlcmlh
bE5vPTA3NzNKMUZXQzMyNTgwCiBDb25maWc9eyBIYXJkU2VjdCBOb3RNRk0gSGRTdz4xNXVTZWMg
Rml4ZWQgRFRSPjEwTWJzIH0KIFJhd0NIUz0xNjM4My8xNi82MywgVHJrU2l6ZT0zNDkwMiwgU2Vj
dFNpemU9NTU0LCBFQ0NieXRlcz00CiBCdWZmVHlwZT1EdWFsUG9ydENhY2hlLCBCdWZmU2l6ZT0y
MDQ4a0IsIE1heE11bHRTZWN0PTE2LCBNdWx0U2VjdD1vZmYKIEN1ckNIUz0xNzQ3NS8xNS82Mywg
Q3VyU2VjdHM9MTY1MTM4NzUsIExCQT15ZXMsIExCQXNlY3RzPTI2ODQzNTQ1NQogSU9SRFk9b24v
b2ZmLCB0UElPPXttaW46MjQwLHcvSU9SRFk6MTIwfSwgdERNQT17bWluOjEyMCxyZWM6MTIwfQog
UElPIG1vZGVzOiAgcGlvMCBwaW8xIHBpbzIgcGlvMyBwaW80IAogRE1BIG1vZGVzOiAgbWRtYTAg
bWRtYTEgbWRtYTIgCiBVRE1BIG1vZGVzOiB1ZG1hMCB1ZG1hMSB1ZG1hMiB1ZG1hMyAqdWRtYTQg
dWRtYTUgCiBBZHZhbmNlZFBNPW5vIFdyaXRlQ2FjaGU9ZW5hYmxlZAogRHJpdmUgY29uZm9ybXMg
dG86IChudWxsKTogIEFUQS9BVEFQSS0xIEFUQS9BVEFQSS0yIEFUQS9BVEFQSS0zIEFUQS9BVEFQ
SS00IEFUQS9BVEFQSS01IEFUQS9BVEFQSS02IEFUQS9BVEFQSS03CgogKiBzaWduaWZpZXMgdGhl
IGN1cnJlbnQgYWN0aXZlIG1vZGUKCgovZGV2L2hkYToKIG11bHRjb3VudCAgICA9ICAwIChvZmYp
CiBJT19zdXBwb3J0ICAgPSAgMSAoMzItYml0KQogdW5tYXNraXJxICAgID0gIDEgKG9uKQogdXNp
bmdfZG1hICAgID0gIDEgKG9uKQoga2VlcHNldHRpbmdzID0gIDAgKG9mZikKIHJlYWRvbmx5ICAg
ICA9ICAwIChvZmYpCiByZWFkYWhlYWQgICAgPSAyNTYgKG9uKQogZ2VvbWV0cnkgICAgID0gMTk0
NTcvMjU1LzYzLCBzZWN0b3JzID0gMzEyNTgxODA4LCBzdGFydCA9IDAK
------=_Part_26770_31599384.1144507638031--
