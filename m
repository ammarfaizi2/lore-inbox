Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269413AbRIJNxC>; Mon, 10 Sep 2001 09:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269515AbRIJNwn>; Mon, 10 Sep 2001 09:52:43 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:28173 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S269454AbRIJNwj>; Mon, 10 Sep 2001 09:52:39 -0400
Date: Mon, 10 Sep 2001 15:53:00 +0200
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: [bug report] NFS and uninterruptable wait states
Message-ID: <20010910155300.D19255@artax.karlin.mff.cuni.cz>
In-Reply-To: <m3zo8cp93a.fsf@belphigor.mcnaught.org> <01090310483100.26387@faldara> <m3zo8cp93a.fsf@belphigor.mcnaught.org> <32526.999534512@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <32526.999534512@redhat.com>; from dwmw2@infradead.org on Mon, Sep 03, 2001 at 05:28:32PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Timeouts are a completely separate issue, surely? Applications ought to be 
> able to deal with getting a _signal_ during a system call, whatever happens.
> 
> IMO, sleeping in state TASK_UNINTERRUPTIBLE in any situation where you can't
> prove that the wakeup _will_ happen and will happen _soon_ should be
> considered a bug - it's almost always just because someone hasn't bothered
> to implement the cleanup code required for dealing with being interrupted.
> 
> /me tries to work out why anyone would ever want filesystem accesses to be 
> uninterruptible.

generic_file_read does wait_on_page, which sleeps uninteruptibly. This
shouldn't be too difficult to change (once the pages are linked to file's
memory_area, generic_read_file redoes readpage on the same pages and it's
up to readpage to find out, weather the request is still pending or timed
out)

Other problem is the RPC layer. If it should check signal_pending only on
timeouts, it;s simple. If it should also check while waiting, it has to be
able to recognise the interupted call. And this in turn brings the problem
of discarding data requested by interupted and not restarted calls (eg. when
the process was killed by the signal). There is the nasty case when request
is sent to the server and sending process dies while waitig. But the request
is eventualy replied and the reply must be handled somewhere.

You are right about not bothering with cleanup code. But it's not easy to
have the RPC layer right.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
