Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbVCIL3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVCIL3N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 06:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVCIL3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 06:29:13 -0500
Received: from smtp3.adl2.internode.on.net ([203.16.214.203]:35591 "EHLO
	smtp3.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S261570AbVCIL2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 06:28:03 -0500
From: Srihari Vijayaraghavan <harisri@internode.on.net>
To: James <James.Roberts-Thomson@nbnz.co.nz>
Subject: Re: Bug: ll_rw_blk.c, elevator.c and displaying "default" IO Schedule 	r at boot-time (Cosmetic only)
Date: Wed, 9 Mar 2005 22:27:59 +1100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/2tLCMbmvQprqFW"
Message-Id: <200503092227.59420.harisri@internode.on.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_/2tLCMbmvQprqFW
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Roberts-Thomson, James wrote:
> I've been trying to investigate an IO performance issue on my machine, as
> part of this I've noticed what is (presumably only a cosmetic) issue with
> the messages displayed at kernel boot-time.

Agree, purely cosmetic.

> In the "good old days" (i.e. older 2.6.x kernel versions), one of the many
> messages displayed at kernel boot-time was "elevator: using XXX as default
> io scheduler", where XXX was one of the IO schedulers (cfq, anticipatory,
> deadline, etc) depending on kernel .config at compile time.
> 
> I noticed in 2.6.11, this message has vanished (although this may have
> happened in an earlier kernel), and I now get some messages "io scheduler
> XXX registered".  Unfortunately, the "default" scheduler is no longer
> tagged.
> 
> The Bug, however, is that code to tag the default clearly exists in
> elevator.c, thus:
> 
> In function "elv_register":
> 
>         printk(KERN_INFO "io scheduler %s registered", e->elevator_name);
>         if (!strcmp(e->elevator_name, chosen_elevator))
>                 printk(" (default)");
>         printk("\n");
> 
> Some investigation has shown that when this code is called at kernel boot
> time with no "elevator=xxx" kernel argument, chosen_elevator is undefined.
> The code that defines chosen_elevator (elevator_setup_default) is only
> called for the first time AFTER all the compiled in schedulers call
> "elv_register".
> 
> However, if "elevator=xxx" is passed as a kernel argument, the code in
> elv_register works.

Absolutely right. I am afraid, I introduced this bug (which is no worse than 
the bug I was trying to fix), while I was trying to get the elevator.c to 
print the default selection info correct, when a user uses "elevator=" boot 
parameter.

Please refer to the attachment, which contains an email, and a patch I sent to 
Jens the moment I realised the mistake (unfortunately I had no reply from 
Jens, perhaps he was/is very busy). I acknowledge that it is an ugly fix, for 
it seems silly to use an extra variable. I could not think of a better idea I 
am afraid.

I strongly believe that while elv_register() is the right place to print info 
about an elevator that is being registered, elevator_init() perhaps is the 
right place to print what is the chosen/default elevator. But the catch 22 is 
that elv_init() is called once for every block device, so I cannot see an 
easy solution to print just once.

I will try to think more about it, and if I could come up with a better idea, 
I shall inform you and LKML.

Thank you.
Hari

--Boundary-00=_/2tLCMbmvQprqFW
Content-Type: text/plain;
  charset="us-ascii";
  name="[PATCH] elevator: print default selection"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="[PATCH] elevator: print default selection"

=46rom harisri@internode.on.net Mon Jan 31 23:10:25 2005
=46rom: Srihari Vijayaraghavan <harisri@internode.on.net>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] elevator: print default selection
Date: Mon, 31 Jan 2005 23:10:25 +1100
User-Agent: KMail/1.7.1
References: <20050112080947.GA2736@suse.de>
In-Reply-To: <20050112080947.GA2736@suse.de>
X-KMail-Link-Message: 494
X-KMail-Link-Type: reply
MIME-Version: 1.0
Content-Disposition: inline
Status: RO
X-Status: RSC
X-KMail-EncryptionState: N
X-KMail-SignatureState: N
Content-Type: Multipart/Mixed;
  boundary=3D"Boundary-00=3D_xAi/BH2etUUo8ex"
Message-Id: <200501312310.25771.harisri@internode.on.net>
X-KMail-MDN-Sent: =20

=2D-Boundary-00=3D_xAi/BH2etUUo8ex
Content-Type: text/plain;
  charset=3D"iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

At a cost of one extra variable, this one works great for all cases:

Hopefully the extra steps in elevator_init() won't hinder the performance, =
as=20
elevator_init() seems to be the safest place to determine the default=20
elevator, as all elevators are registered, when it is called.

Sorry if it is no good.

Thank you.
Hari.

=2D-Boundary-00=3D_xAi/BH2etUUo8ex
Content-Type: text/x-diff;
  charset=3D"iso-8859-1";
  name=3D"elevator-default-selection"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=3D"elevator-default-selection"

=2D-- 2.6.11/drivers/block/elevator.c	2005-01-22 15:22:55.000000000 +1100
+++ test/drivers/block/elevator.c	2005-01-31 22:38:36.000000000 +1100
@@ -180,6 +180,8 @@
=20
 __setup("elevator=3D", elevator_setup);
=20
+static int default_msg =3D 0;
+
 int elevator_init(request_queue_t *q, char *name)
 {
 	struct elevator_type *e =3D NULL;
@@ -195,6 +197,12 @@
 	if (!e)
 		return -EINVAL;
=20
+	if (!default_msg && !strcmp(e->elevator_name, chosen_elevator)) {
+		printk(KERN_INFO "using %s as default io scheduler\n",
+						chosen_elevator);
+		default_msg =3D 1;
+	}
+
 	eq =3D kmalloc(sizeof(struct elevator_queue), GFP_KERNEL);
 	if (!eq) {
 		elevator_put(e->elevator_type);
@@ -513,10 +521,7 @@
 	list_add_tail(&e->list, &elv_list);
 	spin_unlock_irq(&elv_list_lock);
=20
=2D	printk(KERN_INFO "io scheduler %s registered", e->elevator_name);
=2D	if (!strcmp(e->elevator_name, chosen_elevator))
=2D		printk(" (default)");
=2D	printk("\n");
+	printk(KERN_INFO "io scheduler %s registered\n", e->elevator_name);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(elv_register);

=2D-Boundary-00=3D_xAi/BH2etUUo8ex--


--Boundary-00=_/2tLCMbmvQprqFW--
