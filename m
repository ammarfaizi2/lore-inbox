Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbVGCW4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVGCW4b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 18:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVGCW4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 18:56:30 -0400
Received: from cerebus.immunix.com ([198.145.28.33]:49588 "EHLO
	ermintrude.int.immunix.com") by vger.kernel.org with ESMTP
	id S261559AbVGCW4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 18:56:15 -0400
Date: Sun, 3 Jul 2005 15:51:52 -0700
From: Tony Jones <tonyj@immunix.com>
To: Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Steve Beattie <smb@wirex.com>
Subject: Re: [PATCH 1/3] Make cap default
Message-ID: <20050703225152.GA25706@immunix.com>
References: <20050703154333.GB11093@tpkurt.garloff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050703154333.GB11093@tpkurt.garloff.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 03, 2005 at 05:43:33PM +0200, Kurt Garloff wrote:

> Note that we could think of getting rid of dummy; however, it's
> still used as fallback for stubs that are not implemented by an
> LSM. I did not want to change this with this patch set, though
> I'd like to see it done if everyone agrees it's a good idea.

I think this needs to happen (dummy goes away or it's contents are replaced
by cap routines as appropriate).

Currently in security_init() verify(&dummy_security_ops) calling 
security_fixup_ops is a no-op in terms of modifying dummy. In your patch as
you suggest verify(&capability_security_ops) now patches routines from dummy 
into this default capability_security_ops.  The code is already too baroque,
no point making it more complex.

I think the necessary functions need to be present in this new base structure
and security_fixup_ops patches from it into whatever new ops a caller passes, 
dummy goes away. As a bonus, at this point your capability_ops struct in
capability.c can really be different :-)

--- linux-2.6.10.orig/security/commoncap.c
+++ linux-2.6.10/security/commoncap.c
[snip]
> +EXPORT_SYMBOL(capability_security_ops);
> +/* Note: If the capability security module is loaded, we do NOT register
> + * the capability_security_ops but a second structure that has the
> + * identical entries. The reason is that this way,
> + * - we could stack on top of capability if it was stackable
> + * - a loaded capability module will prevent others to register, which
> + *   is the previous behaviour; if capabilities are used as default (not
> + *   because the module has been loaded), we allow the replacement.
> + */
> +#endif

The intent here is to make it past the 
	if (security_ops != &capability_security_ops)
check in security.c::register_security so that it is possible to actually
register capability (capability_ops) subsequently as a module should you
so desire, no?

The above description doesn't impart that.  Plus why would you want to stack
capability on top of this base capability, even if it it supported stacking?

--- linux-2.6.10.orig/security/capability.c
+++ linux-2.6.10/security/capability.c

+/* Note: If the capability security module is loaded, we do NOT register
+ * the capability_security_ops but a second structure capability_ops
+ * that has the identical entries. The reasons:
+ * - we could stack on top of capability if it was stackable
+ * - a loaded capability module will prevent others to register, which
+ *   is the previous behaviour; if capabilities are used as default (not
+ *   because the module has been loaded), we allow the replacement.

Ditto for this comment.

>  static int __init capability_init (void)
>  {
> +	memcpy(&capability_ops, &capability_security_ops, sizeof(capability_ops));
>  	if (capability_disable) {
>  		printk(KERN_INFO "Capabilities disabled at initialization\n");
>  		return 0;
>  	}

No point doing the memcpy if capability_disable is true.

Tony
