Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbULEOzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbULEOzS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 09:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbULEOzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 09:55:18 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:56192
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261307AbULEOzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 09:55:10 -0500
Subject: Re: [PATCH] oom killer (Core)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, andrea@suse.de,
       marcelo.tosatti@cyclades.com, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041205025236.GN2714@holomorphy.com>
References: <20041201104820.1.patchmail@tglx>
	 <20041205025236.GN2714@holomorphy.com>
Content-Type: text/plain
Date: Sun, 05 Dec 2004 14:38:22 +0100
Message-Id: <1102253902.13353.344.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-12-04 at 18:52 -0800, William Lee Irwin III wrote:
> On Wed, Dec 01, 2004 at 10:49:03AM +0100, tglx@linutronix.de wrote:
> > The oom killer has currently some strange effects when triggered.
> > It gets invoked multiple times and the selection of the task to kill
> > does not take processes into account which fork a lot of child processes.
> > The patch solves this by
> > - Preventing reentrancy
> > - Checking for memory threshold before selection and kill.
> > - Taking child processes into account when selecting the process to kill
> 
> Hmm, this thread seems to be serious. 

:)

> I'll audit the policy adjustments
> for issues with the mechanisms (e.g. killing kernel threads, races with
> timeouts).

Andrea provided a quite good fix for the invokation problem. I'm just
tracking down a different problem which was revieled by his changes.

The selection mechanism is currently taking a couple of things into
account:

 - VM size
 - nice value
 - CPU time
 - owner == root ?
 - CAP_SYS_RAWIO

I found out, that it is neccecary to take the child processes into
account to detect processes which fork a lot of childs.

The current mechanism rather kills sshd or portmap as they happen to
have a bigger VM size than the process which forked a lot of childs.

So I added a check for the child processes with an own VM. This solved
the problem quite well. Of course it does not count the childs of PID <
2.

tglx




