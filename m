Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVAWISk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVAWISk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 03:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbVAWISk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 03:18:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:15334 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261257AbVAWISf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 03:18:35 -0500
Date: Sun, 23 Jan 2005 00:18:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Corey Minyard <minyard@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch to fix race between the NMI code and the CMOS clock
Message-Id: <20050123001806.53140e54.akpm@osdl.org>
In-Reply-To: <41F18A52.9040703@acm.org>
References: <41F18A52.9040703@acm.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corey Minyard <minyard@acm.org> wrote:
>
> This patch fixes a race between the CMOS clock setting and the NMI
>  code.  The NMI code indiscriminatly sets index registers and values
>  in the same place the CMOS clock is set.  If you are setting the
>  CMOS clock and an NMI occurs, Bad values could be written to or
>  read from the CMOS RAM, or the NMI operation might not occur
>  correctly.
> 
>  Fixing this requires creating a special lock so the NMI code can
>  know its CPU owns the lock an "do the right thing" in that case.

hm, tricky patch.  I can't see any holes in it.  The volatile variable is
awkward but should be OK on x86 and I can see the need for it.

There's a preposterous amount of inlining happening in this code.  Hence
your patch took the size of drivers/char/rtc.o from

   text    data     bss     dec     hex filename
   3657     540       8    4205    106d drivers/char/rtc.o
to
   5419     540       8    5967    174f drivers/char/rtc.o

Do you think you could take a look at uninlining everything sometime?
