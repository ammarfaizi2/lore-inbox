Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWFWMMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWFWMMx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 08:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933080AbWFWMMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 08:12:53 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:38520 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932141AbWFWMMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 08:12:52 -0400
Date: Fri, 23 Jun 2006 14:12:51 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Karel Kulhavy <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org, kai@germaschewski.name, sam@ravnborg.org
Subject: Re: modpost change proposed
Message-ID: <20060623121250.GG14682@harddisk-recovery.com>
References: <20060623113138.GA29844@kestrel.barix.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623113138.GA29844@kestrel.barix.local>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 01:31:38PM +0200, Karel Kulhavy wrote:
> If the modpost has error it dumps core:
> modpost: vmlinux no symtab?
> /bin/sh: line 1: 28307 Aborted                 (core dumped)
> scripts/mod/modpost -o
> /home/clock/edb9302/cirrus-arm-linux-1.0.7/linux-2.6.8.1/Module.symvers
> vmlinux drivers/net/wireless/hermes.o drivers/net/wireless/orinoco.o
> drivers/net/wireless/orinoco_cs.o drivers/usb/gadget/g_file_storage.o
> make[1]: *** [__modpost] Error 134
> 
> I suggest the abort(); to be everywhere replaced with exit(1) for the
> following reasons:
> 1) it's customary

It's not. In case of a serious error, abort() gives you the chance to
do a post mortem analysis with a debugger, exit() doesn't. I do agree
that the use of abort() in modpost is not necessary. Try this patch
(against 2.6.17):

commit 726ee2748969fb2d40b45de36dd56a5abea37954
Author: Erik Mouw <erik@harddisk-recovery.com>
Date:   Fri Jun 23 14:04:52 2006 +0200

    modpost: change abort() into exit()
    
    The perror() above the abort() tells enough about the
    failure, no need to dump core (a post mortem analysis
    on the core file won't give extra information about the
    failure). Suggested by Karel Kulhavy.
    
    Signed-off-by: Erik Mouw <erik@harddisk-recovery.com>

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index d0f86ed..42a2bc0 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -283,7 +283,7 @@ static void parse_elf(struct elf_info *i
 	hdr = grab_file(filename, &info->size);
 	if (!hdr) {
 		perror(filename);
-		abort();
+		exit(1);
 	}
 	info->hdr = hdr;
 	if (info->size < sizeof(*hdr))

> 2) core dumping looks scary

If it scares you, disable it. "limit coredumpsize 0" in (t)csh, or
"ulimit -c 0" in bash.

> 3) the core takes up space on disk

If you don't like it, disable it.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
