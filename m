Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbVBSE5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbVBSE5R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 23:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbVBSE5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 23:57:17 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:228 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261630AbVBSE5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 23:57:13 -0500
To: Vicente Feito <vicente.feito@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: workqueue - process context
X-Message-Flag: Warning: May contain useful information
References: <200502190148.11334.vicente.feito@gmail.com>
From: Roland Dreier <roland@topspin.com>
Date: Fri, 18 Feb 2005 20:57:11 -0800
In-Reply-To: <200502190148.11334.vicente.feito@gmail.com> (Vicente Feito's
 message of "Sat, 19 Feb 2005 01:48:11 +0000")
Message-ID: <52is4ptae0.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 19 Feb 2005 04:57:12.0008 (UTC) FILETIME=[7914BC80:01C5163F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Vicente> I've been playing with workqueues, and I've found that
    Vicente> once I unload the module, if I don't call
    Vicente> destroy_workqueue(); then the workqueue I've created
    Vicente> stays in the process list, [my_wq], I don't know if
    Vicente> that's meant to be, or is it a bug, cause I believe there
    Vicente> can be two options in here:

    Vicente> 1) It's meant to be so you can unload your module and let
    Vicente> the works run some time after you're already gone, that
    Vicente> allows you to probe other modules or do whatever necesary
    Vicente> without the need to wait for the workqueue to be emtpy.

    Vicente> 2) It's a bug, cause the module allows to be unloaded,
    Vicente> destroying the structs but not removing the workqueue
    Vicente> from the process context.

Not destroying its workqueue is a bug in the module just like any
other resource leak.  It's analogous to a module allocating some
memory with kmalloc() and not calling kfree() when it's unloaded.  If
a module creates a workqueue, then it should call destroy_workqueue()
when it's unloaded.

By the way, the module (or any code calling destroy_workqueue()) must
make sure that it has race conditions that might result in work being
submitted to the queue while it is being destroyed.

 -R .
