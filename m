Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbUFJOsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbUFJOsO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 10:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbUFJOrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 10:47:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:43705 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261422AbUFJOq5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 10:46:57 -0400
Date: Thu, 10 Jun 2004 07:46:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
cc: Al Viro <viro@math.psu.edu>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Finding user/kernel pointer bugs [no html]
In-Reply-To: <1086842898.32053.380.camel@dooby.cs.berkeley.edu>
Message-ID: <Pine.LNX.4.58.0406100735530.2050@ppc970.osdl.org>
References: <1086838266.32059.320.camel@dooby.cs.berkeley.edu> 
 <Pine.LNX.4.58.0406092059030.2050@ppc970.osdl.org>
 <1086842898.32053.380.camel@dooby.cs.berkeley.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Jun 2004, Robert T. Johnson wrote:
> 
> QUESTION:  Do you find it's difficult to figure out which fields of
> structures should be declared __user?

It's _usually_ trivial, by just looking at the warnings. 

Not always, though. We don't have a "taint" attribute (I've been thinking 
about it, but I don't feel the pain has been worth it yet), so if you do 
load a structure from user space (properly, with copy_from_user()) and 
then use a non-annotated part of that as a pointer and dereference it 
directly, sparse won't warn, of course. 

However, that requires that _every_ single user of that attribute member 
mis-uses the pointer (ie that "get_user()" never sees that pointer at 
all)). So that case is fairly unlikely, although it can (and probably 
does) happen for the unusual stuff.

The much harder issue is structures that soemtimes contain user pointers,
and sometime contain kernel pointers. Those sparse can't handle at all,
since sparse does purely local and static type-checking. It will complain
about one or the other.

The only way to fix the second case is to split the structure up - which
is usually a good idea _anyway_, but which can sometimes be pretty 
painful. Al has done some of them. The really painful one is "struct 
iovec", which seems to be used in this capacity a fair amount.

> If a structure pointer is __user, but it has some pointer fields that
> aren't declared __user, there's a good chance that there's a missing
> annotation or something.

Yes. That's likely a good heuristic.

			Linus
