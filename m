Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269658AbUJMJz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269658AbUJMJz1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 05:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269659AbUJMJz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 05:55:27 -0400
Received: from fmr05.intel.com ([134.134.136.6]:47339 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S269658AbUJMJzI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 05:55:08 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH x86_64]: Correct copy_user_generic return value when exception happens
Date: Wed, 13 Oct 2004 17:55:05 +0800
Message-ID: <8126E4F969BA254AB43EA03C59F44E8490E1E2@pdsmsx404>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH x86_64]: Correct copy_user_generic return value when exception happens
Thread-Index: AcSt5QWpVL6ooJXiR0KPkdX8I02GAADIm1XgAACs3ZA=
From: "Jin, Gordon" <gordon.jin@intel.com>
To: <discuss@x86-64.org>, <linux-kernel@vger.kernel.org>
Cc: "Zhang, Yanmin" <yanmin.zhang@intel.com>,
       "Zou, Nanhai" <nanhai.zou@intel.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Fu, Michael" <michael.fu@intel.com>,
       "Jin, Gordon" <gordon.jin@intel.com>
X-OriginalArrivalTime: 13 Oct 2004 09:55:06.0279 (UTC) FILETIME=[B7B04B70:01C4B10A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LTP case write03 and pwrite03 exposed this bug.

Below is a simplified version for write03.c:
Firstly, it writes 100 bytes to fd, so that f_pos is not 8-byte aligned.
Secondly, it mmaps a buffer with PROT_NONE flag.
Finally, it writes the buffer to fd and expects fail. But the write will succeed, if not armed with the patch.

#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

int main(int argc, char **argv)
{
	int fd;
	int ret;
	char wbuf[100];
	char * bad_addr = 0;

	fd = creat("test",0644);
	if (fd < 0) {
		printf("creating a new file failed\n");
	}

	(void)memset(wbuf, '0', 100);

	if (write(fd, wbuf, 100) == -1) {
		perror("first write");
		return (-1);
	}

	bad_addr = mmap(0, 1, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
	if (bad_addr <= 0) {
	    printf("mmap failed\n");
	}

	ret = write(fd, bad_addr, 100);
	if (ret != -1) {
		printf( "FAIL: write(2) failed to fail\n");
		return(-1);
	} else {
		printf( "PASS\n");
		return(0);
	}
}


Thanks,
Gordon 

-----Original Message-----
From: Jin, Gordon 
Sent: Wednesday, October 13, 2004 5:49 PM
To: discuss@x86-64.org; linux-kernel@vger.kernel.org
Subject: [PATCH x86_64]: Correct copy_user_generic return value when exception happens

 
Fix a bug that arch/x86_64/lib/copy_user:copy_user_generic will return a wrong
value when exception happens.
In the case the address is not 8-byte aligned (i.e. go into Lbad_alignment),
if exception happens in Ls11, %rdx will be wrong number of copied bytes,
then copy_user_generic returns wrong value.
It also fixed a bug of zeroing wrong number of bytes of destination at this
situation. (In Lzero_rest)

Signed-off-by: Yanmin Zhang <yanmin.zhang@intel.com>
Signed-off-by: Nanhai Zou <nanhai.zou@intel.com>
Signed-off-by: Gordon Jin <gordon.jin@intel.com>
Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

--- linux-2.6.9-rc3/arch/x86_64/lib/copy_user.S~	2004-07-15 13:30:14.376131432 -0700
+++ linux-2.6.9-rc3/arch/x86_64/lib/copy_user.S	2004-07-15 23:41:40.572981784 -0700
@@ -73,7 +73,7 @@
  * rdx count
  *
  * Output:		
- * eax uncopied bytes or 0 if successfull. 
+ * eax uncopied bytes or 0 if successful.
  */
 	.globl copy_user_generic	
 	.p2align 4
@@ -179,9 +179,9 @@
 	movl $8,%r9d
 	subl %ecx,%r9d
 	movl %r9d,%ecx
-	subq %r9,%rdx
-	jz   .Lsmall_align
-	js   .Lsmall_align
+	cmpq %r9,%rdx
+	jz   .Lhandle_7
+	js   .Lhandle_7
 .Lalign_1:		
 .Ls11:	movb (%rsi),%bl
 .Ld11:	movb %bl,(%rdi)
@@ -189,10 +189,8 @@
 	incq %rdi
 	decl %ecx
 	jnz .Lalign_1
+	subq %r9,%rdx
 	jmp .Lafter_bad_alignment
-.Lsmall_align:
-	addq %r9,%rdx
-	jmp .Lhandle_7
 #endif
 	
 	/* table sorted by exception address */	
@@ -219,8 +217,8 @@
 	.quad .Ls10,.Le_byte
 	.quad .Ld10,.Le_byte
 #ifdef FIX_ALIGNMENT	
-	.quad .Ls11,.Le_byte
-	.quad .Ld11,.Le_byte
+	.quad .Ls11,.Lzero_rest
+	.quad .Ld11,.Lzero_rest
 #endif
 	.quad .Le5,.Le_zero
 	.previous

Thanks,
Gordon 
