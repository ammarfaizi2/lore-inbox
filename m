Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbWHVNxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWHVNxf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 09:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWHVNxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 09:53:35 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:15373 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S932257AbWHVNxe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 09:53:34 -0400
Date: Tue, 22 Aug 2006 15:53:27 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
       Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Lockdep message on workqueue_mutex
Message-ID: <20060822135327.GB29577@osiris.boeblingen.de.ibm.com>
References: <20060822121042.GA29577@osiris.boeblingen.de.ibm.com> <1156250192.2976.47.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156250192.2976.47.camel@laptopd505.fenrus.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 02:36:32PM +0200, Arjan van de Ven wrote:
> On Tue, 2006-08-22 at 14:10 +0200, Heiko Carstens wrote:
> > git commit 9b41ea7289a589993d3daabc61f999b4147872c4 causes the lockdep
> > message below on cpu hotplug (git kernel of today).
> > 
> > We have:
> > 
> > cpu_down (takes cpu_add_remove_lock)
> > [CPU_DOWN_PREPARE]
> > blocking_notifier_call_chain (takes (cpu_chain).rwsem)
> > workqueue_cpu_callback (takes workqueue_mutex)
> > blocking_notifier_call_chain (releases (cpu_chain).rwsem)
> > [CPU_DEAD]
> > blocking_notifier_call_chain (takes (cpu_chain).rwsem)
> >                               ^^^^^^^^^^^^^^^^^^^^^^^
> > -> reverse locking order, since we still hold workqueue_mutex.
> > 
> > But since all of this is protected by the cpu_add_remove_lock this looks
> > legal. Well, at least it's safe as long as no other cpu callback function
> > does anything that will take the workqueue_mutex as well.
> 
> so you're saying this locking is entirely redundant ? ;-)

No, I'm just saying that I think that it currently cannot deadlock. But I
think the workqueue cpu hotplug code should be changed, so that it doesn't
return with the workqueue_mutex being held.
