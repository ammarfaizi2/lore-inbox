Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbVETXNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVETXNa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 19:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVETXNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 19:13:30 -0400
Received: from mail.shareable.org ([81.29.64.88]:63193 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261211AbVETXNU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 19:13:20 -0400
Date: Sat, 21 May 2005 00:13:12 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] FUSE: don't allow restarting of system calls
Message-ID: <20050520231312.GD29155@mail.shareable.org>
References: <E1DZ3Mx-0003ST-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DZ3Mx-0003ST-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> This patch removes ability to interrupt and restart operations while
> there hasn't been any side-effect.
> 
> The reason: applications.  There are some apps it seems that generate
> signals at a fast rate.  This means, that if the operation cannot make
> enough progress between two signals, it will be restarted for ever.
> This bug actually manifested itself with 'krusader' trying to open a
> file for writing under sshfs.  Thanks to Eduard Czimbalmos for the
> report.

Caching and prefetching would solve that probem much more usefully.

Does sshfs not cache or prefetch any of the data?

IMHO, caching and prefetching makes a lot of sense for this situation
- in fact, it does for any kind of filesystem operation during a
sequence of file operations where a program does not use locks (flock
etc.), fsyncs, or open/close.

Surely caching and prefetching should be a generic feature of FUSE for
all its filesystems unless disabled.  Is there a reason why this is
not done, or is it just not implemented?

> The problem can be solved just by making open() uninterruptible,
> because in this case it was the truncate operation that slowed down
> the progress.  But it's better to solve this by simply not allowing
> interrupts at all (except SIGKILL), because applications don't expect
> file operations to be interruptible anyway.  As an added bonus the
> code is simplified somewhat.

NFS makes file operations interruptible when they're mounted with
"intr".

It's a life-saver, when the server or network gets wedged, to be able
to Control-C a program instead of it being stuck in D-state and
requiring a reboot.

Having a program be stuck in read/write ignoring signals, so that
Control-C, Control-Z and kill don't work on it, while it's waiting for
some network operation, is a horrible thing.

-- Jamie
