Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264094AbTEWQLD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 12:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264093AbTEWQLC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 12:11:02 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10761 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264089AbTEWQK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 12:10:59 -0400
Date: Fri, 23 May 2003 09:23:33 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: Re: [PATCH 1/4] Optimize NFS open() calls by means of 'intents'...
In-Reply-To: <16078.6093.339198.108592@charged.uio.no>
Message-ID: <Pine.LNX.4.44.0305230911160.21297-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 23 May 2003, Trond Myklebust wrote:
> 
> Minor cleanup of open() code. Put the original open flags, mode, etc. into
> an 'opendata' structure that can be passed as an intent to lookup.

I don't mind the concepts, but I _really_ dislike the implementation.

For one thing, if you're creating a structure to pass in the flags for 
open, then you should take the time to make the code _more_ readable 
rather than less. In particular, the notion of having a structure like 
this:

	struct opendata {
		int flag;
		int mode;
		int acc_mode;
	};

where each of "flag" and "acc_mode" are magic bitfields just fills me with
horror. 

So why not make those internal modes that we translate the "flags" into be 
a real bitmap? That should make the code a lot more readable.

Also, I don't really understand why you want to have "opendata" and 
"intent" as different structures. That's _especially_ true now that the 
only intent is the "open" intent, but even if there were other intents, 
I'd rather have something like this

	struct lookup_info {
		enum type; /* open, validate, whatever.. */
		union {
			struct open_intent open;
			..
		} data;
	}

and gace tge flags (create/exclusive etc) inside that lookup_intent 
instead of having multiple different pointers and transferring data from 
one to the other at different phases of the "open".

Also, in patch 3/4, you do

	xxx_create(struct inode *dir, struct dentry *dentry, int mode, struct vfsintent *intent)

and that "mode" this I again find offensive: why is it not in the intent?  
It automatically _would_ be, if you only had one structure and one
pointer, but you lost it when you did the "opendata->intent"  
transformation.

So please don't have this artifical (and clearly broken) differentiation
between "intent" and "opendata". They should be one and the same thing:  
"lookup_info". Because that is what they _are_. They are not intents. They
are literally extra information for the lookup.

		Linus

