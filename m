Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbUKVLlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbUKVLlK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 06:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbUKVLky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 06:40:54 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:35456 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261303AbUKVLj5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 06:39:57 -0500
Date: Mon, 22 Nov 2004 12:39:54 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jakub Jelinek <jakub@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: var args in kernel?
In-Reply-To: <20041122113328.GQ10340@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.53.0411221235410.29615@yvahk01.tjqt.qr>
References: <20041109211107.GB5892@stusta.de> <1100037358.1519.6.camel@lb.loomes.de>
 <20041110082407.GA23090@bytesex> <1100085569.1591.6.camel@lb.loomes.de>
 <20041118165853.GA22216@bytesex> <419E689A.5000704@backtobasicsmgmt.com>
 <20041122094312.GC29305@bytesex> <20041122101646.GP10340@devserv.devel.redhat.com>
 <20041122102933.GG29305@bytesex> <Pine.LNX.4.53.0411221155330.31785@yvahk01.tjqt.qr>
 <20041122113328.GQ10340@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> In theory, you can't. But the way how GCC (and probably other compilers)
>> implement it, you can. Because "ap" is just a pointer (which fits into a
>> register, if I may add). As such, you can copy it, pass it multiple times, use
>> it multiple times, and whatever you like.
>
>That's exactly the wrong assumption.
>On some Linux architectures you can, on others you can't.
>Architectures where va_list is a char or void pointer include e.g.:
>i386, sparc*, ppc64, ia64
>Architectures where va_list is something different, usually struct { ... } va_list[1];
>or something similar:
>x86_64, ppc32, alpha, s390, s390x

Yeah I originally had that in mind but did not write it out ;)
What would the struct look like? Because if the following was true, then you
could also use a pointer:

int my_printf(const char *fmt, struct { some ints, some char's, whatever } arg)
{
    struct giveItAName *ap = &arg;
    callanotherfunc(fmt, ap);
    callanotherfunc(fmt, ap);
}

>In the latter case, you obviously can't do va_list dest = src and

Mmh, I could, because GCC is wise enough to copy whole structs. This is BTW
done a LOT in the kernel sources. Just compile it with -Waggreagte-return and
ye'll get a whole whopping lot of warnings from GCC. For
linux-2.[46].\d+.tar.bz2.

>if you do bar (x, ap); the content of the struct pointed by ap is changed
>after the call, therefore you can't use it for other routines

Who said the struct is changed? The compiler could use some magic to copy
above-metioned "arg" to a temporary which is only valid during my_printf() and
callees.
Who says the struct has to be changed? And even if it was about to, you could
copy it.

>(as it depends on where exactly the called function stopped with va_arg).

Don't get me wrong, I'm just asking... in a pessimistic fashion.



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
