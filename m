Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261448AbSJYPZX>; Fri, 25 Oct 2002 11:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261449AbSJYPZX>; Fri, 25 Oct 2002 11:25:23 -0400
Received: from wilma1.suth.com ([207.127.128.4]:43276 "EHLO wilma1.suth.com")
	by vger.kernel.org with ESMTP id <S261448AbSJYPZW>;
	Fri, 25 Oct 2002 11:25:22 -0400
Subject: Re: Linux 2.5.44-ac3
From: Jason Williams <jason_williams@suth.com>
To: Alan Cox <alan@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200210251019.g9PAJ8V14406@devserv.devel.redhat.com>
References: <200210251019.g9PAJ8V14406@devserv.devel.redhat.com>
Content-Type: multipart/mixed; boundary="=-JybGCiHp8quJNTkX4Fha"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Oct 2002 11:34:59 -0400
Message-Id: <1035560104.12219.37.camel@cermanius.suth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JybGCiHp8quJNTkX4Fha
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2002-10-25 at 06:19, Alan Cox wrote:
> ** I strongly recommend saying N to IDE TCQ options otherwise this
>    should hopefully build and run happily.
> 

Ok, so I did some "head-banging-against-the-wall" digging into the IDE
code(my wall is dented now...) and I found where hwif->mate gets
populated.  Checking out this code and the code of the calling function,
I found that since the Primary interface is disabled, the first call to
the ide_hwif_configure is for the secondary channel. Being the first
call to the function the mate argument to the ide_hwif_configure
function is null.    Since the mate argument is null this makes the
secondary interface have no mate, and it needs one(don't we all). I
figured it might be alright to populate it's hwif->mate var with a copy
of itself.  I thought about this and if that var gets called elsewhere
in the code, worst it would do is attempt to double initialize something
on that interface, I think.  So it seems like a few lines right by the
assignment of hwif->mate might take care of this.  I basically check
mate for null, AND port for not zero.  If those 2 conditions are met, I
set hwif->mate to a copy of hwif itself and let it go.  It looks like
this runs ok on  my boxen. I am just wondering everyone's opinion on
this proposed fix.


Jason Williams
 

--=-JybGCiHp8quJNTkX4Fha
Content-Description: 
Content-Disposition: inline; filename=ide-sec-channel-fix.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; charset=ISO-8859-1

diff -u -r linux-2.5.44-ac3/drivers/ide/setup-pci.c linux-2.5.44-ac3-idefix=
/drivers/ide/setup-pci.c
--- linux-2.5.44-ac3/drivers/ide/setup-pci.c	2002-10-18 23:01:49.000000000 =
-0500
+++ linux-2.5.44-ac3-idefix/drivers/ide/setup-pci.c	2002-10-25 10:54:30.000=
000000 -0500
@@ -472,6 +472,16 @@
 		hwif->mate =3D mate;
 		mate->mate =3D hwif;
 	}
+        else if(port){
+               // if mate is NULL and port is 1
+               // then we have a secondary without a primary
+               // which can happen on some bioses
+               // to avoid a null exception later in the code
+               // we populate mate with itself.
+               // Worst case is it says the controller is already=20
+               // initialized later.
+               hwif->mate =3D hwif;
+        }
 	return hwif;
 }
=20

--=-JybGCiHp8quJNTkX4Fha--

