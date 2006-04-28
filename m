Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965069AbWD1A0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965069AbWD1A0Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 20:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965157AbWD1AZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 20:25:51 -0400
Received: from cantor2.suse.de ([195.135.220.15]:33238 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965068AbWD1AZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 20:25:39 -0400
Date: Thu, 27 Apr 2006 17:24:04 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Win Treese <treese@acm.org>, Ralf Baechle <ralf@linux-mips.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 24/24] MIPS: Fix branch emulation for floating-point exceptions.
Message-ID: <20060428002404.GY18750@kroah.com>
References: <20060428001226.204293000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="MIPS-0004.patch"
In-Reply-To: <20060428001557.GA18750@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Win Treese <treese@acm.org>

In the branch emulation for floating-point exceptions, __compute_return_epc
must determine for bc1f et al which condition code bit to test. This is
based on bits <4:2> of the rt field. The switch statement to distinguish
bc1f et al needs to use only the two low bits of rt, but the old code tests
on the whole rt field.  This patch masks off the proper bits.

Signed-off-by: Win Treese <treese@acm.org>
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/mips/kernel/branch.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.16.11.orig/arch/mips/kernel/branch.c
+++ linux-2.6.16.11/arch/mips/kernel/branch.c
@@ -184,7 +184,7 @@ int __compute_return_epc(struct pt_regs 
 		bit = (insn.i_format.rt >> 2);
 		bit += (bit != 0);
 		bit += 23;
-		switch (insn.i_format.rt) {
+		switch (insn.i_format.rt & 3) {
 		case 0:	/* bc1f */
 		case 2:	/* bc1fl */
 			if (~fcr31 & (1 << bit))

--
