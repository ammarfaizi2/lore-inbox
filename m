Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbTD3Ayz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 20:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbTD3Ayz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 20:54:55 -0400
Received: from rj.SGI.COM ([192.82.208.96]:18666 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S261399AbTD3Ayx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 20:54:53 -0400
Date: Tue, 29 Apr 2003 18:07:11 -0700
From: Jeremy Brown <mee@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Oops in inlined __skb_dequeue in unix_stream_recvmsg
Message-ID: <20030430010711.GA135814@miine.engr.sgi.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roughly once a day, and usually when I'm not looking, my desktop will
wedge hard with 2.5.68. Most of the time I get no output to my serial
console, even with nmi_watchdog enabled. However, I have now gotten
three oopses, two of them clean, and they all point to the inlined
skb_dequeue() in unix_stream_recvmsg() in net/unix/af_unix.c.

static inline struct sk_buff *__skb_dequeue(struct sk_buff_head *list)
{
	struct sk_buff *next, *prev, *result;

	prev = (struct sk_buff *) list;
	next = prev->next;
	result = NULL;
	if (next != prev) {
		result	     = next;
		next	     = next->next;
		list->qlen--;
		next->prev   = prev;         <<<<<<< OOPS here
		prev->next   = next;
		result->next = result->prev = NULL;
		result->list = NULL;
	}
	return result;
}

In this case, "next" is NULL (after it has been assigned to
next->next, which is just list->next->next, or the second member of
the circularly linked list).

I've put the ksymoops output, system information, and .config on the
following page (44 KB):

http://www.geocities.com/antinousj/oops3.html

(I'm sorry if the Geocities stuff hurls popups at you or something;
it's just a convenient place to publish at the moment.)

I've been noticing this behavior since 2.5.65, but I've only been able
to capture it in 2.5.67 and 2.5.68 due to the fact that I ran out of
magic smoke in my serial terminal and needed some time to air out the
office and find a replacement.

I would be delighted if anybody had a suggestion.

Jeremy Brown
