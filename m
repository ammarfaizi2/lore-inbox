Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVEOBVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVEOBVM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 21:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVEOBVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 21:21:12 -0400
Received: from holomorphy.com ([66.93.40.71]:13787 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261532AbVEOBUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 21:20:55 -0400
Date: Sat, 14 May 2005 18:20:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc4-mm1
Message-ID: <20050515012051.GJ9304@holomorphy.com>
References: <20050512033100.017958f6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <20050512033100.017958f6.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 12, 2005 at 03:31:00AM -0700, Andrew Morton wrote:
> +uml-remove-elfh.patch
> +uml-critical-change-memcpy-to-memmove.patch
>  UML important updates

uml-remove-elfh looks empty.

Anyway, the real patch, of minor importance, follows in an attachment.
This is a pure bugfix, as the intention was apparent, but not carried
out, but the bug never caused exceptions or corruption. The check for
a comma following "profile=schedule" on the command line had an off by
one that caused it never to trigger. The option checking also
accidentally clobbered prof_on = SCHED_PROFILING, granted that it was
reached (which prior to dealing with that off by one, it never was).

I took the liberty of translating all of the hardcoded string length
constants to strlen(schedstr) plus the appropriate offsets for the sake
of clarity and side benefit of putting a string used only in __init in
__initdata, but left others not multiply referenced in .rodata.


-- wli

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Description: profile-schedule-parsing.patch
Content-Disposition: attachment; filename="profile-schedule-parsing.patch"

profile=schedule parsing is not quite what it should be.
First, str[7] is 'e', not ',', but then even if it did fall through,
prof_on = SCHED_PROFILING would be clobbered inside if (get_option(...))
So a small amount of rearrangement is done in this patch to correct it.

Index: mm1-2.6.12-rc4/kernel/profile.c
===================================================================
--- mm1-2.6.12-rc4.orig/kernel/profile.c	2005-05-14 17:09:17.000000000 -0700
+++ mm1-2.6.12-rc4/kernel/profile.c	2005-05-14 17:45:05.000000000 -0700
@@ -49,15 +49,19 @@
 
 static int __init profile_setup(char * str)
 {
+	static char __initdata schedstr[] = "schedule";
 	int par;
 
-	if (!strncmp(str, "schedule", 8)) {
+	if (!strncmp(str, schedstr, strlen(schedstr))) {
 		prof_on = SCHED_PROFILING;
-		printk(KERN_INFO "kernel schedule profiling enabled\n");
-		if (str[7] == ',')
-			str += 8;
-	}
-	if (get_option(&str,&par)) {
+		if (str[strlen(schedstr)] == ',')
+			str += strlen(schedstr) + 1;
+		if (get_option(&str, &par))
+			prof_shift = par;
+		printk(KERN_INFO
+			"kernel schedule profiling enabled (shift: %ld)\n",
+			prof_shift);
+	} else if (get_option(&str, &par)) {
 		prof_shift = par;
 		prof_on = CPU_PROFILING;
 		printk(KERN_INFO "kernel profiling enabled (shift: %ld)\n",

--vtzGhvizbBRQ85DL--
