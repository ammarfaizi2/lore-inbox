Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264876AbUFLRPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264876AbUFLRPy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 13:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264719AbUFLRPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 13:15:54 -0400
Received: from lakermmtao12.cox.net ([68.230.240.27]:47314 "EHLO
	lakermmtao12.cox.net") by vger.kernel.org with ESMTP
	id S264876AbUFLRPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 13:15:51 -0400
In-Reply-To: <40CB233C.6050505@myrealbox.com>
References: <772741DF-BC19-11D8-888F-000393ACC76E@mac.com> <40CA74D0.5070207@myrealbox.com> <FA11463F-BC2C-11D8-888F-000393ACC76E@mac.com> <40CA95ED.8060902@myrealbox.com> <3131BE9C-BC6F-11D8-888F-000393ACC76E@mac.com> <40CB233C.6050505@myrealbox.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <276EDF6A-BC94-11D8-888F-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: In-kernel Authentication Tokens (PAGs)
Date: Sat, 12 Jun 2004 13:15:51 -0400
To: Andy Lutomirski <luto@myrealbox.com>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 12, 2004, at 11:37, Andy Lutomirski wrote:
> Kyle Moffett wrote:
>> You want to sent a token to some daemon over a UNIX socket?  Just 
>> copy the token data and write it out to the socket, the same as if 
>> you had some external token store (Like in MIT Kerberos) and wanted 
>> to send the token to somewhere without the environment variables.  
>> This system would allow several existing token cache mechanisms to be 
>> converted to this alternative store without much work at all.
>
> Except I'd like non-root users to have tokens that they _cannot_ read, 
> but that they can still pass over unix sockets.  I have no objection 
> to also allowing user-readable tokens.

Ok, that makes a lot of sense, I really should have thought of that 
earlier.  So how about we add an extra flag to a token identifying 
whether it's readable by someone with it's UID or only by someone with 
CAP_LINUX_TOKGRP.  How about the following interface:

The special files "/proc/tokgrp/<tokgrp-id>/group" represent token 
groups.  They cannot be read or written, but they utilize file modes 
(I'm not sure how yet).  Opening one of them prevents it from going 
away until it is closed.  There should be symlinks named 
"/proc/<pid>/tokgrp" to the appropriate dir in "/proc/tokgrp/".  
Perhaps there should be symlinks as "/proc/tokgrp/<tokgrp_id>/parent" 
to the appropriate parent tokgrp directory.  Those would not exist if 
it did not have a parent.

IOCTLs:
tokgrp_{get,set}_pid: Manipulates the PID of a token group
tokgrp_{get,set}_parent: Manipulates the parent of a token group

Tokens are uniquely identified within a token group by an integral 
"type" and a string "realm".  A specific token is mapped to 
"/proc/tokgrp/<id>/<typenum>/<realm>".  They can be read or written 
according to file modes, and the execute permission means the ability 
to execute in-kernel operations on the token (depending on the type) 
using IOCTLs.  All tokens (As long as the process is in the same UID 
and/or has CAP_LINUX_PAG) can be opened and the filehandles passed 
around using UNIX sockets.

> This way I could have a server with, say, a Kerberos service token 
> such that a compromise of the server process does not compromise the 
> service token.  (You still have a gotcha in that the kerberosd this 
> would require would, for performance reasons, want to handle only 
> ticket-granting traffic.  Still, you just mark the TGT unreadable and 
> the individual session tickets readable, so that the damage of a 
> compromise is limited to a few hours until the sessions expire.)

Since we have in-kernel crypto we could even put some of the token 
operations into the kernel and use those operations to work with the 
ticket (decrypt, etc).  That would mean that in certain cases we could 
keep the tickets completely out of reach of exposed software.

> Yes, this would be a _lot_ more work than just blindly porting 
> Kerberos' ticket cache, but it has security benefits.

Definitely

> And I really want a good token system in Linux -- that way the OpenAFS 
> people will stop bitching and I might be able to use it again.

Yeah, I know.  If we do it well enough and make it modular enough then 
OpenAFS, Coda, NFSv4, Kerberos, OpenSSH (RSA keys) etc can all use the 
same implementation.  This could also be steps in the right direction 
of making Linux more TCB-ish.

Cheers,
Kyle Moffett

