Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965108AbWFABME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965108AbWFABME (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 21:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965148AbWFABMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 21:12:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40882 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965108AbWFABMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 21:12:02 -0400
Date: Wed, 31 May 2006 18:14:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: mingo@elte.hu, arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm1-lockdep: a rather strange oops
Message-Id: <20060531181430.bfe25ad5.akpm@osdl.org>
In-Reply-To: <986ed62e0605311747qb8f7a58ybde5d3a87de74309@mail.gmail.com>
References: <986ed62e0605311747qb8f7a58ybde5d3a87de74309@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2006 17:47:35 -0700
"Barry K. Nathan" <barryn@pobox.com> wrote:

> Unfortunately I haven't had a chance to set up a serial console on the
> box in question, so here's a picture instead (it oopses almost
> instantly during boot):
> 
> http://static.flickr.com/46/157552842_ddb0c61d56_b_d.jpg
> 
> Since there have been multiple versions of
> lockdep-combo-2.6.17-rc5-mm1.patch without any name changes, I'll
> identify the version I used by noting that it is 25646 bytes long,
> with md5sum ac96729e1586c1c82127c9fe796a2350. I compiled the kernel
> with gcc 4.1.1.
> 
> I got essentially the same oops on 2.6.17-rc5-mm1 plus the 3 hotfixes,
> with Debian sarge gcc 3.3.5-13. (Since -lockdep enabled KALLSYMS_ALL,
> gcc 3.3.5 compiled a kernel that is too large to boot off a floppy. In
> order to get the -lockdep kernel onto a floppy for booting, I had to
> debloat it by moving to gcc 4.1.1.)
> 
> Oh, one other change I made to both kernels (but I've been doing this
> since 2.6.14-mm or so with no problems until now -- it appears to be
> needed in order for me to use the Promise PATA libata driver, or at
> least, it was necessary the last time I checked):
> --- include/linux/libata.h.old  2006-05-30 22:48:39.000000000 -0700
> +++ include/linux/libata.h      2006-05-30 22:50:48.000000000 -0700
> @@ -43,7 +43,7 @@
>  #undef ATA_VERBOSE_DEBUG       /* yet more debugging output */
>  #undef ATA_IRQ_TRAP            /* define to ack screaming irqs */
>  #undef ATA_NDEBUG              /* define to disable quick runtime checks */
> -#undef ATA_ENABLE_PATA         /* define to enable PATA support in some
> +#define ATA_ENABLE_PATA                /* define to enable PATA
> support in some                                 * low-level drivers */
> 
> (The above patch is probably mangled because I cut-and-pasted it, but
> I'm really including it for human viewing...)
> 
> 2.6.17-rc4-mm[13] have been perfectly stable on this box.
> 
> I'm attaching my .config for 2.6.17-rc5-mm1-lockdep; hopefully GMail
> will include it inline. I guess I'll go ahead and recompile with the
> lockdep stuff disabled, and see if that still oopses. (I'll do that
> recompile in another directory, so that if anyone needs the System.map
> or anything like that, I can provide it.)

We oopsed, probably in the sata code.  And then, very irritatingly, we
oopsed again while trying to display the backtrace.

The original oops was a jump-to-null.  I had a few of those when getting
the latest git-libata-all tree working, due to missing
ata_port_operations.data_xfer vectors.  But it appears that both sata_sil.c
and sata_promise.c do have those filled in.

Perhaps what you could do is to perturb the flakey backtrace code in such a
manner as to avoid the second oops - change the value of
CONFIG_FRAME_POINTER, for example.
