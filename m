Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbTEVE5y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 00:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbTEVE5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 00:57:54 -0400
Received: from CPE-203-51-25-146.nsw.bigpond.net.au ([203.51.25.146]:3968 "EHLO
	didi") by vger.kernel.org with ESMTP id S262273AbTEVE5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 00:57:52 -0400
Date: Thu, 22 May 2003 15:09:56 +1000
From: Nick Piggin <piggin@cyberone.com.au>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: Robert White <rwhite@casabyte.com>,
       Rik van Riel <riel@imladris.surriel.com>,
       David Woodhouse <dwmw2@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: recursive spinlocks. Shoot.
Message-ID: <20030522050956.GA273@didi>
Mail-Followup-To: "Peter T. Breuer" <ptb@it.uc3m.es>,
	Robert White <rwhite@casabyte.com>,
	Rik van Riel <riel@imladris.surriel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org
References: <3ECC4C3A.9000903@cyberone.com.au> <200305220442.h4M4gFM12023@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305220442.h4M4gFM12023@oboe.it.uc3m.es>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 22, 2003 at 06:42:15AM +0200, Peter T. Breuer wrote:
> "Nick Piggin wrote:"
> > Locking is an implementation issue, and as such I think you'll have
> > to come up with a real problem or some real code. You must have some
> > target problem in mind?
> 
> I'll butt back in here.
> 
snip

> 
> The result was a call from the block driver to the md driver with a
> lock held, and a rather unexpected call back from the md driver that
> impotently tried to take the same lock.
> 
> Same thread.
>

OK, in this case, it didn't sound like your block driver
expected to be re-entered. Lucky the problem immediately
caused a deadlock ;)

More seriously, lets say you get around the above with
recursive locks:

Thread 1			Thread 2 (on another cpu)
enter the block driver
take the bd lock
				issue an md ioctl
				take the md lock
				enter the block driver
				spin on bd lock
automatically call md ioctl
spin on md lock

So the problem needs a rethink.
