Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265360AbUFBXU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265360AbUFBXU4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 19:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265377AbUFBXUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 19:20:55 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:24810 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265360AbUFBXU3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 19:20:29 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 2 Jun 2004 16:20:24 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>,
       Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] explicitly mark recursion count
In-Reply-To: <20040602185832.GA2874@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.58.0406021458090.22742@bigblue.dev.mdolabs.com>
References: <200406011929.i51JTjGO006174@eeyore.valparaiso.cl>
 <Pine.LNX.4.58.0406011255070.14095@ppc970.osdl.org>
 <20040602131623.GA23017@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020712180.3403@ppc970.osdl.org>
 <Pine.LNX.4.58.0406020724040.22204@bigblue.dev.mdolabs.com>
 <20040602182019.GC30427@wohnheim.fh-wedel.de>
 <Pine.LNX.4.58.0406021124310.22742@bigblue.dev.mdolabs.com>
 <20040602185832.GA2874@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2004, [iso-8859-1] Jörn Engel wrote:

> Yeah, I know about the problems to generate a complete call graph.
> With function pointers, it is plain impossible to get it right in the
> most general case.
> 
> Note the "in the most general case" part.  You can get things right if
> you make some assumptions and those assumptions are actually valid.
> In my case the assumptions are:
> 1. all relevant function pointers are stuffed into some struct and
> 2. no casts are used to disguise function pointer as something else.
> 
> If you stick with those rules, the resulting code is quite sane, which
> is much more important than any tools being usable.  If the kernel
> doesn't stick to those rules for a good reason, I'd like to know about
> it, so I can adjust my tool.  And if the kernel doesn't stick to those
> rules for no good reason, the code if broken and needs to be fixed.
> 
> Is this sane?

Think at file_operations as very simple example, and try to find out what 
is actually called when somewhere the code does f_op->*(). How would you 
build the graph down there. You'd have to record all the functions that 
have been assigned to such method throughout the code, and nest *all* 
their graph in place. And this will eventually trigger false positives. 
Similar thing with functions that accepts callbacks, either directly or 
inside structures. And this doesn't even start to take aliasing into 
account. Hunting stack hungry functions is very good, and having a tool 
that is maybe 60% precise in detecting loops is fine too. But requiring 
metadata to be maintained to support such tool is IMO wrong.



- Davide

