Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314101AbSEITEL>; Thu, 9 May 2002 15:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314106AbSEITEK>; Thu, 9 May 2002 15:04:10 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:64135 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S314101AbSEITEJ>; Thu, 9 May 2002 15:04:09 -0400
Date: Thu, 9 May 2002 14:04:09 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: linux-kernel@vger.kernel.org
cc: Keith Owens <kaos@ocs.com.au>
Subject: [PATCH] default to "don't export symbols"
Message-ID: <Pine.LNX.4.44.0205091352090.11642-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'd like to get comments and testing on the appended patch.

I spend some time finding and fixing modules which still relied
on the old behavior of "default to exporting all symbols if unsure" and
made the export their symbols explicitly.

As of now, all modules should explicit their symbols explicitly, so they 
won't be affected by the appended change. "should" as in "I tried to 
compile as much as possible modular on i386 and didn't get any unresolved 
symbols."

To find clean this up further, I'm proposing the following:

o the appended change, which will make "EXPORT_NO_SYMBOLS" the default
  for all objects which are not listed in $(export-objs). In case I
  missed some module, this will cause depmod complaining about unresolved
  symbols which thus should be exported explicitly.

o make "EXPORT_NO_SYMBOLS" default for all objects, except of course
  those which explicitly export symbols via EXPORT_SYMBOL()

o cleanup all the EXPORT_NO_SYMBOLS in the sources, as they are default 
  now anyway.

The second step will be another tiny patch to module.h, and the third one
is basically a small grep script.

--Kai

[What the patch actually does is add an empty but allocated section 
 "__ksymtab" to the object file, which modutils recognizes as an 
  indication to not export symbols. It won't use any kernel memory.]


Pull from http://linux-isdn.bkbits.net/linux-2.5.export

(Merging changesets omitted for clarity)

-----------------------------------------------------------------------------
ChangeSet@1.557, 2002-05-09 13:51:22-05:00, kai@tp1.ruhr-uni-bochum.de
  Don't implicitly export all symbols
  
  In the old days, we used to export all symbols from a module by default.
  We still do so, unless
  o either exported symbols are explicitly listed in EXPORT_SYMBOL()
  o or EXPORT_NO_SYMBOLS
  is given.
  
  This patches changes the default of 'export all symbols' to 'export no
  symbols' for all files which are not listed in $(export-objs) in
  the relevant Makefile.

 ----------------------------------------------------------------------------
 module.h |    2 ++
 1 files changed, 2 insertions(+)


 ----------------------------------------------------------------------------

diff -Nru a/include/linux/module.h b/include/linux/module.h
--- a/include/linux/module.h	Thu May  9 13:51:55 2002
+++ b/include/linux/module.h	Thu May  9 13:51:55 2002
@@ -370,6 +370,8 @@
 #define EXPORT_SYMBOL_NOVERS(var)  error this_object_must_be_defined_as_export_objs_in_the_Makefile
 #define EXPORT_SYMBOL_GPL(var)  error this_object_must_be_defined_as_export_objs_in_the_Makefile
 
+__asm__(".section __ksymtab,\"a\"\n.previous");
+
 #else
 
 #define __EXPORT_SYMBOL(sym, str)			\


