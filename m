Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbTJXQrB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 12:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbTJXQrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 12:47:01 -0400
Received: from smtp3.Stanford.EDU ([171.64.14.172]:46816 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S262303AbTJXQq4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 12:46:56 -0400
Message-ID: <3F9956E6.2020709@stanford.edu>
Date: Fri, 24 Oct 2003 09:44:22 -0700
From: Andy Lutomirski <luto@stanford.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b; MultiZilla v1.5.0.1) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: linux-kernel@vger.kernel.org, glasgow@beer.net,
       albert@users.sourceforge.net
Subject: Re: posix capabilities inheritance
References: <fa.n4rmmgg.2423pm@ifi.uio.no> <fa.l1oevhb.1s5k583@ifi.uio.no> <3F98E674.6090104@stanford.edu> <20031024124150.GA5609@thunk.org>
In-Reply-To: <20031024124150.GA5609@thunk.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Theodore Ts'o wrote:

> On Fri, Oct 24, 2003 at 01:44:36AM -0700, Andy Lutomirski wrote:
> 
>>1. pI is currently almost useless.  If a process really wants a capability 
>>to be dropped after exec, it can drop it itself.  So redefine pI to mean 
>>"these are the only capabilities that this process or its children may 
>>_ever_ hold."
> 
> 
> A lot of the reasons why it looks useless is because we don't have
> filesystem support.  The intent behind the POSIX capabilities system
> is that system administrator can control which privileges are
> conferred upon a program when it is exec'ed, as well as which
> privileges it is allowed to inherit.  (The idea behind this is that
> even if the exec'ing process wishes to bequeath some super-user
> capabilities across an exec, unless that program has been audited and
> cleared by the site security officer as being cleared to accept that
> additional capability, it shouldn't be given it.)  In addition, of
> course, the exec'ing process ought to be allowed to control what
> capabilities it is willing to bequeth.  

I agree completely.  I'm just suggesting a different way of doing it. 
If a process is actually not trusted to have some capability, then it is 
presumably not trusted to use helper applications that have that 
capability.  So make it impossible to use or _regain_ caps that are not 
in pI and fI.

On the other hand, if the exec'ing process wants to remove a capability 
without this restriction, then it can just drop it and then call exec. 
Hence:

pP' = (fP | pP) & pI'; (note pI_'_ -- fI restrictions still take effect 
here)

> 
> Hence the capabilities inheritance algorithm of:
> 
> 	pP' = fP | (fI & pI)
> 
> 
>>2. fE is useless.  It doesn't seem to have much of a point, and it just 
>>adds complexity.  (e.g. look at Windows privileges.  they start unenabled, 
>>and programs have to jump through hoops to use them.  I see no security 
>>benefit.) So remove fE entirely.
> 
> 
> It has a lot of point.  It's there for the same reason why just
> because you have the root password, you don't want to run as root all
> the time.  (At least, sane people don't...)  You might make mistakes.
> 
> A very basic rule of security is that you only use the least amount of
> privileges to get the job done.  That way, if you make a mistake, and
> get tricked into accessing the wrong file (say, because you failed to
> check for .. in pathnames supplied by an untrusted user), you limit
> the amount of damage done because of your bone-headed mistake.
> 
> Is this more complexity?  Yes.  But security generally means more
> complexity.  Deal with it.  If you don't like, it you can just always
> run with fE set to fP, just as you just login as root and run with
> root privileges all the time.  As long as you're careful, and never
> accidentally type the command rm -rf /, why bother with non-root
> accounts on a single-user machine?
> 
> (And if you really need help answering that question, then let's just
> agree to disagree, and remind me to never hire you to be a system
> administrator on any of my machines....)

We are both talking about the _file_ effective mask, right?  I 
absolutely agree that pI is needed.

I've been programming Windows for a long time, and windows has a 
capability system.  Essectially, a "privilege" (capability) is either 
present or not present, and, if present, either enabled or disabled. 
This enabled state corresponds to effectiveness in POSIX -- programs can 
freely change it.  All capabilities are disabled by default (almost -- 
there's a pointless exception, of course).  The result is that every 
program that uses a privileged function (e.g. change the time, restart, 
etc.) wraps that call with something that turns enables the capability 
at first, then disables it.  This has no benefit -- a hijacked 
privileged program can still enable them, and the admin never sees this, 
because everything enables them.  I'm not saying that the ability to 
disable capabilities is bad (e.g. single-process file servers absolutely 
require it).

Now let's throw fE into the equation.  Will admins keep a list of which 
programs prefer their capabilities enabled by default?  If I'm an admin, 
and I don't trust a program, I won't give it the capability _at all_. 
Just telling the program "I don't trust you, so please to do 
such-and-such unless you remember to enable the capability first" seems 
useless.  I think a sensible capability system will choose a sane 
default at leave it there.

> 
> 
>>3. The current use of the capability bits is not as fine-grained as it 
>>could be, and lacks the ability to restrict normal users.  
> 
> 
> No.  Bad, bad, bad, bad, bad idea.

I imagined that admins or users would remove almost everything from the 
inheritable mask so that the untrusted program is not given the change 
to screw up.  I'm perfectly willing to drop that part, though.

I think that my proposal for extending super-user capabilities still has 
a lot of value, though.  Things like CAP_SYS_ADMIN are far to wide in 
scope, and I think that can be fixed without breaking old applications.



Andy

