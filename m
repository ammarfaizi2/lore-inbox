Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbTFDAck (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 20:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbTFDAck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 20:32:40 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:35483 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S262029AbTFDAci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 20:32:38 -0400
Date: Tue, 3 Jun 2003 20:43:47 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: strange dependancy generation bug?
In-Reply-To: <20030603195651.GA17845@mars.ravnborg.org>
Message-ID: <Pine.GSO.4.33.0306032004470.7750-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jun 2003, Sam Ravnborg wrote:
>In make a so-called "canned command sequence" is generated.
>Quote from 'info make':
>
>	On the other hand, prefix characters on the command line that refers
>	to a canned sequence apply to every line in the sequence.  So the rule:
>
>	     frob.out: frob.in
>        	     @$(frobnicate)

(I seriously cannot believe there needs to be a protracted debate about
 what's broken and who's at fault -- make or Makefile.  What we see is
 what we get and it's a 5 second fix.  Beyond that, it's a problem for
 the GNU Make maintainers, not lkml.)

Weither make is using 1 shell or 10 doesn't matter.  Make is the thing
emitting the command to the console as well as feeding the shell.  It's
a matter of one command or more than one command.

The Kbuild system is rather complex.  If you look deep enough, you'll
see where the '@' is being applied.  What is actually happening looks
like this:
	define rule_for_act_of_frobnication
		stuff_that_should_be_one_line
				\
		but_isn't
	endef

	frobnicate = @set -e; \
			$(rule_for_act_of_frobnication);

	frob.out: frob.in
		$(call frobnicate)

There's a big difference in @$(call frobnicate) and $(call frobnicate).
Both ultimately resovle to two line of text.  In the first case, all of
it hidden.  In the second, only the lines explicitly hidden will be hidden.

Make isn't broken.  Makefile.build is.  To me, this was immediately obvious
and confirmed after a few seconds searching for the "@". (It looks like
someone hit [enter] where they shouldn't have.)

--Ricky


