Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263500AbUCZRX3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 12:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263608AbUCZRX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 12:23:29 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:41968 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263500AbUCZRXZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 12:23:25 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Manfred Spraul <manfred@colorfullife.com>
Subject: Re: 2.6.5-rc2-mm2 ipc hang fix
Date: Fri, 26 Mar 2004 09:16:44 -0800
User-Agent: KMail/1.4.1
Cc: andrew <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
References: <40638D1F.C296F528@us.ibm.com> <4063C65E.3030608@colorfullife.com>
In-Reply-To: <4063C65E.3030608@colorfullife.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_WB17K2Y3ESS10V26LVKH"
Message-Id: <200403260916.44464.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_WB17K2Y3ESS10V26LVKH
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday 25 March 2004 09:57 pm, Manfred Spraul wrote:
> badari wrote:
> >--- linux/ipc/sem.c     2004-03-26 05:19:22.833959160 -0800
> >+++ linux.new/ipc/sem.c 2004-03-26 05:19:57.047757872 -0800
> >@@ -972,8 +972,10 @@ static struct sem_undo *find_undo(int se
> >        if(sma=3D=3DNULL)
> >                goto out;
> >        un =3D ERR_PTR(-EIDRM);
> >-       if (sem_checkid(sma,semid))
> >+       if (sem_checkid(sma,semid)) {
> >+               sem_unlock(sma);
> >                goto out_unlock;
> >+       }
> >        nsems =3D sma->sem_nsems;
> >        sem_unlock(sma);
>
> [snip]
>
> > out_unlock:
> >         unlock_semundo();
> > out:
> >         return un;
> > }
>
> Thanks for finding the bug - out_unlock unlocks the wrong spinlock,
> that's why I didn't notice it while searching for the bug.
> But I think your fix is wrong: the "goto out_unlock" must be replaced
> with "goto out": the semundo spinlock is not held.

Yes. You are correct. semundo lock is not held.=20
Here is the updated patch.

Thanks,
Badari
--------------Boundary-00=_WB17K2Y3ESS10V26LVKH
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="undo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="undo.patch"

--- linux/ipc/sem.c	2004-03-26 05:19:22.833959160 -0800
+++ linux.new/ipc/sem.c	2004-03-26 20:59:46.496258680 -0800
@@ -972,8 +972,10 @@ static struct sem_undo *find_undo(int se
 	if(sma==NULL)
 		goto out;
 	un = ERR_PTR(-EIDRM);
-	if (sem_checkid(sma,semid))
-		goto out_unlock;
+	if (sem_checkid(sma,semid)) {
+		sem_unlock(sma);
+		goto out;
+	}
 	nsems = sma->sem_nsems;
 	sem_unlock(sma);
 

--------------Boundary-00=_WB17K2Y3ESS10V26LVKH--

