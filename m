Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263984AbUE1XEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263984AbUE1XEK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 19:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264066AbUE1XEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 19:04:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:42163 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263984AbUE1XEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 19:04:07 -0400
Date: Fri, 28 May 2004 16:06:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Fulghum <paulkf@microgate.com>
Cc: jurjen@stupendous.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] 2.6.6 tty_io.c hangup locking
Message-Id: <20040528160612.306c22ab.akpm@osdl.org>
In-Reply-To: <1085769769.2106.23.camel@deimos.microgate.com>
References: <20040527174509.GA1654@quadpro.stupendous.org>
	<1085769769.2106.23.camel@deimos.microgate.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fulghum <paulkf@microgate.com> wrote:
>
> The following patch removes unnecessary disabling of
> interrupts when processing hangup for tty devices.

Ho hum, this has been hanging around forever.  Obviously the current
locking is pointless and the only useful locking we have in there is
lock_kernel().

The reason why a patch such as yours wasn't applied is that it was all kept
as a reminder that we suck.  Someone needs to get down and audit what's
actually happening in there.  It seems that you've now done that via
comparison with other callers, but that is not necessarily a good approach
when it comes to the tty layer ;)

We need to itemise all the affected memory storage in all impementations of
->flush_buffer() and ->write_wakeup() and then make sure that all _other_
users of those fields (whether or not they lie in the ->flush_buffer() and
->write_wakeup() codepaths) are using the same locking.  Is that something
you could do?
