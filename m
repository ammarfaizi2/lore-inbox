Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263463AbTIBEFg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 00:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263480AbTIBEFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 00:05:36 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:7943 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263463AbTIBEF0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 00:05:26 -0400
Date: Tue, 2 Sep 2003 06:05:22 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Christoph Hellwig <hch@infradead.org>,
       Tigran Aivazian <tigran@veritas.com>, linux-kernel@vger.kernel.org,
       tigran@aivazian.fsnet.co.uk
Subject: Re: dontdiff for 2.6.0-test4
Message-ID: <20030902040522.GA1016@mars.ravnborg.org>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Christoph Hellwig <hch@infradead.org>,
	Tigran Aivazian <tigran@veritas.com>, linux-kernel@vger.kernel.org,
	tigran@aivazian.fsnet.co.uk
References: <Pine.GSO.4.44.0309010754480.1106-100000@north.veritas.com> <20030901163958.A24464@infradead.org> <20030901162244.GA1041@mars.ravnborg.org> <3F537CDD.3040809@pobox.com> <20030901171806.GB1041@mars.ravnborg.org> <3F53F142.5050909@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F53F142.5050909@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 09:24:18PM -0400, Jeff Garzik wrote:
> >On Mon, Sep 01, 2003 at 01:07:41PM -0400, Jeff Garzik wrote:
> >
> >>dontdiff must know about many things that 'make mrproper' need not care 
> >>about:
> >>
> >>	files with ".bak" suffix
> >>	files with "~" suffix
> >>	BitKeeper, CVS, RCS, SCCS directories
> >
> >
> >make mrproper already cares about all those.
> >Fragments from top-level Makefile:
> 
> 
> I stand corrected :)  However, I think it's a tangent:
> 
> dontdiff is a file that's useful precisely because of the form its in.

When I proposed to autogenerate it I recalled it was a list of files,
including paths. But it is only basename used for matching.
So generating the list from within kbuild is too unsafe. There will most
likely be false negatives.
The following patch generate a list of filenames only, straight from
the kbuild Makefiles. I did not include patterns from the find
used in the top-level Makefile.

Usage: make KBUILD_DONTDIFF=1 clean

As can be seen wildcards is used in a few places
and the list of filenames generated is much bigger than included
in dontdiff today (341 files).
So I have changed my mind - do not autogenerate it. Stuff in the dontdiff
file somewhere (scripts/?).

	Sam

===== scripts/Makefile.clean 1.12 vs edited =====
--- 1.12/scripts/Makefile.clean	Mon Mar 10 22:03:33 2003
+++ edited/scripts/Makefile.clean	Mon Sep  1 22:31:43 2003
@@ -29,14 +29,19 @@
 # Add subdir path
 
 subdir-ymn	:= $(addprefix $(obj)/,$(subdir-ymn))
-__clean-files	:= $(wildcard $(addprefix $(obj)/, \
-		   $(extra-y) $(EXTRA_TARGETS) $(always) $(host-progs) \
-		   $(targets) $(clean-files)))
+_clean-files	:= $(extra-y) $(EXTRA_TARGETS) $(always) $(host-progs) \
+		   $(targets) $(clean-files)
 
 # ==========================================================================
-
+ifeq ($(KBUILD_DONTDIFF),)
+__clean-files	:= $(wildcard $(addprefix $(obj)/,$(_clean-files)))
 quiet_cmd_clean = CLEAN   $(obj)
       cmd_clean = rm -f $(__clean-files); $(clean-rule)
+else
+__clean-files	:= $(_clean-files))
+quiet_cmd_clean = 
+      cmd_clean = echo $(_clean-files)
+endif
 
 __clean: $(subdir-ymn)
 ifneq ($(strip $(__clean-files) $(clean-rule)),)
