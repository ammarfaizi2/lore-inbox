Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266314AbUAVSG0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 13:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266316AbUAVSGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 13:06:25 -0500
Received: from fed1mtao08.cox.net ([68.6.19.123]:41380 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S266314AbUAVSGH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 13:06:07 -0500
Date: Thu, 22 Jan 2004 11:05:55 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Powerpc Linux <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       George Anzinger <george@mvista.com>
Subject: Re: PPC KGDB changes and some help?
Message-ID: <20040122180555.GK15271@stop.crashing.org>
References: <20040120172708.GN13454@stop.crashing.org> <200401211946.17969.amitkale@emsyssoft.com> <20040121153019.GR13454@stop.crashing.org> <200401212223.13347.amitkale@emsyssoft.com> <20040121184217.GU13454@stop.crashing.org> <20040121192128.GV13454@stop.crashing.org> <20040121192230.GW13454@stop.crashing.org> <20040122174416.GJ15271@stop.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040122174416.GJ15271@stop.crashing.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22, 2004 at 10:44:16AM -0700, Tom Rini wrote:
> On Wed, Jan 21, 2004 at 12:22:30PM -0700, Tom Rini wrote:
> > On Wed, Jan 21, 2004 at 12:21:28PM -0700, Tom Rini wrote:
> > > On Wed, Jan 21, 2004 at 11:42:17AM -0700, Tom Rini wrote:
> > > > On Wed, Jan 21, 2004 at 10:23:12PM +0530, Amit S. Kale wrote:
> > > > 
> > > > > Hi,
> > > > > 
> > > > > Here it is: ppc kgdb from timesys kernel is available at
> > > > > http://kgdb.sourceforge.net/kgdb-2/linux-2.6.1-kgdb-2.1.0.tar.bz2
> > > > > 
> > > > > This is my attempt at extracting kgdb from TimeSys kernel. It works well in 
> > > > > TimeSys kernel, so blame me if above patch doesn't work.
> > > > 
> > > > Okay, here's my first patch against this.
> > > 
> > > And dependant upon this is a patch to fixup the rest of the common PPC
> > > code, as follows:
> > 
> > And on top of all of that is the following, which allows KGDB to work on
> > the Motorola LoPEC.
> 
> On top of everything from yesterday, here's:

First up:
We need to call flush_instruction_cache() on a 'c' or 's' command.
 arch/ppc/kernel/ppc-stub.c |   19 ++++++-------------
 1 files changed, 6 insertions(+), 13 deletions(-)
--- 1.14/arch/ppc/kernel/ppc-stub.c	Thu Jan 22 10:41:58 2004
+++ edited/arch/ppc/kernel/ppc-stub.c	Thu Jan 22 10:49:30 2004
@@ -144,18 +144,6 @@
 	return;
 }				/* gdb_regs_to_regs */
 
-/* exit_handler:
- * 
- * This is called by the generic layer when it is about to return from 
- * the exception handler
- */
-void
-ppc_handler_exit(void)
-{
-//      flush_instruction_cache ();
-	return;
-}
-
 /*
  * This function does PoerPC specific procesing for interfacing to gdb.
  */
@@ -188,6 +176,12 @@
 		if (kgdb_hexToLong(&ptr, &addr))
 			linux_regs->nip = addr;
 
+/* Need to flush the instruction cache here, as we may have deposited a
+ * breakpoint, and the icache probably has no way of knowing that a data ref to
+ * some location may have changed something that is in the instruction cache.
+ */
+		flush_instruction_cache();
+
 		/* set the trace bit if we're stepping */
 		if (remcomInBuffer[0] == 's') {
 #if defined (CONFIG_4xx)
@@ -254,5 +248,4 @@
 	.sleeping_thread_to_gdb_regs = ppc_sleeping_thread_to_gdb_regs,
 	.gdb_regs_to_regs = ppc_gdb_regs_to_regs,
 	.handle_exception = ppc_handle_exception,
-	.handler_exit = ppc_handler_exit,
 };

-- 
Tom Rini
http://gate.crashing.org/~trini/
