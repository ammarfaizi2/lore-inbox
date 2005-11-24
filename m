Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161064AbVKXWcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161064AbVKXWcY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 17:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161065AbVKXWcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 17:32:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62101 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161064AbVKXWcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 17:32:23 -0500
Message-ID: <43863F1C.7000800@redhat.com>
Date: Thu, 24 Nov 2005 14:30:52 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mail/News 1.5 (X11/20051105)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] SMP alternatives
References: <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org>	 <437B5A83.8090808@suse.de> <438359D7.7090308@suse.de>	 <p7364qjjhqx.fsf@verdi.suse.de>	 <1132764133.7268.51.camel@localhost.localdomain>	 <20051123163906.GF20775@brahms.suse.de>	 <1132766489.7268.71.camel@localhost.localdomain>	 <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org>	 <4384AECC.1030403@zytor.com>	 <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/05, Linus Torvalds <torvalds@osdl.org> wrote:
> It _should_ be fairly easy to do something like that - just a simple
> global flag that gets set and makes CPL3 ignore lock prefixes.

This is a goof rist step.  But the effectiveness will descrease
significantly in the near future.  It can only work for
single-threaded processes without writable shared memory.

With the growing number of cores/threads the need to use parallelism
rises.  With techniques like OpenMP the threshold to do this is
lowered significantly.  The process-model, so much preferred on this
list over the thread model, requires shared memory, therefore also
eliminating the effectiveness of this functionality.

A real solution needs to be more fine grained.  It is often known in
the userland code whether the specific word which is accessed using
atomic ops really can be shared.  The POSIX interfaces, for instance,
require that all mutexes etc which are placed in shared memory are
attributed as such.  Combine this with the knowledge about the number
of threads in use and the result is that even with writable shared
memory segments the lock prefix can be avoided.  There are a whole
bunch of cases where we already do conditional locking.  It's just
plain ugly and not as efficient as we would like i t.

So, implementing control with per-userlevel context will se rapidly
diminishing success and I'm wondering whether it is better to go for
something with a bit finer level of control.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
