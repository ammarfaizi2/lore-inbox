Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbVKROPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbVKROPN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 09:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbVKROPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 09:15:13 -0500
Received: from spirit.analogic.com ([204.178.40.4]:12039 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750751AbVKROPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 09:15:11 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C5EC4A.7B485480"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <200511181351.41159.vda@ilport.com.ua>
References: <Pine.LNX.4.61.0511171314440.10063@chaos.analogic.com> <200511181351.41159.vda@ilport.com.ua>
X-OriginalArrivalTime: 18 Nov 2005 14:15:09.0943 (UTC) FILETIME=[7BD83870:01C5EC4A]
Content-class: urn:content-classes:message
Subject: Re: Compaq Presario "reboot" problems
Date: Fri, 18 Nov 2005 09:15:04 -0500
Message-ID: <Pine.LNX.4.61.0511180904470.4215@chaos.analogic.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Compaq Presario "reboot" problems
Thread-Index: AcXsSnvhyQJgwmksQhSou/ctAZq1hQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Denis Vlasenko" <vda@ilport.com.ua>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5EC4A.7B485480
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


On Fri, 18 Nov 2005, Denis Vlasenko wrote:

> On Thursday 17 November 2005 20:51, linux-os (Dick Johnson) wrote:
>>
>> With Linux-2.4.26 I reported that if a Compaq gets rebooted while
>> running Linux-2.4.26, it will not be able to restart Windows 2000.
>> It cam restart Linux fine. Today, I tried the same thing with
>> Linux-2.6.13.4. It fails, too.
>>
>> The symptoms are that you just "reboot" Linux. When the GRUB loader
>> comes up, I select my Windows-2000/professional. That M$ Crap comes
>> up to where it's just about to start the high-resolution screen.
>> Then it stops forever, no interrupts, no nothing. I need to disconnect
>> power and remove the battery to recover.
>>
>> It appears as though Linux is still restarting as a "warm boot",
>> rather than a cold boot (in other words, putting magic in the
>> shutdown byte of CMOS) so the hardware doesn't get properly
>> initialized. Would somebody please check this out. When changing
>> operating systems, you need a cold-boot.
>
> Can you check which driver does that? The test would be to
> boot a special Linux setup which reboots immediately
> (say, wuth init=3D/some/reboot_script.sh boot param).
>
> Then start removing drivers from kernel until you
> can boot Win successfully after Linux reboots.
> --
> vda

I booted into a shell from a floppy disk. There were no drivers
installed, not even the IDE driver. I could not reboot windows
after linux was up and rebooted. This was Linux-2.6.13.4. Then
I tried linux-2.4.26 which corresponds to the version when I
first reported this problem. The same thing happens. Therefore,
I temporarily modified linux-2.6.13.4 to force a triple-fault
and processor reset when doing a reboot. With this temporary
modification it is possible to boot windows after Linux was
running.

This is the reboot patch. It is not a "solution", just something
that shows that the current reboot code doesn't force the BIOS
to start from scratch, which is essential when changing operating
systems.


--- linux-2.6.13.4/arch/i386/kernel/reboot.c.orig	2005-11-18=
 08:29:12.000000000 -0500
+++ linux-2.6.13.4/arch/i386/kernel/reboot.c	2005-11-18 08:52:40.000000000=
 -0500
@@ -337,6 +337,11 @@

  void machine_restart(char * __unused)
  {
+        for(;;) {
+	__asm__ __volatile__("\tmovl %cr0, %eax\n"
+			     "\tandl $~0x80000000,  %eax\n"
+			     "\tmovl %eax, %cr0\n");
+        }
  	machine_shutdown();
  	machine_emergency_restart();
  }

Just in case the M$ mailer screws up everything, the patch
is attached also.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.54 BogoMips).
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
------_=_NextPart_001_01C5EC4A.7B485480
Content-Type: TEXT/PLAIN;
	name="reboot.patch"
Content-Transfer-Encoding: base64
Content-Description: reboot.patch
Content-Disposition: attachment;
	filename="reboot.patch"

LS0tIGxpbnV4LTIuNi4xMy40L2FyY2gvaTM4Ni9rZXJuZWwvcmVib290LmMub3JpZwkyMDA1LTEx
LTE4IDA4OjI5OjEyLjAwMDAwMDAwMCAtMDUwMA0KKysrIGxpbnV4LTIuNi4xMy40L2FyY2gvaTM4
Ni9rZXJuZWwvcmVib290LmMJMjAwNS0xMS0xOCAwODo1Mjo0MC4wMDAwMDAwMDAgLTA1MDANCkBA
IC0zMzcsNiArMzM3LDExIEBADQogDQogdm9pZCBtYWNoaW5lX3Jlc3RhcnQoY2hhciAqIF9fdW51
c2VkKQ0KIHsNCisgICAgICAgIGZvcig7Oykgew0KKwlfX2FzbV9fIF9fdm9sYXRpbGVfXygiXHRt
b3ZsICVjcjAsICVlYXhcbiINCisJCQkgICAgICJcdGFuZGwgJH4weDgwMDAwMDAwLCAgJWVheFxu
Ig0KKwkJCSAgICAgIlx0bW92bCAlZWF4LCAlY3IwXG4iKTsNCisgICAgICAgIH0NCiAJbWFjaGlu
ZV9zaHV0ZG93bigpOw0KIAltYWNoaW5lX2VtZXJnZW5jeV9yZXN0YXJ0KCk7DQogfQ0K

------_=_NextPart_001_01C5EC4A.7B485480--
