Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751608AbWCIWCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbWCIWCF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 17:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbWCIWCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 17:02:05 -0500
Received: from nproxy.gmail.com ([64.233.182.196]:9840 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751608AbWCIWCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 17:02:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=VF2O3Lre3dSOU9f5mp6IQI1KG2lDNqk5y9FrgjMJo9Gz0OxdhHeMVtExvs7sVBh8S6Au6kQLfX9aV9yc3OBFplpn7uB3auaZ+AIgNQodMfBn+wNEqjUr3VyBbYf1LaUUi8GC5vRY5kEoUqPCd6//KD9vheQLZLJEd4XFLgJBQK0=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix potential null deref in kallsyms::read_symbol
Date: Thu, 9 Mar 2006 23:02:29 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603092302.29634.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The Coverity checker found that if malloc() fails in 
scripts/kallsyms.c::read_symbol() then we end up dereferencing a NULL pointer.

Unlikely to happen, but we really should check the malloc() return value.
This patch fixes the problem by checking the return value and printing a nice
descriptive error message and exiting if malloc() did fail.

This fixes coverity error #397


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 scripts/kallsyms.c |    5 +++++
 1 files changed, 5 insertions(+)

--- linux-2.6.16-rc5-git12-orig/scripts/kallsyms.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.16-rc5-git12/scripts/kallsyms.c	2006-03-09 22:57:13.000000000 +0100
@@ -124,6 +124,11 @@ static int read_symbol(FILE *in, struct 
 	 * compressed together */
 	s->len = strlen(str) + 1;
 	s->sym = malloc(s->len + 1);
+	if (!s->sym) {
+		fprintf(stderr, "kallsyms failure: "
+			"unable to allocate required amount of memory\n");
+		exit(EXIT_FAILURE);
+	}
 	strcpy((char *)s->sym + 1, str);
 	s->sym[0] = stype;
 




