Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264958AbUFLXdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264958AbUFLXdJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 19:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264959AbUFLXdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 19:33:09 -0400
Received: from lakermmtao11.cox.net ([68.230.240.28]:55747 "EHLO
	lakermmtao11.cox.net") by vger.kernel.org with ESMTP
	id S264958AbUFLXdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 19:33:02 -0400
In-Reply-To: <1087080664.4683.8.camel@lade.trondhjem.org>
References: <772741DF-BC19-11D8-888F-000393ACC76E@mac.com> <1087080664.4683.8.camel@lade.trondhjem.org>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <D822E85F-BCC8-11D8-888F-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: In-kernel Authentication Tokens (PAGs)
Date: Sat, 12 Jun 2004 19:33:01 -0400
To: Trond Myklebust <trond.myklebust@fys.uio.no>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 12, 2004, at 18:51, Trond Myklebust wrote:
> It's been done.
>
> See the thread on
>
>   http://marc.theaimsgroup.com/?l=linux-fsdevel&m=105290906118164&w=2
>
> on why Linus vetoed the idea of PAGs for Linux.

He didn't veto PAGs, he only vetoed that particular implementation.  
I've
read his criticisms before and I believe that my proposal neatly handles
most of them, which is why I'm posting it.  Another nice feature of my 
system
is that it does not break anything if it is completely ignored by some 
tasks
and used by others.  In fact, most processes shouldn't care, only stuff 
that
actually needs to use or modify the tokens in user-space should care.

I really should change the term "PAG".  My implementation does not 
operate
at all like the posted one did.  His implementation is tied in very 
strongly with
the concept of a user, 1 user => 1 PAG.  In my code the two are 
completely
separate, a PAG is a generic object with a few properties: a security 
context,
a list of tokens, and a parent.  Linus' criticisms are:


- Designed for AFS

I designed this because I would like to see a ticket/token storage 
mechanism
in the kernel.  I would like this to be something that could be a 
Kerberos V5
credentials cache, an RSA key storage agent (like ssh-agent), and a 
generic
remote filesystem token storage.


- A token can only be on one PAG

True in my design, but in order to access the token you open() it, 
which returns
a filehandle that can be passed to any other program over a UNIX socket.
This could be easily extended to allow the original user to 
invalidate/close the
other user's filehandle.  Also, the design allows each PAG to have a 
parent,
so it forms a tree (Must be non-cyclic).  This allows multiple 
processes to share
a set of global tokens in a parent PAG, and each have their own sub-PAGs
that they can work in without disturbing the global token set.  Linus 
even
mentions that perhaps a list of PAGs could handle that issue, but with 
that the
priority is unintuitive, whereas with a tree one can match the process 
tree
much more accurately and without much effort.  Even still, my design 
makes it
simple to add the ability for a token to be in more than one PAG.


- pag_t is too small

This doesn't apply, because I don't map a PAG to a user, it stands on 
its own,
in an allocation namespace separate from anything else.


- Desire for "group" PAGs.

I don't have any feature that allows for a "group" PAG, but I think 
that should be
handled elsewhere.  If I want special file access because I am in a 
group, then
that should be handled by the filesystem based on my _user_ token.  It 
knows
who I am and can figure out my group list from that.  If it is truly a 
desire to have
all members share a token or set of tokens (I don't know of any 
circumstances
where this would be desirable, please tell me if you have any 
examples), then
each group could have a PAG tree associated with it, which would be 
searched
*after* the PAG tree associated with a process when looking for tokens.


Cheers,
Kyle Moffett

