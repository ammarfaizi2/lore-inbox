Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268102AbUHKRBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268102AbUHKRBG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 13:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268108AbUHKRBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 13:01:06 -0400
Received: from [66.45.74.15] ([66.45.74.15]:56497 "EHLO sluggardy.net")
	by vger.kernel.org with ESMTP id S268102AbUHKRBA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 13:01:00 -0400
Message-ID: <37062.66.93.180.209.1092243659.squirrel@66.93.180.209>
Date: Wed, 11 Aug 2004 10:00:59 -0700 (PDT)
Subject: select implementation not POSIX compliant?
From: "Nick Palmer" <nick@sluggardy.net>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,

I am working on porting some software from Solaris to Linux 2.6.7. I have
run into a problem with the interaction of select and/or recvmsg and close
in our multi-threaded application. The application expects that a close
call on a socket that another thread is blocking in select and/or recvmsg
on will cause select and/or recvmsg to return with an error. Linux does
not seem to do this. (I also verified that the same issue exists in Linux
2.4.25, just to be sure it wasn't introduced in 2.6 in case you were
wondering.)

I found this thread:
http://www.ussg.iu.edu/hypermail/linux/kernel/0006.3/0414.html
which indicates that we must call shutdown first in order to get the
desired behavior, which works as described. However this doesn't seem to
be a POSIX compliant implementation by my read of the POSIX specification
for select. (The specification for recvmsg doesn't specifically talk about
this condition, so I can accept that the implementation on Linux is
compliant for recvmsg, even if the behavior is a bit surprising to me, but
not for select.)

>From the POSIX specification for select from
http://www.unix.org/single_unix_specification/:

A descriptor shall be considered ready for reading when a call to an input
function with O_NONBLOCK clear would not block, whether or not the
function would transfer data successfully.
<snip>
If a descriptor refers to a socket, the implied input function is the
recvmsg() function with parameters requesting normal and ancillary data,
such that the presence of either type shall cause the socket to be marked
as readable.

I have a test case (email me off list if you want a copy) that shows that
a call to the input function does not block, but instead returns an error
after a close call, yet the select called before the close continues to
block. Furthermore, a call to close and then select in the same thread
blocks while the other thread is still in select, which has a very large
surprise factor, since the code would work were it not for the other
select.

This is certainly a large enough difference from Solaris to cause our
POSIX application not to work on Linux, and I imagine I'm not the only one
that has experienced problems with this implementation. Is there a good
argument for why it has been implemented this way? It is certainly less
than intuitive.

Thanks for addressing this issue,
-Nick
