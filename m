Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbUENP6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUENP6x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 11:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbUENP6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 11:58:52 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:63142
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S261605AbUENP6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 11:58:40 -0400
Message-ID: <40A4EC7E.4010503@redhat.com>
Date: Fri, 14 May 2004 08:57:50 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a) Gecko/20040513
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martijn Sipkema <m.j.w.sipkema@student.tudelft.nl>
CC: Jakub Jelinek <jakub@redhat.com>, linux-kernel@vger.kernel.org,
       Roland McGrath <roland@redhat.com>
Subject: Re: POSIX message queues should not allocate memory on send
References: <000701c4399e$88a3aae0$161b14ac@boromir> <20040514095145.GC30909@devserv.devel.redhat.com> <000601c439a3$f793af40$161b14ac@boromir> <20040514104012.GE30909@devserv.devel.redhat.com> <001001c439b0$db1af1e0$161b14ac@boromir>
In-Reply-To: <001001c439b0$db1af1e0$161b14ac@boromir>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martijn Sipkema wrote:

> Indeed maybe returning ENOMEM from mq_send() is conforming to the
> standard.

Indeed, it is.


> What _is_ clear from the standard is that a queue is supposed to be
> allocated on creation, even if it may not be required.

Nothing is clear when it comes to the behavior.  There are certainly
some aspects of a possible implementation which the designers of the
APIs had in mind, but this is absolutely no requirement.


> What use is a message queue for a realtime application when on
> mq_send() it may have to wait for memory allocation that may even
> fail?

That's a completely different issue.  You want everybody to suffer
because of the requirements of have.  This is the same as if you would
demand the overcommit is disable.

Yes, there are situations where the allocation-on-demand is not
desirable and the POSIX API description is indeed hinting at such uses.
 But the APIs are useful even without having such hard requirements and
so far the people who developed the code have not seen this hard
realtime requirement.

If you have such requirements I suggest that you sit done and write some
extensions.  I.e., do not replace the current default behavior, but
instead make it possible to force pre-allocation.  I'd say the natural
way is to define a O_* flag which only mq_open() and mq_setattr()
understands.  The former will get it in the second parameter, the latter
via the mq_flags field in the incoming struct mq_attr structure.
Something like O_PREALLOCATE.  Again, the flag would only be needed for
message queues, so a bit other than the ones used by mq_open() can be
reused.


> Even if POSIX allows errors to be returned that are not in the function's
> ERRORS list, I don't think one should do this if it can be avoided.

Do your part to fulfill your niche-requirements.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
