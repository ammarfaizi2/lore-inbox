Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbVLTAFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbVLTAFJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 19:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbVLTAFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 19:05:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:10462 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750703AbVLTAFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 19:05:06 -0500
From: Andreas Schwab <schwab@suse.de>
To: Robin Holt <holt@sgi.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, rth@redhat.com,
       bj0rn@blox.se
Subject: Re: Can somebody with flex/bison experience help with genksyms?
References: <20051219214019.GA25888@lnx-holt.americas.sgi.com>
X-Yow: LIFE is a never-ending INFORMERCIAL!
Date: Tue, 20 Dec 2005 01:05:03 +0100
In-Reply-To: <20051219214019.GA25888@lnx-holt.americas.sgi.com> (Robin Holt's
	message of "Mon, 19 Dec 2005 15:40:19 -0600")
Message-ID: <jelkygljkg.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Holt <holt@sgi.com> writes:

> The following code fails to generate a crc when run through genksyms.
>
> #include <linux/module.h>
>
> struct nodepda_s {
> 	int	z1, z2;
> }
>
> DEFINE_PER_CPU(struct nodepda_s *, __sn_nodepda);
> EXPORT_PER_CPU_SYMBOL(__sn_nodepda);
>
> While the following works:
>
> #include <linux/module.h>
>
> struct nodepda_s {
>         int     z1, z2;
> }
>
> typedef struct nodepda_s * nodepda_s_p;
>
> DEFINE_PER_CPU(nodepda_s_p, __sn_nodepda);
> EXPORT_PER_CPU_SYMBOL(__sn_nodepda);
>
>
>
> This appears to be due to the way STRUCT_KEYW is handled in parse.y as
> compared to TYPEOF_KEYW.  I know nothing about flex and bison.  I am
> just trolling for anybody willing to help.  I believe the STRUCT_KEYW
> handling would need to consume the *, but am not sure how that is
> conditionally done.

Does this patch help?

--- scripts/genksyms/parse.y.~1~	2005-10-28 02:02:08.000000000 +0200
+++ scripts/genksyms/parse.y	2005-12-20 01:02:46.420239410 +0100
@@ -197,7 +197,7 @@ storage_class_specifier:
 type_specifier:
 	simple_type_specifier
 	| cvar_qualifier
-	| TYPEOF_KEYW '(' decl_specifier_seq ')'
+	| TYPEOF_KEYW '(' decl_specifier_seq m_abstract_declarator ')'
 
 	/* References to s/u/e's defined elsewhere.  Rearrange things
 	   so that it is easier to expand the definition fully later.  */

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
