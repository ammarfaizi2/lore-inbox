Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285703AbRLTAYI>; Wed, 19 Dec 2001 19:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285693AbRLTAX6>; Wed, 19 Dec 2001 19:23:58 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:3598 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S285692AbRLTAXt>;
	Wed, 19 Dec 2001 19:23:49 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15393.11001.446919.939724@argo.ozlabs.ibm.com>
Date: Thu, 20 Dec 2001 11:04:09 +1100 (EST)
To: linux-kernel@vger.kernel.org
Subject: 2.4.17-rc2 BUG at slab.c:1110
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing BUG messages when I eject a compact flash card from the
pcmcia slot on my powerbook, not every time but quite often.  The
stack trace looks like this:

c002e99c kmem_cache_grow+0x94
c002ed60 kmem_cache_alloc+0x144
c008844c devfsd_notify_de+0x60
c008852c devfsd_notify+0x30
c0088984 unregister+0x48
c0088a14 devfs_unregister+0x2c
c010c950 ide_unregister+0x200
cd9798b0 ide_release+0x2c
c001e928 timer_bh+0x2f4
c001a314 bh_action+0x3c
c001a1c4 tasklet_hi_action+0x3c
c0019dc0 do_softirq+0x94
c000610c timer_interrupt+0x23c

What is happening is that ide_event is doing

	mod_timer(&link->release, jiffies + HZ/20);

on the card removal event, with link->release.function == ide_release.
Thus ide_release gets called on a timeout, and it calls
ide_unregister, which calls devfs_unregister, which does various
things which you shouldn't do in interrupt context, like calling
schedule and calling kmem_cache_alloc(..., SLAB_KERNEL).

So, is this devfs's fault for not allowing devfs_unregister to be
called from interrupt context, or is it ide-cs's fault for calling
ide_unregister from interrupt context?

Paul.
