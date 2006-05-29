Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWE2TGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWE2TGy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 15:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWE2TGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 15:06:54 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:36547 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751209AbWE2TGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 15:06:53 -0400
Date: Mon, 29 May 2006 21:07:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: perex@suse.cz, alsa-devel@alsa-project.org, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-rc4-mm3-lockdep BUG: possible deadlock detected!
Message-ID: <20060529190707.GB24445@elte.hu>
References: <6bffcb0e0605291132u701cd69tb855cf60fa317994@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0605291132u701cd69tb855cf60fa317994@mail.gmail.com>
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

> I get this with Ingo's lockdep patch from
> http://people.redhat.com/mingo/generic-irq-subsystem/

sigh, that patchset is not released yet ... it showed up in the genirq 
directory accidentally. (will release it later today)

> ====================================
> [ BUG: possible deadlock detected! ]
> ------------------------------------

at first sight this looks like a rare case of nested locking not yet 
covered by the lock validator. Could you try the patch below, to 
correctly express this locking construct to the lock validator?

Btw., beyond this false positive, i dont see how the lock ordering 
between ports is guaranteed - maybe there's some implicit rule that 
enforces it. And the whole grp->list_lock and grp->list_mutex lock use 
seems quite fragile - using list_lock in atomic contexts and list_mutex 
in schedulable contexts?

	Ingo

Index: linux/sound/core/seq/seq_ports.c
===================================================================
--- linux.orig/sound/core/seq/seq_ports.c
+++ linux/sound/core/seq/seq_ports.c
@@ -518,7 +518,7 @@ int snd_seq_port_connect(struct snd_seq_
 	atomic_set(&subs->ref_count, 2);
 
 	down_write(&src->list_mutex);
-	down_write(&dest->list_mutex);
+	down_write_nested(&dest->list_mutex, SINGLE_DEPTH_NESTING);
 
 	exclusive = info->flags & SNDRV_SEQ_PORT_SUBS_EXCLUSIVE ? 1 : 0;
 	err = -EBUSY;
@@ -591,7 +591,7 @@ int snd_seq_port_disconnect(struct snd_s
 	unsigned long flags;
 
 	down_write(&src->list_mutex);
-	down_write(&dest->list_mutex);
+	down_write_nested(&dest->list_mutex, SINGLE_DEPTH_NESTING);
 
 	/* look for the connection */
 	list_for_each(p, &src->list_head) {
