Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbUCZB5Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 20:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263833AbUCZB5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 20:57:16 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:15588 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263823AbUCZB5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 20:57:12 -0500
Message-ID: <40638D1F.C296F528@us.ibm.com>
Date: Thu, 25 Mar 2004 17:53:35 -0800
From: badari <pbadari@us.ibm.com>
Organization: IBM
X-Mailer: Mozilla 4.72 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: andrew <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       manfred@colorfullife.com
Subject: 2.6.5-rc2-mm2 ipc hang fix
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I ran into ipc hang while trying to shutdown database. Problem seems
to be due to missing sem_unlock() in find_undo(). Here is the patch
to fix the problem.

Please apply.

Thanks,
Badari

--- linux/ipc/sem.c     2004-03-26 05:19:22.833959160 -0800
+++ linux.new/ipc/sem.c 2004-03-26 05:19:57.047757872 -0800
@@ -972,8 +972,10 @@ static struct sem_undo *find_undo(int se
        if(sma==NULL)
                goto out;
        un = ERR_PTR(-EIDRM);
-       if (sem_checkid(sma,semid))
+       if (sem_checkid(sma,semid)) {
+               sem_unlock(sma);
                goto out_unlock;
+       }
        nsems = sma->sem_nsems;
        sem_unlock(sma);



