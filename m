Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbWACN03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWACN03 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWACNZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:25:58 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:46597 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932354AbWACNZi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:25:38 -0500
Subject: [PATCH 17/26] kbuild: Fix genksyms handling of DEFINE_PER_CPU(struct foo_s *, bar);
In-Reply-To: <20060103132035.GA17485@mars.ravnborg.org>
X-Mailer: gregkh_patchbomb-sam
Date: Tue, 3 Jan 2006 14:25:26 +0100
Message-Id: <11362947262643@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Holt <holt@sgi.com>
Date: 1135129550 -0600

This is a one-line change to parse.y.
To take advantage of this the scripts/genksyms/*_shipped files needs to
be rebuild - this is the next patch.

When a .c file contains:
DEFINE_PER_CPU(struct foo_s *, bar);

the .cpp output looks like:
__attribute__((__section__(".data.percpu"))) __typeof__(struct foo_s *) per_cpu__bar;

With the existing parse.y, the value inside the paranthesis of
__typeof__() does not evaluate as a type_specifier and therefore
per_cpu__bar does not get assigned a type for genksyms which results in
the EXPORT_PER_CPU_SYMBOL() not generating a CRC value.

I have compared the Modules.symvers with and without this
patch and for ia64's defconfig, the only change is:
Before 0x00000000    per_cpu____sn_nodepda   vmlinux
After  0x9d3f3faa    per_cpu____sn_nodepda   vmlinux

per_cpu____sn_nodepda was the original source of my problems.

Signed-off-by: Robin Holt <holt@sgi.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/genksyms/parse.y |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

a89a0a2354ae666612968e254d650bfd04f11eb6
diff --git a/scripts/genksyms/parse.y b/scripts/genksyms/parse.y
index 0990437..ca04c94 100644
--- a/scripts/genksyms/parse.y
+++ b/scripts/genksyms/parse.y
@@ -197,6 +197,7 @@ storage_class_specifier:
 type_specifier:
 	simple_type_specifier
 	| cvar_qualifier
+	| TYPEOF_KEYW '(' decl_specifier_seq '*' ')'
 	| TYPEOF_KEYW '(' decl_specifier_seq ')'
 
 	/* References to s/u/e's defined elsewhere.  Rearrange things
-- 
1.0.6

