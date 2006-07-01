Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbWGAJrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWGAJrX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 05:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWGAJrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 05:47:23 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:14283 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S964850AbWGAJrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 05:47:23 -0400
Date: Sat, 1 Jul 2006 11:47:11 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ram Pai <linuxram@us.ibm.com>
Subject: Re: 2.6.17-mm3: segvs in modpost with out-of-tree modules
Message-ID: <20060701094711.GB30169@mars.ravnborg.org>
References: <44A2B37F.4030500@goop.org> <20060628112925.f96fcfc4.akpm@osdl.org> <44A2CE04.80606@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A2CE04.80606@goop.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 11:44:20AM -0700, Jeremy Fitzhardinge wrote:
> Andrew Morton wrote:
> >On Wed, 28 Jun 2006 09:51:11 -0700
> >Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> >  
> >>I haven't really looked at yet, but I was hoping someone had already 
> >>tracked it down.
> >>    
> >
> >Not that I'm aware of.
> 
> OK, it wasn't really a bug; I had an old Modules.symvers lying around 
> the madwifi tree from a previous build against an earlier kernel.  But 
> modpost seems all pretty fragile...

I have pushed following patch that fixes the SEGV. We shoul not SEGV no
matter the input.


	Sam

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index d03c9ff..37e34d6 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -205,6 +205,8 @@ static const char *export_str(enum expor
 static enum export export_no(const char * s)
 {
 	int i;
+	if (!s)
+		return export_unknown;
 	for (i = 0; export_list[i].export != export_unknown; i++) {
 		if (strcmp(export_list[i].str, s) == 0)
 			return export_list[i].export;
@@ -1265,7 +1267,7 @@ static void write_if_changed(struct buff
 }
 
 /* parse Module.symvers file. line format:
- * 0x12345678<tab>symbol<tab>module[<tab>export]
+ * 0x12345678<tab>symbol<tab>module[[<tab>export]<tab>something]
  **/
 static void read_dump(const char *fname, unsigned int kernel)
 {
@@ -1278,7 +1280,7 @@ static void read_dump(const char *fname,
 		return;
 
 	while ((line = get_next_line(&pos, file, size))) {
-		char *symname, *modname, *d, *export;
+		char *symname, *modname, *d, *export, *end;
 		unsigned int crc;
 		struct module *mod;
 		struct symbol *s;
@@ -1291,7 +1293,8 @@ static void read_dump(const char *fname,
 		*modname++ = '\0';
 		if ((export = strchr(modname, '\t')) != NULL)
 			*export++ = '\0';
-
+		if (export && ((end = strchr(export, '\t')) != NULL))
+			*end = '\0';
 		crc = strtoul(line, &d, 16);
 		if (*symname == '\0' || *modname == '\0' || *d != '\0')
 			goto fail;
