Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265960AbSKKXdk>; Mon, 11 Nov 2002 18:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265973AbSKKXdj>; Mon, 11 Nov 2002 18:33:39 -0500
Received: from surf.cadcamlab.org ([156.26.20.182]:21934 "EHLO
	surf.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S265960AbSKKXdh>; Mon, 11 Nov 2002 18:33:37 -0500
Date: Mon, 11 Nov 2002 17:37:10 -0600
To: Tom Rini <trini@kernel.crashing.org>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [PATCH] Have split-include take another argument
Message-ID: <20021111233710.GR4182@cadcamlab.org>
References: <20021111170604.GA658@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021111170604.GA658@opus.bloom.county>
User-Agent: Mutt/1.4i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Tom Rini]
> First, does anyone see any problems with the patch itself?

Well,

> -	str_config += sizeof("CONFIG_") - 1;
> +	str_config += strlen(str_split_token);

it does seem a bit inefficient to call strlen() for every single line
of every single source file.  Perhaps today's compilers know that
strlen() is invariant and has no side effects, but I vote you go ahead
and optimise it explicitly.

Peter

--- scripts/split-include.c.trini	2002-11-11 17:34:57.000000000 -0600
+++ scripts/split-include.c	2002-11-11 17:30:45.000000000 -0600
@@ -52,7 +52,7 @@
     FILE * fp_target;
     FILE * fp_find;
 
-    int buffer_size;
+    int buffer_size, split_token_len;
 
     char * line;
     char * old_line;
@@ -72,6 +72,7 @@
     str_file_autoconf = argv[1];
     str_dir_config    = argv[2];
     str_split_token   = argv[3];
+    split_token_len = strlen(str_split_token);
 
     /* Find a buffer size. */
     if (stat(str_file_autoconf, &stat_buf) != 0)
@@ -116,7 +117,7 @@
 	    continue;
 
 	/* Make the output file name. */
-	str_config += strlen(str_split_token);
+	str_config += split_token_len;
 	for (itarget = 0; !isspace(str_config[itarget]); itarget++)
 	{
 	    int c = (unsigned char) str_config[itarget];
