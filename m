Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265699AbTL3INQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 03:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265700AbTL3IMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 03:12:55 -0500
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:21751 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S265699AbTL3IMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 03:12:16 -0500
Date: Tue, 30 Dec 2003 01:11:56 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] optimize ia32 memmove
Message-ID: <20031230011156.N6209@schatzie.adilger.int>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@osdl.org>, manfred@colorfullife.com,
	linux-kernel@vger.kernel.org
References: <200312300713.hBU7DGC4024213@hera.kernel.org> <3FF129F9.7080703@pobox.com> <20031229235158.755e026c.akpm@osdl.org> <3FF12FC7.5030202@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FF12FC7.5030202@pobox.com>; from jgarzik@pobox.com on Tue, Dec 30, 2003 at 02:56:55AM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 30, 2003  02:56 -0500, Jeff Garzik wrote:
> Andrew Morton wrote:
> > Jeff Garzik <jgarzik@pobox.com> wrote:
> > 
> >>Linux Kernel Mailing List wrote:
> >>
> >>>ChangeSet 1.1496.22.32, 2003/12/29 21:45:30-08:00, akpm@osdl.org
> >>>
> >>>	[PATCH] optimize ia32 memmove
> >>>	
> >>>	From: Manfred Spraul <manfred@colorfullife.com>
> >>>	
> >>>	The memmove implementation of i386 is not optimized: it uses movsb, which is
> >>>	far slower than movsd.  The optimization is trivial: if dest is less than
> >>>	source, then call memcpy().  markw tried it on a 4xXeon with dbt2, it saved
> >>>	around 300 million cpu ticks in cache_flusharray():
> >>
> >>[...]
> >>
> >>>diff -Nru a/include/asm-i386/string.h b/include/asm-i386/string.h
> >>>--- a/include/asm-i386/string.h	Mon Dec 29 23:13:20 2003
> >>>+++ b/include/asm-i386/string.h	Mon Dec 29 23:13:20 2003
> >>>@@ -299,14 +299,9 @@
> >>> static inline void * memmove(void * dest,const void * src, size_t n)
> >>> {
> >>> int d0, d1, d2;
> >>>-if (dest<src)
> >>>-__asm__ __volatile__(
> >>>-	"rep\n\t"
> >>>-	"movsb"
> >>>-	: "=&c" (d0), "=&S" (d1), "=&D" (d2)
> >>>-	:"0" (n),"1" (src),"2" (dest)
> >>>-	: "memory");
> >>>-else
> >>>+if (dest<src) {
> >>>+	memcpy(dest,src,n);
> >>>+} else
> >>> __asm__ __volatile__(
> >>> 	"std\n\t"
> >>> 	"rep\n\t"
> >>
> >>Dumb question, though...   what about the overlap case, when dest<src ? 
> >>  It seems to me this change is ignoring that.
> >>
> > 
> > 
> > "if dest is less that source, then call memcpy".  If the move is to a
> > higher address we do it the old way.
> 
> 
> I'm confused... that doesn't say anything to me about overlap.
> 
> They can still overlap:  Consider if dest is 1 byte less than src, and 
> n==128...

The non-overlapping cases are probably very common and worth optimizing for:

	if (dest + n < src || src + n < dest) {
		memcpy(dest, src, n);
	} else {
		"old way"
	}

People generally call memmove() if they _think_ the areas might overlap,
but if memcpy() can be so much faster it is probably worth catching the
cases where the two areas don't actually overlap.  The above assumes that
"dest + n" and "src + n" don't wrap, but that is probably a broken case
in the current code so not worth adding extra checks in for.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

