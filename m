Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbUHBUTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUHBUTK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 16:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbUHBUTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 16:19:09 -0400
Received: from mail.inter-page.com ([12.5.23.93]:34056 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S263093AbUHBUS2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 16:18:28 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "'Arjan van de Ven'" <arjanv@redhat.com>
Cc: "'David S. Miller'" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: RE: tcp_push_pending_frames() without TCP_CORK or TCP_NODELAY
Date: Mon, 2 Aug 2004 13:18:14 -0700
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAhwx/pa8d806ey9yxSc0mvQEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <20040802195330.GA23939@devserv.devel.redhat.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am after explicit flushing of a "normal" (e.g. nagle mode) stream.  The TCP_CORK
stuff is the opposite of what I am after as I am "only sometimes" in a position to
know that a flush will increase performance but I am often not in a position to know
that a CORK won't hurt it.

Right now I am performing the flush operation by calling setsockopt() twice, turning
NODELAY on and then back off.

Using the MSG_MORE will improve some of the small-frame preamble stuff, even with
nagle on (if I am understanding all of the ramifications).  Does MSG_MORE work with
nagle off (NODELAY set)?

The original candidate patch is designed to flush a CORKed or normally Nagled (is
that a word?) socket in one call without losing the actual options.  It does that by
saving the cork/nagle flag, doing the same flush stuff that turning off nagle does,
and then restoring the flag.  It should be safely applicable to each of the three
modes (though kind of pointless for the NODELAY mode 8-).

Arguments for are:
-- The flush is one call.
-- The flush is "safe" to call from a library because it has no net-effect on the
persistent state of the socket. (This is a new argument in this message 8-)

Arguments against are:
-- Two calls are not significantly expensive.
-- Have to add the ioctl info to lots of places and the docs.


-----Original Message-----
From: Arjan van de Ven [mailto:arjanv@redhat.com] 
Sent: Monday, August 02, 2004 12:54 PM
To: Robert White
Cc: 'David S. Miller'; linux-kernel@vger.kernel.org
Subject: Re: tcp_push_pending_frames() without TCP_CORK or TCP_NODELAY

On Mon, Aug 02, 2004 at 12:44:41PM -0700, Robert White wrote:
> Is there an argument _against_ providing an explicit flush?

well MSG_MORE is equivalent, it's an explicit non-flush... 



