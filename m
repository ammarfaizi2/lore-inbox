Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129529AbRBAWZW>; Thu, 1 Feb 2001 17:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129550AbRBAWZN>; Thu, 1 Feb 2001 17:25:13 -0500
Received: from ns1.BayNetworks.COM ([134.177.3.20]:57851 "EHLO
	baynet.baynetworks.com") by vger.kernel.org with ESMTP
	id <S129529AbRBAWY7>; Thu, 1 Feb 2001 17:24:59 -0500
From: "Paul D. Smith" <pausmith@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14969.57896.331183.374489@lemming.engeast.baynetworks.com>
Date: Thu, 1 Feb 2001 17:24:40 -0500
To: linux-kernel@vger.kernel.org
Subject: SO_REUSEADDR redux
X-Mailer: VM 6.89 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So, I have an application that works fine on Solaris, FreeBSD, etc. and
fails on Linux.

This application uses SO_REUSEADDR in conjunction with INADDR_ANY.  What
it does is bind() to INADDR_ANY, then listen().  Then, it proceeds to
bind (but _not_ listen) various other specific addresses.

This works fine on Solaris, but the second, etc. bind fails on Linux.

I found a thread about this from February, 1999, starting here:

  http://www.uwsg.indiana.edu/hypermail/linux/kernel/9902.1/0828.html

In this message, George Pajari (George.Pajari@faximum.com) says:

  The original security threat that lead to SO_REUSERADDR being broken in the
  1.3.60 kernel (incorrect semantics which I think still persist) was the
  fact that if process A bound to port X using INADDR_ANY and SO_REUSERADDR,
  a second process could bind to the specific IP addresses and obtain
  connections intended for process A.

  So the kernel was changed to prevent the second process from completing the
  bind() call.

Maybe I'm missing something, but it seems to me that having two binds is
not a security problem: what's really the problem is having two
_listens_.  As long as you're only listening on the one, I don't see how
connections/packets could be stolen.

Isn't the correct behavior to fail the second listen(), not the second
bind()?  This, anyway, is what Solaris and FreeBSD (and maybe others)
seem to do.

This app does this because it implements peer-to-peer, fully meshed
connections; it first sets up an INADDR_ANY and listens on it so that
any other instance of the app can reach it, then it proceeds to try to
bind to the other instances.  Since we have no idea which one will start
first, or whether they'll all start together, we don't want to have a
hole where we might miss a connection from another instance.  Thus, we
listen first, then proceed to attempt to connect to the other
instances.

Am I missing something here WRT SO_REUSEADDR vs. INADDR_ANY behavior?

Thanks.


PS. CC'ing me is helpful, but I'll follow along either way.  Thx.

-- 
-------------------------------------------------------------------------------
 Paul D. Smith <psmith@baynetworks.com>    HASMAT--HA Software Methods & Tools
 "Please remain calm...I may be mad, but I am a professional." --Mad Scientist
-------------------------------------------------------------------------------
   These are my opinions---Nortel Networks takes no responsibility for them.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
