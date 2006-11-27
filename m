Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756681AbWK0Els@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756681AbWK0Els (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 23:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756689AbWK0Els
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 23:41:48 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:28094 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1756681AbWK0Elr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 23:41:47 -0500
Date: Mon, 27 Nov 2006 04:41:39 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Roland Dreier <rdreier@cisco.com>, Andrew Morton <akpm@osdl.org>,
       David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, tom@opengridcomputing.com,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] Avoid truncating to 'long' in ALIGN() macro
Message-ID: <20061127044138.GA3078@ftp.linux.org.uk>
References: <20061124.220746.57445336.davem@davemloft.net> <adaodqv5e5l.fsf@cisco.com> <20061125.150500.14841768.davem@davemloft.net> <adak61j5djh.fsf@cisco.com> <20061125164118.de53d1cf.akpm@osdl.org> <ada64d23ty8.fsf@cisco.com> <20061126111703.33247a84.akpm@osdl.org> <Pine.LNX.4.64.0611261208550.3483@woody.osdl.org> <adapsba2bvj.fsf@cisco.com> <Pine.LNX.4.64.0611261415530.3483@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611261415530.3483@woody.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2006 at 02:20:10PM -0800, Linus Torvalds wrote:
> So arguably, the result is _more_ like a normal C operation this way. 
> Type-wise, the "ALIGN()" macro acts like any other C operation (ie if you 
> feed it an "unsigned char", the end result is an "int" due to the normal C 
> type widening that happens for all C operations).
> 
> But I don't care horribly much. Al may have some other reasons to _not_ 
> want the normal C type expansion to happen (ie maybe he does something 
> unnatural with sparse ;)

Type expansion will happen as soon as you do any arithmetics (or passing
as argument) anyway.

It's actually more of "typeof() has interesting interactions with
other gccisms" kind of thing and general dislike of using that beast
more than absolutely necessary.

Not the #1 on my list of the worst gccisms we are using (that would be
({...}) with its insane semantics and interesting ways to get gcc puke
its guts out), but still pretty high there...

ObFun: what's the type of ({struct {int x,y;} a = {1,2}; a;}) and
how comes that we can say
	({struct {int x,y;} a = {1,2}; a;}).y
and get gcc eat it up and evaluate that to 2?  Note that we are doing
a very obvious violation of scope rules - WTF _is_ .y in scope where
we have no visible declaration of any structure with field that would
have such name?

IOW, gcc allows type to leak out of scope it's been defined in (and
typeof adds even more fun to the picture).  It not only goes against
a _lot_ in C, it's actually not thought through by gcc folks.  Just
try to mix that with variable-length arrays and watch it blow up
in interesting ways...
