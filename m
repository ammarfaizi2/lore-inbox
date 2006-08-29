Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbWH2AOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbWH2AOA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 20:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbWH2AN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 20:13:59 -0400
Received: from terminus.zytor.com ([192.83.249.54]:8112 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964911AbWH2AN6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 20:13:58 -0400
Message-ID: <44F386B8.8000209@zytor.com>
Date: Mon, 28 Aug 2006 17:13:44 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Matt Domsch <Matt_Domsch@dell.com>
CC: Alon Bar-Lev <alon.barlev@gmail.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johninsd@san.rr.com
Subject: [PATCH] Fix the EDD code misparsing the command line
References: <445B5524.2090001@gmail.com> <200608272116.23498.ak@suse.de> <44F1F356.5030105@zytor.com> <200608272254.13871.ak@suse.de> <44F21122.3030505@zytor.com> <44F286E8.1000100@gmail.com> <44F2902B.5050304@gmail.com> <44F29BCD.3080408@zytor.com> <9e0cf0bf0608280519y7a9afcb9od29494b9cacb8852@mail.gmail.com> <44F335C8.7020108@zytor.com> <20060828184637.GD13464@lists.us.dell.com>
In-Reply-To: <20060828184637.GD13464@lists.us.dell.com>
Content-Type: multipart/mixed;
 boundary="------------000607070609000603050209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000607070609000603050209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------000607070609000603050209
Content-Type: text/plain;
 name="edd-cmdline-fix.path"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="edd-cmdline-fix.path"

The EDD code would scan the command line as a fixed array, without
taking account of either whitespace, null-termination, the old
command-line protocol, late overrides early, or the fact that the
command line may not be reachable from INITSEG.

This should fix those problems, and enable us to use a longer command
line.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>


diff --git a/arch/i386/boot/edd.S b/arch/i386/boot/edd.S
index 4b84ea2..03712a0 100644
--- a/arch/i386/boot/edd.S
+++ b/arch/i386/boot/edd.S
@@ -15,42 +15,90 @@ #include <linux/edd.h>
 #include <asm/setup.h>
 
 #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
-	movb	$0, (EDD_MBR_SIG_NR_BUF)
-	movb	$0, (EDDNR)
 
-# Check the command line for two options:
+# It is assumed that %ds == INITSEG here
+	
+	movb	$0, EDD_MBR_SIG_NR_BUF
+	movb	$0, EDDNR
+
+# Check the command line for options:
 # edd=of  disables EDD completely  (edd=off)
 # edd=sk  skips the MBR test    (edd=skipmbr)
+# edd=on  re-enables EDD (edd=on)
+	
 	pushl	%esi
-    	cmpl	$0, %cs:cmd_line_ptr
-	jz	done_cl
+	movw	$edd_mbr_sig_start, %di	# Default to edd=on
+	
 	movl	%cs:(cmd_line_ptr), %esi
-# ds:esi has the pointer to the command line now
-	movl	$(COMMAND_LINE_SIZE-7), %ecx
+	andl	%esi, %esi
+	jz	old_cl			# Old boot protocol?
+
+# Convert to a real-mode pointer in fs:si
+	movl	%esi, %eax
+	shrl	$4, %eax
+	movw	%ax, %fs
+	andw	$0xf, %si
+	jmp	have_cl_pointer
+
+# Old-style boot protocol?
+old_cl:
+	push	%ds			# aka INITSEG
+	pop	%fs
+
+	cmpw	$0xa33f, (0x20)
+	jne	done_cl			# No command line at all?
+	movw	(0x22), %si		# Pointer relative to INITSEG
+
+# fs:si has the pointer to the command line now
+have_cl_pointer:
+	
 # loop through kernel command line one byte at a time
-cl_loop:
-	cmpl	$EDD_CL_EQUALS, (%si)
+cl_atspace:
+	movl	%fs:(%si), %eax
+	andb	%al, %al		# End of line?
+	jz	done_cl
+	cmpl	$EDD_CL_EQUALS, %eax
 	jz	found_edd_equals
-	incl	%esi
-	loop	cl_loop
-	jmp	done_cl
+	cmpb	$0x20, %al		# <= space consider whitespace
+	ja	cl_skipword
+	incw	%si
+	jnz	cl_atspace
+	jmp	done_cl			# Wraparound...
+
+cl_skipword:
+	movb	%fs:(%si), %al		# End of string?
+	andb	%al, %al
+	jz	done_cl
+	cmpb	$0x20, %al
+	jbe	cl_atspace
+	incw	%si
+	jnz	cl_skipword
+	jmp	done_cl			# Wraparound...
+	
 found_edd_equals:
 # only looking at first two characters after equals
-    	addl	$4, %esi
-	cmpw	$EDD_CL_OFF, (%si)	# edd=of
-	jz	do_edd_off
-	cmpw	$EDD_CL_SKIP, (%si)	# edd=sk
-	jz	do_edd_skipmbr
-	jmp	done_cl
+# late overrides early on the command line, so keep going after finding something
+	movw	%fs:4(%si), %ax
+	cmpw	$EDD_CL_OFF, %ax	# edd=of
+	je	do_edd_off
+	cmpw	$EDD_CL_SKIP, %ax	# edd=sk
+	je	do_edd_skipmbr
+	cmpw	$EDD_CL_ON, %ax		# edd=on
+	je	do_edd_on
+	jmp	cl_skipword
 do_edd_skipmbr:
-    	popl	%esi
-	jmp	edd_start
+	movw	$edd_start, %di
+	jmp	cl_skipword
 do_edd_off:
-	popl	%esi
-	jmp	edd_done
+	movw	$edd_done, %di
+	jmp	cl_skipword
+do_edd_on:
+	movw	$edd_mbr_sig_start, %di
+	jmp	cl_skipword
+	
 done_cl:
 	popl	%esi
-
+	jmpw	*%di
 
 # Read the first sector of each BIOS disk device and store the 4-byte signature
 edd_mbr_sig_start:
diff --git a/include/linux/edd.h b/include/linux/edd.h
index 162512b..b2b3e68 100644
--- a/include/linux/edd.h
+++ b/include/linux/edd.h
@@ -52,6 +52,7 @@ #define EDD_MBR_SIG_NR_BUF 0x1ea  /* add
 #define EDD_CL_EQUALS   0x3d646465     /* "edd=" */
 #define EDD_CL_OFF      0x666f         /* "of" for off  */
 #define EDD_CL_SKIP     0x6b73         /* "sk" for skipmbr */
+#define EDD_CL_ON       0x6e6f	       /* "on" for on */
 
 #ifndef __ASSEMBLY__
 

--------------000607070609000603050209--
