Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262040AbULaN0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbULaN0I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 08:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbULaN0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 08:26:08 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:5349 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S262040AbULaN0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 08:26:02 -0500
From: Mike Hearn <mh@codeweavers.com>
To: Thomas Sailer <sailer@scs.ch>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, the3dfxdude@gmail.com,
       pouech-eric@wanadoo.fr, dan@debian.org, roland@redhat.com,
       linux-kernel@vger.kernel.org, wine-devel@winehq.com,
       wine-patches@winehq.com, mingo@elte.hu
In-Reply-To: <200412311413.16313.sailer@scs.ch>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
	 <1104401393.5128.24.camel@gamecube.scs.ch>
	 <1104411980.3073.6.camel@littlegreen>  <200412311413.16313.sailer@scs.ch>
Organization: Codeweavers, Inc
Date: Fri, 31 Dec 2004 13:31:00 +0000
Message-Id: <1104499860.3594.5.camel@littlegreen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-SPF-Flag: YES
X-SA-Exim-Connect-IP: 81.97.76.53
X-SA-Exim-Mail-From: mh@codeweavers.com
Subject: Re: ptrace single-stepping change breaks Wine
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-31 at 14:13 +0100, Thomas Sailer wrote:
> No this doesn't work. The decision which address space layout to use is done 
> in arch/i386/mm/mmap.c:arch_pick_mmap_layout, and this function is called by 
> the elf loader in fs/binfmt_elf.c:load_elf_binary, i.e. the decision which 
> address space layout to use for the current wine process is already done long 
> time before your personality syscall takes effect.
> 
> I hoped there was some ELF section magic to turn this off (like execshield), 
> but there doesn't seem to be.

So it has to be done before an exec then? I had assumed changing the
personality would affect all mmaps from that point onwards, too bad.

We do some execs as part of the Wine startup code so it shouldn't be too
much of an issue. Anyway, all the setarch program does is do this
syscall then exec the program so it shouldn't be too hard to do the
equivalent in Wine.

What about this patch?

--- libs/wine/config.c  (revision 14)
+++ libs/wine/config.c  (local)
@@ -35,6 +35,10 @@
 #endif
 #include "wine/library.h"
 
+#ifdef HAVE_SYSCALL_H
+#include <syscall.h>
+#endif
+
 static const char server_config_dir[] = "/.wine";        /* config dir relative to $HOME */
 static const char server_root_prefix[] = "/tmp/.wine-";  /* prefix for server root dir */
 static const char server_dir_prefix[] = "/server-";      /* prefix for server dir */
@@ -289,8 +293,13 @@ static void preloader_exec( char **argv,
         new_argv = xmalloc( (last_arg - argv + 2) * sizeof(*argv) );
         memcpy( new_argv + 1, argv, (last_arg - argv + 1) * sizeof(*argv) );
         new_argv[0] = full_name;
+
+        /* set the abi personality */
+        syscall(136, 0x8 /* PER_LINUX32 */ | 0x0200000 /* ADDR_COMPAT_LAYOUT */);
+        
         if (envp) execve( full_name, new_argv, envp );
         else execv( full_name, new_argv );
+        
         free( new_argv );
         free( full_name );
         return;


