Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261599AbSJ1WZv>; Mon, 28 Oct 2002 17:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261601AbSJ1WZu>; Mon, 28 Oct 2002 17:25:50 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:13012 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S261599AbSJ1WZs>; Mon, 28 Oct 2002 17:25:48 -0500
Date: Mon, 28 Oct 2002 16:32:07 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Rob Landley <landley@trommello.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.44: what's .tmp_export-objs for?
In-Reply-To: <200210281054.16008.landley@trommello.org>
Message-ID: <Pine.LNX.4.44.0210281626380.26960-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2002, Rob Landley wrote:

> I accidentally did a 2.5.44 kernel build as root rather than my normal user, 
> so I'm trying to see what clean steps I need to so (as root) to be able to 
> build the tree again.  A normal make clean failed (permission denied deleting 
> files), so I did an su and a make clean.  Exit back to normal user, make 
> clean, life is good, do a make dep, and it complains about the directory 
> .tmp_export-objs.
> 
> 1) Why does the build process use a hidden directory?

The "make dep" stage generates .ver files for all files listed in 
*/Makefile:export-objs. At the same time, it creates a zero-length file
corresponding to each .ver file in .tmp_export-objs, which are needed to 
afterwards construct include/linux/modversions.h, which is basically

	#include <linux/module/path/obj.ver>

for all objects we created the .ver files for earlier. Basically,
.tmp_export-objs is a complicated way to create a list of filenames,
the reason we cannot just append names to one file is that multiple
'make's may run in parallel (make -j), so that appending to a single file
would be racy.

> 2) Why isn't make clean removing something with "tmp" in the name?

Well, for some traditional reasons, there is a distinction between
"make clean" and "make mrproper", where only the latter really removes 
everything.

--Kai

