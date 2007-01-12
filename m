Return-Path: <linux-kernel-owner+w=401wt.eu-S1161048AbXALKWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161048AbXALKWx (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 05:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161063AbXALKWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 05:22:53 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:13271 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161048AbXALKWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 05:22:52 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=PYp8GA0uuA0n0OpXaxIiewvsLBBQR4mOi37XD3AedJlSIn3oKxOz+Tqq4RIiYcBIyPSgoLM8Dw7Cw8vOTDt3STpQ7D26stAkU8rU/Es6slFKavxeBUs7QuQmxH4UIw69kz1BGHA6ggcmtuhlli27TM5NDr6e1Rsgfaoy0WuY7qI=
Date: Fri, 12 Jan 2007 10:20:40 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com
Subject: Early ACPI lockup (was Re: 2.6.20-rc4-mm1)
Message-ID: <20070112102040.GD5941@slug>
References: <20070111222627.66bb75ab.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070111222627.66bb75ab.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2007 at 10:26:27PM -0800, Andrew Morton wrote:
> 
>   ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc3/2.6.20-rc4-mm1/
> 
Hi,

The git-acpi.patch replaces earlier "if(!handler) return -EINVAL" by
"BUG_ON(!handler)". This locks my machine early at boot with a message
along the lines of (It's hand copied):
Int 6: cr2: 00000000 eip: c0570e05 flags: 00010046 cs: 60
stack: c054ffac c011db2b c04936d0 c054ff68 c054ffc0 c054fff4 c057da2c

Reverting the change as follows, allows booting:
Any ideas to debug this further?

Regards,
Frederik

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index db0c5f6..fba018c 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -414,7 +414,9 @@ int __init acpi_table_parse(enum acpi_ta
 	unsigned int index;
 	unsigned int count = 0;
 
-	BUG_ON(!handler);
+	if (!handler)
+		return -EINVAL;
+	/*BUG_ON(!handler);*/
 
 	for (i = 0; i < sdt_count; i++) {
 		if (sdt_entry[i].id != id)
