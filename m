Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267439AbUHEFcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267439AbUHEFcA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 01:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267549AbUHEFcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 01:32:00 -0400
Received: from holomorphy.com ([207.189.100.168]:15809 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267439AbUHEFb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 01:31:59 -0400
Date: Wed, 4 Aug 2004 22:31:55 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [sparc32] [13/13] ignore undefined symbols with 3 or more leading underscores
Message-ID: <20040805053155.GE2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040805044130.GU2334@holomorphy.com> <20040805044427.GV2334@holomorphy.com> <20040805044627.GW2334@holomorphy.com> <20040805044736.GX2334@holomorphy.com> <20040805044839.GY2334@holomorphy.com> <20040805044950.GZ2334@holomorphy.com> <20040805045417.GA2334@holomorphy.com> <20040805045528.GB2334@holomorphy.com> <20040805045643.GC2334@holomorphy.com> <20040805050141.GD2334@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805050141.GD2334@holomorphy.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2004 at 10:01:41PM -0700, William Lee Irwin III wrote:
> From: Art Haas <ahaas@airmail.net>
> The 1.3->1.4 changes to the arch/sparc/lib/copy_user.S file added
> parenthesis to a number of macros within that file. The BK changlog
> associated with this change indicate the change was to make the
> file work with gcc-3.3.

***** this touches core files ******

All of the BTFIXUP-related symbols are prefixed with at least three
underscores. In order not to trip this error, sparc32 needs to have
some kind of hook around this phase of linking. So here is one method.

****** this may not be the best patch possible *******

Index: mm2-2.6.8-rc2/Makefile
===================================================================
--- mm2-2.6.8-rc2.orig/Makefile
+++ mm2-2.6.8-rc2/Makefile
@@ -538,7 +538,8 @@
 	$(if $($(quiet)cmd_vmlinux__),					\
 	  echo '  $($(quiet)cmd_vmlinux__)' &&) 			\
 	$(cmd_vmlinux__);						\
-	if $(OBJDUMP) --syms $@ | egrep -q '^([^R]|R[^E]|RE[^G])[^w]*\*UND\*'; then	\
+	if $(OBJDUMP) --syms $@ | $(AWK) '$$4!~/^___.*/ { print $$0 }'	\
+		| egrep -q '^([^R]|R[^E]|RE[^G])[^w]*\*UND\*'; then	\
 		echo 'ldchk: $@: final image has undefined symbols:';	\
 		$(NM) $@ | sed 's/^ *U \(.*\)/  \1/p;d';		\
 		$(RM) -f $@;						\
