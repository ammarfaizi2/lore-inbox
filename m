Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130803AbRASUQZ>; Fri, 19 Jan 2001 15:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131063AbRASUQP>; Fri, 19 Jan 2001 15:16:15 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:8977 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S130803AbRASUQC>;
	Fri, 19 Jan 2001 15:16:02 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200101192003.XAA25191@ms2.inr.ac.ru>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
To: raj@cup.hp.COM (Rick Jones)
Date: Fri, 19 Jan 2001 23:03:19 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A68908C.3F3FE453@cup.hp.com> from "Rick Jones" at Jan 19, 1 10:15:04 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> the business about the last 1100ish bytes of a 4096 byte send being
> delayed by nagle only implies that the stack's implementation of nagle
> was broken and interpreting it on a per-segment rather than a per-send
> basis. 
+
> software, or the host TCP stack. otherwise, the persistent connections
> would have worked just fine.

Exactly.


But, actually, there exist the situation (in http-1.1, but not in the nature,
as it is now 8)), when explicit push is required even with ideal nagling.

Look: http-1.1, asynchronous one, the first request is sent, but not acked.
Time to send the second one, but it is blocked by Nagle. If there is no
third request, the pipe stalls. Seems, this situation will be usual,
when http-1.1 will start to be used by clients, because of dependencies
between replys (references) frequently move it to http-1.0 synchronous
mode, but with some data in flight. See?

Solution is evident. On such kind of connections explicit push
must be made as soon as we complete some request _and_ there are no
more pending requests in queue.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
