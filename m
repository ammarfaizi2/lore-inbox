Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264093AbUCZRml (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 12:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264090AbUCZRml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 12:42:41 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:54217 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264093AbUCZRmi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 12:42:38 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Manfred Spraul <manfred@colorfullife.com>
Subject: Re: 2.6.5-rc2-mm2 ipc hang fix (final version)
Date: Fri, 26 Mar 2004 09:36:02 -0800
User-Agent: KMail/1.4.1
Cc: andrew <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
References: <40638D1F.C296F528@us.ibm.com> <4063C65E.3030608@colorfullife.com>
In-Reply-To: <4063C65E.3030608@colorfullife.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_2827JQGPAVLXOBCYTWJ3"
Message-Id: <200403260936.02681.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_2827JQGPAVLXOBCYTWJ3
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

Here is the final version. I missed a compile warning before.
out_unlock label is no longer needed.

Thanks,
Badari


--------------Boundary-00=_2827JQGPAVLXOBCYTWJ3
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="undo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="undo.patch"

--- linux/ipc/sem.c	2004-03-26 05:19:22.833959160 -0800
+++ linux.new/ipc/sem.c	2004-03-26 21:18:28.424699632 -0800
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
 
@@ -1004,7 +1006,6 @@ static struct sem_undo *find_undo(int se
 	sma->undo = new;
 	sem_unlock(sma);
 	un = new;
-out_unlock:
 	unlock_semundo();
 out:
 	return un;

--------------Boundary-00=_2827JQGPAVLXOBCYTWJ3--

