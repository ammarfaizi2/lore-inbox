Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264258AbUD0SMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264258AbUD0SMr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 14:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264265AbUD0SMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 14:12:16 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:2224 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264258AbUD0SJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 14:09:30 -0400
Date: Tue, 27 Apr 2004 20:09:24 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: "J.A.Magallon" <jamagallon@able.es>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] incomplete dependencies with BK tree (was: Anyone got aic7xxx working with 2.4.26?)
Message-ID: <20040427180924.GA22366@merlin.emma.line.org>
Mail-Followup-To: "J.A.Magallon" <jamagallon@able.es>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org
References: <200404261532.37860.dj@david-web.co.uk> <20040426161004.GE5430@merlin.emma.line.org> <20040427131941.GC10264@logos.cnet> <20040427142643.GA10553@merlin.emma.line.org> <6A88E87D-985B-11D8-AA97-000A9585C204@able.es> <20040427161314.GA18682@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040427161314.GA18682@merlin.emma.line.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2004, Matthias Andree wrote:

> On Tue, 27 Apr 2004, J.A.Magallon wrote:
> 
> > -nostdinc should be mandatory ?
> 
> Seems to be in use on my machine, looking at what "make" prints.

OK, here's how I can reproduce my previous problems - and I start
wondering why -nostdinc is missing this time:

rm include/asm/processor.h
make

-> boom:

| gcc -D__KERNEL__ -I/space/BK/linux-2.4-dm/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon   -DKBUILD_BASENAME=main -c -o init/main.o init/main.c
| In file included from /space/BK/linux-2.4-dm/include/linux/mm.h:4,
|                  from /space/BK/linux-2.4-dm/include/linux/slab.h:14,
|                  from /space/BK/linux-2.4-dm/include/linux/proc_fs.h:5,
|                  from init/main.c:15:
| /space/BK/linux-2.4-dm/include/linux/sched.h:807: error: conflicting types for `kernel_thread'
| /usr/include/asm/processor.h:428: error: previous declaration of `kernel_thread'
| make: *** [init/main.o] Fehler 1

Given that init wants stdarg.h, -nostdinc is not an option for init/main.c.

Looking further, I find that include/asm/processor.h is not listed in
.depend or .hdepend.

Looks like a mkdep problem: the .hdepend file appears to lists only
files that actually exist - and hence it will not list a dependency on
include/asm/processor.h when it's missing -- creating a hen-and-egg problem:

1. because the file isn't there, it isn't listed as a dependency, follows: #2.

2. because it isn't listed as a dependency, make will not try
   to "get include/asm/processor.h", follows: #1.

I believe the "if (access(path->buffer, F_OK) == 0)" at line 204 in
scripts/mkdep.c needs to be revised, it appears overzealous for a
BitKeeper-hosted tree. Someone more familiar with kbuild-2.4 should do
that.

I am suggesting the following patch (bksend format) that fixes the issue
for me (it isn't complete, the Config.in stuff also needs support, but
it fails in much more obvious ways - i. e. it prints which file it
cannot access, whereas #includes pick up the wrong file or spew tons of
warnings, burying the actual "include file not found" message):

 mkdep.c |   78 ++++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 66 insertions(+), 12 deletions(-)

This BitKeeper patch contains the following changesets:
1.1390

# This is a BitKeeper patch.  What follows are the unified diffs for the
# set of deltas contained in the patch.  The rest of the patch, the part
# that BitKeeper cares about, is below these diffs.
# User:	matthias.andree
# Host:	gmx.de
# Root:	/suse/kernel/BK/linux-2.4-dm

#
#--- 1.4/scripts/mkdep.c	Sat May  4 15:53:16 2002
#+++ 1.5/scripts/mkdep.c	Tue Apr 27 20:01:36 2004
#@@ -30,6 +30,7 @@
#  *   -isystem, -I- etc.
#  */
# 
#+#define _GNU_SOURCE /* for stpcpy */
# #include <ctype.h>
# #include <fcntl.h>
# #include <limits.h>
#@@ -81,6 +82,13 @@
# 	}
# }
# 
#+static void
#+oom(void)
#+{
#+    fprintf(stderr, "mkdep: out of memory.\n");
#+    exit(1);
#+}
#+
# /*
#  * Grow the configuration string to a desired length.
#  * Usually the first growth is plenty.
#@@ -92,7 +100,7 @@
# 			size_config = 2048;
# 		str_config = realloc(str_config, size_config *= 2);
# 		if (str_config == NULL)
#-			{ perror("malloc config"); exit(1); }
#+			oom();
# 	}
# }
# 
#@@ -162,7 +170,7 @@
# 			size_precious = 2048;
# 		str_precious = realloc(str_precious, size_precious *= 2);
# 		if (str_precious == NULL)
#-			{ perror("malloc"); exit(1); }
#+			oom();
# 	}
# }
# 
#@@ -182,7 +190,57 @@
# 	len_precious += 3;
# }
# 
#+/* Matthias Andree:
#+ * stpncpy copies at most max bytes from src to dest, adds a NUL byte
#+ * and returns a pointer to the NUL byte.
#+ * WARNING: dest must be able to hold max + 1 bytes!
#+ */
#+static char *stpn0cpy(char *dest, const char *src, size_t max)
#+{
#+	while(max) {
#+		*dest = *(src++);
#+		if (*dest == '\0')
#+			return dest;
#+		dest++;
#+		max--;
#+	}
#+	*dest = '\0';
#+	return dest;
#+}
# 
#+/* Matthias Andree:
#+ * check if an SCCS/s. file corresponding to path exists.
#+ */
#+static int access_sccs(const struct path_struct *path, const char *name, const int len)
#+{
#+	char prefix[] = "SCCS/s.";
#+	size_t pfxlen = strlen(prefix), seplen;
#+	const char *lastsep = name + len;
#+	int rv;
#+	char *t, *d;
#+
#+	t = malloc(path->len + pfxlen + len + 1);
#+	if (!t)
#+		oom();
#+
#+	while(--lastsep >= name)
#+		if (*lastsep == '/')
#+			break;
#+
#+	if (lastsep < name)
#+		lastsep = name;
#+	else
#+		lastsep ++;
#+	seplen = lastsep - name;
#+
#+	d = stpn0cpy(t, path->buffer, path->len);
#+	d = stpn0cpy(d, name, seplen);
#+	d = stpcpy(d, prefix);
#+	d = stpn0cpy(d, name+seplen, len - seplen);
#+	rv = access(t, F_OK);
#+	free(t);
#+	return rv;
#+}
# 
# /*
#  * Handle an #include line.
#@@ -201,13 +259,13 @@
# 	for (i = start, path = path_array+start; i < paths; ++i, ++path) {
# 		memcpy(path->buffer+path->len, name, len);
# 		path->buffer[path->len+len] = '\0';
#-		if (access(path->buffer, F_OK) == 0) {
#+		if (access(path->buffer, F_OK) == 0
#+			|| access_sccs(path, name, len) == 0) {
# 			do_depname();
# 			printf(" \\\n   %s", path->buffer);
# 			return;
# 		}
# 	}
#-
# }
# 
# 
#@@ -233,18 +291,14 @@
# 	}
# 
# 	path_array = realloc(path_array, (++paths)*sizeof(*path_array));
#-	if (!path_array) {
#-		fprintf(stderr, "cannot expand path_arry\n");
#-		exit(1);
#-	}
#+	if (!path_array)
#+		oom();
# 
# 	path = path_array+paths-1;
# 	path->len = strlen(name2);
# 	path->buffer = malloc(path->len+1+256+1);
#-	if (!path->buffer) {
#-		fprintf(stderr, "cannot allocate path buffer\n");
#-		exit(1);
#-	}
#+	if (!path->buffer)
#+		oom();
# 	strcpy(path->buffer, name2);
# 	if (path->len && *(path->buffer+path->len-1) != '/') {
# 		*(path->buffer+path->len) = '/';
#

# Diff checksum=11f9831e


# Patch vers:	1.3
# Patch type:	REGULAR

== ChangeSet ==
torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
geert@linux-m68k.org|ChangeSet|20040427115253|59043
D 1.1390 04/04/27 20:05:55+02:00 matthias.andree@gmx.de +1 -0
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c mkdep.c:
c   When searching paths, check for path/SCCS/s.name
c   files in addition to path/name files, to have a more
c   complete dependency record.
K 59773
P ChangeSet
------------------------------------------------

0a0
> torvalds@athlon.transmeta.com|scripts/mkdep.c|20020205174036|09708|c47e74e17b837ca3 matthias.andree@gmx.de|scripts/mkdep.c|20040427180136|27902

== scripts/mkdep.c ==
torvalds@athlon.transmeta.com|scripts/mkdep.c|20020205174036|09708|c47e74e17b837ca3
kaos@ocs.com.au|scripts/mkdep.c|20020514005529|09830
D 1.5 04/04/27 20:01:36+02:00 matthias.andree@gmx.de +66 -12
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Cleanup: consolidate all out-of-memory print/exit
c in a single oom() function.
c Feature: when searching for includes, also look for
c path/SCCS/s.name files.
K 27902
O -rw-rw-r--
P scripts/mkdep.c
------------------------------------------------

I32 1
#define _GNU_SOURCE /* for stpcpy */
I83 7
static void
oom(void)
{
    fprintf(stderr, "mkdep: out of memory.\n");
    exit(1);
}
\
D95 1
I95 1
			oom();
D165 1
I165 1
			oom();
I184 17
/* Matthias Andree:
 * stpncpy copies at most max bytes from src to dest, adds a NUL byte
 * and returns a pointer to the NUL byte.
 * WARNING: dest must be able to hold max + 1 bytes!
 */
static char *stpn0cpy(char *dest, const char *src, size_t max)
{
	while(max) {
		*dest = *(src++);
		if (*dest == '\0')
			return dest;
		dest++;
		max--;
	}
	*dest = '\0';
	return dest;
}
I185 33
/* Matthias Andree:
 * check if an SCCS/s. file corresponding to path exists.
 */
static int access_sccs(const struct path_struct *path, const char *name, const int len)
{
	char prefix[] = "SCCS/s.";
	size_t pfxlen = strlen(prefix), seplen;
	const char *lastsep = name + len;
	int rv;
	char *t, *d;
\
	t = malloc(path->len + pfxlen + len + 1);
	if (!t)
		oom();
\
	while(--lastsep >= name)
		if (*lastsep == '/')
			break;
\
	if (lastsep < name)
		lastsep = name;
	else
		lastsep ++;
	seplen = lastsep - name;
\
	d = stpn0cpy(t, path->buffer, path->len);
	d = stpn0cpy(d, name, seplen);
	d = stpcpy(d, prefix);
	d = stpn0cpy(d, name+seplen, len - seplen);
	rv = access(t, F_OK);
	free(t);
	return rv;
}
D204 1
I204 2
		if (access(path->buffer, F_OK) == 0
			|| access_sccs(path, name, len) == 0) {
D210 1
D236 4
I239 2
	if (!path_array)
		oom();
D244 4
I247 2
	if (!path->buffer)
		oom();

# Patch checksum=ea3230b5

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
