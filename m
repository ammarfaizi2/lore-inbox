Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264718AbRF3Efh>; Sat, 30 Jun 2001 00:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264723AbRF3Ef2>; Sat, 30 Jun 2001 00:35:28 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:31618 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S264718AbRF3EfP>; Sat, 30 Jun 2001 00:35:15 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 29 Jun 2001 21:35:10 -0700
Message-Id: <200106300435.VAA14173@adam.yggdrasil.com>
To: alan@lxorguk.ukuu.org.uk, rmk@arm.linux.org.uk
Subject: Re: linux-2.4.6-pre6: numerous dep_{bool,tristate} $CONFIG_ARCH_xxx bugs
Cc: kaos@ocs.com.au, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> = Keith Owens
>  = Alan Cox

>> I'd rather that we fixed dep_* so that undefined symbols were treated as
>> 'n', just like the makefiles treat undefined symbols.
>
>That isnt a simple change. dep_tristate is used both to express 'need this'
>and also 'conflicts with'. Those are ambiguous. You'd need to extend the
>syntax say by adding  ${FOO:N} syntax 

	I do not understand what you (Alan) mean by the "'conflicts with'"
usage.  I do not believe there is any way to directly use dep_* to express
that a "y" answer to some feature requires "n" or even "m" for another
feature.

	Regarding Jeff Garzik's suggestion to just "Define CONFIG_ARCH_xxx
in various arches where needed", the problem primarily arises from
CONFIG_ variables from other architectures, so you're talking about
adding the same set of lines for every architecture, and they are
changes that would have to be maintained.  That wouldn't be the
end of the world, but it would be another instance of people doing
work that computers can do for them.

	Implementing Keith's suggestion will still require changes to
the Config.in files, to put quotation marks around things like
$CONFIG_SPARC64.  Otherwise, the shell will treat the undefined
variable is if it were not provided, as opposed to turning it into
an emptry string argument.  I could put together a patch to do this
if there is a consensus that it is the preferred solution.

	In the meantime, I have implemented the following small kludge
in scripts/Configure that extracts all variables from arch/*/config.in
and sets them all to "n" before reading in their default values.
I only processed the variables in arch/*/config.in so that I could
assume that the list of variables is small and because defaulting the
variables to "n" makes it slightly harder to detect bugs where Config.in
scripts look at the values of variables that have not yet been set.
Because some platforms use variables that do not being with CONFIG_ARCH
(e.g., CONFIG_SPARC64, CONFIG_X86), I could not just filter for CONFIG_ARCH_*.
I could mail Linus a shell script to clean this up too if that were
desired (a patch would be far too messy).  Anyhow, the change seems to
work, although I have been bumping into a lot of other build errors
with linux-2.4.6-pre6, partly as a result of gcc-3.0 pickiness, so
I have yet to see the build complete.  It is a kludge, but at least
it's a solution.  I'm not particularly enamored of any one approach
in this case; I just want it resolved in a way that is unlikely to
lead to recurrence.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."


--- linux-2.4.6-pre6/scripts/Configure	Sat Dec 30 18:16:13 2000
+++ linux/scripts/Configure	Fri Jun 29 15:18:14 2001
@@ -48,6 +48,9 @@
 #
 # 24 January 1999, Michael Elizabeth Chastain, <mec@shout.net>
 # - Improve the exit message (Jeff Ronne).
+#
+# 29 June 2001, Adam J. Richter, <adam@yggdrasil.com>
+# - Default all CONFIG_ARCH_* and CONFIG_X86 to "n"
 
 #
 # Make sure we're really running bash.
@@ -531,6 +534,16 @@
 echo " * Automatically generated C config: don't edit" >> $CONFIG_H
 echo " */" >> $CONFIG_H
 echo "#define AUTOCONF_INCLUDED" >> $CONFIG_H
+
+# Ensure all unselected architectures are set to "n" rather than being
+# undefined, so that dep_bool and dep_tristate properly detect their absense.
+# Really, CONFIG_X86 should be CONFIG_ARCH_X86.
+set +f
+for arch in CONFIG_X86 $(cat arch/*/config.in | tr '   $"' '\n\n\n' |
+              egrep ^CONFIG_ARCH_ | sort -u) ; do
+	define_bool "$arch" "n"
+done
+set -f
 
 DEFAULT=""
 if [ "$1" = "-d" ] ; then
