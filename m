Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbVCOWpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbVCOWpq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 17:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVCOWo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 17:44:57 -0500
Received: from fire.osdl.org ([65.172.181.4]:58018 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262053AbVCOWmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 17:42:35 -0500
Date: Tue, 15 Mar 2005 14:42:19 -0800
From: Chris Wright <chrisw@osdl.org>
To: Chris Wright <chrisw@osdl.org>, Alexander Nyberg <alexn@dsv.su.se>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Capabilities across execve
Message-ID: <20050315224219.GA5389@shell0.pdx.osdl.net>
References: <1110627748.2376.6.camel@boxen> <20050313032117.GA28536@shell0.pdx.osdl.net> <20050315215719.A12283@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050315215719.A12283@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Russell King (rmk+lkml@arm.linux.org.uk) wrote:
> At some point, I decided I'd like to run a certain program non-root
> with certain capabilities only.  I looked at the above two programs
> and stupidly thought they'd actually allow me to do this.
> 
> However, the way the kernel is setup today, this seems impossible to
> achieve, which tends to make the whole idea of capabilities completely
> and utterly useless.

Yes, the only value of capabilities right now is for a single program
that starts off as root with full caps to drop uid and caps.

> How is this stuff supposed to work?  Are my ideas of what's supposed
> to be achievable completely wrong, although they look completely
> reasonable to me.

It was meant to work with capabilities in the filesystem like setuid bits.
So the patches that have floated around from myself, Andy Lutomirski
and Alex Nyberg are attempts to make something half-way sane out of the
mess.  The trouble is then convincing yourself that it's not some way to
leak capabilities (esp. since some programs use the interface already,
like bind9).

> Don't get me wrong - the capability system seems great at permanently
> revoking capabilities via /proc/sys/kernel/cap-bound, and dropping
> them within an application provided it remains UID0.  Apart from that,
> capabilities seem completely useless.

It doesn't have to remain uid0.  That's what the prctl PR_SET_KEEPCAPS does.
But it's not a nice interface, nor simple to use (for example, it'll
drop the effective set, so you have to reinstate them).

> For example:
> 
> bash-2.05a# execcap all-ep /bin/sh -c 'getpcaps $$'
> Capabilities for `5036': =ep cap_setpcap-ep
> 
> Note carefully that the requested capabilities haven't been granted:
> 
> capset(0x19980330, 0, {, , })           = 0
> execve("/bin/sh", ["/bin/sh", "-c", "getpcaps $$"], [/* 19 vars */]) = 0
> 
> The reason this happens is that we're still running UID0, and UID0 on
> execve appears to re-gain all privileges.  This is fine of you're
> running in compatibility mode.  So, in order to do this, we want to
> drop from UID0 _first_ and then play around with capabilities.  Great,
> we have the sucap program to do that for us.  So we can do:
> 
> 	sucap rmk rmk execcap <capabilities> program args
> 
> Or can we?
> 
> bash-2.05a# sucap rmk rmk /bin/sh -c 'getpcaps $$'
> Caps: =ep cap_setpcap-ep
> Caps: =
> [debug] uid:501, real uid:501
> sucaps: capsetp: Operation not permitted
> sucap: child did not exit cleanly.
> 
> Oh dear, I guess sucap doesn't work after all.  (It forks a child
> process, the parent then switches UID, the child then tries to
> capsetp() the parent - which of course won't work without the
> cap_setpcap.  Since the kernel never grants this capability in the
> first place to *anyone*... it seems to be something of a lost cause.

Yes, that's the core of the issue.  If you exec a uid0 process you get
all caps, otherwise you lose all caps.  And cap_setpcap was removed when the
sendmail exploit came out, so it's further crippled.

> Don't get me wrong - the current behaviour is secure.  But it's so
> secure that it gets in the way of things which should appear to work.
> 
> I forget precisely what I wanted to achieve with this, and why I
> couldn't just make the program do it itself...  It may have been a
> script running from cron periodically which needed just one or two
> capabilities in order to operate, rather than the whole truck load
> you get by running it as root.  What I do remember is that my goal
> of running the script with minimal capabilities was completely
> *impossible* to achieve.

All I can say is work is underway.  There's 3 different patches that
will get you to your goal.  I understand that it's a real pain right now.
One of the authors of the withdrawn draft has told me that the notion of
capabilities w/out filesystem support was considered effectively useless.
So, we're in uncharted territory.  BTW, thanks for reminding me of
scripts, I had been testing just C programs.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
