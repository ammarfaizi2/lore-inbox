Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264588AbUFLDNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264588AbUFLDNX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 23:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264595AbUFLDNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 23:13:23 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:48568 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S264588AbUFLDNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 23:13:21 -0400
Message-ID: <40CA74D0.5070207@myrealbox.com>
Date: Fri, 11 Jun 2004 20:13:20 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: In-kernel Authentication Tokens (PAGs)
References: <772741DF-BC19-11D8-888F-000393ACC76E@mac.com>
In-Reply-To: <772741DF-BC19-11D8-888F-000393ACC76E@mac.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:

> I am working on a generic PAG subsystem for the kernel, something that
> handles BLOB PAG data and could be used for OpenAFS, Coda, NFSv4, etc.
> I have a patch, but it is not well tested yet.  Here is an overview of the
> architecture:
> 
> Each process has a PAG, and each PAG has a parent PAG.  Users are
> allowed to make new PAGs associated with their UID and modify ones that
> are already associated with their UID.  Each PAG consists of a set of 
> tokens,
> each uniquely identified by an integral "type" and a string "realm."  The
> search for a token by any subsystem is done starting at the immediate 
> parent
> and proceeds upward.  Tokens are in kernel memory and so are not ever
> swapped out.
> 
 > ...

I like the idea of having some kernel support for tokens.

But why PAGs?  I imagine tokens as being independent objects without any 
hierarchy.  A token group is a set of tokens.  The operations on tokens are:

read: read the raw value of the token
write: change the value of the token
execute: "use" the token (i.e. for VFS, pass over UNIX socket (to a 
privileged process, I guess).

Which gives an interesting thought: there are "anonymous" and named tokens. 
  Anonymous ones are just fds.  Named ones live in /cred/tokens.

/cred/tokens: a named token
/cred/groups/all: a magic group which has everything
/cred/groups/whatever: contains symlinks to tokens it can access

/proc/12345/tokengroup: symlink to my token group

To avoid information leaks, /cred/tokens would be readable and executable 
only by root.  You can only create symlinks to tokens you have access to. 
And you have a syscall to select a token group.

AFS's pagsh (or whatever it's called) creates a new token group and selects it.

If you really need a hierarchy, then you could allow token groups to 
contain other token groups, with the rule that the whole thing must be acyclic.

Now, if I only knew how to write filesystems...

--Andy
