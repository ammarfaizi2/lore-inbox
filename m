Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262368AbUK3WeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbUK3WeU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 17:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbUK3WeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 17:34:20 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:51812 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S262370AbUK3Wd4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 17:33:56 -0500
Date: Tue, 30 Nov 2004 23:33:59 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Mariusz Mazur <mmazur@kernel.pl>, David Woodhouse <dwmw2@infradead.org>,
       Alexandre Oliva <aoliva@redhat.com>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041130223359.GA15443@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Mariusz Mazur <mmazur@kernel.pl>,
	David Woodhouse <dwmw2@infradead.org>,
	Alexandre Oliva <aoliva@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
	Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
	hch@infradead.org, linux-kernel@vger.kernel.org,
	libc-hacker@sources.redhat.com
References: <19865.1101395592@redhat.com> <1101837135.26071.380.camel@hades.cambridge.redhat.com> <Pine.LNX.4.58.0411301020160.22796@ppc970.osdl.org> <200411302128.53583.mmazur@kernel.pl> <Pine.LNX.4.58.0411301243000.22796@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411301243000.22796@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2004 at 12:47:50PM -0800, Linus Torvalds wrote:
 If that's all that people want, I hereby proclaim that
> 
> 	include/asm-xxx/user/xxxx.h
> 	include/user/xxxx.h
> 
> is reserved for user-visible stuff. And now you can send me small and 
> localized patches that fix a _particular_ gripe. 

Please use:
 	include/$arch/user-asm/xxxx.h
 	include/user/xxxx.h
	
This allows us to

1) To include file foo.h we still distingush between user versus user-asm:
#include <user/foo.h>		(include/user/foo.h)
#include <user-asm/foo.h>	(include/$arch/user-asm/foo.h)

2) No symlinks needed - just proper options to gcc

	Sam

This should do it for the top-level makefile:

===== Makefile 1.549 vs edited =====
--- 1.549/Makefile	2004-11-15 10:00:11 +01:00
+++ edited/Makefile	2004-11-30 23:31:09 +01:00
@@ -345,6 +345,10 @@
 # Needed to be compatible with the O= option
 LINUXINCLUDE    := -Iinclude \
                    $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include)
+		   
+# Extend include path with user dir
+LINUXINCLUDE	+= -Iinclude/$(ARCH) \
+		   $(if $(KBUILD_SRC), -I$(srctree)/include/$(ARCH))
 
 CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
 

