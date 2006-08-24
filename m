Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030385AbWHXQtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030385AbWHXQtw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 12:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030386AbWHXQtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 12:49:52 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:41877 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1030385AbWHXQtv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 12:49:51 -0400
Date: Thu, 24 Aug 2006 18:48:11 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Woodhouse <dwmw2@infradead.org>
cc: linux-kernel@vger.kernel.org, linux-tiny@selenic.com, devel@laptop.org
Subject: Re: [PATCH 0/4] Compile kernel with -fwhole-program --combine
In-Reply-To: <1156433068.3012.115.camel@pmac.infradead.org>
Message-ID: <Pine.LNX.4.61.0608241840440.16422@yvahk01.tjqt.qr>
References: <1156429585.3012.58.camel@pmac.infradead.org>
 <1156433068.3012.115.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>     If you are compiling multiple source files, this option tells the
>     driver to pass all the source files to the compiler at once (for
>     those languages for which the compiler can handle this).  This
>     will allow intermodule analysis (IMA) to be performed by the
>     compiler.  Currently the only language for which this is supported
>     is C.  If you pass source files for multiple languages to the
>     driver, using this option, the driver will invoke the compiler(s)
>     that support IMA once each, passing each compiler all the source
>     files appropriate for it. 

Compiling files on their own (`make drivers/foo/bar.o`) seems to make 
the optimization void. Sure, most people don't stop compiling in 
between. Just a note

> For those languages that do not support
>     IMA this option will be ignored, and the compiler will be invoked
>     once for each source file in that language.  If you use this
>     option in conjunction with `-save-temps', the compiler will
>     generate multiple pre-processed files (one for each source file),
>     but only one (combined) `.o' or `.s' file.

There should be an option (in the kernel's makefile system) to disable 
its use, just in case `gcc *.c` gobbles up a little more RAM 
than is present.

>Using a combination of these two compiler options for building kernel
>code leads to some useful optimisation -- especially with modules which
>are made up of a bunch of incestuous C files, where none of the global
>symbols actually _need_ to be visible outside the directory they reside
>in.

For modules, we have EXPORT_SYMBOL() and any other symbols that are 
'extern' but not exported are not visible to other modules.

>The same benefits can be extended to the vmlinux too, although there are
>caveats with making _everything_ static. However, it's relatively simple
>to make EXPORT_SYMBOL() automatically set the 'externally_visible'
>attribute on the symbol in question, and to introduce a new '__global'
>tag which does the same for those symbols which aren't exported to
>modules but which _are_ needed as a global symbol in vmlinux.

Does the kernel (at least for modules) really use ELF symbol visibility 
(read: __attribute__((visibility(xyz))) or -fvisibility=xyz) for 
lookups? I do not think so, since EXPORT_SYMBOL explicitly puts something 
into __ksymtab/__kstrtab.
If visibility supports had been in GCC a long time ago, I am sure we would 
not need EXPORT_SYMBOL today, or rather, would do it by use of 
__attribute__() rather than a macro that ksymtabs it. Or am I possibly 
misunderstanding something?


Jan Engelhardt
-- 
