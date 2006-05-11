Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965188AbWEKH0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965188AbWEKH0t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 03:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965189AbWEKH0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 03:26:48 -0400
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:45997 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP id S965188AbWEKH0s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 03:26:48 -0400
Subject: Re: Bug while executing : cat /proc/iomem on 2.6.17-rc1/rc2
From: Sharyathi Nagesh <sharyath@in.ibm.com>
Reply-To: sharyath@in.ibm.com
To: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Cc: Sachin Sant <sachinp@in.ibm.com>
In-Reply-To: <1145962096.3114.19.camel@laptopd505.fenrus.org>
References: <444DFD53.2000108@in.ibm.com>
	 <1145962096.3114.19.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: IBM
Date: Thu, 11 May 2006 12:57:48 +0530
Message-Id: <1147332468.17798.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was able to replicate the Bug, even when all the drivers are built into the kernel. 
It looks like while traversing through p->parent field of resource structure is leading to NULL pointer. 
Would it be appropriate to make the following code change. 
	But I found cat /proc/iomem hangs after line kernel data..

--- kernel/resource.c.old       2006-05-11 05:29:33.000000000 -0700
+++ kernel/resource.c   2006-05-11 05:29:58.000000000 -0700
@@ -81,7 +81,7 @@ static int r_show(struct seq_file *m, vo
        int depth;

        for (depth = 0, p = r; depth < MAX_IORES_LEVEL; depth++, p = p->parent){
-               if (p->parent == root)
+               if (p->parent == root || p->parent == NULL)
                        break;
        }
        seq_printf(m, "%*s%0*lx-%0*lx : %s\n",
Regards
Sharyathi Nagesh

On Tue, 2006-04-25 at 12:48 +0200, Arjan van de Ven wrote:
> On Tue, 2006-04-25 at 16:13 +0530, Sachin Sant wrote:
> > I found this following problem while executing cat/proc/iomem. The 
> > command causes following BUG.
> > 
> > x236:/linux-2.6.17-rc1/fs # cat /proc/iomem
> > Segmentation fault
> 
> 
> this tends to be a driver bug; could you compile all the drivers you
> need as module, and then try to not load them as much as possible. See
> if it still crashes, if not, load the rest one at a time until it
> crashes, and then you've found the culprit :)
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

