Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266289AbUHNXOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266289AbUHNXOZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 19:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266295AbUHNXOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 19:14:25 -0400
Received: from mailservice.tudelft.nl ([130.161.131.5]:8526 "EHLO
	mailservice.tudelft.nl") by vger.kernel.org with ESMTP
	id S266289AbUHNXOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 19:14:22 -0400
Message-ID: <000601c4825c$90504bc0$161b14ac@boromir>
From: "Martijn Sipkema" <m.j.w.sipkema@student.tudelft.nl>
To: "Jakub Jelinek" <jakub@redhat.com>
Cc: <linux-kernel@vger.kernel.org>, "Ulrich Drepper" <drepper@redhat.com>,
       "Roland McGrath" <roland@redhat.com>
References: <000701c4399e$88a3aae0$161b14ac@boromir> <20040514095145.GC30909@devserv.devel.redhat.com> <000601c439a3$f793af40$161b14ac@boromir> <20040514104012.GE30909@devserv.devel.redhat.com>
Subject: Re: POSIX message queues should not allocate memory on send
Date: Sun, 15 Aug 2004 01:12:33 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jakub Jelinek" <jakub@redhat.com>
> On Fri, May 14, 2004 at 12:09:46PM +0100, Martijn Sipkema wrote:
> > You are correct; defaults are indeed needed. The current default value
> > for mq_msgsize seems rather large considering that mq_msgsize*mq_maxmsg
> > bytes will have to be allocated on queue creation. If variable sized large
> > payload messages are needed one might consider using shared memory in
> > combination with a message queue.
> > 
> > My main point was that mq_send()/mq_timedsend() may not return ENOMEM
> > and I am positive I did not misread the standard on that.
> 
> Even that is not clear.
> http://www.opengroup.org/onlinepubs/009695399/functions/xsh_chap02_03.html#tag_02_03
> "   Implementations may support additional errors not included in this list,
>     may generate errors included in this list under circumstances other than
>     those described here, or may contain extensions or limitations that
>     prevent some errors from occurring.  The ERRORS section on each
>     reference page specifies whether an error shall be returned, or whether
>     it may be returned.  Implementations shall not generate a different error
>     number from the ones described here for error conditions described in
>     this volume of IEEE Std 1003.1-2001, but may generate additional errors
>     unless explicitly disallowed for a particular function."
> 
> Explicitely disallowed in the general section is only EINTR for the THR
> option functions unless explitely listed for that function and nothing else.
> 
> I don't see ENOMEM explicitly forbidden for mq_send/mq_timedsend nor
> any wording in mq_open description which would require the buffers to
> be preallocated.

You are correct, but from the mq_send/mq_timedsend DESCRIPTION:

``If the specified message queue is not full, mq_send() shall behave as if the
message is inserted into the message queue at the position indicated by the
msg_prio argument.''

and from ERRORS:

``The mq_send() and mq_timedsend() functions shall fail if:
[EAGAIN] The O_NONBLOCK flag is set in the message queue description
associated with mqdes, and the specified message queue is full.''

Thus, if full could be interpreted as to also mean that there is no memory
to store the message, returning ENOMEM is not allowed and EAGAIN
would have to be used in stead since an implementation isn't allowed to
use a different error number for the same error condition.

If full is taken to mean that the queue contains its maximum number
of messages, which I think is the correct meaning, then returning ENOMEM
is not allowed, i.e. the queue has to be preallocated, I think, since the
description states that a message shall be added if the queue is not full.

--ms


