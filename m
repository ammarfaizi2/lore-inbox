Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbVLUVja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbVLUVja (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 16:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbVLUVja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 16:39:30 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:7429 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751116AbVLUVj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 16:39:29 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C60677.0025F400"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <m3d5jq2oo3.fsf@defiant.localdomain>
X-OriginalArrivalTime: 21 Dec 2005 21:39:20.0630 (UTC) FILETIME=[00861560:01C60677]
Content-class: urn:content-classes:message
Subject: Re: About 4k kernel stack size....
Date: Wed, 21 Dec 2005 16:39:09 -0500
Message-ID: <Pine.LNX.4.61.0512211628040.4217@chaos.analogic.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: About 4k kernel stack size....
Thread-Index: AcYGdwCPozY7G9boSOeoibVumUilxg==
References: <20051218231401.6ded8de2@werewolf.auna.net><43A77205.2040306@rtr.ca> <20051220133729.GC6789@stusta.de><170fa0d20512200637l169654c9vbe38c9931c23dfb1@mail.gmail.com><BAYC1-PASMTP01F075F44E45AA32F0DF85AE3E0@CEZ.ICE><dobr1u$19t$1@sea.gmane.org> <m3d5jq2oo3.fsf@defiant.localdomain>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Krzysztof Halasa" <khc@pm.waw.pl>
Cc: "Giridhar Pemmasani" <giri@lmc.cs.sunysb.edu>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C60677.0025F400
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


On Wed, 21 Dec 2005, Krzysztof Halasa wrote:

> Giridhar Pemmasani <giri@lmc.cs.sunysb.edu> writes:
>
>> As I see, although people that rely on
>> ndiswrapper (since there is no other way they could use the hardware=
 that
>> they have) will not be able to use their wireless cards when this patch
>> gets merged without having to patch the kernel
>
> Huh? -mm is already a patch so I'm not sure what users are you talking
> about. End-users (non-developers) using -mm kernel (binary?) provided
> by their distribution? Why would they want to use ndiswrapper (=3D binary
> drivers, which make all bug reports and in fact all development
> pointless) with devel kernel?
> --=0D
> Krzysztof Halasa

The attached patch will poison the user-to-kernel stack with the letters
'Q', starting on each page boundary. It does one page only so it will
work with any sized stack. One can run the machine with the usual
work, then do:

# cat /dev/mem | strings >junk.dat

Somebody, if interested, could make a program that looks for a string
of 'Q's starting on each page boundary reading /dev/kmem. Anyway,
using `vim` and searching for "QQQQQQQQQQQQQQ", you can see how
much of the existing stack is being used. A cursory check shows that,
out of every instance of a string of such poison, the smallest string
was about 48 bytes and the largest was too many to bother to count.
This shows that there is (probably) about 48 bytes of overhead when
using 1 page stacks.


The mailer screws up patches not attached, but here is one
in the foreground for review. It is running on this system so
it doesn't break anything (probably slows syscalls down, though).

--- linux-2.6.13.4/arch/i386/kernel/entry.S.orig	2005-12-21=
 15:29:05.000000000 -0500
+++ linux-2.6.13.4/arch/i386/kernel/entry.S	2005-12-21 16:09:08.000000000=
 -0500
@@ -75,6 +75,27 @@
  NT_MASK		=3D 0x00004000
  VM_MASK		=3D 0x00020000

+poison:
+	pushl	%eax
+	pushl	%ecx
+	pushl	%edi
+	pushl	%es
+	pushl	%ss
+	popl	%es
+	movl	%esp, %edi
+	movl	%edi, %ecx
+	andl	$~0x1000, %edi
+	subl	%edi, %ecx
+	movb	$'Q', %al
+	rep	stosb
+	popl	%es
+	popl	%edi
+	popl	%ecx
+	popl	%eax
+	ret
+
+
+
  #ifdef CONFIG_PREEMPT
  #define preempt_stop		cli
  #else
@@ -93,6 +114,7 @@
  	pushl %edx; \
  	pushl %ecx; \
  	pushl %ebx; \
+	call poison; \
  	movl $(__USER_DS), %edx; \
  	movl %edx, %ds; \
  	movl %edx, %es;



Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5591.09 BogoMips).
Warning : 98.36% of all statistics are fiction.
.


****************************************************************
The information transmitted in this message is confidential and may be=
 privileged.  Any review, retransmission, dissemination, or other use of=
 this information by persons or entities other than the intended recipient=
 is prohibited.  If you are not the intended recipient, please notify=
 Analogic Corporation immediately - by replying to this message or by=
 sending an email to DeliveryErrors@analogic.com - and destroy all copies=
 of this information, including any attachments, without reading or=
 disclosing them.

Thank you.
------_=_NextPart_001_01C60677.0025F400
Content-Type: TEXT/PLAIN;
	name="entry.patch"
Content-Transfer-Encoding: base64
Content-Description: entry.patch
Content-Disposition: attachment;
	filename="entry.patch"

LS0tIGxpbnV4LTIuNi4xMy40L2FyY2gvaTM4Ni9rZXJuZWwvZW50cnkuUy5vcmlnCTIwMDUtMTIt
MjEgMTU6Mjk6MDUuMDAwMDAwMDAwIC0wNTAwDQorKysgbGludXgtMi42LjEzLjQvYXJjaC9pMzg2
L2tlcm5lbC9lbnRyeS5TCTIwMDUtMTItMjEgMTY6MDk6MDguMDAwMDAwMDAwIC0wNTAwDQpAQCAt
NzUsNiArNzUsMjcgQEANCiBOVF9NQVNLCQk9IDB4MDAwMDQwMDANCiBWTV9NQVNLCQk9IDB4MDAw
MjAwMDANCiANCitwb2lzb246DQorCXB1c2hsCSVlYXgNCisJcHVzaGwJJWVjeA0KKwlwdXNobAkl
ZWRpDQorCXB1c2hsCSVlcw0KKwlwdXNobAklc3MNCisJcG9wbAklZXMNCisJbW92bAklZXNwLCAl
ZWRpDQorCW1vdmwJJWVkaSwgJWVjeA0KKwlhbmRsCSR+MHgxMDAwLCAlZWRpDQorCXN1YmwJJWVk
aSwgJWVjeA0KKwltb3ZiCSQnUScsICVhbA0KKwlyZXAJc3Rvc2INCisJcG9wbAklZXMNCisJcG9w
bAklZWRpDQorCXBvcGwJJWVjeA0KKwlwb3BsCSVlYXgNCisJcmV0DQorDQorDQorDQogI2lmZGVm
IENPTkZJR19QUkVFTVBUDQogI2RlZmluZSBwcmVlbXB0X3N0b3AJCWNsaQ0KICNlbHNlDQpAQCAt
OTMsNiArMTE0LDcgQEANCiAJcHVzaGwgJWVkeDsgXA0KIAlwdXNobCAlZWN4OyBcDQogCXB1c2hs
ICVlYng7IFwNCisJY2FsbCBwb2lzb247IFwNCiAJbW92bCAkKF9fVVNFUl9EUyksICVlZHg7IFwN
CiAJbW92bCAlZWR4LCAlZHM7IFwNCiAJbW92bCAlZWR4LCAlZXM7DQo=

------_=_NextPart_001_01C60677.0025F400--
