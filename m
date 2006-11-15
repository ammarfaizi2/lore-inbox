Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966539AbWKOL7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966539AbWKOL7q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 06:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966587AbWKOL7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 06:59:45 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:14216 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S966539AbWKOL7o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 06:59:44 -0500
To: balbir@in.ibm.com
Subject: Re: [RFC][PATCH 5/8] RSS controller task migration support
Cc: ckrm-tech@lists.sourceforge.net, dev@openvz.org, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, rohitseth@google.com
Message-Id: <20061115115937.B0A851B6A2@openx4.frec.bull.fr>
Date: Wed, 15 Nov 2006 12:59:37 +0100 (CET)
From: Patrick.Le-Dot@bull.net (Patrick.Le-Dot)
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 15/11/2006 13:06:37,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 15/11/2006 13:06:39,
	Serialize complete at 15/11/2006 13:06:39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balbir,

The get_task_mm()/mmput(mm) usage is not correct.
With CONFIG_DEBUG_SPINLOCK_SLEEP=y :

BUG: sleeping function called from invalid context at kernel/fork.c:390
in_atomic():1, irqs_disabled():0
 [<c0116620>] __might_sleep+0x97/0x9c
 [<c0116a2e>] mmput+0x15/0x8b
 [<c01582f6>] install_arg_page+0x72/0xa9
 [<c01584b1>] setup_arg_pages+0x184/0x1a5
 ...

BUG: sleeping function called from invalid context at kernel/fork.c:390
in_atomic():1, irqs_disabled():0
 [<c0116620>] __might_sleep+0x97/0x9c
 [<c0116a2e>] mmput+0x15/0x8b
 [<c01468ee>] do_no_page+0x255/0x2bd
 [<c0146b8d>] __handle_mm_fault+0xed/0x1ef
 [<c0111884>] do_page_fault+0x247/0x506
 [<c011163d>] do_page_fault+0x0/0x506
 [<c0348f99>] error_code+0x39/0x40


current->mm seems to be enough here.



In patch4, memctlr_dec_rss(page, mm) should be memctlr_dec_rss(page)
to compile correctly.

and in patch0 :
> 4. Disable cpuset's (to simply assignment of tasks to resource groups)
>         cd /container
>         echo 0 > cpuset_enabled

should be :
        echo 0 > cpuacct_enabled

Note : cpuacct_enabled is 0 by default.


Now the big question : to implement guarantee, the LRU needs to know
if a page can be removed from memory or not.
Any ideas to do that without any change in the struct page ?

Patrick

+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+    Patrick Le Dot
 mailto: P@trick.Le-Dot@bull.net         Centre UNIX de BULL SAS
 Phone : +33 4 76 29 73 20               1, Rue de Provence     BP 208
 Fax   : +33 4 76 29 76 00               38130 ECHIROLLES Cedex FRANCE
 Bull, Architect of an Open World TM
 www.bull.com
