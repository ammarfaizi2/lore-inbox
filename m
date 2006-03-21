Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030435AbWCUQbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030435AbWCUQbI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbWCUQaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:30:39 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:28940 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030295AbWCUQVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:13 -0500
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 32/46] kbuild: in the section mismatch check try harder to find symbols
In-Reply-To: <11429580562973-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:56 +0100
Message-Id: <11429580562919-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When searching for symbols the only check performed was if
offset equals st_value. Adding an additional check to see if st_name
points t a valid name made us sort out a few more false positives and
let us report more correct names in warnings.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/mod/modpost.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

43c74d179596ba1f8eceb8c6a5c7e11afe233662
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 3b570b1..3648683 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -558,7 +558,10 @@ static Elf_Sym *find_elf_symbol(struct e
 }
 
 /*
- * Find symbols before or equal addr and after addr - in the section sec
+ * Find symbols before or equal addr and after addr - in the section sec.
+ * If we find two symbols with equal offset prefer one with a valid name.
+ * The ELF format may have a better way to detect what type of symbol
+ * it is, but this works for now.
  **/
 static void find_symbols_between(struct elf_info *elf, Elf_Addr addr,
 				 const char *sec,
@@ -587,6 +590,12 @@ static void find_symbols_between(struct 
 				beforediff = addr - sym->st_value;
 				*before = sym;
 			}
+			else if ((addr - sym->st_value) == beforediff) {
+				/* equal offset, valid name? */
+				const char *name = elf->strtab + sym->st_name;
+				if (name && strlen(name))
+					*before = sym;
+			}
 		}
 		else
 		{
@@ -594,6 +603,12 @@ static void find_symbols_between(struct 
 				afterdiff = sym->st_value - addr;
 				*after = sym;
 			}
+			else if ((sym->st_value - addr) == afterdiff) {
+				/* equal offset, valid name? */
+				const char *name = elf->strtab + sym->st_name;
+				if (name && strlen(name))
+					*after = sym;
+			}
 		}
 	}
 }
-- 
1.0.GIT


