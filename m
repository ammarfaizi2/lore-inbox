Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbVC3U4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVC3U4G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 15:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVC3U4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 15:56:06 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:32369 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261271AbVC3UzZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 15:55:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=jwUmNsqUKtfgo8dYnZW2TQK5sTdAi0hPhu5DMWmlWgik3sPTgDW3keQjg10UlduZFsqSmufjZ+2AKnZViy50qp0f/vPhlQ5SMs5s/vqpgf9QjIyO3ETXPZ6oShC4t2j4DqWcr/4Lg3cY5LdL/yeQzfQxMwExqTPZuZtxwAXskdQ=
Date: Wed, 30 Mar 2005 22:55:05 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Paul Jackson <pj@engr.sgi.com>
Cc: gh@us.ibm.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Subject: Re: [patch 0/8] CKRM:   Core patch set
Message-Id: <20050330225505.7a443227.diegocg@gmail.com>
In-Reply-To: <20050329220530.4a5639c8.pj@engr.sgi.com>
References: <E1DGTK2-0007gO-00@w-gerrit.beaverton.ibm.com>
	<20050329220530.4a5639c8.pj@engr.sgi.com>
X-Mailer: Sylpheed version 1.9.7+svn (GTK+ 2.6.2; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 29 Mar 2005 22:05:30 -0800,
Paul Jackson <pj@engr.sgi.com> escribió:


> worth having.  I for one am a CKRM skeptic, so won't be much help to you
> in that quest.  Good luck.
> 
> I don't see any performance numbers, either on small systems, or
> scalability on large systems.  Certainly this patch does not fall under
> the "obviously no performance impact" exclusion.

I'm one of those people who also thinks that CKRM tries to do too much things, and
although my opinion doesn't counts a lot, I'll try to explain myself anyway :)

One of the things I personally don't like about CKRM its how it handles "CPU resources".
The goal of CKRM seems to be "control how much % a process can get get", but the
amount of concepts created to achieve that is too huge and too complex. For the
"CPU resources", I think that there're much simpler and better solutions. For example,
instead what CRKM proposes I propose a simpler concept: "attaching" GIDs to a 
niceness level.

Say, we "attach" group foo to nice level -5. All users who belong to group foo will have
permissions to renice themselves to nice -5. If instead of that, group foo has been
attached at nice level 15, all processes from users who belong to foo will be run at 15,
and they won't be able to renice themselves even to the default priority (0)

This should be very easy to implement, and what's more important, it'd probably have
zero performance impact at runtime - CRKM touches hot paths in the scheduler
I think, this would just touch a few non-critical places - because we'd just use a existing
concept.

Sure, this can't guarantee that a group will get reserved exactly 57% of  the CPU, but I
think that such level of detail is unnecesary - instead we let the kernel uses the
standard internal mechanisms to do the dirty job based in the distinction between
standard nice levels. (And we could get that level of detail just by modifying the
scheduler algorithm and adding a range of -50...0...50 nice levels ;)

For the CPU resources, we already have nice levels. The existing algorithms can already
handle priorities with them. CKRM alternative seems to be to add a second scheduling
algorithm which in super-hot paths like the ones from sched.c are, it will probably have a
performance impact. In my very humble opinion, I think we should reuse existing UNIX
concepts and combine them to achieve some of the goals CKRM tries to achieve in
a much simpler (unixy ;) way.
