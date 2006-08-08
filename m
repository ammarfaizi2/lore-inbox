Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbWHHPRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbWHHPRX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 11:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbWHHPRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 11:17:23 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:23262 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S964938AbWHHPRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 11:17:22 -0400
Date: Tue, 8 Aug 2006 17:16:57 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Magnus Damm <magnus@valinux.co.jp>
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org,
       ebiederm@xmission.com
Subject: Re: [PATCH] CONFIG_RELOCATABLE modpost fix
Message-ID: <20060808151657.GA18059@mars.ravnborg.org>
References: <20060808083307.391.45887.sendpatchset@cherry.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060808083307.391.45887.sendpatchset@cherry.local>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 05:32:11PM +0900, Magnus Damm wrote:
> CONFIG_RELOCATABLE modpost fix
> 
> Run modpost on vmlinux regardless of CONFIG_MODULES. The modpost code is also
> extended to ignore references from ".pci_fixup" to ".init.text".
I've splitted the patch in two parts.
First is this one (I slightly modified your version and removed trailing
whitespaces).

	Sam

commit 1f43a633dc485f90fddf667270179058a07b9d77
Author: Magnus Damm <magnus@valinux.co.jp>
Date:   Tue Aug 8 17:32:11 2006 +0900

    kbuild: ignore references from ".pci_fixup" to ".init.text"
    
    The modpost code is extended to ignore references
    from ".pci_fixup" to ".init.text".
    
    Signed-off-by: Magnus Damm <magnus@valinux.co.jp>

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index dfde0e8..5028d46 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -581,8 +581,8 @@ static int strrcmp(const char *s, const 
  *   fromsec = .data
  *   atsym = *driver, *_template, *_sht, *_ops, *_probe, *probe_one
  **/
-static int secref_whitelist(const char *tosec, const char *fromsec,
-			    const char *atsym)
+static int secref_whitelist(const char *modname, const char *tosec,
+			    const char *fromsec, const char *atsym)
 {
 	int f1 = 1, f2 = 1;
 	const char **s;
@@ -618,8 +618,15 @@ static int secref_whitelist(const char *
 	for (s = pat2sym; *s; s++)
 		if (strrcmp(atsym, *s) == 0)
 			f1 = 1;
+	if (f1 && f2)
+		return 1;
 
-	return f1 && f2;
+	/* Whitelist all references from .pci_fixup section if vmlinux */
+	if (is_vmlinux(modname)) {
+		if ((strcmp(fromsec, ".pci_fixup") == 0) &&
+		    (strcmp(tosec, ".init.text") == 0))
+		return 1;
+	}
 }
 
 /**
@@ -726,7 +733,8 @@ static void warn_sec_mismatch(const char
 
 	/* check whitelist - we may ignore it */
 	if (before &&
-	    secref_whitelist(secname, fromsec, elf->strtab + before->st_name))
+	    secref_whitelist(modname, secname, fromsec,
+			     elf->strtab + before->st_name))
 		return;
 
 	if (before && after) {

