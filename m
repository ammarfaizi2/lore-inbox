Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbUCCVGl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 16:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbUCCVGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 16:06:41 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:22035 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261198AbUCCVGM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 16:06:12 -0500
Date: Wed, 3 Mar 2004 22:07:15 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Chris Wright <chrisw@osdl.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: kbuild will remove .c files
Message-ID: <20040303210715.GA2229@mars.ravnborg.org>
Mail-Followup-To: Chris Wright <chrisw@osdl.org>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <20040303123406.G21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303123406.G21045@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 12:34:06PM -0800, Chris Wright wrote:
> I added a new config to my kernel, and hadn't done a bk -r get in quite
> a while.  Turns out the subdir relevant to the config item hits the make
> builtin to get the file (since it had been missing), but then kbuild
> assembles, links, links, and finally removes the .c file.  This will
> be done everytime, since the .c file is now gone.  While a preemptive
> bk -r get is the obvious solution here (or even a after the fact bk get
> $missing.c), is this a possible very small buglet in kbuild?
> 
> Here's some relevant output:
> 
> get   net/irda/irlan/SCCS/s.irlan_client.c
> net/irda/irlan/irlan_client.c 1.8: 565 lines
>   CC      net/irda/irlan/irlan_client.s
> as   -o net/irda/irlan/irlan_client.o net/irda/irlan/irlan_client.s
>   LD      net/irda/irlan/irlan.o
>   LD      net/irda/irlan/built-in.o
> rm net/irda/irlan/irlan_client.c

What happens here is that make resort to a chained rule to create the
irlan.o file.
The chain goes from SCCS/%.c -> %.c -> %.s -> %.o

The two files %.c and %.s is considered intermidiate files, and make
guarantees that intermidiate files that did not exist when
make was called, does not exists when make exists.
This is reported by make with the "rm ..." line.

See info make -> Implicit rules - > Chained rules

The reason why you see this is that there is no implicit rule from SCCS/%.c -> %.c
wich is because kbuild does not 'know' of SCCS/* - but make uses some build-in
rule for this.

Two questions pops up though.
First my make documentatin say the make would use "rm -f ...",not "rm".
What make version do you use?

Also I would expect to see irlan_client.s to be deleted also - did you miss that?
It may show up a bit later.

	Sam
