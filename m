Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbTJ0Guv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 01:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbTJ0Guv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 01:50:51 -0500
Received: from pizda.ninka.net ([216.101.162.242]:55741 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261226AbTJ0Guu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 01:50:50 -0500
Date: Sun, 26 Oct 2003 22:43:58 -0800
From: "David S. Miller" <davem@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: akpm@osdl.org, Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, kuznet@ms2.inr.ac.ru
Subject: Re: Linux 2.6.0-test9
Message-Id: <20031026224358.233e6d1a.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0310261623000.3157-100000@home.osdl.org>
References: <Pine.LNX.4.44.0310261607230.3157-100000@home.osdl.org>
	<Pine.LNX.4.44.0310261623000.3157-100000@home.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Oct 2003 16:28:11 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> But reverting the change is clearly the "safer" thing to do, I just worry 
> that Alexey might have had a real reason for tryign to avoid the EINTR in 
> the first place (for non-URG data).

I'd like to hear something from Alexey first.

The problem we were trying to deal with was that when data
is available to read a lot of people were complaining that
we return -EINTR and no other system does this.

This is heavily inconsistent with how we handle every other
type of socket error.  In all other cases, a read() when data
is available will succeed until the very last byte is sucked
out of the socket, then any subsequent read() call after the
queue is emptied will return the error.

But I am starting to see that URG is different.  It is not like
other socket errors that halt the socket and make no new data
arrive after it happens.  Rather, URG can happen just about anywhere
and more data can continue to flow into the socket buffers.

In fact, this means that our change can result in an application
can never see the error if data continues to arrive faster than
the application can pull it out, see?

Alexey, I think we did not understand this case fully when making this
change.

