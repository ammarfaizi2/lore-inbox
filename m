Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWIXWaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWIXWaU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 18:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWIXWaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 18:30:20 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:13996 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S1751286AbWIXWaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 18:30:18 -0400
Date: Mon, 25 Sep 2006 00:35:34 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Kirill Korotaev <dev@openvz.org>,
       Andrey Mirkin <amirkin@sw.ru>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 18/28] kbuild: fail kernel compilation in case of unresolved module symbols
Message-ID: <20060924223534.GA27984@uranus.ravnborg.org>
References: <11591327051381-git-send-email-sam@ravnborg.org> <11591327054119-git-send-email-sam@ravnborg.org> <11591327051998-git-send-email-sam@ravnborg.org> <11591327051652-git-send-email-sam@ravnborg.org> <11591327053365-git-send-email-sam@ravnborg.org> <1159132705363-git-send-email-sam@ravnborg.org> <11591327063034-git-send-email-sam@ravnborg.org> <11591327061320-git-send-email-sam@ravnborg.org> <1159132706174-git-send-email-sam@ravnborg.org> <20060924222026.GS29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060924222026.GS29920@ftp.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2006 at 11:20:26PM +0100, Al Viro wrote:
> On Sun, Sep 24, 2006 at 11:18:14PM +0200, sam@ravnborg.org wrote:
> > From: Kirill Korotaev <dev@openvz.org>
> > 
> > At stage 2 modpost utility is used to check modules.  In case of unresolved
> > symbols modpost only prints warning.
> > 
> > IMHO it is a good idea to fail compilation process in case of unresolved
> > symbols (at least in modules coming with kernel), since usually such errors
> > are left unnoticed, but kernel modules are broken.
> > 
> > - new option '-w' is added to modpost:
> >   if option is specified, modpost only warns about unresolved symbols
> > 
> > - modpost is called with '-w' for external modules in Makefile.modpost
> 
> Oh, joy...  Could you add a way to tell kbuild that old behaviour is,
> in fact, desired?  make MODPOST_FLAGS=-w or something along these lines...

On what architectures do you see lots of these warnings - maybe fixable?
Otherwise I could do something like this:

diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 4b2721c..e9efe61 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -58,7 +58,7 @@ quiet_cmd_modpost = MODPOST $(words $(fi
 	$(if $(KBUILD_EXTMOD),-i,-o) $(kernelsymfile) \
 	$(if $(KBUILD_EXTMOD),-I $(modulesymfile)) \
 	$(if $(KBUILD_EXTMOD),-o $(modulesymfile)) \
-	$(if $(KBUILD_EXTMOD),-w) \
+	$(if $(KBUILD_EXTMOD)$(KBUILD_MODPOST_WARN),-w) \
 	$(wildcard vmlinux) $(filter-out FORCE,$^)
 
 PHONY += __modpost

Then:
make KBUILD_MODPOST_WARN=1

would warn and not fail.

Note: I beleive the patch has been in -mm for a while.
      Got the patch via akpm

	Sam
