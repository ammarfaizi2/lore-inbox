Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbVLEPyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbVLEPyU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 10:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbVLEPyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 10:54:20 -0500
Received: from spirit.analogic.com ([204.178.40.4]:45068 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751376AbVLEPyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 10:54:19 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C5F9B4.262F7100"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <Pine.LNX.4.61.0512050900340.27266@chaos.analogic.com>
X-OriginalArrivalTime: 05 Dec 2005 15:54:18.0219 (UTC) FILETIME=[2650DBB0:01C5F9B4]
Content-class: urn:content-classes:message
Subject: Re: kernel loading question
Date: Mon, 5 Dec 2005 10:54:17 -0500
Message-ID: <Pine.LNX.4.61.0512051047490.4182@chaos.analogic.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: kernel loading question
Thread-Index: AcX5tCZam40W6A8kTUaIshij3fOR0A==
References: <e1e1d5f40512022134y73318ed4p54064a07905cef3c@mail.gmail.com> <Pine.LNX.4.61.0512050900340.27266@chaos.analogic.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Daniel Bonekeeper" <thehazard@gmail.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5F9B4.262F7100
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


On Mon, 5 Dec 2005, linux-os (Dick Johnson) wrote:

>
> On Sat, 3 Dec 2005, Daniel Bonekeeper wrote:
>
>> Well, this probably should not be posted here, but who knows ? =3D)
>>
>> Well, on arch/i386/boot/compressed/head.S line 65 we call
>> decompress_kernel that decompresses the kernel starting at $0x100000.
>> If we were loaded high, we first move the code back to $0x1000 before
>> ljmp'ing it.
>>
>> My question is: why, when loaded high, we care to disable interrupts
>> (cli  # make sure we don't get interrupted) while otherwise, we don't
>> do that ? in both cases, aren't we supposed to disable cli (as they
>> can happen in both situations) ?
>>
>> Since currently, the kernel boots fine for everybody in the world, I
>> know that this is not a bug... but why don't disable interruptions on
>> both cases ?
>>
>> Thanks !
>
> The first thing to do when looking at assembly language files
> is to find what symbols are global (.globl or .global). Unlike
> 'C' the stuff doesn't default to being visible from other
> files. Given that, you will see that code executes from
> startup_32, the only way "in" since it's the only global
> symbol. The second instruction is 'cli', which will disable
> interrupts on the current processor.
>
> Now, later on in the code is the sequence:
> 		pushl	$0
> 		popfl
>
> ... which will further clear any flags so the interrupt-enable
> flag is truly disabled there, also. Later on, there are redundant
> 'cld' instructions as well as an additional 'cli' instruction.
>
> These probably occurred because the code was assembled from
> various pieces and nobody bothered to review it for such
> redundancy.
>
> Getting rid of the extra instructions will save 3 or 4 bytes
> of code. Since this code executes only once, it's certainly
> not in the "fast-path" so nobody has bothered to clean it.
> If you would like to clean up the code and submit a patch
> it probably would be accepted.
>
> I will test any patch you may want to produce.
>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.13.4 on an i686 machine (5589.44 BogoMips).
> Warning : 98.36% of all statistics are fiction.


Here is a patch that works both on the normal Pentium and the
ELAN which is a '486'. It hasn't been tested on __everything__
because I don't have a '386. Nevertheless, it should work
everywhere and it contains a few cleanups as well. Just in
case the mailer screws it up, it is attached as a plain
text file as well.

Signed Off By:  Richard B. Johnson	rjohnson@analogic.com

--------

--- linux-2.6.13.4/arch/i386/boot/compressed/head.S.orig	2005-12-05=
 09:23:22.000000000 -0500
+++ linux-2.6.13.4/arch/i386/boot/compressed/head.S	2005-12-05=
 10:39:56.000000000 -0500
@@ -18,9 +18,21 @@
   * mode.
   */

-/*
- * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
- */
+#
+#  High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
+#
+#  Dec 5, 2005	rjohnson@analogic.com
+#  Removed most of the old-style 'C' comment format and replaced with
+#  GAS comment delimiters.
+#
+#  Dec 5, 2005	rjohnson@analogic.com
+#  Removed many redundant flag operations. Adjusted offset of
+#  the move_routine_start to a 16-byte boundary so it is truly
+#  position-independent.
+#
+#  Dec 5, 2005	rjohnson@analogic.com
+#  Fixed A20 detection code.
+#
  .text

  #include <linux/linkage.h>
@@ -30,41 +42,38 @@
  	.globl startup_32

  startup_32:
-	cld
  	cli
-	movl $(__BOOT_DS),%eax
-	movl %eax,%ds
+	movl $(__BOOT_DS),%eax	# Linear address-space
+	movl %eax,%ds		# Set segments
  	movl %eax,%es
  	movl %eax,%fs
  	movl %eax,%gs

-	lss stack_start,%esp
-	xorl %eax,%eax
-1:	incl %eax		# check that A20 really IS enabled
-	movl %eax,0x000000	# loop forever if it isn't
-	cmpl %eax,0x100000
-	je 1b
-
-/*
- * Initialize eflags.  Some BIOS's leave bits like NT set.  This would
- * confuse the debugger if this code is traced.
- * XXX - best to initialize before switching to protected mode.
- */
-	pushl $0
-	popfl
-/*
- * Clear BSS
- */
+	lss stack_start,%esp	# Set stack
+	xorl %eax,%eax		# Clear
+	pushl %eax
+	popfl			# Clear all flags
+#
+#	Check for at least 20-bit addressing, (A20 is enabled).
+#
+	movl	$__PHYSICAL_START, %ebx
+	movl	(%ebx), %eax		# Save whatever is there
+	movl	$0xfeedface, (%ebx)	# Set magic
+1:	cmpl	$0xfeedface, (%ebx)	# See if 32-bits
+	jnz	1b			# Hang forever if not
+	movl	%eax, (%ebx)		# Put the code back
+#
+#	Clear BSS
+#
  	xorl %eax,%eax
  	movl $_edata,%edi
  	movl $_end,%ecx
  	subl %edi,%ecx
-	cld
  	rep
  	stosb
-/*
- * Do the decompression, and jump to the new kernel..
- */
+#
+#	Do the decompression, and jump to the new kernel..
+#
  	subl $16,%esp	# place for structure on the stack
  	movl %esp,%eax
  	pushl %esi	# real mode pointer as second arg
@@ -77,20 +86,18 @@
  	xorl %ebx,%ebx
  	ljmp $(__BOOT_CS), $__PHYSICAL_START

-/*
- * We come here, if we were loaded high.
- * We need to move the move-in-place routine down to 0x1000
- * and then start it with the buffer addresses in registers,
- * which we got from the stack.
- */
-3:
-	movl $move_routine_start,%esi
+#
+#	We come here, if we were loaded high.
+#	We need to move the move-in-place routine down to 0x1000
+#	and then start it with the buffer addresses in registers
+#	which we got from the stack.
+#
+3:	movl $move_routine_start,%esi
  	movl $0x1000,%edi
  	movl $move_routine_end,%ecx
  	subl %esi,%ecx
  	addl $3,%ecx
  	shrl $2,%ecx
-	cld
  	rep
  	movsl

@@ -101,13 +108,13 @@
  	popl %edx	# high_buffer_start
  	popl %eax	# hcount
  	movl $__PHYSICAL_START,%edi
-	cli		# make sure we don't get interrupted
  	ljmp $(__BOOT_CS), $0x1000 # and jump to the move routine

-/*
- * Routine (template) for moving the decompressed kernel in place,
- * if we were high loaded. This _must_ PIC-code !
- */
+#
+#	Routine (template) for moving the decompressed kernel in place,
+#	when we are high loaded. This _must_ be position-independent code!
+#
+.align	0x10
  move_routine_start:
  	movl %ecx,%ebp
  	shrl $2,%ecx

-----------



Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.44 BogoMips).
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
------_=_NextPart_001_01C5F9B4.262F7100
Content-Type: TEXT/PLAIN;
	name="head.patch"
Content-Transfer-Encoding: base64
Content-Description: head.patch
Content-Disposition: attachment;
	filename="head.patch"

LS0tIGxpbnV4LTIuNi4xMy40L2FyY2gvaTM4Ni9ib290L2NvbXByZXNzZWQvaGVhZC5TLm9yaWcJ
MjAwNS0xMi0wNSAwOToyMzoyMi4wMDAwMDAwMDAgLTA1MDANCisrKyBsaW51eC0yLjYuMTMuNC9h
cmNoL2kzODYvYm9vdC9jb21wcmVzc2VkL2hlYWQuUwkyMDA1LTEyLTA1IDEwOjM5OjU2LjAwMDAw
MDAwMCAtMDUwMA0KQEAgLTE4LDkgKzE4LDIxIEBADQogICogbW9kZS4NCiAgKi8NCiANCi0vKg0K
LSAqIEhpZ2ggbG9hZGVkIHN0dWZmIGJ5IEhhbnMgTGVybWVuICYgV2VybmVyIEFsbWVzYmVyZ2Vy
LCBGZWIuIDE5OTYNCi0gKi8NCisjDQorIyAgSGlnaCBsb2FkZWQgc3R1ZmYgYnkgSGFucyBMZXJt
ZW4gJiBXZXJuZXIgQWxtZXNiZXJnZXIsIEZlYi4gMTk5Ng0KKyMNCisjICBEZWMgNSwgMjAwNQly
am9obnNvbkBhbmFsb2dpYy5jb20NCisjICBSZW1vdmVkIG1vc3Qgb2YgdGhlIG9sZC1zdHlsZSAn
QycgY29tbWVudCBmb3JtYXQgYW5kIHJlcGxhY2VkIHdpdGgNCisjICBHQVMgY29tbWVudCBkZWxp
bWl0ZXJzLg0KKyMNCisjICBEZWMgNSwgMjAwNQlyam9obnNvbkBhbmFsb2dpYy5jb20NCisjICBS
ZW1vdmVkIG1hbnkgcmVkdW5kYW50IGZsYWcgb3BlcmF0aW9ucy4gQWRqdXN0ZWQgb2Zmc2V0IG9m
DQorIyAgdGhlIG1vdmVfcm91dGluZV9zdGFydCB0byBhIDE2LWJ5dGUgYm91bmRhcnkgc28gaXQg
aXMgdHJ1bHkNCisjICBwb3NpdGlvbi1pbmRlcGVuZGVudC4NCisjDQorIyAgRGVjIDUsIDIwMDUJ
cmpvaG5zb25AYW5hbG9naWMuY29tDQorIyAgRml4ZWQgQTIwIGRldGVjdGlvbiBjb2RlLg0KKyMN
CiAudGV4dA0KIA0KICNpbmNsdWRlIDxsaW51eC9saW5rYWdlLmg+DQpAQCAtMzAsNDEgKzQyLDM4
IEBADQogCS5nbG9ibCBzdGFydHVwXzMyDQogCQ0KIHN0YXJ0dXBfMzI6DQotCWNsZA0KIAljbGkN
Ci0JbW92bCAkKF9fQk9PVF9EUyksJWVheA0KLQltb3ZsICVlYXgsJWRzDQorCW1vdmwgJChfX0JP
T1RfRFMpLCVlYXgJIyBMaW5lYXIgYWRkcmVzcy1zcGFjZQ0KKwltb3ZsICVlYXgsJWRzCQkjIFNl
dCBzZWdtZW50cw0KIAltb3ZsICVlYXgsJWVzDQogCW1vdmwgJWVheCwlZnMNCiAJbW92bCAlZWF4
LCVncw0KIA0KLQlsc3Mgc3RhY2tfc3RhcnQsJWVzcA0KLQl4b3JsICVlYXgsJWVheA0KLTE6CWlu
Y2wgJWVheAkJIyBjaGVjayB0aGF0IEEyMCByZWFsbHkgSVMgZW5hYmxlZA0KLQltb3ZsICVlYXgs
MHgwMDAwMDAJIyBsb29wIGZvcmV2ZXIgaWYgaXQgaXNuJ3QNCi0JY21wbCAlZWF4LDB4MTAwMDAw
DQotCWplIDFiDQotDQotLyoNCi0gKiBJbml0aWFsaXplIGVmbGFncy4gIFNvbWUgQklPUydzIGxl
YXZlIGJpdHMgbGlrZSBOVCBzZXQuICBUaGlzIHdvdWxkDQotICogY29uZnVzZSB0aGUgZGVidWdn
ZXIgaWYgdGhpcyBjb2RlIGlzIHRyYWNlZC4NCi0gKiBYWFggLSBiZXN0IHRvIGluaXRpYWxpemUg
YmVmb3JlIHN3aXRjaGluZyB0byBwcm90ZWN0ZWQgbW9kZS4NCi0gKi8NCi0JcHVzaGwgJDANCi0J
cG9wZmwNCi0vKg0KLSAqIENsZWFyIEJTUw0KLSAqLw0KKwlsc3Mgc3RhY2tfc3RhcnQsJWVzcAkj
IFNldCBzdGFjaw0KKwl4b3JsICVlYXgsJWVheAkJIyBDbGVhcg0KKwlwdXNobCAlZWF4DQorCXBv
cGZsCQkJIyBDbGVhciBhbGwgZmxhZ3MNCisjDQorIwlDaGVjayBmb3IgYXQgbGVhc3QgMjAtYml0
IGFkZHJlc3NpbmcsIChBMjAgaXMgZW5hYmxlZCkuDQorIw0KKwltb3ZsCSRfX1BIWVNJQ0FMX1NU
QVJULCAlZWJ4DQorCW1vdmwJKCVlYngpLCAlZWF4CQkjIFNhdmUgd2hhdGV2ZXIgaXMgdGhlcmUN
CisJbW92bAkkMHhmZWVkZmFjZSwgKCVlYngpCSMgU2V0IG1hZ2ljDQorMToJY21wbAkkMHhmZWVk
ZmFjZSwgKCVlYngpCSMgU2VlIGlmIDMyLWJpdHMNCisJam56CTFiCQkJIyBIYW5nIGZvcmV2ZXIg
aWYgbm90DQorCW1vdmwJJWVheCwgKCVlYngpCQkjIFB1dCB0aGUgY29kZSBiYWNrDQorIw0KKyMJ
Q2xlYXIgQlNTDQorIw0KIAl4b3JsICVlYXgsJWVheA0KIAltb3ZsICRfZWRhdGEsJWVkaQ0KIAlt
b3ZsICRfZW5kLCVlY3gNCiAJc3VibCAlZWRpLCVlY3gNCi0JY2xkDQogCXJlcA0KIAlzdG9zYg0K
LS8qDQotICogRG8gdGhlIGRlY29tcHJlc3Npb24sIGFuZCBqdW1wIHRvIHRoZSBuZXcga2VybmVs
Li4NCi0gKi8NCisjDQorIwlEbyB0aGUgZGVjb21wcmVzc2lvbiwgYW5kIGp1bXAgdG8gdGhlIG5l
dyBrZXJuZWwuLg0KKyMNCiAJc3VibCAkMTYsJWVzcAkjIHBsYWNlIGZvciBzdHJ1Y3R1cmUgb24g
dGhlIHN0YWNrDQogCW1vdmwgJWVzcCwlZWF4DQogCXB1c2hsICVlc2kJIyByZWFsIG1vZGUgcG9p
bnRlciBhcyBzZWNvbmQgYXJnDQpAQCAtNzcsMjAgKzg2LDE4IEBADQogCXhvcmwgJWVieCwlZWJ4
DQogCWxqbXAgJChfX0JPT1RfQ1MpLCAkX19QSFlTSUNBTF9TVEFSVA0KIA0KLS8qDQotICogV2Ug
Y29tZSBoZXJlLCBpZiB3ZSB3ZXJlIGxvYWRlZCBoaWdoLg0KLSAqIFdlIG5lZWQgdG8gbW92ZSB0
aGUgbW92ZS1pbi1wbGFjZSByb3V0aW5lIGRvd24gdG8gMHgxMDAwDQotICogYW5kIHRoZW4gc3Rh
cnQgaXQgd2l0aCB0aGUgYnVmZmVyIGFkZHJlc3NlcyBpbiByZWdpc3RlcnMsDQotICogd2hpY2gg
d2UgZ290IGZyb20gdGhlIHN0YWNrLg0KLSAqLw0KLTM6DQotCW1vdmwgJG1vdmVfcm91dGluZV9z
dGFydCwlZXNpDQorIw0KKyMJV2UgY29tZSBoZXJlLCBpZiB3ZSB3ZXJlIGxvYWRlZCBoaWdoLg0K
KyMJV2UgbmVlZCB0byBtb3ZlIHRoZSBtb3ZlLWluLXBsYWNlIHJvdXRpbmUgZG93biB0byAweDEw
MDANCisjCWFuZCB0aGVuIHN0YXJ0IGl0IHdpdGggdGhlIGJ1ZmZlciBhZGRyZXNzZXMgaW4gcmVn
aXN0ZXJzDQorIwl3aGljaCB3ZSBnb3QgZnJvbSB0aGUgc3RhY2suDQorIw0KKzM6CW1vdmwgJG1v
dmVfcm91dGluZV9zdGFydCwlZXNpDQogCW1vdmwgJDB4MTAwMCwlZWRpDQogCW1vdmwgJG1vdmVf
cm91dGluZV9lbmQsJWVjeA0KIAlzdWJsICVlc2ksJWVjeA0KIAlhZGRsICQzLCVlY3gNCiAJc2hy
bCAkMiwlZWN4DQotCWNsZA0KIAlyZXANCiAJbW92c2wNCiANCkBAIC0xMDEsMTMgKzEwOCwxMyBA
QA0KIAlwb3BsICVlZHgJIyBoaWdoX2J1ZmZlcl9zdGFydA0KIAlwb3BsICVlYXgJIyBoY291bnQN
CiAJbW92bCAkX19QSFlTSUNBTF9TVEFSVCwlZWRpDQotCWNsaQkJIyBtYWtlIHN1cmUgd2UgZG9u
J3QgZ2V0IGludGVycnVwdGVkDQogCWxqbXAgJChfX0JPT1RfQ1MpLCAkMHgxMDAwICMgYW5kIGp1
bXAgdG8gdGhlIG1vdmUgcm91dGluZQ0KIA0KLS8qDQotICogUm91dGluZSAodGVtcGxhdGUpIGZv
ciBtb3ZpbmcgdGhlIGRlY29tcHJlc3NlZCBrZXJuZWwgaW4gcGxhY2UsDQotICogaWYgd2Ugd2Vy
ZSBoaWdoIGxvYWRlZC4gVGhpcyBfbXVzdF8gUElDLWNvZGUgIQ0KLSAqLw0KKyMNCisjCVJvdXRp
bmUgKHRlbXBsYXRlKSBmb3IgbW92aW5nIHRoZSBkZWNvbXByZXNzZWQga2VybmVsIGluIHBsYWNl
LA0KKyMJd2hlbiB3ZSBhcmUgaGlnaCBsb2FkZWQuIFRoaXMgX211c3RfIGJlIHBvc2l0aW9uLWlu
ZGVwZW5kZW50IGNvZGUhDQorIw0KKy5hbGlnbgkweDEwDQogbW92ZV9yb3V0aW5lX3N0YXJ0Og0K
IAltb3ZsICVlY3gsJWVicA0KIAlzaHJsICQyLCVlY3gNCg==

------_=_NextPart_001_01C5F9B4.262F7100--
