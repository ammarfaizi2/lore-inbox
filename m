Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbVCHIUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbVCHIUa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 03:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbVCHIUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 03:20:30 -0500
Received: from mx1.elte.hu ([157.181.1.137]:4049 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261875AbVCHIUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 03:20:22 -0500
Date: Tue, 8 Mar 2005 09:19:22 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Lameter <christoph@graphe.net>, roland@redhat.com,
       shai@scalex86.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] del_timer_sync scalability patch
Message-ID: <20050308081921.GA25679@elte.hu>
References: <Pine.LNX.4.58.0503072244270.20044@server.graphe.net> <20050307233202.1e217aaa.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050307233202.1e217aaa.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Christoph Lameter <christoph@graphe.net> wrote:
> >
> > When a potential periodic timer is deleted through timer_del_sync, all
> >  cpus are scanned to determine if the timer is running on that cpu. In a
> >  NUMA configuration doing so will cause NUMA interlink traffic which limits
> >  the scalability of timers.
> > 
> >  The following patch makes the timer remember where the timer was last
> >  started. It is then possible to only wait for the completion of the timer
> >  on that specific cpu.

i'm not sure about this. The patch adds one more pointer to a very
frequently used and frequently embedded data structure (struct
timer_list), for the benefit of a rarely used API variant
(timer_del_sync()).

Furthermore, timer->base itself is affine too, a timer always runs on
the CPU belonging to timer->base. So a more scalable variant of
del_timer_sync() would perhaps be possible by carefully deleting the
timer and only going into the full loop if the timer was deleted before. 
(and in which case semantics require us to synchronize on timer
execution.) Or we could skip the full loop altogether and just
synchronize with timer execution if _we_ deleted the timer. This should
work fine as far as itimers are concerned.

	Ingo
