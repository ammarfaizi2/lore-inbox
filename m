Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267526AbUJGRD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267526AbUJGRD2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 13:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267447AbUJGRBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 13:01:31 -0400
Received: from findaloan.ca ([66.11.177.6]:15574 "EHLO findaloan.ca")
	by vger.kernel.org with ESMTP id S267487AbUJGQN2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 12:13:28 -0400
Date: Thu, 7 Oct 2004 12:09:14 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Martijn Sipkema <martijn@entmoot.nl>
Cc: Adam Heath <doogie@debian.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041007160914.GB26784@mark.mielke.cc>
Mail-Followup-To: Martijn Sipkema <martijn@entmoot.nl>,
	Adam Heath <doogie@debian.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0410061124110.31091@chaos.analogic.com> <Pine.LNX.4.61.0410070212340.5739@hibernia.jakma.org> <4164EBF1.3000802@nortelnetworks.com> <Pine.LNX.4.61.0410071244150.304@hibernia.jakma.org> <001601c4ac72$19932760$161b14ac@boromir> <Pine.LNX.4.61.0410071346040.304@hibernia.jakma.org> <001c01c4ac76$fb9fd190$161b14ac@boromir> <1097156929.31753.47.camel@localhost.localdomain> <Pine.LNX.4.58.0410071017300.1194@gradall.private.brainfood.com> <004901c4ac8c$2a14ed70$161b14ac@boromir>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004901c4ac8c$2a14ed70$161b14ac@boromir>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 05:39:06PM +0100, Martijn Sipkema wrote:
> Aaargh... I'm going to shut up about this now, because this is clearly going
> nowhere, but you are saying that any application that expects behaviour as
> defined in POSIX is broken, and that bothers me..

I like the idea submitted by somebody else. If O_NONBLOCK is enabled,
the current semantics apply. If O_NONBLOCK is not enabled, select()
takes longer to run and verifies that data is actually available. No
cost for applications that people consider to be 'proper', and the
standard, and saner behaviour, is implemented for the rest. If
somebody could provide a patch for this, that was clean, easy to
maintain, and could be proven to have a minimal impact on performance,
I bet the opponents to this would quiet down.

I don't have the time or experience to do this right now. It would take
me over a month just to learn what would need to be done. So, it will
have to be somebody else...

There is one claim I'd like to question - the claim that select()
would be slowed down unnecessarily, even if the behaviour was changed
for both O_NONBLOCK enabled. Isn't it more expensive to allow the
application to be woken up, and poll using read(), than to just do a
quick check in the kernel and not tell the application there is data,
when there really isn't? This sounds to me like a question of
implementation - if select() did the read check, including checksums,
or whatever, the checks are done. The application doesn't get waken
up, or by the time it gets to read(), the data is already
available. No loss. I'm thinking that it must be the current
implementation that would make this expensive to implement, rather
than some convincing theoretical explanation. If this is true, it's
fine - we all live in the practical world, but we should admit it.

Cheers,
mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

