Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262788AbVAFJTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbVAFJTf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 04:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262789AbVAFJTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 04:19:35 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:27861 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S262788AbVAFJTZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 04:19:25 -0500
Date: Thu, 6 Jan 2005 10:18:44 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, jaharkes@cs.cmu.edu,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       acme@conectiva.com.br, davem@redhat.com, kas@fi.muni.cz,
       nathans@sgi.com
Subject: Re: [Coverity] Untrusted user data in kernel
Message-ID: <20050106091844.GB6961@fi.muni.cz>
References: <1103247211.3071.74.camel@localhost.localdomain> <20050105120423.GA13662@logos.cnet> <20050105161653.GF13455@fi.muni.cz> <20050105140549.GA14622@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050105140549.GA14622@logos.cnet>
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.42
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

: //////////////////////////////////////////////
: // 6:   /drivers/net/wan/sdla.c::sdla_xfer  //
: //////////////////////////////////////////////
: 
	I am not a maintainer of sdla driver, but being Cc'd with this
mail, I'll try to look at it.

: - tainted signed scalar mem.len passed to kmalloc and memset (1206 and
: 1211, or 1220 and 1223). Possibly minor because of kmalloc's
: implicit size check

	Yes. The value mem.len is passed to kmalloc and the code immediately
returns -ENOMEM when kmalloc fails.

: Protected by NET_ADMIN caps, but definately needs some bound checking.
:
	Depends on whether the kmalloc's internal checks are
sufficient or not.

: Jan, I think SDLA_MAX_DATA is the correct bound to check for here, can
: you confirm please?
: 
	I cannot because I don't know or even have this hardware.
However: looking at the definitions in include/linux/sdla.h and the
code itself it looks like SDLA_READMEM, SDLA_WRITEMEM, and SDLA_CLEAR
ioctls are for reading/writing/clearing the card memory itself (maybe
for debugging purposes or downloading a firmware or what). So no,
SDLA_MAX_DATA is probably not a correct limit there.

	The SDLA_CLEAR ioctl (the sdla_clear(dev) function) tries
to clear exactly 65536 bytes (hardcoded at sdla.c:sdla_clear() line 140).
So the mem.len should be <= 65536 bytes, and even mem.addr + mem.len
should be <= 65536 bytes.

	So I propose the following patch (maybe the constant 65536 should
be defined in sdla.h and used both in sdla_xfer() and sdla_clear()):

Signed-off-by: Jan "Yenya" Kasprzak <kas@fi.muni.cz>

--- linux-2.4.28/drivers/net/wan/sdla.c.orig	2002-11-29 00:53:14.000000000 +0100
+++ linux-2.4.28/drivers/net/wan/sdla.c	2005-01-06 10:14:21.115490248 +0100
@@ -1195,6 +1195,10 @@
 
 	if(copy_from_user(&mem, info, sizeof(mem)))
 		return -EFAULT;
+
+	if (mem.len <= 0 || mem.addr < 0 || mem.len > 65536 || mem.addr > 65535
+		|| mem.addr + mem.len > 65536)
+		return -EFAULT;
 		
 	if (read)
 	{	


-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <
