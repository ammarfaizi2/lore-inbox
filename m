Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264900AbUGLE7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264900AbUGLE7g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 00:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266720AbUGLE7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 00:59:33 -0400
Received: from mail.donpac.ru ([80.254.111.2]:21909 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S264900AbUGLE71 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 00:59:27 -0400
Date: Mon, 12 Jul 2004 08:59:16 +0400
From: Andrey Panin <pazke@donpac.ru>
To: Anton Blanchard <anton@samba.org>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Moving per-arch IRQ handling code into common directories
Message-ID: <20040712045916.GD13803@pazke>
Mail-Followup-To: Anton Blanchard <anton@samba.org>,
	Peter Chubb <peterc@gelato.unsw.edu.au>,
	linux-kernel@vger.kernel.org
References: <16602.9814.700745.300562@wombat.chubb.wattle.id.au> <20040711110919.GI5232@krispykreme>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7CZp05NP8/gJM8Cl"
Content-Disposition: inline
In-Reply-To: <20040711110919.GI5232@krispykreme>
User-Agent: Mutt/1.5.6+20040523i
X-SMTP-Authenticated: pazke@donpac.ru (cram)
X-SMTP-TLS: TLSv1:AES256-SHA:256
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7CZp05NP8/gJM8Cl
Content-Type: multipart/mixed; boundary="sXc4Kmr5FA7axrvy"
Content-Disposition: inline


--sXc4Kmr5FA7axrvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 193, 07 11, 2004 at 09:09:20PM +1000, Anton Blanchard wrote:
>=20
> Hi,
>=20
> >   Inside each arch-specific kernel/irq.c, there's a comment something l=
ike,=20
> >   /* (mostly architecture independent, will move to kernel/irq.c in 2.5=
=2E) */
> >=20
> > This obviously hasn't happened, even though there was a patch by
> > Andrey Panin floating about around a year ago.  Is there some
> > fundamental objection to consolidating the IRQ handling as far as
> > possible, or was it just that the patch didn't get high enough profile?
>=20
> I think it died because we were in a freeze at the time. Id like to see
> it happen again, perhaps we can get something together to go into -mm.

No, it almost died because of lack of time to track changes in so many
architectures. BTW can you take a look at attached patch, which removes
do_free_irq() crap from ppc64 irq handling code ?

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--sXc4Kmr5FA7axrvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-ppc64-free_irq-cleanup
Content-Transfer-Encoding: quoted-printable

diff -urpN -X /usr/share/dontdiff linux-2.6.7.vanilla/arch/ppc64/kernel/irq=
=2Ec linux-2.6.7-ppc64/arch/ppc64/kernel/irq.c
--- linux-2.6.7.vanilla/arch/ppc64/kernel/irq.c	Sat May 22 14:58:15 2004
+++ linux-2.6.7-ppc64/arch/ppc64/kernel/irq.c	Sat May 22 19:58:35 2004
@@ -143,47 +143,6 @@ EXPORT_SYMBOL(synchronize_irq);
=20
 #endif /* CONFIG_SMP */
=20
-/* XXX Make this into free_irq() - Anton */
-
-/* This could be promoted to a real free_irq() ... */
-static int
-do_free_irq(int irq, void* dev_id)
-{
-	irq_desc_t *desc =3D get_irq_desc(irq);
-	struct irqaction **p;
-	unsigned long flags;
-
-	spin_lock_irqsave(&desc->lock,flags);
-	p =3D &desc->action;
-	for (;;) {
-		struct irqaction * action =3D *p;
-		if (action) {
-			struct irqaction **pp =3D p;
-			p =3D &action->next;
-			if (action->dev_id !=3D dev_id)
-				continue;
-
-			/* Found it - now remove it from the list of entries */
-			*pp =3D action->next;
-			if (!desc->action) {
-				desc->status |=3D IRQ_DISABLED;
-				mask_irq(irq);
-			}
-			spin_unlock_irqrestore(&desc->lock,flags);
-
-			/* Wait to make sure it's not being used on another CPU */
-			synchronize_irq(irq);
-			kfree(action);
-			return 0;
-		}
-		printk("Trying to free free IRQ%d\n",irq);
-		spin_unlock_irqrestore(&desc->lock,flags);
-		break;
-	}
-	return -ENOENT;
-}
-
-
 int request_irq(unsigned int irq,
 	irqreturn_t (*handler)(int, void *, struct pt_regs *),
 	unsigned long irqflags, const char * devname, void *dev_id)
@@ -194,8 +153,7 @@ int request_irq(unsigned int irq,
 	if (irq >=3D NR_IRQS)
 		return -EINVAL;
 	if (!handler)
-		/* We could implement really free_irq() instead of that... */
-		return do_free_irq(irq, dev_id);
+		return -EINVAL;
=20
 	action =3D (struct irqaction *)
 		kmalloc(sizeof(struct irqaction), GFP_KERNEL);
@@ -222,7 +180,38 @@ EXPORT_SYMBOL(request_irq);
=20
 void free_irq(unsigned int irq, void *dev_id)
 {
-	request_irq(irq, NULL, 0, NULL, dev_id);
+	irq_desc_t *desc =3D get_irq_desc(irq);
+	struct irqaction **p;
+	unsigned long flags;
+
+	spin_lock_irqsave(&desc->lock,flags);
+	p =3D &desc->action;
+	for (;;) {
+		struct irqaction * action =3D *p;
+		if (action) {
+			struct irqaction **pp =3D p;
+			p =3D &action->next;
+			if (action->dev_id !=3D dev_id)
+				continue;
+
+			/* Found it - now remove it from the list of entries */
+			*pp =3D action->next;
+			if (!desc->action) {
+				desc->status |=3D IRQ_DISABLED;
+				mask_irq(irq);
+			}
+			spin_unlock_irqrestore(&desc->lock,flags);
+
+			/* Wait to make sure it's not being used on another CPU */
+			synchronize_irq(irq);
+			kfree(action);
+			return;
+		}
+		printk("Trying to free free IRQ%d\n",irq);
+		spin_unlock_irqrestore(&desc->lock,flags);
+		break;
+	}
+	return;
 }
=20
 EXPORT_SYMBOL(free_irq);

--sXc4Kmr5FA7axrvy--

--7CZp05NP8/gJM8Cl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA8hqkby9O0+A2ZecRApcFAKDA/ZuOW5vV4INsauqh+qrX3jYu1ACfaiKs
Vr5xcNEuWye4cAcyu1gYR74=
=R5sA
-----END PGP SIGNATURE-----

--7CZp05NP8/gJM8Cl--
