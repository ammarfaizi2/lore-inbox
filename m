Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262774AbVA1TYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbVA1TYd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 14:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262736AbVA1TU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 14:20:57 -0500
Received: from pat.uio.no ([129.240.130.16]:19141 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262776AbVA1TTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 14:19:34 -0500
Subject: Re: Real-time rw-locks (Re: [patch] Real-Time Preemption,
	-RT-2.6.10-rc2-mm3-V0.7.32-15)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ingo Molnar <mingo@elte.hu>
Cc: Esben Nielsen <simlo@phys.au.dk>, Rui Nuno Capela <rncbc@rncbc.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       mark_h_johnson@raytheon.com, Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       linux-kernel@vger.kernel.org, Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>, Shane Shrybman <shrybman@aei.ca>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
In-Reply-To: <20050128073856.GA2186@elte.hu>
References: <20041214113519.GA21790@elte.hu>
	 <Pine.OSF.4.05.10412271404440.25730-100000@da410.ifa.au.dk>
	 <20050128073856.GA2186@elte.hu>
Content-Type: text/plain
Date: Fri, 28 Jan 2005 11:18:30 -0800
Message-Id: <1106939910.14321.37.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12,
	autolearn=disabled)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fr den 28.01.2005 Klokka 08:38 (+0100) skreiv Ingo Molnar:

> no, it's not a big scalability problem. rwlocks are really a mistake -
> if you want scalability and spinlocks/semaphores are not enough then one
> should either use per-CPU locks or lockless structures. rwlocks/rwsems
> will very unlikely help much.

If you do have a highest interrupt case that causes all activity to
block, then rwsems may indeed fit the bill.

In the NFS client code we may use rwsems in order to protect stateful
operations against the (very infrequently used) server reboot recovery
code. The point is that when the server reboots, the server forces us to
block *all* requests that involve adding new state (e.g. opening an
NFSv4 file, or setting up a lock) while our client and others are
re-establishing their existing state on the server.

IOW: If you are planning on converting rwsems into a semaphore, you will
screw us over most royally, by converting the currently highly
infrequent scenario of a single task being able to access the server
into the common case.

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

