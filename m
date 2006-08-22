Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWHVMgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWHVMgn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 08:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWHVMgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 08:36:43 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25250 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932196AbWHVMgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 08:36:43 -0400
Subject: Re: Lockdep message on workqueue_mutex
From: Arjan van de Ven <arjan@infradead.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
       Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20060822121042.GA29577@osiris.boeblingen.de.ibm.com>
References: <20060822121042.GA29577@osiris.boeblingen.de.ibm.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 22 Aug 2006 14:36:32 +0200
Message-Id: <1156250192.2976.47.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-22 at 14:10 +0200, Heiko Carstens wrote:
> git commit 9b41ea7289a589993d3daabc61f999b4147872c4 causes the lockdep
> message below on cpu hotplug (git kernel of today).
> 
> We have:
> 
> cpu_down (takes cpu_add_remove_lock)
> [CPU_DOWN_PREPARE]
> blocking_notifier_call_chain (takes (cpu_chain).rwsem)
> workqueue_cpu_callback (takes workqueue_mutex)
> blocking_notifier_call_chain (releases (cpu_chain).rwsem)
> [CPU_DEAD]
> blocking_notifier_call_chain (takes (cpu_chain).rwsem)
>                               ^^^^^^^^^^^^^^^^^^^^^^^
> -> reverse locking order, since we still hold workqueue_mutex.
> 
> But since all of this is protected by the cpu_add_remove_lock this looks
> legal. Well, at least it's safe as long as no other cpu callback function
> does anything that will take the workqueue_mutex as well.

so you're saying this locking is entirely redundant ? ;-)

