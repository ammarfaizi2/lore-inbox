Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266027AbUAUSm1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 13:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266028AbUAUSm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 13:42:27 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:18845 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S266027AbUAUSmT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 13:42:19 -0500
Date: Wed, 21 Jan 2004 11:42:17 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Powerpc Linux <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       George Anzinger <george@mvista.com>
Subject: Re: PPC KGDB changes and some help?
Message-ID: <20040121184217.GU13454@stop.crashing.org>
References: <20040120172708.GN13454@stop.crashing.org> <200401211946.17969.amitkale@emsyssoft.com> <20040121153019.GR13454@stop.crashing.org> <200401212223.13347.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401212223.13347.amitkale@emsyssoft.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 21, 2004 at 10:23:12PM +0530, Amit S. Kale wrote:

> Hi,
> 
> Here it is: ppc kgdb from timesys kernel is available at
> http://kgdb.sourceforge.net/kgdb-2/linux-2.6.1-kgdb-2.1.0.tar.bz2
> 
> This is my attempt at extracting kgdb from TimeSys kernel. It works well in 
> TimeSys kernel, so blame me if above patch doesn't work.

Okay, here's my first patch against this.
===== kernel/kgdbstub.c 1.1 vs edited =====
--- 1.1/kernel/kgdbstub.c	Wed Jan 21 10:13:17 2004
+++ edited/kernel/kgdbstub.c	Wed Jan 21 10:53:38 2004
@@ -1058,9 +1058,6 @@
 	kgdb_serial->write_char('+');
 
 	linux_debug_hook = kgdb_handle_exception;
-	
-	if (kgdb_ops->kgdb_init)
-		kgdb_ops->kgdb_init();
 
 	/* We can't do much if this fails */
 	register_module_notifier(&kgdb_module_load_nb);
@@ -1104,6 +1101,11 @@
 	if (!kgdb_enter) {
 		return;
 	}
+
+	/* Let the arch do any initalization it needs to */
+	if (kgdb_ops->kgdb_init)
+		kgdb_ops->kgdb_init();
+
 	if (!kgdb_serial) {
 		printk("KGDB: no gdb interface available.\n"
 		       "kgdb can't be enabled\n");

I'm not sure why you were calling the arch-specific init so late in the
process, but since it's a nop on both i386 and x86_64 (so perhaps it
should be removed for both of these?), this change doesn't matter to
them.  But it does make the PPC code cleaner, IMHO.

-- 
Tom Rini
http://gate.crashing.org/~trini/
