Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262640AbSJNJTp>; Mon, 14 Oct 2002 05:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261970AbSJNJTp>; Mon, 14 Oct 2002 05:19:45 -0400
Received: from node-d-1ef6.a2000.nl ([62.195.30.246]:25582 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S262640AbSJNJTn>; Mon, 14 Oct 2002 05:19:43 -0400
Subject: Re: [PATCH] IPMI driver for Linux, version 6
From: Arjan van de Ven <arjanv@redhat.com>
To: Corey Minyard <cminyard@mvista.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3DAA1899.1030909@mvista.com>
References: <3DAA1899.1030909@mvista.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-pBScMKAsHRA1uR57ieIn"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Oct 2002 11:25:24 +0200
Message-Id: <1034587536.3038.15.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pBScMKAsHRA1uR57ieIn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2002-10-14 at 03:06, Corey Minyard wrote:
> Yet one more update, mostly fixes for stylistic things that Randy Dunlap=20
> pointed out, and a bug fix that lets the KCS state machine get out of=20
> the "hosed" state on the next message (buggy hardware can sometimes be=20
> useful :-).  As usual, on my home page at  http://home.attbi.com/~minyard=
.
>=20
> -Corey
+static int ipmi_open(struct inode *inode, struct file *file)
..
+	priv =3D kmalloc(sizeof(*priv), GFP_KERNEL);
..
+	MOD_INC_USE_COUNT;

hmm. Ok so you either need the MOD_INC_USE_COUNT or you don't, but if
you do it should go before the sleeping kmalloc ;)

+static int ipmi_ioctl(struct inode  *inode,
...
+		if (copy_from_user(&req, (void *) data, sizeof(req))) {
+			rv =3D -EFAULT;
+			break;
+		}
+
+		if (req.addr_len > sizeof(struct ipmi_addr))
+		{
+			rv =3D -EINVAL;
+			break;
+		}
+
+		if (copy_from_user(&addr, req.addr, req.addr_len)) {

since addr_len is a signed value, a user that passes -1 will get a
LOOOONG copy_from_user scribbling all over kernel memory...same for
data_len a few lines onwards

+static void sender(void                *send_info,
..
+	if (kcs_info->run_to_completion) {
+		/* If we are running to completion, then throw it in
+		   the list and run transactions until everything is
+		   clear.  Priority doesn't matter here. */
+		list_add_tail(&(msg->link), &(kcs_info->xmit_msgs));
+		result =3D kcs_event_handler(kcs_info, 0);
+		while (result !=3D KCS_SM_IDLE) {
+			udelay(500);
+			result =3D kcs_event_handler(kcs_info, 500);
+		}

is that unconditional udelay with interrupts off really needed?=20

+/* The locking for these for a write lock is done by two locks, first
+   the "outside" lock then the normal lock.  This way, the interfaces
+   lock can be converted to a read lock without allowing a new write
+   locker to come in.  Note that at interrupt level, this can only be
+   claimed read, so there is no reason for read lock to save
+   interrupts.  Write locks must still save interrupts because they
+   can block an interrupt. */

I get the feeling this locking is fishy. A double r/w lock smells bad.
really. Either you always take both the same way (eg both for read or
both for write) and then the inner lock could be a normal spinlock; or
you will deadlock in new and surprising ways....
=20
+	spin_lock_irqsave(&interfaces_outside_lock, flags);
+	write_lock(&interfaces_lock);
+	for (i=3D0; i<MAX_IPMI_INTERFACES; i++) {
+		if (ipmi_interfaces[i] =3D=3D NULL) {
+			new_intf =3D kmalloc(sizeof(*new_intf), GFP_KERNEL);

ehm ehm didn't just take TWO spinlocks 3 lines above this sleeping
function ?



--=-pBScMKAsHRA1uR57ieIn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9qo2ExULwo51rQBIRAqpvAKCc5vK7E3N84EwEpRUwSZRSXX1H7wCgikEr
QYI3I+8U7S0PoEc1VRP+i4c=
=AT+H
-----END PGP SIGNATURE-----

--=-pBScMKAsHRA1uR57ieIn--

