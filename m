Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965531AbWIRIFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965531AbWIRIFv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 04:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965532AbWIRIFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 04:05:50 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:38135 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965530AbWIRIFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 04:05:47 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [patch 1/8] extend make headers_check to detect more problems
Date: Mon, 18 Sep 2006 10:05:36 +0200
User-Agent: KMail/1.9.1
Cc: David Woodhouse <dwmw2@infradead.org>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <20060918012740.407846000@klappe.arndb.de> <20060918013216.335200000@klappe.arndb.de> <20060918062152.GA7088@uranus.ravnborg.org>
In-Reply-To: <20060918062152.GA7088@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609181005.36817.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 September 2006 08:21, Sam Ravnborg wrote:
> > --- linux-cg.orig/scripts/hdrcheck.sh	2006-09-18 02:04:44.000000000 +0200
> > +++ linux-cg/scripts/hdrcheck.sh	2006-09-18 02:04:45.000000000 +0200
> > @@ -1,8 +1,28 @@
> >  #!/bin/sh
> >  
> > +# check if all included files exist
> >  for FILE in `grep '^[ \t]*#[ \t]*include[ \t]*<' $2 | cut -f2 -d\< | cut -f1 -d\> | egrep ^linux\|^asm` ; do
> >      if [ ! -r $1/$FILE ]; then
> >  	echo $2 requires $FILE, which does not exist in exported headers
> >  	exit 1
> >      fi
> >  done
> > +
> > +# try to compile in order to see CC warnings, show only the first few
> > +CHECK_CFLAGS=`grep @headercheck: $2 | sed -e 's/^.*@headercheck:\([^@]*\)@.*$/\1/'`
> 
> The purpose of @headercheck: should be documented sonewhere.
> A simple way to do so would be to paste the content of the changelog that
> describe it in the top of this file.

ok. I've ended up writing more than that now, since the headers_install
target also wasn't documented well.

> > +CFLAGS="-Wall -std=gnu99 -xc -O2 -I$1 ${CHECK_CFLAGS}"
> > +tmpfile=`mktemp`
> Can't we do this with a hdrchk$$$ filename to avoid using
> random entropy for each compile?

For now, I've hacked something up in the script below. I suppose
that can be improved with Dave's proposal by doing it from the
Makefile.

> > +${CC:-gcc} ${CFLAGS} -c $2 -o $tmpfile 2>&1 | sed -e "s:$1:include:g" >&2
> > +
> > +# check if object file is empty
> > +if [ "`nm $tmpfile`" ] ; then
> Replace nm with {NM:-nm} to obtain correct NM when cross compiling.
> 
> > +    echo include${2#$1}: warning: non-empty output >&2
> Paste output of nm so one can see what is defined?
> 

ok

	Arnd <><
---
In addition to the problem of including non-existant header
files, a number of other things can go wrong with header
files exported to user space. This adds checks for some
common problems:

- The header fails to include the files it needs, which
  results in build errors when a program tries to include
  it. Check this by doing a dummy compile.

- There is a declarations of a static variable or non-inline
  function in the header, which results in object code
  in every file including it. Check for symbols in the object
  with 'nm'.

- Part of the header is subject to conditional compilation
  based on CONFIG_*. Add a regex search for this.

I found many problems with this, which I then fixed for
powerpc, s390 and i386, in subsequent patches.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

---

Index: linux-cg/scripts/hdrcheck.sh
===================================================================
--- linux-cg.orig/scripts/hdrcheck.sh	2006-09-18 08:44:08.000000000 +0200
+++ linux-cg/scripts/hdrcheck.sh	2006-09-18 09:59:13.000000000 +0200
@@ -1,8 +1,28 @@
 #!/bin/sh
 
+# check if all included files exist
 for FILE in `grep '^[ \t]*#[ \t]*include[ \t]*<' $2 | cut -f2 -d\< | cut -f1 -d\> | egrep ^linux\|^asm` ; do
     if [ ! -r $1/$FILE ]; then
 	echo $2 requires $FILE, which does not exist in exported headers
 	exit 1
     fi
 done
+
+# try to compile in order to see CC warnings, show only the first few
+CHECK_CFLAGS=`grep @headercheck: $2 | sed -e 's/^.*@headercheck:\([^@]*\)@.*$/\1/'`
+CFLAGS="-Wall -std=gnu99 -xc -O2 -I$1 ${CHECK_CFLAGS}"
+mkdir -p ${3%/*}
+${CC:-gcc} ${CFLAGS} -c $2 -o $3 2>&1 | sed -e "s:$1:include:g" >&2
+
+# check if object file is empty
+if [ "`${NM:-nm} $3`" ] ; then
+    echo include${2#$1}: warning: non-empty output >&2
+    ${NM:-nm} $3 >&2
+fi
+
+# check if we use a CONFIG_ symbol, which is not allowed in installed headers
+grep '^[ \t]*#[ \t]*if.*\<CONFIG_[[:alnum:]_]*\>' -n $2 |
+while read i ; do
+    echo include${2#$1}:${i%%:*}: warning: invalid use of `echo $i |
+	sed -e 's/.*\(\<CONFIG_[[:alnum:]_]*\>\).*/\1/g'` >&2
+done
Index: linux-cg/Documentation/headers.txt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cg/Documentation/headers.txt	2006-09-18 09:45:17.000000000 +0200
@@ -0,0 +1,96 @@
+		Exporting data structures to user space
+
+
+===  Background
+
+Traditionally, headers in include/asm and include/linux symlinked to
+/usr/include [1]. This has always been a bad idea and stopped working
+well a few years ago. The next step was that distributions shipped
+their own copy of sometimes heavily modified headers to have
+something usable. Mariusz Mazur was maintaining pre-packaged
+linux-libc-headers [2] that were picked up by some distros but
+in the end that turned out too much work to keep up with.
+
+In 2.6.18, the current mechanism was merged, which uses Makefile
+in the include directory to install a minimal set of user space
+headers that can be used in /usr/include.
+
+
+===  Installing headers
+
+The 'make headers_install' command is used to install headers
+into the location specified with the 'INSTALL_HDR_PATH' environment
+variable. The default location for this is ${OBJDIR}/usr/include.
+
+Which headers get installed is specified in the 'Kbuild' file in
+the source directory containing each headers. The variables used
+in Kbuild to designate these files are:
+
+headers-y    Files that are installed verbatim from the source
+	     directory, as well subdirectories that also contain
+	     installable header files.
+objhdr-y     Files that are installed from the object directory,
+	     having been generated during the kernel build.
+unifdef-y    Files that have both parts for installations and
+	     parts that are private to the kernel. These files
+	     are run through the 'unifdef'(1) program that will
+	     strip all parts inside of '#ifdef __KERNEL__'.
+
+Apart from unifdef, all files are also run through a sed script
+that strips the usage of '#include <linux/compiler.h' [5].
+
+
+===  What should be in installed headers
+
+The contents of /usr/include/linux define the binary interface
+to the kernel. It should ideally only contain data structures
+and definitions of constants used on the kernel ABI. In particular,
+it is not a general helper library. While some applications
+are attempting to e.g. spinlocks or linked lists from the kernel
+in user space, such uses are usually subtly broken and should
+not be encouraged.
+
+The set of installed headers is supposed to be usable without
+dependencies on other files, so none of them can #include headers
+that are not also installed nor use types or macros defined
+elsewhere. Typically, this requires enclosing parts of the header
+inside of #ifdef __KERNEL__, or (preferred) splitting the header
+file into a file that can be included in user space and another
+one that contains the kernel-only parts and is not installed.
+
+
+===  Checking header files
+
+The 'make headers_check' target is used to perform a sanity
+check on the contents of the installed headers[6]. It checks for
+a number of common problems:
+
+- The header file includes another header that is not also
+  present in the set of installed headers.
+
+- The header fails to include the files it needs, which
+  results in build errors when a program tries to include
+  it. Check this by doing a dummy compile.
+
+- There is a declarations of a static variable or non-inline
+  function in the header, which results in object code
+  in every file including it. Check for symbols in the object
+  with 'nm'.
+
+- Part of the header is subject to conditional compilation
+  based on CONFIG_*. Add a regex search for this.
+
+Since the headers are different on each architectures, and
+at least the compile step of headers_check requires a compiler
+for the target architectures, only one architecture can be
+checked at a time.
+
+
+===  References
+
+[1] http://linuxmafia.com/faq/Kernel/usr-src-olinux-symlink.html
+[2] http://ep09.pld-linux.org/~mmazur/linux-libc-headers/
+[3] http://lkml.org/lkml/2006/3/14/144
+[4] http://kerneltrap.org/node/6536
+[5] file:../scripts/Makefile.headersinst
+[6] file:../scripts/hdrcheck.sh
