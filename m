Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263945AbUCZF6U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 00:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263619AbUCZF6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 00:58:20 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:53190 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263945AbUCZF6S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 00:58:18 -0500
Message-ID: <4063C65E.3030608@colorfullife.com>
Date: Fri, 26 Mar 2004 06:57:50 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: badari <pbadari@us.ibm.com>
CC: andrew <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.5-rc2-mm2 ipc hang fix
References: <40638D1F.C296F528@us.ibm.com>
In-Reply-To: <40638D1F.C296F528@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

badari wrote:

>--- linux/ipc/sem.c     2004-03-26 05:19:22.833959160 -0800
>+++ linux.new/ipc/sem.c 2004-03-26 05:19:57.047757872 -0800
>@@ -972,8 +972,10 @@ static struct sem_undo *find_undo(int se
>        if(sma==NULL)
>                goto out;
>        un = ERR_PTR(-EIDRM);
>-       if (sem_checkid(sma,semid))
>+       if (sem_checkid(sma,semid)) {
>+               sem_unlock(sma);
>                goto out_unlock;
>+       }
>        nsems = sma->sem_nsems;
>        sem_unlock(sma);
>  
>
[snip]

> out_unlock:
>         unlock_semundo();
> out:
>         return un;
> }

Thanks for finding the bug - out_unlock unlocks the wrong spinlock, 
that's why I didn't notice it while searching for the bug.
But I think your fix is wrong: the "goto out_unlock" must be replaced 
with "goto out": the semundo spinlock is not held.

--
    Manfred

