Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267432AbSLLHwQ>; Thu, 12 Dec 2002 02:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267433AbSLLHwQ>; Thu, 12 Dec 2002 02:52:16 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:63985 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267432AbSLLHwO>;
	Thu, 12 Dec 2002 02:52:14 -0500
Date: Thu, 12 Dec 2002 13:43:04 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: John Levon <levon@movementarian.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH] Notifier for significant events on i386
Message-ID: <20021212134304.A20330@in.ibm.com>
Reply-To: vamsi@in.ibm.com
References: <1039471369.1055.161.camel@dell_ss3.pdx.osdl.net> <20021211165153.A17546@in.ibm.com> <20021211111639.GJ9882@holomorphy.com> <20021211171337.A17600@in.ibm.com> <20021211202727.GF20735@compsoc.man.ac.uk> <1039641336.18587.30.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1039641336.18587.30.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Wed, Dec 11, 2002 at 10:13:33PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2002 at 10:13:33PM +0000, Alan Cox wrote:
> On Wed, 2002-12-11 at 20:27, John Levon wrote:
> > There are notifiers being used that sleep inside the called notifiers.
> > 
> > You could easily make a __notifier_call_chain that is lockless and
> > another one that readlocks the notifier_lock ...
> 
> The notifier chains assume the users will do the locking needed for
> them. It might be possible to do cool things there with RCU
> 
Hmm. If the called notifiers sleep, RCU can't prevent the notifiers
from being unregistered while they are executing. I suppose then that
RCU is not suitable for generic notifiers. It may still be useful
for managing notifiers in very fast paths where acquiring a
read lock may be undesirable (like the oprofile's NMI handler).

Instead of a lockless __notifier_call_chain, I would rather add
a notifier_call_chain_safe() to avoid changing the existing
handlers. Something like the patch below.

The safe version should be used for the trap handlers: we know
that the called notifiers will not sleep and the smp-safeness 
makes the handlers simpler.

Thanks,
Vamsi.
-- 
Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi@in.ibm.com
--
diff -urN -X /home/vamsi/.dontdiff 51-pure/include/linux/notifier.h 51-notifier/include/linux/notifier.h
--- 51-pure/include/linux/notifier.h	2002-12-10 08:15:43.000000000 +0530
+++ 51-notifier/include/linux/notifier.h	2002-12-12 11:53:53.000000000 +0530
@@ -24,6 +24,7 @@
 extern int notifier_chain_register(struct notifier_block **list, struct notifier_block *n);
 extern int notifier_chain_unregister(struct notifier_block **nl, struct notifier_block *n);
 extern int notifier_call_chain(struct notifier_block **n, unsigned long val, void *v);
+extern int notifier_call_chain_safe(struct notifier_block **n, unsigned long val, void *v);
 
 #define NOTIFY_DONE		0x0000		/* Don't care */
 #define NOTIFY_OK		0x0001		/* Suits me */
diff -urN -X /home/vamsi/.dontdiff 51-pure/kernel/sys.c 51-notifier/kernel/sys.c
--- 51-pure/kernel/sys.c	2002-12-10 08:15:43.000000000 +0530
+++ 51-notifier/kernel/sys.c	2002-12-12 11:52:45.000000000 +0530
@@ -166,6 +166,29 @@
 }
 
 /**
+ *	notifier_call_chain_safe - Call functions in a notifier chain
+ *	@n: Pointer to root pointer of notifier chain
+ *	@val: Value passed unmodified to notifier function
+ *	@v: Pointer passed unmodified to notifier function
+ *
+ *	Calls each function in a notifier chain in turn while ensuring
+ *	that a notifier cannot be unregistered while it is being
+ *	executed. Because a read_lock is taken, the called notifiers
+ *	must not sleep.
+ */
+ 
+int notifier_call_chain_safe(struct notifier_block **n, unsigned long val, void *v)
+{
+	int ret;
+
+	read_lock(&notifier_lock);
+	ret = notifier_call_chain(n, val, v);
+	read_unlock(&notifier_lock);
+
+	return ret;
+}
+
+/**
  *	register_reboot_notifier - Register function to be called at reboot time
  *	@nb: Info about notifier function to be called
  *
