Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262937AbSLTQwa>; Fri, 20 Dec 2002 11:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263105AbSLTQwa>; Fri, 20 Dec 2002 11:52:30 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:6023 "HELO atlrel9.hp.com")
	by vger.kernel.org with SMTP id <S262937AbSLTQw3>;
	Fri, 20 Dec 2002 11:52:29 -0500
Content-Type: text/plain; charset=US-ASCII
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
To: William Lee Irwin III <wli@holomorphy.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH] Fix CPU bitmask truncation
Date: Fri, 20 Dec 2002 10:00:21 -0700
User-Agent: KMail/1.4.3
References: <200212161213.29230.bjorn_helgaas@hp.com> <20021220103028.GB9704@holomorphy.com> <20021220111523.GA7644@holomorphy.com>
In-Reply-To: <20021220111523.GA7644@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212201000.21223.bjorn_helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 December 2002 4:15 am, William Lee Irwin III wrote:
> Actually, this looks like a non-issue from userspace on the IA64 boxen
> I can get to. akpm pointed out that this seemed to pass his testing,
> and on deeper inspection, IA64 userspace did not find this to be an issue.
> 
> Bjorn, could you explain on what toolchains and/or architectures you had
> this issue? It sounds serious and/or real enough yet I can't actually
> make this happen myself.

This was an issue with gcc 2.96 on a 64-way IA64 box.  I don't have
access to one at the moment, but as I remember, without the 2.4 changes:

-       ((p)->cpus_runnable & (p)->cpus_allowed & (1 << cpu))
+       ((p)->cpus_runnable & (p)->cpus_allowed & (1UL << cpu))

nothing would get scheduled on CPUs 32-63.  I guess those changes
aren't controversial, though.

The question of whether this was strictly necessary:

-    cpus_runnable:     -1,                                             \
-    cpus_allowed:      -1,                                             \
+    cpus_runnable:     ~0UL,                                           \
+    cpus_allowed:      ~0UL,                                           \

I don't specifically recall, and a quick test suggests that it really
doesn't matter.  Since cpus_runnable and cpus_allowed are declared
unsigned long, I think ~0UL is a more direct expression of what is
desired, but maybe that's just a personal preference.

Bjorn

