Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTFJSy1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTFJSyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:54:10 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:5871 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S261151AbTFJSvo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:51:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Krzysztof Halasa <khc@pm.waw.pl>, Timothy Miller <miller@techsource.com>
Subject: Re: select for UNIX sockets?
Date: Tue, 10 Jun 2003 14:04:41 -0500
X-Mailer: KMail [version 1.2]
Cc: David Schwartz <davids@webmaster.com>, linux-kernel@vger.kernel.org
References: <MDEHLPKNGKAHNMBLJOLKOEKFDIAA.davids@webmaster.com> <3EE5DE7E.4090800@techsource.com> <m3k7buxbbr.fsf@defiant.pm.waw.pl>
In-Reply-To: <m3k7buxbbr.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Message-Id: <03061014044103.06462@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 June 2003 09:21, Krzysztof Halasa wrote:
> Timothy Miller <miller@techsource.com> writes:
> > If you were to use blocking writes, and you sent too much data, then
> > you would block.  If you were to use non-blocking writes, then the
> > socket would take as much data as it could, then return from write()
> > with an indication of how much data actually got sent.  Then you call
> > select() again so as to wait for your next opportunity to send some
> > more of your data.
>
> This is all true in general but in this particular case of unix datagram
> sockets select (poll) is just buggy.

Ahh no.

The following is from Solaris 2.8 manpage on poll:

     The poll() function supports  regular  files,  terminal  and
     pseudo-terminal  devices,  STREAMS-based  files,  FIFOs  and
     pipes.  The behavior of poll() on elements of fds that refer
     to other types of file is unspecified.

     The poll() function supports sockets.

     A file descriptor for a socket that is listening for connec-
     tions  will indicate that it is ready for reading, once con-
     nections are available.  A file descriptor for a socket that
     is  connecting asynchronously will indicate that it is ready
     for writing, once a connection has been established.

As in: ALWAYS ready to write as soon as a connection is made. It can
still block on a write if the amount to write is larger than the buffer
available. Nothing is said about the AMOUNT that can be written
(though with most FIFOs/pipes the limit is ~ 4K, though not guaranteed
since other writers may fill it between the poll and the write.

The select function (3c):

     The select() function supports regular files,  terminal  and
     pseudo-terminal  devices,  STREAMS-based  files,  FIFOs  and
     pipes. The behavior of select()  on  file  descriptors  that
     refer to other types of file is unspecified.

And the following on it's use on sockets:

     A file descriptor for a socket that is listening for connec-
     tions  will indicate that it is ready for reading, when con-
     nections are available.  A file descriptor for a socket that
     is  connecting asynchronously will indicate that it is ready
     for writing, when a connection has been established.

as in "READY for writing", not that it won't block when you DO write.

(Also "READY for reading", not that it won't block when you DO read.)

You've been lucky to have relatively idle systems or large memory
systems.

I suspect you actually were blocking, just not for very long.









