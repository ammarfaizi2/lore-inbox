Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315832AbSEJIOE>; Fri, 10 May 2002 04:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315833AbSEJIOD>; Fri, 10 May 2002 04:14:03 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:31507 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S315832AbSEJIOB>; Fri, 10 May 2002 04:14:01 -0400
Message-Id: <200205100810.g4A8AaX28554@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: DervishD <raul@viadomus.com>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: mmap() doesn't like certain value...
Date: Fri, 10 May 2002 11:13:40 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <3CD983C5.mail1K71EX1NG@viadomus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 May 2002 18:00, DervishD wrote:
>     While writing a test program I used mmap using SIZE_MAX (which is
> the maximum value storeable in a size_t variable) as the length, just
> to see when mmap starts failing with EINVAL or ENOMEM.
>
>     Well, mmap() acted quite good and reasonable and gave me the
> values I was searching for... except when a value of SIZE_MAX-4095 or
> higher is passed to it.
>
>     I've taken a look at the kernel sources and in the file
> mm/mmap.c, in the function do_mmap_pgoff, the length supplied is page
> aligned (thru the macro PAGE_ALIGN). But this macro correctly says
> that when we are at address SIZE_MAX-4095 or higher the next page in
> the addressable space is the page at address 0. But we are dealing
> with *sizes*, not addresses.

unsigned long do_mmap_pgoff(struct file * file, unsigned long addr, unsigned 
long len,
        unsigned long prot, unsigned long flags, unsigned long pgoff)
{
        [local var defs snipped]
        if (file && (!file->f_op || !file->f_op->mmap))
                return -ENODEV;
        if ((len = PAGE_ALIGN(len)) == 0)
                return addr;
        if (len > TASK_SIZE)
                return -EINVAL;
        /* offset overflow? */
        if ((pgoff + (len >> PAGE_SHIFT)) < pgoff)
                return -EINVAL;
...

>     The matter is that mmap() doesn't fail with values of
> SIZE_MAX-4095 and higher (as it should do), but succeeds returning
> '0' as the address... This is due the calculus that PAGE_ALIGN does
> with the enormous length passed (namely 4294963200 or higher, up to
> the limit marked by SIZE_MAX: 2^32-1). This macro cannot be used with
> numbers near to the limit. mmap() should return -1 and set errno to
> EINVAL, as properly does when the enormous length is less than
> 2^32-4096.

So,

-	if ((len = PAGE_ALIGN(len)) == 0)
-		return addr;
-	if (len > TASK_SIZE)
+	if (!len)
+		return addr;
+	len = PAGE_ALIGN(len);
+	if (!len || len > TASK_SIZE) /* !len: address wrapped to 0 in ALIGN */

>     I know: this lengths are enormous, nobody uses them, etc... but I

Looks like you found an obscure corner case. Good!

> think that mmap shouldn't behave as bad just because nobody will use
> the entire domain of the function. If the length domain is [0, 2^32)
> the function should behave correctly, returning errors as
> appropriate, not succeeding falsely. So please consider correcting
> the problem (should suffice with eliminating the use of PAGE_ALIGN or
> adding special cases to the test prior to its use).
>
>     If this is not a bug, but an intended behaviour please excuse me.
> Moreover, I can provide a patch (I suppose) against the 2.4.18 tree.

Do it.

BTW, does anybody know why len==0 is not flagged as error?
--
vda
