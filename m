Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbVF1ODV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbVF1ODV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 10:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbVF1ODV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 10:03:21 -0400
Received: from graphe.net ([209.204.138.32]:19406 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261772AbVF1OBv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 10:01:51 -0400
Date: Tue, 28 Jun 2005 07:01:34 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Kirill Korotaev <dev@sw.ru>
cc: Pavel Machek <pavel@ucw.cz>, Linus Torvalds <torvalds@osdl.org>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, raybry@engr.sgi.com,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [RFC] Fix SMP brokenness for PF_FREEZE and make freezing usable
 for other purposes
In-Reply-To: <42C0FCB3.4030205@sw.ru>
Message-ID: <Pine.LNX.4.62.0506280649270.6114@graphe.net>
References: <Pine.LNX.4.62.0506241316370.30503@graphe.net>
 <20050625025122.GC22393@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.62.0506242311220.7971@graphe.net>
 <20050626023053.GA2871@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.62.0506251954470.26198@graphe.net>
 <20050626030925.GA4156@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.62.0506261928010.1679@graphe.net>
 <Pine.LNX.4.58.0506262121070.19755@ppc970.osdl.org>
 <Pine.LNX.4.62.0506262249080.4374@graphe.net> <20050627141320.GA4945@atrey.karlin.mff.cuni.cz>
 <Pine.LNX.4.62.0506270804450.17400@graphe.net> <42C0EBAB.8070709@sw.ru>
 <Pine.LNX.4.62.0506272323490.30956@graphe.net> <42C0FCB3.4030205@sw.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2005, Kirill Korotaev wrote:

> > > <<<< is it intentionaly? or you just lost CONFIG_MIGRATE?
> > It is intentional. freeze_processes and thaw_processes are only needed for
> > suspend. One only needs to freeze a couple of processes for process
> > migration.
> But PM and your migrate code can be not the only users of it.

freeze_processes and thaw_processes is not needed by the migrate 
code.

> > Hmm... If we wait to clear both flags until after the completion
> > notification then we do not have the race right? But then we need to move
> > the signal recalc since it tests for TIF_FREEZE too.
> It is almost ok, but it is still not fine :)
> 
> look what happens if you call freeze/unfreeze in a loop:
> 
> refrigerator:
> awakes
> 
> freezer:
> check PF_FROZEN, it is still set, skips task and thinks it is finished
> freezing.
> 
> refrigerator:
> clears PF_FROZEN and TIF_FREEZE and returns.
> 
> I think you can fix this by moving PF_FROZEN check and set in both places
> under siglock.

I do not think this is necessary because 
freezing and awakening are not done concurrently. First you will 
freeze a number of processes (and no awakening occurs).

Then some action occurs (migration, suspend). Then complete_all 
is invoked. No freezing occurs during the awakening period.

It would be great if you can fix this issue with a patch. But taking a 
lock only makes sense if you can use it to coordinate multiple updates
of variables. I.e. take siglock for clearing PF_FROZEN and TIF_FREEZE and
then use it while checking the state of PF_FROZEN and TIF_FREEZE.
