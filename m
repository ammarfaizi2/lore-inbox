Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269252AbUJKVHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269252AbUJKVHp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 17:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269250AbUJKVHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 17:07:45 -0400
Received: from fmr03.intel.com ([143.183.121.5]:17646 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S269255AbUJKVGM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 17:06:12 -0400
Message-ID: <416AF599.2060801@intel.com>
Date: Mon, 11 Oct 2004 14:05:29 -0700
From: Arun Sharma <arun.sharma@intel.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] Support ia32 exec domains without CONFIG_IA32_SUPPORT
References: <41643EC0.1010505@intel.com> <20041007142710.A12688@infradead.org> <4165D4C9.2040804@intel.com> <mailman.1097223239.25078@unix-os.sc.intel.com> <41671696.1060706@intel.com> <mailman.1097403036.11924@unix-os.sc.intel.com>
In-Reply-To: <mailman.1097403036.11924@unix-os.sc.intel.com>
Content-Type: multipart/mixed;
 boundary="------------090308060502010803020105"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090308060502010803020105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


[ cc'ing LKML - since this really belongs there ]

Original thread on linux-ia64 about supporting alternate root for user level emulators:

http://marc.theaimsgroup.com/?t=109708875700003&r=1&w=2

I've reattached the patch here for new readers.

On 10/10/2004 3:10 AM, Christoph Hellwig wrote:
> On Fri, Oct 08, 2004 at 03:37:10PM -0700, Arun Sharma wrote:
>> On 10/8/2004 1:08 AM, David Mosberger wrote:
>> 
>> >Unfortunately, that thread ran out in a rather unhelpful manner, as
>> >far as I can see.  Rusty seemed to agree that the performance-hit of
>> >doing it all in user-level was unacceptably high, but I didn't see any
>> >actual numbers.  There was a suggestion to decouple the altroot from
>> >the personality which makes some sense, but nobody actually did
>> >anything about it?
>> >
>> 
>> I'd really like this issue to be resolved one way or the other. I'm not 
>> sure I've heard a convincing argument on why my original patch(which adds a 
>> new exec domain unconditionally) should not be applied.
>> 
>> I'm fine with the attached patch to set the altroot via a system call as 
>> well.
> 
> I'd still like to see some number on how much smaller a userland emulation
> is.  Best using qumu because that's opensource and we simply don't care
> about intel's propritary stuff.  Else your patch looks pretty okay - but
> I'd need to go through linux-kernel and hooking up to all architectures.

I've prototyped a generic userland solution that covers just open and stat system calls (for completeness, all path walk related syscalls need to be covered) using the LD_PRELOAD approach.

I saw a 16% degradation in system time on this benchmark:

find /usr/src/linux -name '*.[chS]' | xargs grep fsck

mainly due to the doubling of the number of calls to open. Also, there was a slight increase in user time as well, due to malloc/free overhead.

shar file with the benchmark and system call interposer attached.

	-Arun

--------------090308060502010803020105
Content-Type: text/plain;
 name="ia32-exec-domain.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ia32-exec-domain.patch"


Register the ia32 exec domain even though CONFIG_IA32_SUPPORT and
CONFIG_COMPAT are turned off. This is necessary to support the alternate
root feature for programs running with PER_LINUX32.

Signed-off-by: Arun Sharma <arun.sharma@intel.com>

--- linux26/include/asm-ia64/ia32.h-	2004-10-05 15:30:05.000000000 -0700
+++ linux26/include/asm-ia64/ia32.h	2004-10-05 15:31:11.000000000 -0700
@@ -11,6 +11,8 @@
 
 #ifndef __ASSEMBLY__
 
+extern int register_ia32_exec_domain(void);
+
 # ifdef CONFIG_IA32_SUPPORT
 
 extern void ia32_cpu_init (void);
--- linux26/arch/ia64/kernel/process.c-	2004-10-05 15:20:04.000000000 -0700
+++ linux26/arch/ia64/kernel/process.c	2004-10-05 15:30:57.000000000 -0700
@@ -765,3 +765,19 @@
 }
 
 EXPORT_SYMBOL(machine_power_off);
+
+struct exec_domain ia32_exec_domain;
+
+int __init
+register_ia32_exec_domain()
+{
+	ia32_exec_domain.name = "Linux/x86";
+	ia32_exec_domain.handler = NULL;
+	ia32_exec_domain.pers_low = PER_LINUX32;
+	ia32_exec_domain.pers_high = PER_LINUX32;
+	ia32_exec_domain.signal_map = default_exec_domain.signal_map;
+	ia32_exec_domain.signal_invmap = default_exec_domain.signal_invmap;
+	return register_exec_domain(&ia32_exec_domain);
+}
+
+__initcall(register_ia32_exec_domain);
--- linux26/arch/ia64/ia32/ia32_support.c-	2004-10-05 15:19:24.000000000 -0700
+++ linux26/arch/ia64/ia32/ia32_support.c	2004-10-05 16:37:50.000000000 -0700
@@ -29,7 +29,6 @@
 
 extern void die_if_kernel (char *str, struct pt_regs *regs, long err);
 
-struct exec_domain ia32_exec_domain;
 struct page *ia32_shared_page[NR_CPUS];
 unsigned long *ia32_boot_gdt;
 unsigned long *cpu_gdt_table[NR_CPUS];
@@ -211,14 +210,6 @@
 static int __init
 ia32_init (void)
 {
-	ia32_exec_domain.name = "Linux/x86";
-	ia32_exec_domain.handler = NULL;
-	ia32_exec_domain.pers_low = PER_LINUX32;
-	ia32_exec_domain.pers_high = PER_LINUX32;
-	ia32_exec_domain.signal_map = default_exec_domain.signal_map;
-	ia32_exec_domain.signal_invmap = default_exec_domain.signal_invmap;
-	register_exec_domain(&ia32_exec_domain);
-
 #if PAGE_SHIFT > IA32_PAGE_SHIFT
 	{
 		extern kmem_cache_t *partial_page_cachep;

--------------090308060502010803020105
Content-Type: text/plain;
 name="perf.shar.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="perf.shar.txt"

#!/bin/sh
# This is a shell archive (produced by GNU sharutils 4.2.1).
# To extract the files from this archive, save it to some FILE, remove
# everything before the `!/bin/sh' line above, then type `sh FILE'.
#
# Made on 2004-10-11 13:43 PDT by <adsharma@linux-t08.sc.intel.com>.
# Source directory was `/home/adsharma'.
#
# Existing files will *not* be overwritten unless `-c' is specified.
#
# This shar contains:
# length mode       name
# ------ ---------- ------------------------------------------
#    157 -rw-r--r-- perf/Makefile
#   1227 -rw-r--r-- perf/namei.c
#     56 -rwxr-xr-x perf/test1.sh
#     88 -rwxr-xr-x perf/test.sh
#     85 -rw-r--r-- perf/results.txt
#
save_IFS="${IFS}"
IFS="${IFS}:"
gettext_dir=FAILED
locale_dir=FAILED
first_param="$1"
for dir in $PATH
do
  if test "$gettext_dir" = FAILED && test -f $dir/gettext \
     && ($dir/gettext --version >/dev/null 2>&1)
  then
    set `$dir/gettext --version 2>&1`
    if test "$3" = GNU
    then
      gettext_dir=$dir
    fi
  fi
  if test "$locale_dir" = FAILED && test -f $dir/shar \
     && ($dir/shar --print-text-domain-dir >/dev/null 2>&1)
  then
    locale_dir=`$dir/shar --print-text-domain-dir`
  fi
done
IFS="$save_IFS"
if test "$locale_dir" = FAILED || test "$gettext_dir" = FAILED
then
  echo=echo
else
  TEXTDOMAINDIR=$locale_dir
  export TEXTDOMAINDIR
  TEXTDOMAIN=sharutils
  export TEXTDOMAIN
  echo="$gettext_dir/gettext -s"
fi
if touch -am -t 200112312359.59 $$.touch >/dev/null 2>&1 && test ! -f 200112312359.59 -a -f $$.touch; then
  shar_touch='touch -am -t $1$2$3$4$5$6.$7 "$8"'
elif touch -am 123123592001.59 $$.touch >/dev/null 2>&1 && test ! -f 123123592001.59 -a ! -f 123123592001.5 -a -f $$.touch; then
  shar_touch='touch -am $3$4$5$6$1$2.$7 "$8"'
elif touch -am 1231235901 $$.touch >/dev/null 2>&1 && test ! -f 1231235901 -a -f $$.touch; then
  shar_touch='touch -am $3$4$5$6$2 "$8"'
else
  shar_touch=:
  echo
  $echo 'WARNING: not restoring timestamps.  Consider getting and'
  $echo "installing GNU \`touch', distributed in GNU File Utilities..."
  echo
fi
rm -f 200112312359.59 123123592001.59 123123592001.5 1231235901 $$.touch
#
if mkdir _sh21367; then
  $echo 'x -' 'creating lock directory'
else
  $echo 'failed to create lock directory'
  exit 1
fi
# ============= perf/Makefile ==============
if test ! -d 'perf'; then
  $echo 'x -' 'creating directory' 'perf'
  mkdir 'perf'
fi
if test -f 'perf/Makefile' && test "$first_param" != -c; then
  $echo 'x -' SKIPPING 'perf/Makefile' '(file already exists)'
else
  $echo 'x -' extracting 'perf/Makefile' '(text)'
  sed 's/^X//' << 'SHAR_EOF' > 'perf/Makefile' &&
CFLAGS		=	-D_GNU_SOURCE
X
all: libaltroot.so
X
libaltroot.so: namei.o
X	gcc -shared -g -fpic namei.o -o libaltroot.so -ldl
X
clean:
X	$(RM) namei.o libaltroot.so
SHAR_EOF
  (set 20 04 10 11 13 43 04 'perf/Makefile'; eval "$shar_touch") &&
  chmod 0644 'perf/Makefile' ||
  $echo 'restore of' 'perf/Makefile' 'failed'
  if ( md5sum --help 2>&1 | grep 'sage: md5sum \[' ) >/dev/null 2>&1 \
  && ( md5sum --version 2>&1 | grep -v 'textutils 1.12' ) >/dev/null; then
    md5sum -c << SHAR_EOF >/dev/null 2>&1 \
    || $echo 'perf/Makefile:' 'MD5 check failed'
c04da369bdfbb9e9a73346b393ac99a0  perf/Makefile
SHAR_EOF
  else
    shar_count="`LC_ALL= LC_CTYPE= LANG= wc -c < 'perf/Makefile'`"
    test 157 -eq "$shar_count" ||
    $echo 'perf/Makefile:' 'original size' '157,' 'current size' "$shar_count!"
  fi
fi
# ============= perf/namei.c ==============
if test -f 'perf/namei.c' && test "$first_param" != -c; then
  $echo 'x -' SKIPPING 'perf/namei.c' '(file already exists)'
else
  $echo 'x -' extracting 'perf/namei.c' '(text)'
  sed 's/^X//' << 'SHAR_EOF' > 'perf/namei.c' &&
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <dlfcn.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <linux/limits.h>
#include <fcntl.h>
X
#define EMULATE 1
X
int open(const char *pathname, int flags, ...)
{
X    static int (*func) (const char *, int, mode_t);
X    int ret;
X    mode_t mode;
X    char *buf;
X  
X    if (!func)
X	func = (int (*)()) dlsym(RTLD_NEXT, "open");
X
#ifdef EMULATE
X    if (*pathname == '/') {
X    	buf = malloc(PATH_MAX);
X	strncpy(buf, "/emul/ia32-linux", PATH_MAX);
X	strncat(buf, pathname, PATH_MAX-16);
X    	ret = func(buf, flags, mode);
X	if (ret != -1) {
X		free(buf);
X		return ret;
X	}
X	free(buf);
X    }
#endif
X
X    ret = func(pathname, flags, mode);
X
X    return ret;
}
X
int stat(const char *pathname, struct stat *buf1)
{
X    static int (*func) (const char *, struct stat *);
X    int ret;
X    char *buf;
X
X    if (!func)
X	func = (int (*)()) dlsym(RTLD_NEXT, "stat");
X
#ifdef EMULATE
X    if (*pathname == '/') {
X    	buf = malloc(PATH_MAX);
X	strncpy(buf, "/emul/ia32-linux", PATH_MAX);
X	strncat(buf, pathname, PATH_MAX-16);
X    	ret = func(buf, buf1);
X	if (ret != -1) {
X		free(buf);
X		return ret;
X	}
X	free(buf);
X    }
#endif
X
X    ret = func(pathname, buf1);
X
X    return ret;
}
SHAR_EOF
  (set 20 04 10 11 13 28 34 'perf/namei.c'; eval "$shar_touch") &&
  chmod 0644 'perf/namei.c' ||
  $echo 'restore of' 'perf/namei.c' 'failed'
  if ( md5sum --help 2>&1 | grep 'sage: md5sum \[' ) >/dev/null 2>&1 \
  && ( md5sum --version 2>&1 | grep -v 'textutils 1.12' ) >/dev/null; then
    md5sum -c << SHAR_EOF >/dev/null 2>&1 \
    || $echo 'perf/namei.c:' 'MD5 check failed'
968c756b5664cc2125b842b1750e40a8  perf/namei.c
SHAR_EOF
  else
    shar_count="`LC_ALL= LC_CTYPE= LANG= wc -c < 'perf/namei.c'`"
    test 1227 -eq "$shar_count" ||
    $echo 'perf/namei.c:' 'original size' '1227,' 'current size' "$shar_count!"
  fi
fi
# ============= perf/test1.sh ==============
if test -f 'perf/test1.sh' && test "$first_param" != -c; then
  $echo 'x -' SKIPPING 'perf/test1.sh' '(file already exists)'
else
  $echo 'x -' extracting 'perf/test1.sh' '(text)'
  sed 's/^X//' << 'SHAR_EOF' > 'perf/test1.sh' &&
#!/bin/sh
X
find `pwd` -name '*.[chS]' | xargs grep fsck
SHAR_EOF
  (set 20 04 10 11 13 41 25 'perf/test1.sh'; eval "$shar_touch") &&
  chmod 0755 'perf/test1.sh' ||
  $echo 'restore of' 'perf/test1.sh' 'failed'
  if ( md5sum --help 2>&1 | grep 'sage: md5sum \[' ) >/dev/null 2>&1 \
  && ( md5sum --version 2>&1 | grep -v 'textutils 1.12' ) >/dev/null; then
    md5sum -c << SHAR_EOF >/dev/null 2>&1 \
    || $echo 'perf/test1.sh:' 'MD5 check failed'
bd830f72d5ade56e00a8c5c4f0e4c5fe  perf/test1.sh
SHAR_EOF
  else
    shar_count="`LC_ALL= LC_CTYPE= LANG= wc -c < 'perf/test1.sh'`"
    test 56 -eq "$shar_count" ||
    $echo 'perf/test1.sh:' 'original size' '56,' 'current size' "$shar_count!"
  fi
fi
# ============= perf/test.sh ==============
if test -f 'perf/test.sh' && test "$first_param" != -c; then
  $echo 'x -' SKIPPING 'perf/test.sh' '(file already exists)'
else
  $echo 'x -' extracting 'perf/test.sh' '(text)'
  sed 's/^X//' << 'SHAR_EOF' > 'perf/test.sh' &&
#!/bin/sh
X
find `pwd` -name '*.[chS]' | LD_PRELOAD=~/perf/libaltroot.so xargs grep fsck
SHAR_EOF
  (set 20 04 10 11 13 41 25 'perf/test.sh'; eval "$shar_touch") &&
  chmod 0755 'perf/test.sh' ||
  $echo 'restore of' 'perf/test.sh' 'failed'
  if ( md5sum --help 2>&1 | grep 'sage: md5sum \[' ) >/dev/null 2>&1 \
  && ( md5sum --version 2>&1 | grep -v 'textutils 1.12' ) >/dev/null; then
    md5sum -c << SHAR_EOF >/dev/null 2>&1 \
    || $echo 'perf/test.sh:' 'MD5 check failed'
005c01ad066d70c7be266f1bec9074f6  perf/test.sh
SHAR_EOF
  else
    shar_count="`LC_ALL= LC_CTYPE= LANG= wc -c < 'perf/test.sh'`"
    test 88 -eq "$shar_count" ||
    $echo 'perf/test.sh:' 'original size' '88,' 'current size' "$shar_count!"
  fi
fi
# ============= perf/results.txt ==============
if test -f 'perf/results.txt' && test "$first_param" != -c; then
  $echo 'x -' SKIPPING 'perf/results.txt' '(file already exists)'
else
  $echo 'x -' extracting 'perf/results.txt' '(text)'
  sed 's/^X//' << 'SHAR_EOF' > 'perf/results.txt' &&
test1.sh:
X
real 14.49
user 14.09
sys 0.37
X
test.sh:
X
real 14.68
user 14.13
sys 0.43
X
SHAR_EOF
  (set 20 04 10 11 13 42 04 'perf/results.txt'; eval "$shar_touch") &&
  chmod 0644 'perf/results.txt' ||
  $echo 'restore of' 'perf/results.txt' 'failed'
  if ( md5sum --help 2>&1 | grep 'sage: md5sum \[' ) >/dev/null 2>&1 \
  && ( md5sum --version 2>&1 | grep -v 'textutils 1.12' ) >/dev/null; then
    md5sum -c << SHAR_EOF >/dev/null 2>&1 \
    || $echo 'perf/results.txt:' 'MD5 check failed'
db123bdf3d15d40c363be0924ccb2b6d  perf/results.txt
SHAR_EOF
  else
    shar_count="`LC_ALL= LC_CTYPE= LANG= wc -c < 'perf/results.txt'`"
    test 85 -eq "$shar_count" ||
    $echo 'perf/results.txt:' 'original size' '85,' 'current size' "$shar_count!"
  fi
fi
rm -fr _sh21367
exit 0

--------------090308060502010803020105--
