Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273697AbRIWX5y>; Sun, 23 Sep 2001 19:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273701AbRIWX5o>; Sun, 23 Sep 2001 19:57:44 -0400
Received: from adsl-63-195-80-148.dsl.snfc21.pacbell.net ([63.195.80.148]:49045
	"EHLO pincoya.com") by vger.kernel.org with ESMTP
	id <S273697AbRIWX5e> convert rfc822-to-8bit; Sun, 23 Sep 2001 19:57:34 -0400
Date: Sun, 23 Sep 2001 17:11:45 -0700
From: Gordon Oliver <gordo@pincoya.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] /dev/epoll update ...
Message-ID: <20010923171145.A15109@furble>
Reply-To: gordo@pincoya.com
In-Reply-To: <3BA97155.4D2D53AC@distributopia.com> <XFMail.20010920101821.davidel@xmailserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <XFMail.20010920101821.davidel@xmailserver.org>; from davidel@xmailserver.org on Thu, Sep 20, 2001 at 10:18:21 -0700
X-Mailer: Balsa 1.2.pre3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2001.09.20 10:18 Davide Libenzi wrote:
> If you need to request the current status of a socket you've to
> f_ops->poll the fd.
> The cost of the extra read, done only for fds that are not "ready", is
> nothing
> compared to the cost of a linear scan with HUGE numbers of fds.
> You could implement a solution where the low level io functions goes
> directly to write
> inside the mmapped fd set where the data buffer is empty or the out
> buffer is full.
> This would be a way more intrusive patch whose perf gain won't match the
> cost.

But you missed the obvious optimization of doing an f_ops->poll when
the file is _added_. This means that you'll get an initial event when
there is data ready. This means you still never do a scan (only check
when an fd is added), but you don't have to do an empty read every time
you add an fd.

Before you argue that this does not save a system call, it will in
the typical case of:
   <add fd>
   <fail read>
   <wait on events>
   <successful read>

Note that it has the additional advantage of making the dispatch code
in the user application easier. You no longer have to do special code
to handle the speculative read after adding the fd.
	-gordo
