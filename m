Return-Path: <linux-kernel-owner+w=401wt.eu-S1161009AbWLTXIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161009AbWLTXIH (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 18:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161008AbWLTXIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 18:08:06 -0500
Received: from smtp.osdl.org ([65.172.181.25]:47280 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161009AbWLTXIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 18:08:05 -0500
Date: Wed, 20 Dec 2006 15:07:54 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] daemon.c blows up on OSX
In-Reply-To: <86ac1iyyla.fsf@blue.stonehenge.com>
Message-ID: <Pine.LNX.4.64.0612201502090.3576@woody.osdl.org>
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net> <86vek6z0k2.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0612201412250.3576@woody.osdl.org> <86irg6yzt1.fsf_-_@blue.stonehenge.com>
 <7vr6uu6w8e.fsf@assigned-by-dhcp.cox.net> <86ejquyz4v.fsf@blue.stonehenge.com>
 <86ac1iyyla.fsf@blue.stonehenge.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 20 Dec 2006, Randal L. Schwartz wrote:
> 
> According to my headers, "strncasecmp" is defined in <string.h>,
> "NI_MAXSERV" is defined in <netdb.h>, and "initgrps" is defined
> in "unistd.h".  So this patch works (just verified on OSX), but I
> don't know what damage it does elsehwere:

Look at "cache.h": the first thing it does is to include 
"git-compat-util.h". And THAT in turn does include ALL the headers you 
added (string.h, netdb.h and unistd.h).

So it would appear that for OS X, the

	#define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
	#define _GNU_SOURCE
	#define _BSD_SOURCE

sequence actually _disables_ those things.

Some googling finds a python source diff:

	   # On Mac OS X 10.4, defining _POSIX_C_SOURCE or _XOPEN_SOURCE
	   # disables platform specific features beyond repair.
	-  Darwin/8.*)
	+  Darwin/8.*|Darwin/7.*)
	     define_xopen_source=no
	     ;;

(and Ruby shows up as well in the google)

Can you try to grovel around in the OS X headers, and see what the magic 
is to enable all the compatibility crud on OS X?

		Linus
