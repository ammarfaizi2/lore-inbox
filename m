Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264056AbUKZUMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264056AbUKZUMK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 15:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264045AbUKZUKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 15:10:08 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262362AbUKZTip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:38:45 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 25 Nov 2004 17:03:39 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Gerd Knorr <kraxel@suse.de>, Johannes Stezenbach <js@convergence.de>,
       Johannes Stezenbach <js@linuxtv.org>, Takashi Iwai <tiwai@suse.de>,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: modprobe + request_module() deadlock
Message-ID: <20041125160339.GA3504@bytesex>
References: <20041122102502.GF29305@bytesex> <20041122141607.GA21184@linuxtv.org> <20041122144432.GB575@bytesex> <20041122153637.GA10673@convergence.de> <20041122165201.GA2060@bytesex> <1101272551.6186.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101272551.6186.25.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2004 at 04:02:31PM +1100, Rusty Russell wrote:
> On Mon, 2004-11-22 at 17:52 +0100, Gerd Knorr wrote:
> > > > I can fix that in the driver, by delaying the request_module() somehow
> > > > until the saa7134 module initialization is finished.  I don't think that
> > > > this is a good idea through as it looks like I'm not the only one with
> > > > that problem ...
> > > 
> > > Delaying request_module() sounds ugly. Anyway, if you can
> > > get it to work reliably...
> > 
> > I think I can, havn't tried yet through.

Untested proof-of-concept code (don't have a saa7134 card in my machine
at the moment), but that way it could work I think.  Tried to keep it
generic.  Basically it keeps a list of pending module loads and the
dependencies.  Then it hooks into the module state notifier chain and
calls request_module() once the depending module went to LIVE state.

Comments?

  Gerd

Index: saa7134-core.c
===================================================================
RCS file: /home/cvsroot/video4linux/saa7134-core.c,v
retrieving revision 1.20
diff -u -p -r1.20 saa7134-core.c
--- saa7134-core.c	23 Nov 2004 17:29:09 -0000	1.20
+++ saa7134-core.c	25 Nov 2004 15:54:23 -0000
@@ -233,6 +233,75 @@ static void dump_statusregs(struct saa71
 }
 #endif
 
+/* ----------------------------------------------------------- */
+
+struct pending_module {
+	struct module    *dep;
+	char             *name;
+	struct list_head next;
+};
+
+static int pending_call(struct notifier_block *self, unsigned long state,
+			void *module);
+
+static LIST_HEAD(pending_modules);
+static struct notifier_block pending_notifier = {
+	.notifier_call = pending_call,
+};
+
+static int pending_call(struct notifier_block *self, unsigned long state,
+			void *module)
+{
+	struct list_head *item;
+	struct pending_module *mod = NULL;
+
+	list_for_each(item,&pending_modules) {
+		mod = list_entry(item, struct pending_module, next);
+		if (mod->dep == module)
+			break;
+		mod = NULL;
+	}
+	if (NULL == mod)
+		return NOTIFY_DONE;
+
+	switch (state) {
+	case MODULE_STATE_LIVE:
+		request_module(mod->name);
+		/* fall through */
+	case MODULE_STATE_GOING:
+		list_del(&mod->next);
+		kfree(mod);
+		if (list_empty(&pending_modules))
+			unregister_module_notifier(&pending_notifier);
+		break;
+	}
+	return NOTIFY_DONE;
+}
+
+static void request_module_depend(struct module *dep, char *name)
+{
+	struct pending_module *mod;
+
+	switch (dep->state) {
+	case MODULE_STATE_COMING:
+		mod = kmalloc(sizeof(mod),GFP_KERNEL);
+		if (NULL == mod)
+			return;
+		mod->dep  = dep;
+		mod->name = name;
+		if (list_empty(&pending_modules))
+			register_module_notifier(&pending_notifier);
+		list_add(&mod->next,&pending_modules);
+		break;
+	case MODULE_STATE_LIVE:
+		request_module(name);
+		break;
+	default:
+		/* nothing */;
+		break;
+	}
+}
+
 /* ------------------------------------------------------------------ */
 
 /* nr of (saa7134-)pages for the given buffer size */
@@ -954,12 +1023,12 @@ static int __devinit saa7134_initdev(str
 		request_module("tuner");
 	if (dev->tda9887_conf)
 		request_module("tda9887");
-  	if (card_is_empress(dev)) {
-		request_module("saa7134-empress");
+  	if (1 /* card_is_empress(dev) */) {
+		request_module_depend(THIS_MODULE,"saa7134-empress");
 		request_module("saa6752hs");
 	}
-  	if (card_is_dvb(dev))
-		request_module("saa7134-dvb");
+  	if (1 /* card_is_dvb(dev) */)
+		request_module_depend(THIS_MODULE,"saa7134-dvb");
 
 	v4l2_prio_init(&dev->prio);
 
