Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261898AbVCOV6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbVCOV6A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 16:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbVCOV6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 16:58:00 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28944 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261898AbVCOV5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 16:57:25 -0500
Date: Tue, 15 Mar 2005 21:57:20 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Chris Wright <chrisw@osdl.org>
Cc: Alexander Nyberg <alexn@dsv.su.se>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: Capabilities across execve
Message-ID: <20050315215719.A12283@flint.arm.linux.org.uk>
Mail-Followup-To: Chris Wright <chrisw@osdl.org>,
	Alexander Nyberg <alexn@dsv.su.se>, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <1110627748.2376.6.camel@boxen> <20050313032117.GA28536@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050313032117.GA28536@shell0.pdx.osdl.net>; from chrisw@osdl.org on Sat, Mar 12, 2005 at 07:21:17PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2005 at 07:21:17PM -0800, Chris Wright wrote:
> * Alexander Nyberg (alexn@dsv.su.se) wrote:
> > This makes it possible for a root-task to pass capabilities to
> > nonroot-task across execve. The root-task needs to change it's
> > cap_inheritable mask and set prctl(PR_SET_KEEPCAPS, 1) to pass on
> > capabilities. 
> 
> This overloads keepcaps, which could surprise to existing users.

Chris,

Since you seem to be knowledgeable about the capability system, I have
a question.

As part of the libcap library (found on Fedora and such like), there are
several programs supplied with it - execcap and sucap for instance:

usage: execcap <caps> <command-path> [command-args...]

  This program is a wrapper that can be used to limit the Inheritable
  capabilities of a program to be executed.  Note, this wrapper is
  intended to assist in overcoming a lack of support for filesystem
  capability attributes and should be used to launch other files.
  This program should _NOT_ be made setuid-0.

usage: sucap <user> <group> <command-path> [command-args...]

  This program is a wrapper that change UID but not privileges of a
  program to be executed.
  Note, this wrapper is intended to assist in overcoming a lack of support
  for filesystem capability attributes and should be used to launch other
  files. This program should _NOT_ be made setuid-0.

At some point, I decided I'd like to run a certain program non-root
with certain capabilities only.  I looked at the above two programs
and stupidly thought they'd actually allow me to do this.

However, the way the kernel is setup today, this seems impossible to
achieve, which tends to make the whole idea of capabilities completely
and utterly useless.

How is this stuff supposed to work?  Are my ideas of what's supposed
to be achievable completely wrong, although they look completely
reasonable to me.

Don't get me wrong - the capability system seems great at permanently
revoking capabilities via /proc/sys/kernel/cap-bound, and dropping
them within an application provided it remains UID0.  Apart from that,
capabilities seem completely useless.

For example:

bash-2.05a# execcap all-ep /bin/sh -c 'getpcaps $$'
Capabilities for `5036': =ep cap_setpcap-ep

Note carefully that the requested capabilities haven't been granted:

capset(0x19980330, 0, {, , })           = 0
execve("/bin/sh", ["/bin/sh", "-c", "getpcaps $$"], [/* 19 vars */]) = 0

The reason this happens is that we're still running UID0, and UID0 on
execve appears to re-gain all privileges.  This is fine of you're
running in compatibility mode.  So, in order to do this, we want to
drop from UID0 _first_ and then play around with capabilities.  Great,
we have the sucap program to do that for us.  So we can do:

	sucap rmk rmk execcap <capabilities> program args

Or can we?

bash-2.05a# sucap rmk rmk /bin/sh -c 'getpcaps $$'
Caps: =ep cap_setpcap-ep
Caps: =
[debug] uid:501, real uid:501
sucaps: capsetp: Operation not permitted
sucap: child did not exit cleanly.

Oh dear, I guess sucap doesn't work after all.  (It forks a child
process, the parent then switches UID, the child then tries to
capsetp() the parent - which of course won't work without the
cap_setpcap.  Since the kernel never grants this capability in the
first place to *anyone*... it seems to be something of a lost cause.

Don't get me wrong - the current behaviour is secure.  But it's so
secure that it gets in the way of things which should appear to work.

I forget precisely what I wanted to achieve with this, and why I
couldn't just make the program do it itself...  It may have been a
script running from cron periodically which needed just one or two
capabilities in order to operate, rather than the whole truck load
you get by running it as root.  What I do remember is that my goal
of running the script with minimal capabilities was completely
*impossible* to achieve.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
