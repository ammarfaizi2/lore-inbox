Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965003AbWHXPYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbWHXPYc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 11:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965054AbWHXPYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 11:24:32 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12680 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965003AbWHXPYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 11:24:31 -0400
Subject: [PATCH 0/4] Compile kernel with -fwhole-program --combine
From: David Woodhouse <dwmw2@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tiny@selenic.com, devel@laptop.org
In-Reply-To: <1156429585.3012.58.camel@pmac.infradead.org>
References: <1156429585.3012.58.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 16:24:28 +0100
Message-Id: <1156433068.3012.115.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

`-combine'
     If you are compiling multiple source files, this option tells the
     driver to pass all the source files to the compiler at once (for
     those languages for which the compiler can handle this).  This
     will allow intermodule analysis (IMA) to be performed by the
     compiler.  Currently the only language for which this is supported
     is C.  If you pass source files for multiple languages to the
     driver, using this option, the driver will invoke the compiler(s)
     that support IMA once each, passing each compiler all the source
     files appropriate for it.  For those languages that do not support
     IMA this option will be ignored, and the compiler will be invoked
     once for each source file in that language.  If you use this
     option in conjunction with `-save-temps', the compiler will
     generate multiple pre-processed files (one for each source file),
     but only one (combined) `.o' or `.s' file.

`-fwhole-program'
     Assume that the current compilation unit represents whole program
     being compiled.  All public functions and variables with the
     exception of `main' and those merged by attribute
     `externally_visible' become static functions and in a affect gets
     more aggressively optimized by interprocedural optimizers.  While
     this option is equivalent to proper use of `static' keyword for
     programs consisting of single file, in combination with option
     `--combine' this flag can be used to compile most of smaller scale
     C programs since the functions and variables become local for the
     whole combined compilation unit, not for the single source file
     itself.

Using a combination of these two compiler options for building kernel
code leads to some useful optimisation -- especially with modules which
are made up of a bunch of incestuous C files, where none of the global
symbols actually _need_ to be visible outside the directory they reside
in. File systems are a prime example of this -- on PPC64 I see a
reduction in size of ext3.ko by 2.6%, jffs2.ko by 5%, cifs.ko by 8% and
befs.ko by a scary 14%. Strangely, udf.ko seems to have _grown_ by 6.6%
-- that'll probably be another optimisation bug like GCC PR28755.

The same benefits can be extended to the vmlinux too, although there are
caveats with making _everything_ static. However, it's relatively simple
to make EXPORT_SYMBOL() automatically set the 'externally_visible'
attribute on the symbol in question, and to introduce a new '__global'
tag which does the same for those symbols which aren't exported to
modules but which _are_ needed as a global symbol in vmlinux.

Size results from a test build on ppc64 are shown at
http://david.woodhou.se/combine/sizes.csv -- the format is
<old size>,<new size>,<delta>,<percentage * 100>,<object name>

The same file with objects where the size didn't change omitted, and
sorted on percentage is http://david.woodhou.se/combine/sizes-sorted.csv

There are a bunch of GCC bugs which make this interesting:
http://gcc.gnu.org/bugzilla/show_bug.cgi?id=27898
http://gcc.gnu.org/bugzilla/show_bug.cgi?id=27889
http://gcc.gnu.org/bugzilla/show_bug.cgi?id=28706
http://gcc.gnu.org/bugzilla/show_bug.cgi?id=28712
http://gcc.gnu.org/bugzilla/show_bug.cgi?id=28744
http://gcc.gnu.org/bugzilla/show_bug.cgi?id=28755
http://gcc.gnu.org/bugzilla/show_bug.cgi?id=28779

Fixes (or workarounds) for some of these are at
http://david.woodhou.se/combine/gcc-patches/

(Actual patches will follow, to linux-kernel@vger.kernel.org only)

-- 
dwmw2

