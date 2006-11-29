Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966430AbWK2JGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966430AbWK2JGV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 04:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966435AbWK2JGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 04:06:21 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:8645 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S966430AbWK2JGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 04:06:20 -0500
Subject: Re: 2.6.19-rc6-mm2
From: Kay Sievers <kay.sievers@vrfy.org>
To: Greg KH <greg@kroah.com>
Cc: Mariusz Kozlowski <m.kozlowski@tuxland.pl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061128223058.GC16152@kroah.com>
References: <20061128020246.47e481eb.akpm@osdl.org>
	 <200611281235.45087.m.kozlowski@tuxland.pl>
	 <20061128223058.GC16152@kroah.com>
Content-Type: multipart/mixed; boundary="=-mkrtD8m0lDA0cKpI+OLb"
Date: Wed, 29 Nov 2006 10:06:01 +0100
Message-Id: <1164791161.3613.106.camel@pim.off.vrfy.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2 
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:4ddcc9dd12ba6cf3155e4d81b383efda
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mkrtD8m0lDA0cKpI+OLb
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2006-11-28 at 14:30 -0800, Greg KH wrote:
> On Tue, Nov 28, 2006 at 12:35:43PM +0100, Mariusz Kozlowski wrote:
> > Hello,
> > 
> > 	When CONFIG_MODULE_UNLOAD is not set then this happens:
> > 
> >   CC      kernel/module.o
> > kernel/module.c:852: error: `initstate' undeclared here (not in a function)
> > kernel/module.c:852: error: initializer element is not constant
> > kernel/module.c:852: error: (near initialization for `modinfo_attrs[2]')
> > make[1]: *** [kernel/module.o] Error 1
> > make: *** [kernel] Error 2
> > 
> > Reference to 'initstate' should stay under #ifdef CONFIG_MODULE_UNLOAD
> > as its definition I guess.
> > 
> > Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
> > 
> > --- linux-2.6.19-rc6-mm2-a/kernel/module.c      2006-11-28 12:17:09.000000000 +0100
> > +++ linux-2.6.19-rc6-mm2-b/kernel/module.c      2006-11-28 12:05:01.000000000 +0100
> > @@ -849,8 +849,8 @@ static inline void module_unload_init(st
> >  static struct module_attribute *modinfo_attrs[] = {
> >         &modinfo_version,
> >         &modinfo_srcversion,
> > -       &initstate,
> >  #ifdef CONFIG_MODULE_UNLOAD
> > +       &initstate,
> >         &refcnt,
> >  #endif
> 
> Kay, is this correct?  I think we still need this information exported
> to userspace, even if we can't unload modules, right?

Yes, instead we should move the attribute out of the ifdef, so
it will be there, even when modules can't be unloaded.

Thanks,
Kay


--=-mkrtD8m0lDA0cKpI+OLb
Content-Description: 
Content-Disposition: inline; filename=modules-state.patch
Content-Type: text/x-patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff --git a/kernel/module.c b/kernel/module.c
index f016656..0648f5d 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -811,9 +811,34 @@ static inline void module_unload_init(st
 }
 #endif /* CONFIG_MODULE_UNLOAD */
 
+static ssize_t show_initstate(struct module_attribute *mattr,
+			   struct module *mod, char *buffer)
+{
+	const char *state = "unknown";
+
+	switch (mod->state) {
+	case MODULE_STATE_LIVE:
+		state = "live";
+		break;
+	case MODULE_STATE_COMING:
+		state = "coming";
+		break;
+	case MODULE_STATE_GOING:
+		state = "going";
+		break;
+	}
+	return sprintf(buffer, "%s\n", state);
+}
+
+static struct module_attribute initstate = {
+	.attr = { .name = "initstate", .mode = 0444, .owner = THIS_MODULE },
+	.show = show_initstate,
+};
+
 static struct module_attribute *modinfo_attrs[] = {
 	&modinfo_version,
 	&modinfo_srcversion,
+	&initstate,
 #ifdef CONFIG_MODULE_UNLOAD
 	&refcnt,
 #endif

--=-mkrtD8m0lDA0cKpI+OLb--

