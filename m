Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWDXNL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWDXNL6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 09:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWDXNL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 09:11:57 -0400
Received: from stanford.columbia.tresys.com ([209.60.7.66]:18638 "EHLO
	gotham.columbia.tresys.com") by vger.kernel.org with ESMTP
	id S1750742AbWDXNL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 09:11:56 -0400
Message-ID: <444CCE83.90704@gentoo.org>
Date: Mon, 24 Apr 2006 09:11:31 -0400
From: Joshua Brindle <method@gentoo.org>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Chris Wright <chrisw@sous-sol.org>,
       James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>	<1145470463.3085.86.camel@laptopd505.fenrus.org>	<p73mzeh2o38.fsf@bragg.suse.de>	<1145522524.3023.12.camel@laptopd505.fenrus.org>	<20060420192717.GA3828@sorel.sous-sol.org>	<1145621926.21749.29.camel@moss-spartans.epoch.ncsc.mil>	<20060421173008.GB3061@sorel.sous-sol.org>	<1145642853.21749.232.camel@moss-spartans.epoch.ncsc.mil> <17484.20906.122444.964025@cse.unsw.edu.au>
In-Reply-To: <17484.20906.122444.964025@cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: avast! (VPS 0616-4, 04/21/2006), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> On Friday April 21, sds@tycho.nsa.gov wrote:
>>
>> Access control of any form requires unambiguous identification of
>> subjects and objects in the system.   Paths don't achieve such
>> identification.  Is that broken enough?  If not, what is?  What
>> qualifies as broken?
>>     
>
> I have to disagree with this.  Paths *do* achieve unambiguous
> identification of something.  That something is ..... the path.
>
>   
On the contrary. Due to namespaces a single path can describe many 
different files, depending on the namespace you are in. Same with 
chroots, if an app that is chrooted can read /etc/shadow it can also 
read it outside the chroot. Even if this weren't the case the path isn't 
the object. Objects are 'things' being acted upon by a subject. A path 
is merely an address to an object. A burglar might use your address to 
get to your house but in the end it's your house he's robbing, not the 
address.

> Think about the name of this system for a minute.  "AppArmor".
> i.e. it is Armour for an Application.  It protects the application.
> It doesn't (as far as I can tell: I'm not an expert and don't work on
> this thing) claim to protect files.  It protects applications.
>   
A large part of protecting applications is protecting which apps can 
interact with those applications, directly or indirectly. Without the 
ability to look at the policy and know if its actually doing what you 
think it is (which you can't with path based access control) you have no 
way of telling whether an application is actually protected. This leads 
to false sense of security.

Another large part of protecting applications is protecting the system 
which supports them. The apparmor crowd will claim that these apps are 
trusted but there are many ways a confined application can indirectly 
influence an unconfined application and most privilege escalation 
attacks are multi-step already thus buying little.

> It protects them from doing the wrong thing - from doing something
> they weren't designed to do.  i.e. it protects them from being
> subverted by exploiting a bug.
>
> A large part of the behaviour of an application is the path names that
> it uses and what it does with them.  If an application started doing
> unexpected things with unexpected paths (e.g. exec("/bin/sh") or
> open("/etc/shadow",O_RDONLY)) then this is a sure sign that it has
> been subverted and that AppArmor need to protect it, from itself.
>
>   
Sure but if, instead, it's able to open /var/chroot/etc/shadow which is 
a hardlink to /etc/shadow you've bought nothing. You may filter out 
worms and script kiddies this way but in the end you are using obscurity 
(of filesystem layout, what the policy allows, how the apps are 
configured, etc) for security, which again, leads to a false sense of 
security.
> Obviously the protection will not be complete.  The profiles describe
> what the application is expected to do, and to some extent, this
> description will be in general terms.  It might identify files that
> can be written to, but not what will be written to them. etc.
>
> While the protection against subversion cannot be complete, it can be
> sufficient to dramatically reduce the chances of privilege
> escalation.   There are lots of wrong things you can get an
> application to do once you find an exploitable bug.  Many of these
> will lead to a crash.  AppArmor will not try to protect against these
> (I suspect).  There are substantially fewer that lead to privilege
> escalation.   AppArmor focusses its effort in terms of profile design
> on exactly these sorts of unplanned behaviours.
>
>   
It only reduces the chance to inexperienced and/or lazy hackers ;) . It 
wouldn't take someone experienced to figure out that you have apparmor  
running on the system and thus know how to break/bypass it. Once again, 
false sense of security.
> So I think you still haven't given convincing evidence that AppArmor
> is broken by design.
>   
I haven't heard any responses to any of the ~11ish points brought up at 
http://securityblog.org/brindle/2006/04/19/security-anti-pattern-path-based-access-control/ 
. Its very long but I can paste it into an email if necessary.

In particular I'd love to hear about how Apparmor is so easy to use, 
considering the apparmor crowd advocates things like making hardlinks to 
/bin/bash and setting that new path to a 'restricted' users login shell. 
This is not obvious, secure, scalable or intuitive. I'd hope most 
administrators recognize the severe limitations of this 'solution' and 
opt for something stronger.

Joshua Brindle
