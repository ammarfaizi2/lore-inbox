Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262640AbTJXVYM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 17:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbTJXVYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 17:24:12 -0400
Received: from smtp3.Stanford.EDU ([171.64.14.172]:26288 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S262640AbTJXVYJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 17:24:09 -0400
Message-ID: <3F999870.4050709@stanford.edu>
Date: Fri, 24 Oct 2003 14:24:00 -0700
From: Andy Lutomirski <luto@stanford.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b; MultiZilla v1.5.0.1) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Wagner <daw@cs.berkeley.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: posix capabilities inheritance
References: <fa.f26d55g.1qgijbi@ifi.uio.no> <fa.hq0dft9.9i0obd@ifi.uio.no>
In-Reply-To: <fa.hq0dft9.9i0obd@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David Wagner wrote:

> Andy Lutomirski  wrote:
> 
>>I've been programming Windows for a long time, and windows has a 
>>capability system.  [...] All capabilities are disabled by default (almost -- 
>>there's a pointless exception, of course).  The result is that every 
>>program that uses a privileged function (e.g. change the time, restart, 
>>etc.) wraps that call with something that turns enables the capability 
>>at first, then disables it.  This has no benefit -- a hijacked 
>>privileged program can still enable them, and the admin never sees this, 
>>because everything enables them.
> 
> 
> Actually, it does have some benefits.  If I do an open() somewhere
> else in the code, I know that it is not going to unintentionally use
> my elevated privileges.  That's useful.  Least privilege, and all that.

Agreed, somewhat. The problem IMHO is that, even for caps like 
CAP_DAC_READ_SEARCH, no existing code expects this behavior.  (Windows 
example again: users with SeBackupPrivilege have a _very_ hard time 
using it since few programs actually know what to do with it.)  If I'm a 
user with CAP_DAC_READ_SEARCH, I don't want to have to rewrite all of 
fileutils just to use that privilege.  Users can still have this 
behavior, though, under my proposed evolution rules:
pE' = pP' & (pE|fP)

Pretend that 'cap' is a bash builtin that did the obvious thing:

~backupuser/.bashrc: cap all disable
~backupuser/bin/privrun: cap all enable; exec $*

Now that user can't accidentally use CAP_DAC_READ_SEARCH, but s/he could 
do 'privrun ls', for example, if necessary.  (I'm ignoring funny issues 
with cd here.)  All of this is without the fE mask and without modifying 
or breaking existing user tools.

If you can think of a use for fE, let me know :)


Andy

