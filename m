Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264488AbTKNVjA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 16:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264495AbTKNVjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 16:39:00 -0500
Received: from auemail2.lucent.com ([192.11.223.163]:30935 "EHLO
	auemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S264488AbTKNViw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 16:38:52 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16309.14997.961879.421597@gargle.gargle.HOWL>
Date: Fri, 14 Nov 2003 15:27:01 -0500
From: "John Stoffel" <stoffel@lucent.com>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test9-mm3
In-Reply-To: <20031114193249.GM2014@mis-mike-wstn.matchmail.com>
References: <20031112233002.436f5d0c.akpm@osdl.org>
	<98290000.1068836914@flay>
	<20031114105947.641335f5.akpm@osdl.org>
	<20031114193249.GM2014@mis-mike-wstn.matchmail.com>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mike> Or maybe if it didn't start sync committing from the journal
Mike> once it hits 50%.

Instead of using a percentage like this, would it make sense to flush
the journal when there are only N number of free journal slots/entries
left?  Now the question is how to compute N in a sane way that works
for small (memory) systems, as well as for larger systems.

You don't want to grow N too aggresively, or base it on the memory of
the system, do you?  When you have a 20mb journal, maybe starting
writeout after 10mb is used makes sense, because you've only got 10
transaction slots open.  But when you have a 200mb journal, does it
make sense to start writeout when you only have 100 transaction slots
left?  

Since I don't know the internals of Ext3 at all, I'm probably
completely missing the idea here, but my gut feeling is that the
scaling we use in these cases shouldn't be linear at all, but more
likely inverse logyrythmic instead.  Basically, the larger we get with
a resource, the slower we grow our useage, or the smaller we grow the
absolute size of the writeout buffer(s).

Hmmm... this doesn't sound clear even to me.  But the idea I think I'm
trying to get at is that if we have X size of a journal, we want to
start writeout when we have X/2 available.  But when we have Y size of
a journal, where Y is X*10 (or larger), we don't want Y/2 as the
cutover point, we want something like  Y/10.  The idea is that we grow
the denominator here at a slow rate, since it will shrink the free
buffer percentage nicely, yet not let us get too close to a truly zero
sized buffer.

     X     X/N
    ----- --------
     10    5
     100   10
     1000  25
     10000 125

Does this make any sense to anyone?

John
