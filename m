Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265255AbUFSIQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265255AbUFSIQU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 04:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbUFSIQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 04:16:20 -0400
Received: from mx2.elte.hu ([157.181.151.9]:57736 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265255AbUFSIQS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 04:16:18 -0400
Date: Sat, 19 Jun 2004 10:06:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] flexible-mmap-2.6.7-D5
Message-ID: <20040619080643.GA13861@elte.hu>
References: <20040618213814.GA589@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040618213814.GA589@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> - i also introduced a new personality bit (ADDR_COMPAT_LAYOUT) to signal
>   older binaries that dont have PT_GNU_STACK. x86 uses this to revert 
>   back to the stock layout. [...]

i've also attached a patch below against setarch that adds the -L option
which turns on the old layout. Thus if there's any old broken app that
relies on mmap()s being below 2GB then the following can be used:

	setarch -L oldapp <params>

and 'oldapp' (and all its children) will run with the old layout. But
this should be an extremely rare occurance, i've added it more for
completeness and paranoia reasons than necessity.

	Ingo

--- setarch-1.4/setarch.c.orig
+++ setarch-1.4/setarch.c
@@ -118,6 +118,15 @@ int main(int argc, char *argv[])
       if(got_arch)
 	p = argv[0];
     }
+  if(!strcmp(p, "-L"))
+    {
+      argv++;
+      argc--;
+      options |= 0x0200000 /* ADDR_COMPAT_LAYOUT */;
+      if(got_arch)
+	p = argv[0];
+    }
+
 
   if(set_arch(p, options))
     {
