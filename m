Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161034AbWBUWPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161034AbWBUWPV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 17:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932774AbWBUWPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 17:15:21 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:52486 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932769AbWBUWPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 17:15:20 -0500
Date: Tue, 21 Feb 2006 23:15:17 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: make -j with j <= 4 seems to only load a single CPU core
Message-ID: <20060221221517.GA9629@mars.ravnborg.org>
References: <9a8748490602211302j61c0088fp8b555860e928028e@mail.gmail.com> <9a8748490602211310j344db10evd685149a3c60b1e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490602211310j344db10evd685149a3c60b1e7@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 10:10:46PM +0100, Jesper Juhl wrote:
> On 2/21/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > This is quite odd and I've no idea where to start looking for the
> > cause, but let me describe what I'm seeing and maybe someone can point
> > me in the right direction.
> >
> > I'm running SMP 2.6.x kernels on a Athlon 64 X2 4400+
> >
> 
> I should probably mention that the kernel I'm currently running and
> observing this behaviour with is 2.6.16-rc4-mm1.

Hi Jesper.
Could you please double check that patch below has been applied to your
tree.

	Sam

diff-tree 36cbbe5eb9857730768aa5f54ad94d69e0b2133d (from 9f672004ab1a8094bec1785b39ac683ab9eebebc)
Author: Benjamin LaHaise <bcrl@kvack.org>
Date:   Wed Feb 15 15:17:35 2006 -0800

    [PATCH] kbuild: revert "fix make -jN with multiple targets with O=..."
    
    Commit 296e0855b0f9a4ec9be17106ac541745a55b2ce1:
    
        "kbuild: fix make -jN with multiple targets with O=..."
    
    causes a ~95% increase in build time for the kernel.  Before: 4m21s
    after: 8m1.403s.  Can we revert this until another approach is found?
    
    Cc: Sam Ravnborg <sam@ravnborg.org>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

diff --git a/Makefile b/Makefile
index 74d67b2..48d569d 100644
--- a/Makefile
+++ b/Makefile
@@ -104,17 +104,16 @@ ifneq ($(KBUILD_OUTPUT),)
 saved-output := $(KBUILD_OUTPUT)
 KBUILD_OUTPUT := $(shell cd $(KBUILD_OUTPUT) && /bin/pwd)
 $(if $(KBUILD_OUTPUT),, \
      $(error output directory "$(saved-output)" does not exist))
 
-.PHONY: $(MAKECMDGOALS) cdbuilddir
-$(MAKECMDGOALS) _all: cdbuilddir
+.PHONY: $(MAKECMDGOALS)
 
-cdbuilddir:
+$(filter-out _all,$(MAKECMDGOALS)) _all:
 	$(if $(KBUILD_VERBOSE:1=),@)$(MAKE) -C $(KBUILD_OUTPUT) \
 	KBUILD_SRC=$(CURDIR) \
-	KBUILD_EXTMOD="$(KBUILD_EXTMOD)" -f $(CURDIR)/Makefile $(MAKECMDGOALS)
+	KBUILD_EXTMOD="$(KBUILD_EXTMOD)" -f $(CURDIR)/Makefile $@
 
 # Leave processing to above invocation of make
 skip-makefile := 1
 endif # ifneq ($(KBUILD_OUTPUT),)
 endif # ifeq ($(KBUILD_SRC),)
