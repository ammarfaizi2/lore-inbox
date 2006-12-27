Return-Path: <linux-kernel-owner+w=401wt.eu-S932870AbWL0Ak4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932870AbWL0Ak4 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 19:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932866AbWL0Ak4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 19:40:56 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:41682
	"EHLO grelber.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932870AbWL0Akz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 19:40:55 -0500
From: Rob Landley <rob@landley.net>
To: David Lang <david.lang@digitalinsight.com>
Subject: Re: Feature request: exec self for NOMMU.
Date: Tue, 26 Dec 2006 19:39:56 -0500
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org,
       David McCullough <david_mccullough@au.securecomputing.com>
References: <200612261823.07927.rob@landley.net> <Pine.LNX.4.63.0612261549050.24795@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.63.0612261549050.24795@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612261939.57359.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 December 2006 6:55 pm, David Lang wrote:
> > Worse, it's not always possible.  If chroot() has happened since the 
program
> > started, there may not _be_ a path to my current executable available from
> > this process's current or root directories.
> 
> does this even make sense (as a general purpose function)? if the executable 
> isn't available in your path it's likly that any config files it needs are
> not available either.

For a statically linked busybox it makes sense, but you're right that a 
dynamically linked one is going to suck however you do it...

I guess what I really want to do is promote a vfork() to a real fork() after 
the fact.  Which sounds painful.

For the daemonize() case I want to unblock the parent and have it exit.  Too 
bad I can't call clone() with some kind of CLONE_VFORK_BACKWARDS so it blocks 
the child until the parent exits.  (Hmmm...  CLONE_STOPPED doesn't help, just 
moves the race...)

For the "new process runs code out of this executable" case what I really want 
is an actual fork, hideously expensive as that is on nommu systems.  (There 
are things I can do to minimize that.)  Maybe I can call clone() directly on 
a nommu system to get it to fork, even when the C library hasn't got it?  
Hmmm...

> for something like busybox/toolbox where you have different functions based
> on the name used to execute the program, which name would you use?

The one from argv[0].  (Notice how exec has a "path to executable" and then an 
argv array?  Nobody said that the path to executable and argv[0] had to point 
to the same string...)

Rob
-- 
"Perfection is reached, not when there is no longer anything to add, but
when there is no longer anything to take away." - Antoine de Saint-Exupery
