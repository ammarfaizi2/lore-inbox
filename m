Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270073AbTGSNLE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 09:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270063AbTGSNLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 09:11:04 -0400
Received: from mail-01.iinet.net.au ([203.59.3.33]:49682 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S270371AbTGSNK5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 09:10:57 -0400
Subject: Re: [BUG REPORT 2.6.0] cisco airo_cs scheduling while atomic
From: Sven Dowideit <svenud@ozemail.com.au>
Reply-To: svenud@ozemail.com.au
To: Andrew Morton <akpm@osdl.org>
Cc: breed@users.sourceforge.net, linux-kernel@vger.kernel.org,
       Tom Sightler <ttsig@tuxyturvy.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RxS/nYlZH5Zh9Z40p4rK"
Message-Id: <1058619536.752.19.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 19 Jul 2003 22:58:57 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RxS/nYlZH5Zh9Z40p4rK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

hey there,
	I have a longer version of this patch from Tom that i applied to
2.6-test1, that fixes the bad scheduling problem..

I have appended his patch - will this qualify for a sucessful test?

cheers

sven

--------

Message: 19
Date: Fri, 18 Jul 2003 14:04:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Bourne <jbourne@hardrock.org>
Cc: breed@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BUG REPORT 2.6.0] cisco airo_cs scheduling while atomic

James Bourne <jbourne@hardrock.org> wrote:
>
> The Cisco Airo card driver calls schedule while atomic in the function
> issuecommand in drivers/net/wireless/airo.c line 2388.
>=20
>=20
> Jul 17 15:27:10 localhost kernel: bad: scheduling while atomic!
> Jul 17 15:27:10 localhost kernel: Call Trace:
> Jul 17 15:27:10 localhost kernel:  [<c0119754>] schedule+0x3c4/0x3d0
> Jul 17 15:27:10 localhost kernel:  [<d18cbb51>] sendcommand+0xa1/0xe0
[airo]
> Jul 17 15:27:10 localhost kernel:  [<d18cba80>] issuecommand+0x60/0x90
[airo]
> Jul 17 15:27:10 localhost kernel:  [<d18cc001>]
PC4500_accessrid+0x41/0x80 [airo]
> Jul 17 15:27:10 localhost kernel:  [<d18cc0a3>]
PC4500_readrid+0x63/0x130 [airo]
> Jul 17 15:27:10 localhost kernel:  [<d18c95d9>] readStatsRid+0x29/0x50
[airo]
> Jul 17 15:27:10 localhost kernel:  [<d18c9c0a>]
airo_get_stats+0x2a/0xe0 [airo]

I've been waiting months for someone to test this patch.  Can you please
do
so?


diff -puN drivers/net/wireless/airo.c~airo-schedule-fix
drivers/net/wireless/airo.c
--- 25/drivers/net/wireless/airo.c~airo-schedule-fix    2003-06-26
17:37:47.000000000 -0700
+++ 25-akpm/drivers/net/wireless/airo.c 2003-06-26 17:37:47.000000000
-0700
@@ -44,6 +44,7 @@
 #include <linux/ioport.h>
 #include <linux/config.h>
 #include <linux/pci.h>
+#include <linux/delay.h>
 #include <asm/uaccess.h>
=20
 #ifdef CONFIG_PCI
@@ -2379,20 +2380,26 @@ static u16 setup_card(struct airo_info *
 static u16 issuecommand(struct airo_info *ai, Cmd *pCmd, Resp *pRsp) {
         // Im really paranoid about letting it run forever!
        int max_tries =3D 600000;
+       static int max =3D 0;
+       int count =3D 0;
=20
        if (sendcommand(ai, pCmd) =3D=3D (u16)ERROR)
                return ERROR;
=20
        while (max_tries-- && (IN4500(ai, EVSTAT) & EV_CMD) =3D=3D 0) {
-               if (!in_interrupt() && (max_tries & 255) =3D=3D 0)
-                       schedule();
+               udelay(1);
+               count++;
        }
-       if ( max_tries =3D=3D -1 ) {
+       if (max_tries =3D=3D -1) {
                printk( KERN_ERR
                        "airo: Max tries exceeded waiting for command\n"
);
                 return ERROR;
        }
        completecommand(ai, pRsp);
+       if (count > max) {
+               max =3D count;
+               printk("%s: max delay =3D %d usec\n", __FUNCTION__, max);
+       }
        return SUCCESS;
 }
=20

_

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

-----------------------------------------------------------------


Tom's patch:

--- airo.c      2003-05-31 09:26:12.000000000 -0400
+++ airo.c.tom  2003-06-19 15:37:07.100811000 -0400
@@ -44,6 +44,7 @@
 #include <linux/ioport.h>
 #include <linux/config.h>
 #include <linux/pci.h>
+#include <linux/delay.h>
 #include <asm/uaccess.h>
=20
 #ifdef CONFIG_PCI
@@ -1762,6 +1763,8 @@
        int i;
        struct airo_info *ai =3D dev->priv;
=20
+       if (down_interruptible(&ai->sem))
+               return -1;
        waitbusy (ai);
        OUT4500(ai,COMMAND,CMD_SOFTRESET);
        set_current_state (TASK_UNINTERRUPTIBLE);
@@ -1771,6 +1774,7 @@
        schedule_timeout (HZ/5);
        if ( setup_card(ai, dev->dev_addr ) !=3D SUCCESS ) {
                printk( KERN_ERR "airo: MAC could not be enabled\n" );
+               up(&ai->sem);
                return -1;
        } else {
                printk( KERN_INFO "airo: MAC enabled %s
%x:%x:%x:%x:%x:%x\n",
@@ -1788,6 +1792,7 @@
        }
        enable_interrupts( ai );
        netif_wake_queue(dev);
+       up(&ai->sem);
        return 0;
 }
=20
@@ -1866,6 +1871,7 @@
=20
                if ( status & EV_MIC ) {
                        OUT4500( apriv, EVACK, EV_MIC );
+                       if (apriv->flags & FLAG_MIC_CAPABLE)
                        airo_read_mic( apriv );
                }
                if ( status & EV_LINK ) {
@@ -2379,20 +2385,26 @@
 static u16 issuecommand(struct airo_info *ai, Cmd *pCmd, Resp *pRsp) {
         // Im really paranoid about letting it run forever!
        int max_tries =3D 600000;
+       static int max =3D 0;
+       int count =3D 0;
=20
        if (sendcommand(ai, pCmd) =3D=3D (u16)ERROR)
                return ERROR;
=20
        while (max_tries-- && (IN4500(ai, EVSTAT) & EV_CMD) =3D=3D 0) {
-               if (!in_interrupt() && (max_tries & 255) =3D=3D 0)
-                       schedule();
+               udelay(1);
+               count++;
        }
-       if ( max_tries =3D=3D -1 ) {
+       if (max_tries =3D=3D -1) {
                printk( KERN_ERR
                        "airo: Max tries exceeded waiting for command\n"
);
                 return ERROR;
        }
        completecommand(ai, pRsp);
+       if (count > max) {
+               max =3D count;
+               printk("%s: max delay =3D %d usec\n", __FUNCTION__, max);
+       }
        return SUCCESS;
 }
=20
@@ -2653,11 +2665,11 @@
        if (down_interruptible(&ai->sem))
                return ERROR;
        if (issuecommand(ai, &cmd, &rsp) !=3D SUCCESS) {
-               txFid =3D 0;
+               txFid =3D ERROR;
                goto done;
        }
        if ( (rsp.status & 0xFF00) !=3D 0) {
-               txFid =3D 0;
+               txFid =3D ERROR;
                goto done;
        }
        /* wait for the allocate event/indication
@@ -2704,7 +2716,7 @@
=20
        len >>=3D 16;
=20
-       if (len < ETH_ALEN * 2) {
+       if (len <=3D ETH_ALEN * 2) {
                printk( KERN_WARNING "Short packet %d\n", len );
                return ERROR;
        }
@@ -4838,7 +4850,7 @@
        readCapabilityRid(local, &cap_rid);
=20
        dwrq->length =3D sizeof(struct iw_range);
-       memset(range, 0, sizeof(*range));
+       memset(range, 0, sizeof(range));
        range->min_nwid =3D 0x0000;
        range->max_nwid =3D 0x0000;
        range->num_channels =3D 14;



--=-RxS/nYlZH5Zh9Z40p4rK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/GUCQPAwzu0QrW+kRAvurAKCbcObQvoYq+5uCAtOCBv0TIhLatACgi5AJ
KsR9P+nghJi9fZLGwPJpimU=
=91so
-----END PGP SIGNATURE-----

--=-RxS/nYlZH5Zh9Z40p4rK--

