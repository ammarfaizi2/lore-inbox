Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261713AbULJGLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbULJGLr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 01:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbULJGLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 01:11:46 -0500
Received: from bgm-24-94-57-164.stny.rr.com ([24.94.57.164]:33668 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261713AbULJGLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 01:11:33 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-12
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>, emann@mrv.com,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <20041209221021.GF14194@elte.hu>
References: <20041207141123.GA12025@elte.hu>
	 <1102526018.25841.308.camel@localhost.localdomain>
	 <32950.192.168.1.5.1102529664.squirrel@192.168.1.5>
	 <1102532625.25841.327.camel@localhost.localdomain>
	 <32788.192.168.1.5.1102541960.squirrel@192.168.1.5>
	 <1102543904.25841.356.camel@localhost.localdomain>
	 <20041209093211.GC14516@elte.hu> <20041209131317.GA31573@elte.hu>
	 <1102602829.25841.393.camel@localhost.localdomain>
	 <1102619992.3882.9.camel@localhost.localdomain>
	 <20041209221021.GF14194@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Fri, 10 Dec 2004 01:11:29 -0500
Message-Id: <1102659089.3236.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-09 at 23:10 +0100, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > This looks like it was triggered by bounce_copy_vec calling
> > kmap_atomic which is now just kmap with irqs disabled.  Does this need
> > to change to __kmap_atomic?  Is this also used to make things more
> > preemptible, and start removing the local_irq_saves?  I'd like to know
> > so that you don't need to make the patches yourself and I can handle
> > things like this, but I need to know what the general ideas are. 
> > Also, am I the only one that has highmem support enabled, because this
> > looks like this bug would have been triggered by anyone.
> 
> the fix would be to find the place that disabled interrupts, and to
> check that it's safe to change it to local_irq_disable_nort() (or
> whatever other variant is used). Usually it's safe.

Hi Ingo,

Here's your fix. I haven't seen anything else cause the bug, and since
it uses local_irq_save, I guess the bounce_copy_vec can be called with
interrupts disabled. Since the kmap_atomic (or just kmap) checks for
that, I don't think I need more than what I've done.

Second, my ethernet doesn't work, and it really seems to be some kind of
interrupt trouble.  It sends out ARPs but doesn't see them come back,
and it also doesn't seem to know that it sent them out. I get the
following:

NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e601.
  diagnostics: net 0ccc media 8880 dma 0000003a fifo 0000
eth0: Interrupt posted but not delivered -- IRQ blocked by another
device?
  Flags; bus-master 1, dirty 33(1) current 33(1)
  Transmit list 00000000 vs. f75012a0.
  0: @f7501200  length 80000043 status 8c010043
  1: @f75012a0  length 8000007a status 0c01007a
  2: @f7501340  length 8000002a status 0001002a
  3: @f75013e0  length 80000098 status 0c010098
  4: @f7501480  length 8000002a status 0001002a
  5: @f7501520  length 8000002a status 0001002a
  6: @f75015c0  length 8000002a status 0001002a
  7: @f7501660  length 8000002a status 0001002a
  8: @f7501700  length 80000043 status 0c010043
  9: @f75017a0  length 80000043 status 0c010043
  10: @f7501840  length 8000004f status 0c01004f
  11: @f75018e0  length 8000004f status 0c01004f
  12: @f7501980  length 80000043 status 0c010043
  13: @f7501a20  length 8000007a status 0c01007a
  14: @f7501ac0  length 80000098 status 0c010098
  15: @f7501b60  length 8000002a status 8001002a 

I have a (from lspci) 
0000:02:08.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M
[Tornado] (rev 78)


I can look into this further to see what the problem is. One funny note,
on the vanilla kernel, my eth0 is at interrupt 177, but on the rt
patched kernel its swapped with the sound card and is at interrupt 169.
Well it's getting too late for me now (its 1am my time (01:00 for you
European folks ;-) , and I need to get up at 6:30 am). Tomorrow, I'll
hack on it some more.

Oh, and here's the highmem patch:

Index: mm/highmem.c
===================================================================
--- mm/highmem.c	(revision 16)
+++ mm/highmem.c	(working copy)
@@ -240,11 +240,11 @@
 	unsigned long flags;
 	unsigned char *vto;
 
-	local_irq_save(flags);
+	local_irq_save_nort(flags);
 	vto = kmap_atomic(to->bv_page, KM_BOUNCE_READ);
 	memcpy(vto + to->bv_offset, vfrom, to->bv_len);
 	kunmap_atomic(vto, KM_BOUNCE_READ);
-	local_irq_restore(flags);
+	local_irq_restore_nort(flags);
 }
 
 #else /* CONFIG_HIGHMEM */



-- Steve

