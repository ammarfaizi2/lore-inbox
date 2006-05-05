Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751605AbWEEPPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbWEEPPc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 11:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751604AbWEEPPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 11:15:32 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:21771 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751601AbWEEPPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 11:15:32 -0400
Date: Fri, 5 May 2006 17:15:31 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dan Merillat <harik.attar@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kbuild + Cross compiling
Message-ID: <20060505151531.GB6568@mars.ravnborg.org>
References: <c0c067900605041852m50e04171x7fd1579e77c9d5a3@mail.gmail.com> <20060505045529.GA17896@mars.ravnborg.org> <c0c067900605042330s2ebfea1fk8d218a5a826f67f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0c067900605042330s2ebfea1fk8d218a5a826f67f9@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2006 at 02:30:05AM -0400, Dan Merillat wrote:
> On 5/5/06, Sam Ravnborg <sam@ravnborg.org> wrote:
> >kbuild checks for any differences in the commandline alos - so a rebuild
> >happens if you change options to gcc (think -O2 => -Os).
> >If you experience that for example mm/slab.c is rebuild then try to
> >do the following:
> >cp mm/.slab.o.cmd foo
> >make mm/
> >diff -u foo mm/.slab.o.cmd
> >
> >If diff detects any difference then you know why and need to find out
> >why there is a difference.
> 
> Nothing, even md5sums match.
> 2abfcbee132335ba8e1da120569abf67  .do_mounts.o.cmd
> 2abfcbee132335ba8e1da120569abf67  .do_mounts.o.cmd.1
> 
> but it gets rebuilt every time.

So we need to dive a bit deeper to understand why everything gets
rebuild.
Try following patch:

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index e48e60d..4c52131 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -189,6 +189,9 @@ endef
 # Built-in and composite module parts
 
 %.o: %.c FORCE
+	@echo $@
+	@echo chg=$?
+	@echo arg-check=$(call arg-check, $(cmd_cc_o_c), $(cmd_$@))
 	$(call cmd,force_checksrc)
 	$(call if_changed_rule,cc_o_c)
 
This will not fix anything - but will give us a hint why things gets
rebuild.
After applying the patch try:
make init/do_mounts.o

And then post the output.
Also include the .do_mounts.o.cmd file

	Sam
