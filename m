Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265967AbUA2DLW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 22:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265981AbUA2DLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 22:11:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15556 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265967AbUA2DLT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 22:11:19 -0500
Date: Wed, 28 Jan 2004 19:11:15 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: schwidefsky@de.ibm.com
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: SECURITY - data leakage due to incorrect strncpy implementation
Message-Id: <20040128191115.0f33a113.zaitcev@redhat.com>
In-Reply-To: <1057963814.20636.72.camel@dhcp22.swansea.linux.org.uk>
References: <Pine.LNX.4.44.0307111544020.4337-100000@home.osdl.org>
	<1057963814.20636.72.camel@dhcp22.swansea.linux.org.uk>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 11 Jul 2003 23:50:15 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Gwe, 2003-07-11 at 23:44, Linus Torvalds wrote:
> > On 11 Jul 2003, Alan Cox wrote:
> > > 
> > > Lots of kernel drivers rely on the libc definition of strncpy. 
> > 
> > But that's ok. We _do_ do the padding. I hated it when I wrote it, but as 
> > far as I know, the kernel strncpy() has done padding pretty much since day 
> > one.

>  * Note that unlike userspace strncpy, this does not %NUL-pad the buffer.
>  * However, the result is not %NUL-terminated if the source exceeds
>  * @count bytes.
>  */
> 
> Only x86 does the padding 

I do not undestand Alan's position, if he is for it or against it.
Anyway, in case you want it, here's what I wrote for s390.
I wrote some userland tests, it seems to check out. BUT I warn you,
someone better check my assembly.

-- Pete

diff -ur -X dontdiff linux-2.6.1/arch/s390/lib/strncpy64.S linux-2.6.1-s390/arch/s390/lib/strncpy64.S
--- linux-2.6.1/arch/s390/lib/strncpy64.S	2003-07-13 20:31:50.000000000 -0700
+++ linux-2.6.1-s390/arch/s390/lib/strncpy64.S	2004-01-28 18:48:27.000000000 -0800
@@ -23,8 +23,16 @@
 	LA      3,1(3)
         STC     0,0(1)
 	LA      1,1(1)
-        JZ      strncpy_exit   # ICM inserted a 0x00
+        JZ      strncpy_pad    # ICM inserted a 0x00
         BRCTG   4,strncpy_loop # R4 -= 1, jump to strncpy_loop if > 0
-strncpy_exit:
         BR      14
 
+strncpy_pad:
+	LTR     4,4
+        JZ      strncpy_exit   # 0 bytes -> nothing to do
+strncpy_padloop:
+	MVI	0(1),0
+	LA	1,1(1)
+	BRCTG	4,strncpy_padloop
+strncpy_exit:
+        BR      14
diff -ur -X dontdiff linux-2.6.1/arch/s390/lib/strncpy.S linux-2.6.1-s390/arch/s390/lib/strncpy.S
--- linux-2.6.1/arch/s390/lib/strncpy.S	2003-07-13 20:35:16.000000000 -0700
+++ linux-2.6.1-s390/arch/s390/lib/strncpy.S	2004-01-28 18:46:20.000000000 -0800
@@ -23,8 +23,16 @@
 	LA      3,1(3)
         STC     0,0(1)
 	LA      1,1(1)
-        JZ      strncpy_exit   # ICM inserted a 0x00
+        JZ      strncpy_pad    # ICM inserted a 0x00
         BRCT    4,strncpy_loop # R4 -= 1, jump to strncpy_loop if >  0
-strncpy_exit:
         BR      14
 
+strncpy_pad:
+	LTR	4,4
+	JZ	strncpy_exit
+strncpy_padloop:
+	MVI	0(1),0
+	LA	1,1(1)
+	BRCT	4,strncpy_padloop
+strncpy_exit:
+        BR      14
