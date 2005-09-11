Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbVIKH1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbVIKH1J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 03:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbVIKH1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 03:27:09 -0400
Received: from ms004msg.fastwebnet.it ([213.140.2.58]:4270 "EHLO
	ms004msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932426AbVIKH1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 03:27:07 -0400
Date: Sun, 11 Sep 2005 09:28:02 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>,
       Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [patch 7/7] uml: retry host close() on EINTR
Message-ID: <20050911092802.1ab931ac@localhost>
In-Reply-To: <Pine.LNX.4.58.0509101157170.30958@g5.osdl.org>
References: <20050910174452.907256000@zion.home.lan>
	<20050910174630.063774000@zion.home.lan>
	<Pine.LNX.4.58.0509101157170.30958@g5.osdl.org>
X-Mailer: Sylpheed-Claws 1.9.13 (GTK+ 2.6.7; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Sep 2005 12:00:01 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> Re-doing the close() is the wrong thing to do, since in a threaded 
> environment, something else might have opened another file, gotten
> the same file descriptor, and you now close _another_ file.

So glibc doc is wrong here:

http://www.gnu.org/software/libc/manual/html_node/Opening-and-Closing-Files.html#index-close-1197

-----------------------------------------------------------------------
The normal return value from close is 0; a value of -1 is returned in
case of failure. The following errno error conditions are defined for
this function:

...

EINTR
    The close call was interrupted by a signal. See Interrupted
Primitives. Here is an example of how to handle EINTR properly:

               TEMP_FAILURE_RETRY (close (desc));
-----------------------------------------------------------------------


And: /usr/include/unistd.h

# define TEMP_FAILURE_RETRY(expression)		\
  (__extension__				\
    ({ long int __result;			\
       do __result = (long int) (expression);	\
       while (__result == -1L && errno == EINTR); \
       __result; }))
#endif


SUSV3:
-------------------------------------------------------------
If close() is interrupted by a signal that is to be caught, it shall
return -1 with errno set to [EINTR] and the state of fildes is
unspecified
-------------------------------------------------------------

Unspecified! ;-)

-- 
	Paolo Ornati
	Linux 2.6.13.1 on x86_64
