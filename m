Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWF0MUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWF0MUf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 08:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbWF0MUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 08:20:35 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:31203 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S932484AbWF0MUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 08:20:34 -0400
From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: oom-killer problem
Date: Tue, 27 Jun 2006 14:21:44 +0200
User-Agent: KMail/1.7.2
Cc: Linus Torvalds <torvalds@osdl.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200606270028.16346.daniel.ritz-ml@swissonline.ch> <Pine.LNX.4.64.0606261604180.3927@g5.osdl.org> <20060627053950.GA26435@mars.ravnborg.org>
In-Reply-To: <20060627053950.GA26435@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606271421.45497.daniel.ritz-ml@swissonline.ch>
X-DCC-spamcheck-02.tornado.cablecom.ch-Metrics: smtp-04.tornado.cablecom.ch 1378;
	Body=4 Fuz1=4 Fuz2=4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 June 2006 07.39, Sam Ravnborg wrote:
> On Mon, Jun 26, 2006 at 04:05:40PM -0700, Linus Torvalds wrote:
> > On Tue, 27 Jun 2006, Daniel Ritz wrote:
> > >
> > > reverting the attached patch fixes the problem...
> > 
> > Michal, can you also confirm that just doing a simple revert of that one 
> > commit makes things work for you?
> > 
> > Sam, if I don't hear otherwise from you, and Michael confirms, I'll just 
> > revert it for now, and you can figure out how to fix it without breakage?
> I will try to find time during the weekend to track down the cause of
> this.
> But by reverting said patch you also have to revert:
> 566f81ca598f80de03e80a9a743e94b65b4e017e
> 
> This is the patch where make -rR is enabled and that one initally caused
> problems for ia64.
> 
> 	Sam
> 

this little something on top (instead of reverting the patch) also fixes the
problem for me. because the module name depends on the name of module.mod.o
it's necessary to call basename twice on that, otherwise the name ends up
being module.mod

maybe we could also define basetarget in Kbuild.include as:
	basetarget = $(basename $(basename $(notdir $@)))
but that might be too much...dunno


diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 3cb445c..e66f6dc 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -117,7 +117,7 @@ quiet_modtag := $(empty)   $(empty)
 $(obj-m)              : quiet_modtag := [M]
 
 # Default for not multi-part modules
-modname = $(basetarget)
+modname = $(basename $(basetarget))
 
 $(multi-objs-m)         : modname = $(modname-multi)
 $(multi-objs-m:.o=.i)   : modname = $(modname-multi)
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index e83613e..17f3d31 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -72,7 +72,7 @@ # Declare generated files as targets for
 # Step 5), compile all *.mod.c files
 
 # modname is set to make c_flags define KBUILD_MODNAME
-modname = $(basetarget)
+modname = $(basename $(basetarget))
 
 quiet_cmd_cc_o_c = CC      $@
       cmd_cc_o_c = $(CC) $(c_flags) $(CFLAGS_MODULE)	\



