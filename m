Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263028AbUCYBa1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 20:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbUCYBa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 20:30:27 -0500
Received: from fed1mtao07.cox.net ([68.6.19.124]:45710 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S263028AbUCYBaS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 20:30:18 -0500
Date: Wed, 24 Mar 2004 18:30:16 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch 3/22] __early_param for ppc
Message-ID: <20040325013016.GB13366@smtp.west.cox.net>
References: <20040324235747.NSKC2428.fed1mtao03.cox.net@localhost.localdomain> <16482.12026.739450.257677@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16482.12026.739450.257677@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2004 at 11:59:38AM +1100, Paul Mackerras wrote:
> trini@kernel.crashing.org writes:
> 
> > -#ifdef CONFIG_XMON
> > -	xmon_map_scc();
> > -	if (strstr(cmd_line, "xmon"))
> > -		xmon(0);
> > -#endif /* CONFIG_XMON */
> ...
> > +/* Allow us a hook to drop in early. */
> > +static void __init early_xmon(char **ign)
> > +{
> > +	xmon_map_scc();
> > +	xmon(0);
> > +}
> > +__early_param("xmon", early_xmon);
> 
> You have changed the behaviour here, in that now xmon_map_scc() only
> gets called if you put xmon on the command line, whereas previously it
> got called unconditionally (assuming CONFIG_XMON=y).  Did you check
> whether this will cause problems?

Hmm, you're right.  How about the following patch on top of the first
(restore the unconditional call to xmon_map_scc() where it was) ?

--- linux-2.6-early_setup-trini/arch/ppc/kernel/setup.c	2004-03-24 16:15:05.312991415 -0700
+++ linux-2.6-early_setup-trini/arch/ppc/kernel/setup.c	2004-03-24 18:29:27.179336978 -0700
@@ -639,6 +639,10 @@
 		pmac_feature_init();	/* New cool way */
 #endif
 
+#ifdef CONFIG_XMON
+	xmon_map_scc();
+#endif
+
 	if ( ppc_md.progress ) ppc_md.progress("setup_arch: enter", 0x3eab);
 
 	/*
--- linux-2.6-early_setup-trini/arch/ppc/xmon/xmon.c	2004-03-24 16:15:05.316990515 -0700
+++ linux-2.6-early_setup-trini/arch/ppc/xmon/xmon.c	2004-03-24 18:27:52.013643465 -0700
@@ -266,7 +266,6 @@
 /* Allow us a hook to drop in early. */
 static void __init early_xmon(char **ign)
 {
-	xmon_map_scc();
 	xmon(0);
 }
 __early_param("xmon", early_xmon);

-- 
Tom Rini
http://gate.crashing.org/~trini/
