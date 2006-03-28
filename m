Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWC1Azb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWC1Azb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 19:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWC1Azb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 19:55:31 -0500
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:2222 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932144AbWC1Aza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 19:55:30 -0500
Date: Mon, 27 Mar 2006 19:52:58 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [RFC, PATCH 5/24] i386 Vmi code patching
To: Andi Kleen <ak@suse.de>
Cc: virtualization <virtualization@lists.osdl.org>,
       Zachary Amsden <zach@vmware.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Dan Hecht <dhecht@vmware.com>, Chris Wright <chrisw@sous-sol.org>
Message-ID: <200603271955_MC3-1-BBB1-E3F1@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200603222115.46926.ak@suse.de>

On Wed, 22 Mar 2006 21:15:44 +0100, Andi Kleen wrote:

> On Monday 13 March 2006 19:02, Zachary Amsden wrote:
> > The VMI ROM detection and code patching mechanism is illustrated in
> > setup.c.  There ROM is a binary block published by the hypervisor, and
> > and there are certainly implications of this.  ROMs certainly have a
> > history of being proprietary, very differently licensed pieces of
> > software, and mostly under non-free licenses.  Before jumping to the
> > conclusion that this is a bad thing, let us consider more carefully
> > why hiding the interface layer to the hypervisor is actually a good
> > thing.
> 
> How about you fix all these issues you describe here first 
> and then submit it again?
> 
> The disassembly stuff indeed doesn't look like something
> that belongs in the kernel.

I think they put the disassembler in there as a joke. ;)

It's not necessary for fixing up the call site, anyway. Something like
this should work, assuming there is always a call in every vmi
translation.


 /* Now, measure and emit the vmi translation sequence */
 #define vmi_translation_start			\
 	.pushsection .vmi.translation,"ax";	\
 	781:;
 #define vmi_translation_finish			\
-	782:;					\
+	783:;					\
 	.popsection;
 #define vmi_translation_begin	781b
-#define vmi_translation_end	782b
+#define vmi_call_location	782b
+#define vmi_translation_end	783b
 #define vmi_translation_len	(vmi_translation_end - vmi_translation_begin)
+#define vmi_call_offset	(vmi_call_location - vmi_translation_begin)

 #define vmi_call(name)						\
-	call .+5+name
+	782: call .+5+name

 #define vmi_annotate(name)				\
 	.pushsection .vmi.annotation,"a";		\
 	.align 4;					\
 	.long name;					\
 	.long vmi_padded_begin;				\
 	.long vmi_translation_begin;			\
 	.byte vmi_padded_len;				\
 	.byte vmi_translation_len;			\
 	.byte vmi_pad_total;				\
-	.byte 0;					\
+	.byte vmi_call_offset;				\
 	.popsection;

 struct vmi_annotation {
 	unsigned long	vmi_call;
 	unsigned char 	*nativeEIP;
 	unsigned char	*translationEIP;
 	unsigned char	native_size;
 	unsigned char	translation_size;
 	char		nop_size;
-	unsigned char	pad;
+	unsigned char	call_offset;
 };

 static void fixup_translation(struct vmi_annotation *a)
 {
 	unsigned char *c, *start, *end;
 	int left;
 
 	memcpy(a->nativeEIP, a->translationEIP, a->translation_size);
+	patch_call_site(a, a->nativeEIP + a->call_offset);
-	start = a->nativeEIP;
-	end = a->nativeEIP + a->translation_size;
-
-	for (c = start; c < end;) {
-		switch(*c) {
-			case MNEM_CALL_NEAR:
-				patch_call_site(a, c);
-				c+=5;
-				break;
-
-			case MNEM_PUSH_I:
-				c+=5;
-				break;
-
-			case MNEM_PUSH_IB:
-				c+=2;
-				break;
-
-			case MNEM_PUSH_EAX:
-			case MNEM_PUSH_ECX:
-			case MNEM_PUSH_EDX:
-			case MNEM_PUSH_EBX:
-			case MNEM_PUSH_EBP:
-			case MNEM_PUSH_ESI:
-			case MNEM_PUSH_EDI: 
-				c+=1;
-				break;
-
-			case MNEM_LEA:
-				BUG_ON(*(c+1) != 0x64);  /* [--][--]+disp8, %esp */
-				BUG_ON(*(c+2) != 0x24);  /* none + %esp */
-				c+=4;
-				break;
-
-			default:
-				/*
-				 * Don't printk - it may acquire spinlocks with
-				 * partially completed VMI translations, causing
-				 * nuclear meltdown of the core.
- 				 */
-				BUG();
-				return;
-		}
-	}

-- 
Chuck
"Penguins don't come from next door, they come from the Antarctic!"
