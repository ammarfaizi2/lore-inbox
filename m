Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVDZWG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVDZWG1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 18:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbVDZWG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 18:06:27 -0400
Received: from mail.dif.dk ([193.138.115.101]:8658 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261175AbVDZWGI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 18:06:08 -0400
Date: Wed, 27 Apr 2005 00:09:25 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Frederik Deweerdt <dev.deweerdt@laposte.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Don't oops when unregistering unknown kprobes
In-Reply-To: <20050426214241.GF27406@gilgamesh.home.res>
Message-ID: <Pine.LNX.4.62.0504262349160.2071@dragon.hyggekrogen.localhost>
References: <20050426162203.GE27406@gilgamesh.home.res> <20050426162751.GD32766@in.ibm.com>
 <20050426214241.GF27406@gilgamesh.home.res>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2005, Frederik Deweerdt wrote:

> Le 26/04/05 21:57 +0530, Prasanna S Panchamukhi écrivit:
> > This is wrong. You should call get_kprobe() with spin_lock().
> >  
> Right, corrected patch attached. It also sets flags to zero.
> Signed-off-by: Frederik Deweerdt <frederik.deweerdt@laposte.net>

> --- linux-2.6.12-rc3/kernel/kprobes.c   2005-04-26 16:35:22.000000000 +0200
> +++ linux-2.6.12-rc3-devel/kernel/kprobes.c     2005-04-26 23:18:47.000000000 +0200
> @@ -106,13 +106,22 @@ rm_kprobe:
> 
>  void unregister_kprobe(struct kprobe *p)
>  {
> -       unsigned long flags;
> +       unsigned long flags = 0;
> +
> +       spin_lock_irqsave(&kprobe_lock, flags);
          ^^^
           +one...

> +       if (!get_kprobe(p)) {
> +               printk(KERN_WARNING "Warning: Attempt to unregister "
> +                                       "unknown kprobe (addr:0x%lx)\n",
> +                                       (unsigned long) p);
> +               goto out;
> +       }
>         arch_remove_kprobe(p);
>         spin_lock_irqsave(&kprobe_lock, flags);
          ^^^
           +two...

>         *p->addr = p->opcode;
>         hlist_del(&p->hlist);
>         flush_icache_range((unsigned long) p->addr,
>                            (unsigned long) p->addr + sizeof(kprobe_opcode_t));
> +out:
>         spin_unlock_irqrestore(&kprobe_lock, flags);
          ^^^
           -one...

>  }

Seems to me this will end up calling spin_lock_irqsave() twice, but only 
spin_unlock_irqrestore once in the non-failing case... hmm..

Also, as Chris Wedgwood asked, why not simply  return -EINVAL;  instead of 
the printk()?  Does the user really care that we tried to unregister a 
nonexisting kprobe? and if you really think someone would like to know 
then I'd personally say that KERN_DEBUG should be sufficient.

I'd suggest something like this :

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc2-mm3-orig/kernel/kprobes.c	2005-04-11 21:20:56.000000000 +0200
+++ linux-2.6.12-rc2-mm3/kernel/kprobes.c	2005-04-27 00:04:23.000000000 +0200
@@ -108,16 +108,24 @@ rm_kprobe:
 	return ret;
 }
 
-void unregister_kprobe(struct kprobe *p)
+int unregister_kprobe(struct kprobe *p)
 {
-	unsigned long flags;
-	arch_remove_kprobe(p);
+	unsigned long flags = 0;
+	int ret = 0;
+
 	spin_lock_irqsave(&kprobe_lock, flags);
+	if (!get_kprobe(p)) {
+		ret = -EINVAL;
+		goto out;
+	}
+	arch_remove_kprobe(p);
 	*p->addr = p->opcode;
 	hlist_del(&p->hlist);
 	flush_icache_range((unsigned long) p->addr,
 			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
+out:
 	spin_unlock_irqrestore(&kprobe_lock, flags);
+	return ret;
 }
 
 


And if you really want that printk in there, then this should make you 
happy - but personally I don't see the big need : 
+       if (!get_kprobe(p)) {
+               printk(KERN_DEBUG "Warning: Attempt to unregister "
+                                 "unknown kprobe (addr:0x%lx)\n",
+                                 (unsigned long) p);
+               ret = -EINVAL;
+               goto out;
+       }


Ohh and btw, would you mind posting patches inline? Having to save the 
patch, add quotes to it and then read it back into the reply mail to 
comment on it is a pain...

And don't trim the CC: list when replying to mails on LKML, please.


-- 
Jesper Juhl


