Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266736AbTAORkJ>; Wed, 15 Jan 2003 12:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266755AbTAORkJ>; Wed, 15 Jan 2003 12:40:09 -0500
Received: from gra-lx1.iram.es ([150.214.224.41]:45475 "EHLO gra-lx1.iram.es")
	by vger.kernel.org with ESMTP id <S266736AbTAORkH>;
	Wed, 15 Jan 2003 12:40:07 -0500
Date: Wed, 15 Jan 2003 18:48:45 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Cleanup of the lcall7/lcall27 entry path.
Message-ID: <Pine.LNX.4.33.0301151814310.11008-200000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-694801952-391265687-1042652925=:11008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---694801952-391265687-1042652925=:11008
Content-Type: TEXT/PLAIN; charset=US-ASCII


	Hi,

I have more carefully tested the last patch I proposed in:
http://www.ussg.indiana.edu/hypermail/linux/kernel/0301.1/0917.html

The question I wanted to answer is: is it necessary to clear NT in the
sysenter entry path as implemented for lcall7/lcall27 or is it possible
to remove the flag manipulation from do_lcall?

Doing it only for one and not the other looks wrong since several return
paths are shared, especially the ones which end up in iret, the only
instruction which is affected by the NT flag.

The conclusion is that 2.5 is NT safe (had to dig out an old P5-133 which
I could crash without fear of data loss, so I have only tested on 1
machine). The reason this cleanup works is that now (since Jan 5th) flags
are saved and restored in switch_to() to keep IOPL private to a process
even when using sysenter/sysexit.

The side effect of that patch is that NT becomes also process-private
instead of infecting all processes and triggering a killfest of all user
mode processes, including init (AFAICT kernel threads survived, but I
did not have any debug tools enabled in the kernel).

Ok, here is the patch, the only addition to the preceding version is that
interrupts are reenabled in the iret fixup path because it seems that
do_exit() might otherwise spend quite some time with interrupts disabled.

===== arch/i386/kernel/entry.S 1.52 vs edited =====
--- 1.52/arch/i386/kernel/entry.S	Fri Jan 10 02:12:00 2003
+++ edited/arch/i386/kernel/entry.S	Wed Jan 15 15:50:14 2003
@@ -126,7 +126,8 @@
 	addl $4, %esp;	\
 1:	iret;		\
 .section .fixup,"ax";   \
-2:	movl $(__USER_DS), %edx; \
+2:	sti;		\
+	movl $(__USER_DS), %edx; \
 	movl %edx, %ds; \
 	movl %edx, %es; \
 	pushl $11;	\
@@ -154,17 +155,6 @@
 	movl %eax,EFLAGS(%ebp)	#
 	movl %edx,EIP(%ebp)	# Now we move them to their "normal" places
 	movl %ecx,CS(%ebp)	#
-
-	#
-	# Call gates don't clear TF and NT in eflags like
-	# traps do, so we need to do it ourselves.
-	# %eax already contains eflags (but it may have
-	# DF set, clear that also)
-	#
-	andl $~(DF_MASK | TF_MASK | NT_MASK),%eax
-	pushl %eax
-	popfl
-
 	andl $-8192, %ebp	# GET_THREAD_INFO
 	movl TI_EXEC_DOMAIN(%ebp), %edx	# Get the execution domain
 	call *4(%edx)		# Call the lcall7 handler for the domain


To convince myself that my patch is correct, I have also tested 2.4 with
the attached patch, and it also becomes immune to the attack published in:
http://www.ussg.indiana.edu/hypermail/linux/kernel/0211.1/0988.html

	Regards,
	Gabriel.

---694801952-391265687-1042652925=:11008
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="lk24.dif"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0301151848450.11008@gra-lx1.iram.es>
Content-Description: Patch for 2.4 (from recent bk)
Content-Disposition: attachment; filename="lk24.dif"

PT09PT0gYXJjaC9pMzg2L2tlcm5lbC9lbnRyeS5TIDEuMTYgdnMgZWRpdGVk
ID09PT09DQotLS0gMS4xNi9hcmNoL2kzODYva2VybmVsL2VudHJ5LlMJV2Vk
IE5vdiAxMyAyMTo0MDoxOSAyMDAyDQorKysgZWRpdGVkL2FyY2gvaTM4Ni9r
ZXJuZWwvZW50cnkuUwlXZWQgSmFuIDE1IDE1OjA1OjA4IDIwMDMNCkBAIC0x
MTYsNyArMTE2LDggQEANCiAJam1wIDFiOwkJXA0KIDU6CW1vdmwgJDAsKCVl
c3ApOwlcDQogCWptcCAyYjsJCVwNCi02OglwdXNobCAlc3M7CVwNCis2Oglz
dGk7CQlcDQorCXB1c2hsICVzczsJXA0KIAlwb3BsICVkczsJXA0KIAlwdXNo
bCAlc3M7CVwNCiAJcG9wbCAlZXM7CVwNCkBAIC0xNDIsOSArMTQzLDYgQEAN
CiAJbW92bCBDUyglZXNwKSwlZWR4CSMgdGhpcyBpcyBlaXAuLg0KIAltb3Zs
IEVGTEFHUyglZXNwKSwlZWN4CSMgYW5kIHRoaXMgaXMgY3MuLg0KIAltb3Zs
ICVlYXgsRUZMQUdTKCVlc3ApCSMNCi0JYW5kbCAkfihOVF9NQVNLfFRGX01B
U0t8REZfTUFTSyksICVlYXgNCi0JcHVzaGwgJWVheA0KLQlwb3BmbA0KIAlt
b3ZsICVlZHgsRUlQKCVlc3ApCSMgTm93IHdlIG1vdmUgdGhlbSB0byB0aGVp
ciAibm9ybWFsIiBwbGFjZXMNCiAJbW92bCAlZWN4LENTKCVlc3ApCSMNCiAJ
bW92bCAlZXNwLCVlYngNCkBAIC0xNjYsOSArMTY0LDYgQEANCiAJbW92bCBD
UyglZXNwKSwlZWR4CSMgdGhpcyBpcyBlaXAuLg0KIAltb3ZsIEVGTEFHUygl
ZXNwKSwlZWN4CSMgYW5kIHRoaXMgaXMgY3MuLg0KIAltb3ZsICVlYXgsRUZM
QUdTKCVlc3ApCSMNCi0JYW5kbCAkfihOVF9NQVNLfFRGX01BU0t8REZfTUFT
SyksICVlYXgNCi0JcHVzaGwgJWVheA0KLQlwb3BmbA0KIAltb3ZsICVlZHgs
RUlQKCVlc3ApCSMgTm93IHdlIG1vdmUgdGhlbSB0byB0aGVpciAibm9ybWFs
IiBwbGFjZXMNCiAJbW92bCAlZWN4LENTKCVlc3ApCSMNCiAJbW92bCAlZXNw
LCVlYngNCj09PT09IGluY2x1ZGUvYXNtLWkzODYvc3lzdGVtLmggMS4xMyB2
cyBlZGl0ZWQgPT09PT0NCi0tLSAxLjEzL2luY2x1ZGUvYXNtLWkzODYvc3lz
dGVtLmgJU3VuIERlYyAgOCAyMzowOTowOSAyMDAyDQorKysgZWRpdGVkL2lu
Y2x1ZGUvYXNtLWkzODYvc3lzdGVtLmgJV2VkIEphbiAxNSAxNDo1MDozOSAy
MDAzDQpAQCAtMTQsNyArMTQsOCBAQA0KIA0KICNkZWZpbmUgcHJlcGFyZV90
b19zd2l0Y2goKQlkbyB7IH0gd2hpbGUoMCkNCiAjZGVmaW5lIHN3aXRjaF90
byhwcmV2LG5leHQsbGFzdCkgZG8gewkJCQkJXA0KLQlhc20gdm9sYXRpbGUo
InB1c2hsICUlZXNpXG5cdCIJCQkJCVwNCisJYXNtIHZvbGF0aWxlKCJwdXNo
Zmxcblx0IgkJCQkJXA0KKwkJICAgICAicHVzaGwgJSVlc2lcblx0IgkJCQkJ
XA0KIAkJICAgICAicHVzaGwgJSVlZGlcblx0IgkJCQkJXA0KIAkJICAgICAi
cHVzaGwgJSVlYnBcblx0IgkJCQkJXA0KIAkJICAgICAibW92bCAlJWVzcCwl
MFxuXHQiCS8qIHNhdmUgRVNQICovCQlcDQpAQCAtMjYsNiArMjcsNyBAQA0K
IAkJICAgICAicG9wbCAlJWVicFxuXHQiCQkJCQlcDQogCQkgICAgICJwb3Bs
ICUlZWRpXG5cdCIJCQkJCVwNCiAJCSAgICAgInBvcGwgJSVlc2lcblx0IgkJ
CQkJXA0KKwkJICAgICAicG9wZmxcblx0IgkJCQkJXA0KIAkJICAgICA6Ij1t
IiAocHJldi0+dGhyZWFkLmVzcCksIj1tIiAocHJldi0+dGhyZWFkLmVpcCks
CVwNCiAJCSAgICAgICI9YiIgKGxhc3QpCQkJCQlcDQogCQkgICAgIDoibSIg
KG5leHQtPnRocmVhZC5lc3ApLCJtIiAobmV4dC0+dGhyZWFkLmVpcCksCVwN
Cg==
---694801952-391265687-1042652925=:11008--
