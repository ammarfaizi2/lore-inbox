Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266605AbUAWRIj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 12:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266606AbUAWRIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 12:08:39 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:19153 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S266605AbUAWRIZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 12:08:25 -0500
Date: Fri, 23 Jan 2004 10:08:14 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Hollis Blanchard <hollisb@us.ibm.com>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       George Anzinger <george@mvista.com>,
       Powerpc Linux <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PPC KGDB changes and some help?
Message-ID: <20040123170814.GZ15271@stop.crashing.org>
References: <20040120172708.GN13454@stop.crashing.org> <30216351-4CEF-11D8-A2A1-000A95A0560C@us.ibm.com> <20040122154529.GE15271@stop.crashing.org> <200401222136.10887.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401222136.10887.amitkale@emsyssoft.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22, 2004 at 09:36:10PM +0530, Amit S. Kale wrote:

> On Thursday 22 Jan 2004 9:15 pm, Tom Rini wrote:
> > On Thu, Jan 22, 2004 at 09:25:19AM -0600, Hollis Blanchard wrote:
> > > On Jan 22, 2004, at 9:07 AM, Tom Rini wrote:
> > > >On Wed, Jan 21, 2004 at 03:12:25PM -0800, George Anzinger wrote:
> > > >>A question I have been meaning to ask:  Why is the arch/common
> > > >>connection
> > > >>via a structure of addresses instead of just calls?  I seems to me
> > > >>that
> > > >>just calling is a far cleaner way to do things here.  All the struct
> > > >>seems
> > > >>to offer is a way to change the backend on the fly.  I don't thing we
> > > >>ever
> > > >>want to do that.  Am I missing something?
> > > >
> > > >I imagine it's a style thing.  I don't have a preference either way.
> > >
> > > I think we in PPC land have gotten used to that "style" because we have
> > > one kernel that supports different "platforms", i.e. it selects the
> > > appropriate code at runtime as George says. In general that's a little
> > > bit slower and a little bit bigger.
> > >
> > > Unless you need to choose among PPC KGDB functions at runtime, which I
> > > don't think you do, you don't need it...
> >
> > That's certainly true, so if (and if I understand Georges question
> > right) Amit wants to change kgdb_arch into a set of required functions,
> > with stubs in, say, kernel/kgdbdummy.c, (and just keep the flags / etc
> > in the struct), that's fine with me.
> 
> The penalty of keeping them consolidated in a structure isn't so high. I 
> prefer to keep them that way. I'll work on reducing number of initialization 
> functions, though.

Ok.  After talking with George off-list, I think most of ppc_kgdb_init
can go.  The only remaining part is the serial plugin, which could be
done ala the kgdb_8250 driver.  But I've got a different idea:

 arch/ppc/kernel/ppc-stub.c |    3 +--
 drivers/serial/kgdb_8250.c |    4 +---
 kernel/kgdbstub.c          |    2 +-
 3 files changed, 3 insertions(+), 6 deletions(-)
--- kernel/kgdbstub.c	2004-01-23 10:03:48.000000000 -0700
+++ kernel/kgdbstub.c	2004-01-23 10:06:19.000000000 -0700
@@ -61,7 +61,7 @@
 gdb_breakpoint_t kgdb_break[MAX_BREAKPOINTS];
 extern int pid_max;
 
-struct kgdb_serial *kgdb_serial;
+struct kgdb_serial *kgdb_serial = &kgdb_serial_driver;
 
 int kgdb_initialized = 0;
 int kgdb_enter = 0;
--- drivers/serial/kgdb_8250.c	2004-01-23 10:04:57.000000000 -0700
+++ drivers/serial/kgdb_8250.c	2004-01-23 09:57:26.000000000 -0700
@@ -370,7 +370,7 @@
 	rs_table[i].regshift = serial_req->regshift;
 }
 
-struct kgdb_serial kgdb8250_serial = {
+struct kgdb_serial kgdb_serial_driver = {
 	.read_char = kgdb8250_read_char,
 	.write_char = kgdb8250_write_char,
 	.hook = kgdb8250_hook
@@ -396,8 +396,6 @@
 	    kgdb8250_baud != 115200)
 		goto errout;
 
-	kgdb_serial = &kgdb8250_serial;
-
 	return 1;
 
 errout:
--- arch/ppc/kernel/ppc-stub.c	2004-01-23 10:04:46.000000000 -0700
+++ arch/ppc/kernel/ppc-stub.c	2004-01-23 09:57:47.000000000 -0700
@@ -264,7 +264,7 @@
 	return 0;
 }
 
-struct kgdb_serial kgdbppc_serial = {
+struct kgdb_serial kgdb_serial_driver = {
 	.read_char = kgdbppc_read_char,
 	.write_char = kgdbppc_write_char,
 	.hook = kgdbppc_hook
@@ -272,5 +272,4 @@
 
 void kgdbppc_init(void)
 {
-	kgdb_serial = &kgdbppc_serial;
 }

This does mean that we can only have one serial driver per kernel, but I
don't see this as a problem.  This also means that i386 would need
something like PPC's CONFIG_KGDB_TTYSx to pick something other than
ttyS0/115200 to use kgdb on, this early.  But, IMHO, that's a small
price to pay.

-- 
Tom Rini
http://gate.crashing.org/~trini/
