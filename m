Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263806AbUGFMys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUGFMys (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 08:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263847AbUGFMys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 08:54:48 -0400
Received: from holomorphy.com ([207.189.100.168]:36566 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263806AbUGFMyn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 08:54:43 -0400
Date: Tue, 6 Jul 2004 05:54:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm6
Message-ID: <20040706125438.GS21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040705023120.34f7772b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040705023120.34f7772b.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2004 at 02:31:20AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm6/
> - Added the DVD-RW/CD-RW packet writing patches.  These need more work.
> - The USB update seems deadlocky.  I fixed one bug but it still causes my
>   ia64 test box to lock up on boot.  If it goes bad, please revert
>   usb-locking-fix.patch and then revert bk-usb.patch.  Retest and send a report
>   to linux-kernel and linux-usb-devel@lists.sourceforge.net.

Uneventful on alpha, needed a make rpm compilefix Andi's got queued for
the next merge on x86-64 and otherwise uneventful there.

OTOH, various things made sparc64 a living Hell that took about 9
hours of solid compile/boot/crash drudgery to carry out bisection
search on to find the offending patches.

First, I had to back out bk-input because it has a sysfsification patch
that deadlocks sunzilog.c at boot.

Second, I had to back out those scheduler cleanups because it appears
that one of those scheduler cleanups deadlocks the system during
secondary wakeup.

Third, some naive check for undefined symbols failed to understand the
relocation types indicating that a given operand refers to some hard
register, which manifest as undefined symbols in ELF executables. A
patch to refine its criteria, which I used to build with, follows. rmk
and hpa have some other ideas on this undefined symbol issue I've not
quite had the opportunity to get a clear statement of yet.

If it could be arranged so that the authors of the bk-input and
scheduler patches fix their code prior to merging, I'd be much obliged.

Thanks.


-- wli


Index: mm6-2.6.7/Makefile
===================================================================
--- mm6-2.6.7.orig/Makefile	2004-07-05 12:53:05.349741672 -0700
+++ mm6-2.6.7/Makefile	2004-07-05 17:04:04.976330440 -0700
@@ -548,9 +548,14 @@
 	$(if $($(quiet)cmd_vmlinux__),					\
 	  echo '  $($(quiet)cmd_vmlinux__)' &&) 			\
 	$(cmd_vmlinux__);						\
-	if $(NM) $@ | grep -q '^ *U '; then				\
+	if $(OBJDUMP) --all-headers $@ |				\
+		$(AWK) '$$4 == "*UND*" && $$1 !~ /^REG_.*/ { exit 0 }	\
+						END { exit 1 }';	\
+	then								\
 		echo 'ldchk: $@: final image has undefined symbols:';	\
-		$(NM) $@ | sed 's/^ *U \(.*\)/  \1/p;d';		\
+		$(OBJDUMP) --all-headers $@ |				\
+			$(AWK) '$$4 == "*UND*" && $$1 !~ /^REG_.*/	\
+						{ print $$0 }';		\
 		$(RM) -f $@;						\
 		exit 1;							\
 	fi;								\
