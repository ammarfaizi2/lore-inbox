Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265284AbTFUTgy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 15:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265285AbTFUTgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 15:36:54 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:9438 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265284AbTFUTgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 15:36:53 -0400
Date: Sat, 21 Jun 2003 12:51:11 -0700
From: Andrew Morton <akpm@digeo.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com, perex@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Isapnp warning
Message-Id: <20030621125111.0bb3dc1c.akpm@digeo.com>
In-Reply-To: <Pine.GSO.4.21.0306211658470.869-100000@vervain.sonytel.be>
References: <1056198688.25975.25.camel@dhcp22.swansea.linux.org.uk>
	<Pine.GSO.4.21.0306211658470.869-100000@vervain.sonytel.be>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Jun 2003 19:50:56.0149 (UTC) FILETIME=[6DFD8C50:01C3382E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> > >  int pnp_add_irq_resource(struct pnp_dev *dev, int depnum, struct pnp_irq *data)
>  > >  {
>  > > +#ifdef CONFIG_PCI
>  > >  	int i;
>  > > +#endif
>  > 
>  > This is far uglier than te warning
> 
>  It depends on your goals. These warnings distract us from the real harmful
>  warnings. Will we ever have a kernel that compiles with -Werror?

It would be nice.  But as soon as we do that, some gcc guy will have a
brainfart and we'll get a whole new batch of warnings which we cannot turn
off.  Again.  I've been involved in projects where it was unacceptable to
upgrade the gcc version for this sole reason.


Meanwhile, let's do this:

diff -puN drivers/pnp/resource.c~misc6 drivers/pnp/resource.c
--- 25/drivers/pnp/resource.c~misc6	2003-06-21 12:47:23.000000000 -0700
+++ 25-akpm/drivers/pnp/resource.c	2003-06-21 12:47:44.000000000 -0700
@@ -97,7 +97,6 @@ int pnp_get_max_depnum(struct pnp_dev *d
 
 int pnp_add_irq_resource(struct pnp_dev *dev, int depnum, struct pnp_irq *data)
 {
-	int i;
 	struct pnp_resources *res;
 	struct pnp_irq *ptr;
 	res = pnp_find_resources(dev,depnum);
@@ -113,9 +112,13 @@ int pnp_add_irq_resource(struct pnp_dev 
 	else
 		res->irq = data;
 #ifdef CONFIG_PCI
-	for (i=0; i<16; i++)
-		if (data->map & (1<<i))
-			pcibios_penalize_isa_irq(i);
+	{
+		int i;
+
+		for (i=0; i<16; i++)
+			if (data->map & (1<<i))
+				pcibios_penalize_isa_irq(i);
+	}
 #endif
 	return 0;
 }

_

