Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263508AbVBEBAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263508AbVBEBAY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 20:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263428AbVBEBAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 20:00:23 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:52961 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263508AbVBEAzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 19:55:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=LKrE0wT2sNKOu4+PVEeDSPNhD+H37P4Q9FqxnZvgp9o1phEX3GtxjOKL7LZMkxjtR1btCXIMuSmn3W9aj/ehrTXBBRWxp7WV/SDyAB1l/LpOgwjZwEOhuJGHPqJrhmSoM+w6cEDfmiXUsBvU+FOR2D8mGfNimAgqJHR89ETU9Rk=
Message-ID: <58cb370e05020416546e0d6b0e@mail.gmail.com>
Date: Sat, 5 Feb 2005 01:54:56 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.11-rc3-mm1
Cc: Sean Neakums <sneakums@zork.net>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1107562609.2363.134.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_212_3577328.1107564896831"
References: <20050204103350.241a907a.akpm@osdl.org>
	 <6ud5vgezqx.fsf@zork.zork.net> <1107561472.2363.125.camel@gaston>
	 <6u7jlng9b0.fsf@zork.zork.net> <1107562609.2363.134.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_212_3577328.1107564896831
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, 05 Feb 2005 11:16:49 +1100, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> 
> > I tried it two or three times, same result each time.  I'll give it a
> > lash with USB disabled.
> 
> Also, can you try editing arch/ppc/syslib/open_pic.c, in function
> openpic_resume(), comment out the call to openpic_reset() and let me
> know if that helps...

Well, maybe I'm to blame this time...

I've introduced bug in ATAPI Power Management handling,
idedisk_pm_idle shouldn't be done for ATAPI devices.

Sorry for that, fix attached.

------=_Part_212_3577328.1107564896831
Content-Type: text/x-patch; name="ide-io.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="ide-io.diff"

--- a/drivers/ide/ide-io.c=092005-02-04 03:27:35.000000000 +0100
+++ b/drivers/ide/ide-io.c=092005-02-05 01:44:33.000000000 +0100
@@ -230,6 +230,12 @@
=20
 =09memset(args, 0, sizeof(*args));
=20
+=09if (drive->media !=3D ide_disk) {
+=09=09/* skip idedisk_pm_idle for ATAPI devices */
+=09=09if (rq->pm->pm_step =3D=3D idedisk_pm_idle)
+=09=09=09rq->pm->pm_step =3D ide_pm_restore_dma;
+=09}
+
 =09switch (rq->pm->pm_step) {
 =09case ide_pm_flush_cache:=09/* Suspend step 1 (flush cache) */
 =09=09if (drive->media !=3D ide_disk)

------=_Part_212_3577328.1107564896831--
