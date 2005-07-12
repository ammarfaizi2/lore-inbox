Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVGLImp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVGLImp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 04:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVGLIkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 04:40:22 -0400
Received: from ms005msg.fastwebnet.it ([213.140.2.50]:52415 "EHLO
	ms005msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S261274AbVGLIjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 04:39:02 -0400
Date: Tue, 12 Jul 2005 10:38:11 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Lack of Documentation about SA_RESTART...
Message-ID: <20050712103811.0087a7e3@localhost>
In-Reply-To: <20050711143427.GC14529@thunk.org>
References: <20050711123237.787dfcde@localhost>
	<20050711143427.GC14529@thunk.org>
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2005 10:34:27 -0400
Theodore Ts'o <tytso@mit.edu> wrote:

> According to the Single Unix Specification V3, all functions that
> return EINTR are supposed to restart if a process receives a signal
> where signal handler has been installed with the SA_RESTART flag.  

Thanks to have cited SUS... I'm reading it and is much cleaner than
manpages :-)

"SA_RESTART
    This flag affects the behavior of interruptible
functions; that is, those specified to fail with errno set to [EINTR].
If set, and a function specified as interruptible is interrupted by this
signal, the function shall restart and shall not fail with [EINTR]
unless otherwise specified. If the flag is not set, interruptible
functions interrupted by this signal shall fail with errno set to
[EINTR]"

Note the "unless otherwise specified".

> 
> > Example of behavior: according to source code it seems that
> > "connect()" (the "net/ipv4/af_inet.c : inet_stream_connect()"
> > implementation) returns -ERESTARTSYS if interrupted, but if the
> > socket is in non-blocking mode it returns -EINTR.
> 
> If the socket is non-blocking mode, and there isn't a connection ready
> to be received, then the socket is going to return with some kind of
> errno set; either EINPROGRESS (Operation now in progress) or EALREADY
> (Operation already in progress), or if a signal came in during the
> system call (which would happen pretty rarely, the window for the race
> condition is pretty small) it will return EINTR.  I _think_ that a
> close reading of the specification would state that the system call
> should be restarted, and since a connection isn't ready, then at that
> point EINPROGRESS or EALREADY would be returned.  
> 

Reading SUSV3 it seems that doing a connection with non-blocking socket
CANNOT return EINTR... and this make sense.

The particular case you analized (blocking connect interrupted by a
SA_RESTART signal) is interesting... and since SUSV3 says
	"but the connection request shall not be aborted, and the connection
	shall be established asynchronously" (with select() or poll()...)
both for EINPROGRESS and EINTR, I think it's quite stupit to
automatically restart it and then return EALREADY.

The logically correct behaviur with blocking connect interrupted and
then restarted should be to continue the blocking wait... IHMO.

-- 
	Paolo Ornati
	Linux 2.6.12.2 on x86_64
