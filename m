Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267517AbUIOV1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267517AbUIOV1F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267464AbUIOVXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:23:32 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:46509 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267548AbUIOVUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:20:06 -0400
Subject: Re: [PATCH] hvc_console fix to protect hvc_write against ldisc
	write after hvc_close
From: Ryan Arnold <rsa@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
In-Reply-To: <1095276020.20569.2.camel@localhost.localdomain>
References: <1095273835.3294.278.camel@localhost>
	 <1095276020.20569.2.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM
Message-Id: <1095283382.3294.349.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 15 Sep 2004 16:23:02 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 14:20, Alan Cox wrote:
> Actually for the short term I may have made the ldisc calling tty race
> worse. I'm still looking into some of that. I've fixed the one the other
> way but for now driver defensively 8)

Alan, thanks for the heads up, and thanks for the work on the ldisc code
it is MUCH appreciated.

While we're looking at the ldisc code; I am a bit disturbed by how easy
it is to tty_flip_buffer_push() and silently lose data.  The ldisc
function n_tty_receive_buf() which is normally scheduled as delayed work
via the tty_flip_buffer_push() operation simply overwrites the contents
of the circular tty->read_buf leading to dataloss and out of order
output if too much data is pushed too quickly.

The manual accounting of pushed data is very tricky to do when the
pushing thread isn't sure of when the line discipline will actually
schedule the n_tty_receive_buf() operation.  I think that the tty
throttle() & unthrottle api is supposed to help with this but it is
possible (and in my experience was common) that the throttle callback
would happen AFTER data has already been lost.

Many of us tty driver writers resort to setting tty->low_latency = 1
which synchronizes the n_tty_receive_buf() call to be executed in the
same thread as that which invoked tty_flip_buffer_push() such that we
know when a throttle happens we haven't yet lost data.

I don't know when tty->low_latency is really appropriate to use but it
solves my problems.  I've heard people say that tty data delivery is
inherently unreliable.  This doesn't make sense to me because imho tty
data is very important.  I hope I'm not approaching this topic of
flip_buffer_pushing and throttling from a mistaken assumption.

Thanks,

Ryan S. Arnold
Linux Technology Center

