Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291795AbSBAPNe>; Fri, 1 Feb 2002 10:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291792AbSBAPNW>; Fri, 1 Feb 2002 10:13:22 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:15823 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S291791AbSBAPNH>;
	Fri, 1 Feb 2002 10:13:07 -0500
Date: Fri, 1 Feb 2002 16:12:21 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@transmeta.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
        kaos@ocs.com.au, linux-kernel@vger.kernel.org, paulus@samba.org,
        davidm@hpl.hp.com, ralf@gnu.org, garzik@havoc.gtf.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
Message-ID: <20020201151221.GA8404@vana.vc.cvut.cz>
In-Reply-To: <20020131.222643.85689058.davem@redhat.com> <E16WfDe-0005Jd-00@the-village.bc.nu> <20020201095510.D17412@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020201095510.D17412@havoc.gtf.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 09:55:10AM -0500, Jeff Garzik wrote:
> On Fri, Feb 01, 2002 at 03:03:13PM +0000, Alan Cox wrote:
> > > If you have a dependency concern, you put yourself in the
> > > right initcall group.  You don't depend ever on the order within the
> > > group, thats the whole idea.  You can't depend on that, so you must
> > > group things correctly.
> > 
> > This was proposed right back at the start. Linus point blank vetoed it.

Hi Linus,
  I've found that multiple level initcalls went into kernel
behind my back, so you can throw away my yesterday patch
which converted lib.a => lib.o, and apply this one.

  I decided to use fs_initcall level, as nobody is using this
yet. If jffs2 will get initialized by fs_initcall, we'll have
to switch init_crc32 from fs_initcall to arch_initcall or
even sooner - crc32 initialization needs only working
kmalloc, nothing else (and it could use static buffer happilly,
as zeroes compress very good), so subsys_initcall could work
too.

  This patch does NOT solve problem with useless option CRC32 in
Config.in, as we compile crc32.o, but nobody picks it up for kernel
link. It is impossible to have .a for this directory unless we'll
start using --undefined= linker option to bring crc32 into final
image.

  Best is probably applying this over lib.a=>lib.o patch. Then
ordering is ensured by initcall level, and not by Makefiles,
and in addition CRC32 makefile option really does something...
					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz

[Patch tested with both lib.a and lib.o - it boots correctly
in both cases]


diff -urdN linux/lib/crc32.c linux/lib/crc32.c
--- linux/lib/crc32.c	Tue Jan 15 19:08:05 2002
+++ linux/lib/crc32.c	Fri Feb  1 14:54:28 2002
@@ -564,7 +564,7 @@
 	crc32cleanup_be();
 }
 
-module_init(init_crc32);
+fs_initcall(init_crc32);
 module_exit(cleanup_crc32);
 
 EXPORT_SYMBOL(crc32_le);
