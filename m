Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbVBHV2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVBHV2f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 16:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVBHV2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 16:28:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40577 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261667AbVBHV1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 16:27:25 -0500
Date: Tue, 8 Feb 2005 21:27:20 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Matthew Wilcox <matthew@wil.cx>, Roman Zippel <zippel@linux-m68k.org>,
       Sam Ravnborg <sam@ravnborg.org>,
       Kai Germaschewski <kai@germaschewski.name>,
       linux-kernel@vger.kernel.org, dholland@eecs.harvard.edu
Subject: Re: [PATCH] Makefiles are not built using a Fortran compiler
Message-ID: <20050208212720.GI20386@parcelfarce.linux.theplanet.co.uk>
References: <20050208030228.GE20386@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.61.0502081322310.6118@scrub.home> <20050208154417.GH20386@parcelfarce.linux.theplanet.co.uk> <20050208192027.GA8360@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050208192027.GA8360@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2005 at 08:20:27PM +0100, Sam Ravnborg wrote:
> In my inbox I have a patch that enables SCCS support for all files.
> Today it fails for Kconfig files at least.

I guess the kconfig system needs to try to make Kconfig files before
including them ... this works for me, checking a Kconfig file out of RCS:

--- scripts/kconfig/zconf.l     29 Jul 2003 17:02:27 -0000      1.1
+++ scripts/kconfig/zconf.l     8 Feb 2005 21:25:43 -0000
@@ -269,15 +269,24 @@ static void zconf_endhelp(void)
  */
 FILE *zconf_fopen(const char *name)
 {
-       char *env, fullname[PATH_MAX+1];
+       char *env, fullname[PATH_MAX+6];
        FILE *f;
 
        f = fopen(name, "r");
+       if (!f) {
+               sprintf(fullname, "make %s", name);
+               system(fullname);
+               f = fopen(name, "r");
+       }
        if (!f && name[0] != '/') {
                env = getenv(SRCTREE);
                if (env) {
-                       sprintf(fullname, "%s/%s", env, name);
-                       f = fopen(fullname, "r");
+                       sprintf(fullname, "make %s/%s", env, name);
+                       f = fopen(fullname + 5, "r");
+                       if (!f) {
+                               system(fullname);
+                               f = fopen(fullname + 5, "r");
+                       }
                }
        }
        return f;

I bet someone else can do it better than this ... I'm sure we don't need
to invoke sh to invoke make ;-)

> I'm willing to give it a try. But we will only see people complaining
> when it hits linus tree. -mm users uses quilt and the like - and thus
> will not be hit by this.
> 
> 	Sam

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
