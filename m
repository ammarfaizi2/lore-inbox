Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262624AbTCIVEm>; Sun, 9 Mar 2003 16:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262625AbTCIVEm>; Sun, 9 Mar 2003 16:04:42 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:61960 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S262624AbTCIVEk>;
	Sun, 9 Mar 2003 16:04:40 -0500
Date: Sun, 9 Mar 2003 22:15:18 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kconfig update
Message-ID: <20030309211518.GA18087@mars.ravnborg.org>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0303090432200.32518-100000@serv> <20030309190103.GA1170@mars.ravnborg.org> <Pine.LNX.4.44.0303092028020.32518-100000@serv> <20030309193439.GA15837@mars.ravnborg.org> <Pine.LNX.4.44.0303092115310.32518-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303092115310.32518-100000@serv>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 09, 2003 at 09:18:30PM +0100, Roman Zippel wrote:
> I still don't see what you mean. :)

Sample output:
$ make mrproper
$ make KBUILD_VERBOSE=0 defconfig
  HOSTCC  scripts/fixdep
  HOSTCC  scripts/split-include
.....
  HOSTLD  scripts/kconfig/conf
SAM> Until here, just normal build output
./scripts/kconfig/conf -d arch/i386/Kconfig
SAM> OK, we run conf
./arch/i386/defconfig:544: trying to assign nonexistent symbol NET_PCMCIA_RADIO
SAM> One warning, but not fatal so we proceed
*
* Linux Kernel Configuration
*
Support for paging of anonymous memory (SWAP) [Y/n/?] y

SAM> Snipped ~890 lines

Cryptographic API (CRYPTO) [N/y/?] n
*
* Library routines
*
CRC32 functions (CRC32) [N/m/y/?] n
$ _

So executing "make KBUILD_VERBOSE=0 defconfig"
results in ~930 lines of output, including one warning message.

What I request is that conf outputs essential stuff only, for example
warnings.
That would remove 900 lines of output when building a kernel,
and maybe people actually paid attention to the warnings generated
by kconfig.

In general I prefer minimum output when building the kernel, without
loosing the ability to follow progress.
One reason why we have some of the warnings left all around in the kernel is
due to the fact people does not see them when building their drivers etc.
With default options to make, warnings simply does not show up as visible,
and when the build proceeds the relevant parts scroll out.

See my point now?

Also speaking about warnings. How about sticking in a "warning:",
to make the format gcc compatible.
Something like attacted patch.

	Sam

===== scripts/kconfig/confdata.c 1.4 vs edited =====
--- 1.4/scripts/kconfig/confdata.c	Sun Dec  8 05:14:02 2002
+++ edited/scripts/kconfig/confdata.c	Sun Mar  9 22:11:37 2003
@@ -148,7 +148,7 @@
 				*p2 = 0;
 			sym = sym_find(line + 7);
 			if (!sym) {
-				fprintf(stderr, "%s:%d: trying to assign nonexistent symbol %s\n", name, lineno, line + 7);
+				fprintf(stderr, "%s:%d: warning: trying to assign nonexistent symbol %s\n", name, lineno, line + 7);
 				break;
 			}
 			switch (sym->type) {
@@ -181,7 +181,7 @@
 					memmove(p2, p2 + 1, strlen(p2));
 				}
 				if (!p2) {
-					fprintf(stderr, "%s:%d: invalid string found\n", name, lineno);
+					fprintf(stderr, "%s:%d: error: invalid string found\n", name, lineno);
 					exit(1);
 				}
 			case S_INT:
@@ -190,7 +190,7 @@
 					S_VAL(sym->def) = strdup(p);
 					sym->flags &= ~SYMBOL_NEW;
 				} else {
-					fprintf(stderr, "%s:%d: symbol value '%s' invalid for %s\n", name, lineno, p, sym->name);
+					fprintf(stderr, "%s:%d: error: symbol value '%s' invalid for %s\n", name, lineno, p, sym->name);
 					exit(1);
 				}
 				break;
