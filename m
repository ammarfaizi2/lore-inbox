Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263406AbUCPCId (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 21:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263417AbUCPCFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 21:05:35 -0500
Received: from mail.tpgi.com.au ([203.12.160.61]:37254 "EHLO mail4.tpgi.com.au")
	by vger.kernel.org with ESMTP id S263406AbUCPCEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 21:04:45 -0500
Subject: Re: Dealing with swsusp vs. pmdisk
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Pavel Machek <pavel@ucw.cz>, "Theodore Ts'o" <tytso@mit.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1079401255.1967.217.camel@gaston>
References: <20040312224645.GA326@elf.ucw.cz>
	 <20040313004756.GB5115@thunk.org> <1079146273.1967.63.camel@gaston>
	 <20040313123620.GA3352@openzaurus.ucw.cz>
	 <1079223482.1960.113.camel@gaston>  <20040314003717.GI549@elf.ucw.cz>
	 <1079381114.5349.62.camel@calvin.wpcb.org.au>
	 <1079395292.2302.191.camel@gaston>
	 <1079393514.2043.10.camel@calvin.wpcb.org.au>
	 <1079401255.1967.217.camel@gaston>
Content-Type: text/plain
Message-Id: <1079395159.2167.47.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2.norlug 
Date: Tue, 16 Mar 2004 12:59:19 +1300
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.


On Tue, 2004-03-16 at 14:40, Benjamin Herrenschmidt wrote:
> On Tue, 2004-03-16 at 10:31, Nigel Cunningham wrote:
> > On Tue, 2004-03-16 at 13:01, Benjamin Herrenschmidt wrote:
> > > > - Freezer hooks (I can easily get suspend2 working with the old freezer
> > > > until people are convinced it's not up to the task). This accounts for
> > > > the vast majority of those file changes.
> > > 
> > > It would be nice if you did that as a first step indeed. I'm personally
> > > not convinced of the usefullness of having a freezer at all ;)
> > 
> > Without a freezer, how would you ensure that other processes don't mess
> > up your memory state while you're saving/reloading the image?
> 
> Hrm, you are not protecting about "asynchronous" (interrupt based)
> activity anyway... I'm not sure how the IO sceduler may kill us
> and whatever doing things based on a timer that doesn't have a
> device-driver underneath getting the PM callbacks.

I have other measures to protect the consistency there; forgot about
them until you reminded me. There are simple hooks in the page
allocation and freeing code so that pages allocated and freed during
suspending/resuming come from and go to a fix memory pool. All pages in
this pool are saved with the atomic copy, regardless of whether they're
used or not. This makes the image state consistent even if drivers
allocate or free memory during suspending (including during the
device_suspend/resume calls).

The freezer hooks also catch processes forking or exiting during
suspend, and preserve consistency there too. Right after an init S, the
network code was often seen to be running processes in the middle of a
suspend, after freezing had finished. This works correctly now.

> As far as suspend-to-disk is concerned, I agree we need a state
> snapshot, then we need to be able to play with drivers to save that
> state without having userland get in the way, so yup, we need a
> freezer. I think we don't need it for suspend-to-ram though.

I'll say nothing here; I'm not thinking about suspend-to-ram at all.

Nigel.
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6253 0250 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

