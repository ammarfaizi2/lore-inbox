Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965189AbWEKHcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965189AbWEKHcM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 03:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965193AbWEKHcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 03:32:12 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56329 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965189AbWEKHcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 03:32:12 -0400
Date: Thu, 11 May 2006 08:32:05 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Sharyathi Nagesh <sharyath@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Sachin Sant <sachinp@in.ibm.com>
Subject: Re: Bug while executing : cat /proc/iomem on 2.6.17-rc1/rc2
Message-ID: <20060511073205.GA28693@flint.arm.linux.org.uk>
Mail-Followup-To: Sharyathi Nagesh <sharyath@in.ibm.com>,
	linux-kernel@vger.kernel.org,
	Arjan van de Ven <arjan@infradead.org>,
	Sachin Sant <sachinp@in.ibm.com>
References: <444DFD53.2000108@in.ibm.com> <1145962096.3114.19.camel@laptopd505.fenrus.org> <1147332468.17798.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147332468.17798.13.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2006 at 12:57:48PM +0530, Sharyathi Nagesh wrote:
> I was able to replicate the Bug, even when all the drivers are built into the kernel. 
> It looks like while traversing through p->parent field of resource structure is leading to NULL pointer. 
> Would it be appropriate to make the following code change. 
> 	But I found cat /proc/iomem hangs after line kernel data..
> 
> --- kernel/resource.c.old       2006-05-11 05:29:33.000000000 -0700
> +++ kernel/resource.c   2006-05-11 05:29:58.000000000 -0700
> @@ -81,7 +81,7 @@ static int r_show(struct seq_file *m, vo
>         int depth;
> 
>         for (depth = 0, p = r; depth < MAX_IORES_LEVEL; depth++, p = p->parent){
> -               if (p->parent == root)
> +               if (p->parent == root || p->parent == NULL)
>                         break;
>         }
>         seq_printf(m, "%*s%0*lx-%0*lx : %s\n",

Only the root should have a NULL parent, so this is just covering up some
other problem - you have a resource which somehow has illegally ended up
with a NULL parent pointer while it's been registered.

Maybe try adding:

		if (p->parent == NULL) {
			printk("resource with null parent: %lx-%lx: %s\n",
				p->start, p->end, p->name);
			break;
		}

just before the test in that loop, and then finding out why that resource
is becoming invalid.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
