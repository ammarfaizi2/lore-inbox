Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbVC3B1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbVC3B1L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 20:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbVC3B1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 20:27:11 -0500
Received: from smartmx-01.inode.at ([213.229.60.33]:45725 "EHLO
	smartmx-01.inode.at") by vger.kernel.org with ESMTP id S261701AbVC3B1G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 20:27:06 -0500
From: Gerold Jury <gerold.ml@inode.at>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: memcpy(a,b,CONST) is not inlined by gcc 3.4.1 in Linux kernel
Date: Wed, 30 Mar 2005 04:27:26 +0200
User-Agent: KMail/1.7.2
References: <200503291542.j2TFg4ER027715@earth.phy.uc.edu>
In-Reply-To: <200503291542.j2TFg4ER027715@earth.phy.uc.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503300427.26253.gerold.ml@inode.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> On Tue, Mar 29, 2005 at 05:37:06PM +0300, Denis Vlasenko wrote:
>> > /*
>> >  * This looks horribly ugly, but the compiler can optimize it totally,
>> >  * as the count is constant.
>> >  */
>> > static inline void * __constant_memcpy(void * to, const void * from,
>> > size_t n) {
>> >         if (n <= 128)
>> >                 return __builtin_memcpy(to, from, n);
>>
>> The problem is that in GCC < 4.0 there is no constant propagation
>> pass before expanding builtin functions, so the __builtin_memcpy
>> call above sees a variable rather than a constant.
>
>or change "size_t n" to "const size_t n" will also fix the issue.
>As we do some (well very little and with inlining and const values)
>const progation before 4.0.0 on the trees before expanding the builtin.
>
>-- Pinski
>-
I used the following "const size_t n" change on x86_64
and it reduced the memcpy count from 1088 to 609 with my setup and gcc 3.4.3.
(kernel 2.6.12-rc1, running now)

--- include/asm-x86_64/string.h.~1~     2005-03-02 08:38:33.000000000 +0100
+++ include/asm-x86_64/string.h 2005-03-30 03:24:35.000000000 +0200
@@ -28,9 +28,9 @@
    function. */

 #define __HAVE_ARCH_MEMCPY 1
-extern void *__memcpy(void *to, const void *from, size_t len);
+extern void *__memcpy(void *to, const void *from, const size_t len);
 #define memcpy(dst,src,len) \
-       ({ size_t __len = (len);                                \
+       ({ const size_t __len = (len);                          \
           void *__ret;                                         \
           if (__builtin_constant_p(len) && __len >= 64)        \
                 __ret = __memcpy((dst),(src),__len);           \
