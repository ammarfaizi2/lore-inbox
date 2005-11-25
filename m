Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161123AbVKYQnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161123AbVKYQnz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 11:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161126AbVKYQnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 11:43:55 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:63192 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161123AbVKYQnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 11:43:55 -0500
Subject: Re: RFC: Kill -ERESTART_RESTARTBLOCK.
From: David Woodhouse <dwmw2@infradead.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0511251602460.1609@scrub.home>
References: <1132859323.11921.110.camel@baythorne.infradead.org>
	 <Pine.LNX.4.61.0511250110470.1610@scrub.home>
	 <1132919594.4044.41.camel@baythorne.infradead.org>
	 <Pine.LNX.4.61.0511251602460.1609@scrub.home>
Content-Type: text/plain
Date: Fri, 25 Nov 2005 16:44:06 +0000
Message-Id: <1132937046.21643.127.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-25 at 16:24 +0100, Roman Zippel wrote:
> The arguments have to be saved somewhere, otherwise ERESTARTNOHAND 
> wouldn't work, so my basic idea would be to change ERESTART_RESTARTBLOCK 
> into ERESTARTNOHAND + some extra state.

That's true; it should probably work.

> > One simpler option which _might_ work for pselect(), ppoll() and
> > sigsuspend() is a TIF_RESTORE_SIGMASK flag which restores the original
> > signal mask on the way back to userspace but _after_ calling do_signal()
> > with the temporary mask.
> 
> Now I see the problem with the signal mask and I agree, this would be a 
> simpler and IMO preferable approach.

Yes; and its downside (-EINTR even when the signal gets ignored) is
avoided by the above -- or just by using -ERESTARTNOHAND, in fact.

I think I'll use this approach, and probably use -ERESTARTNOHAND in the
first instance. Because ppoll() is going to take a timespec instead of
just an integer for the timeout, we can write back to it as we do for
select, and there shouldn't be a problem restarting. 

Thanks.

-- 
dwmw2

