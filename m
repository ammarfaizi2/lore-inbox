Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316591AbSFUNKY>; Fri, 21 Jun 2002 09:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316592AbSFUNKX>; Fri, 21 Jun 2002 09:10:23 -0400
Received: from host194.steeleye.com ([216.33.1.194]:56581 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S316591AbSFUNKX>; Fri, 21 Jun 2002 09:10:23 -0400
Message-Id: <200206211310.g5LDALT02295@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Pete Zaitcev <zaitcev@redhat.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Optimisation for smp_num_cpus loop in hotplug 
In-Reply-To: Message from Pete Zaitcev <zaitcev@redhat.com> 
   of "Fri, 21 Jun 2002 00:16:18 EDT." <200206210416.g5L4GIx16142@devserv.devel.redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 21 Jun 2002 09:10:21 -0400
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zaitcev@redhat.com said:
> This is neat, but I'd like to see it work with O(1) as well. Mingo's
> code uses some long bitmaps. 

Well, it's strictly only for the cpu bitmap (and it's designed to be different 
depending on the arch so you can use arch specific CPU enumeration knowlege).  
The O(1) optimisation for this is easy:

#ifdef CONFIG_SMP
#define for_each_cpu(cpu, mask) \
        for(mask = cpu_online_map; \
            cpu = __ffs(mask), mask != 0; \
            mask &= ~(1<<cpu))
#else
#define for_each_cpu(cpu, mask) cpu = 1; 
#endif

because you don't really want to run an SMP kernel on a machine which has only 
one cpu.  Or did you mean you'd like to see it work with the O(1) scheduler, 
some kind of generic for_each_set_bit?

James


