Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbUEJXd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbUEJXd0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 19:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbUEJXdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 19:33:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:10710 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262100AbUEJXcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 19:32:35 -0400
Date: Mon, 10 May 2004 16:24:13 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Cc: rusty@rustcorp.com.au, zwane@linuxpower.ca, sam@ravnborg.org
Subject: Re: [PATCH*] show last kernel-image symbol in /proc/kallsyms
Message-Id: <20040510162413.6db2d60e.rddunlap@osdl.org>
In-Reply-To: <20040510105606.27554ad0.rddunlap@osdl.org>
References: <20040509171452.09ee1ca0.rddunlap@osdl.org>
	<1084162450.8121.6.camel@bach>
	<20040510105606.27554ad0.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2004 10:56:06 -0700 Randy.Dunlap wrote:

| On Mon, 10 May 2004 14:14:10 +1000 Rusty Russell wrote:
| 
| | On Mon, 2004-05-10 at 10:14, Randy.Dunlap wrote:
| | > 'cat' or 'tail' of /proc/kallsyms (2.6.6-rc2 or -rc3, & probably much
| | > earlier) does not include the last kernel-image symbol (_einittext).
| | > 
| | > _einittext is the last symbol generated in .tmp_kallsyms2.S
| | > and the symbol count in that file also appears to be correct,
| | > but the iterator code for /proc/kallsyms comes up 1 short somehow.
| | > 
| | > Here are 2 patches.  Either one of them "fixes" the problem.
| | > Neither of them is the correct fix AFAIK.
| | 
| | Ah, I see you are a student of the Morton school of patch extraction. 
| | Well, it worked.
| 
| Well.... yes.
| 
| And thanks for taking time to fix it.
| It now works as expected.  :)

Welllll, almost as expected.  I now see _einittext as hoped and
expected.  However, sometimes I don't see _etext... if it has the
same address as another (previous) symbol, which it can.

so I think that you may want this kind of patch, especially for
CONFIG_KALLSYMS_ALL.

Please apply/merge.

--
~Randy



// linux-266
// Always include the _etext symbol in /proc/kallsyms.

diffstat:=
 scripts/kallsyms.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)


diff -Naurp ./scripts/kallsyms.c~force_etext ./scripts/kallsyms.c
--- ./scripts/kallsyms.c~force_etext	2004-05-09 19:33:21.000000000 -0700
+++ ./scripts/kallsyms.c	2004-05-10 16:01:02.000000000 -0700
@@ -115,7 +115,10 @@ write_src(void)
 		if (!symbol_valid(&table[i]))
 			continue;
 		
-		if (table[i].addr == last_addr)
+		if (table[i].addr == last_addr &&
+		    last_addr != _etext)
+			/* don't duplicate addresses, except always
+			 * make sure that _etext is in kallsyms */
 			continue;
 
 		printf("\tPTR\t%#llx\n", table[i].addr);
@@ -140,7 +143,8 @@ write_src(void)
 		if (!symbol_valid(&table[i]))
 			continue;
 		
-		if (table[i].addr == last_addr)
+		if (table[i].addr == last_addr &&
+		    last_addr != _etext)
 			continue;
 
 		for (k = 0; table[i].sym[k] && table[i].sym[k] == prev[k]; ++k)
