Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264767AbUFLMwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264767AbUFLMwE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 08:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264749AbUFLMwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 08:52:04 -0400
Received: from lakermmtao03.cox.net ([68.230.240.36]:44422 "EHLO
	lakermmtao03.cox.net") by vger.kernel.org with ESMTP
	id S264767AbUFLMvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 08:51:17 -0400
In-Reply-To: <40CA95ED.8060902@myrealbox.com>
References: <772741DF-BC19-11D8-888F-000393ACC76E@mac.com> <40CA74D0.5070207@myrealbox.com> <FA11463F-BC2C-11D8-888F-000393ACC76E@mac.com> <40CA95ED.8060902@myrealbox.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3131BE9C-BC6F-11D8-888F-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: In-kernel Authentication Tokens (PAGs)
Date: Sat, 12 Jun 2004 08:51:16 -0400
To: Andy Lutomirski <luto@myrealbox.com>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 12, 2004, at 01:34, Andy Lutomirski wrote:
> Right.  But I think it would be desirable to do other things -- for 
> example, a program might want to forward one token over to a daemon to 
> do some work.  It doesn't make much sense here to have a hierarchial 
> structure.

So you disagree with the hierarchical structure because you believe 
that there are other things that are more important that conflict with 
it.  I see no reason why both cannot be accommodated.  For me, I would 
really desire a hierarchical structure because it would make it very 
simple to have a token set for the entire session and one for each 
instance (shell), and ones for subshells where convenient.

You want to sent a token to some daemon over a UNIX socket?  Just copy 
the token data and write it out to the socket, the same as if you had 
some external token store (Like in MIT Kerberos) and wanted to send the 
token to somewhere without the environment variables.  This system 
would allow several existing token cache mechanisms to be converted to 
this alternative store without much work at all.

Perhaps the syscalls should be changed to allow better protection 
against race conditions when two processes are using token groups.

sys_tokgrp_open
	Returns a tokgrp_handle associated with a token group id.  Implies 
that the tokgrp will not go away until this handle is closed

sys_tokgrp_pid_open
	Returns a tokgrp_handle associated with the token group currently 
controlled by a given PID.

sys_tokgrp_close
	Releases a tokgrp_handle

sys_tokgrp_get{parent,uid,token}
sys_tokgrp_set{parent,uid,token}
	These operate the same as earlier, except on tokgrp_handles instead of 
tokgrp IDs.

Then perhaps we could arrange for a tokgrp_handle to be a special kind 
of filehandle, and perhaps the set* and get* functions could be IOCTLs 
or something.  That would allow a tokgrp_handle to be passed around 
between processes, although a suitably privileged process could just 
run sys_tokgrp_pid_open on the PID of the other process.  That way also 
close-on-exec and such work as expected.

> BTW, does AFS even have this hierarchy, or does pagsh just create a 
> copy? I can't find any manpage for it...

AFS in 2.4 has these magic high-numbered groups that it dynamically 
allocates.  The way a new set of tokens is created is by changing magic 
groups to a new set.  That whole system is just a massive hack and I'd 
rather it stop at 2.4  I don't know about 2.6, I think they might be 
ready for a beta, but I don't know how their auth tokens work.

Cheers,
Kyle Moffett

