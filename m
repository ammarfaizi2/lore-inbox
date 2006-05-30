Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbWE3XEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWE3XEz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 19:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbWE3XEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 19:04:55 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:60357 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964804AbWE3XEy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 19:04:54 -0400
Date: Wed, 31 May 2006 01:05:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-rc5-mm1
Message-ID: <20060530230512.GA6042@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org> <6bffcb0e0605301155h3b472d79h65e8403e7fa0b214@mail.gmail.com> <6bffcb0e0605301157o6b7c5f66q3c9f151cbb4537d5@mail.gmail.com> <20060530194259.GB22742@elte.hu> <6bffcb0e0605301457v9ba284bk75b8b6d14384489a@mail.gmail.com> <20060530220931.GA32759@elte.hu> <6bffcb0e0605301559y603a60bl685b7aca60069dfd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0605301559y603a60bl685b7aca60069dfd@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:

> I'll try to reproduce that bug now... but here is new one :)
> 
> BUG: key f7155db0 not in .data!
> (        modprobe-485  |#0): new 15286092 us user-latency.
> stopped custom tracer.
> BUG: warning at /usr/src/linux-mm/kernel/lockdep.c:1985/lockdep_init_map()

Arjan's sound patch is wrong: the key must not be in a dynamic variable!

Could you try the patch below? This uses the ID string as the key. (the 
ID string seems to be based on static kernel strings most of the time, 
so this might as well work)

	Ingo

Index: linux/sound/core/seq/seq_device.c
===================================================================
--- linux.orig/sound/core/seq/seq_device.c
+++ linux/sound/core/seq/seq_device.c
@@ -382,7 +382,7 @@ static struct ops_list * create_driver(c
 
 	/* set up driver entry */
 	strlcpy(ops->id, id, sizeof(ops->id));
-	mutex_init_key(&ops->reg_mutex, id, &ops->reg_mutex_key);
+	mutex_init_key(&ops->reg_mutex, id, (struct lockdep_type_key)id);
 	ops->driver = DRIVER_EMPTY;
 	INIT_LIST_HEAD(&ops->dev_list);
 	/* lock this instance */
