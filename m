Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423042AbWBAX7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423042AbWBAX7G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 18:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423041AbWBAX7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 18:59:05 -0500
Received: from cantor2.suse.de ([195.135.220.15]:28081 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1423040AbWBAX7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 18:59:04 -0500
X-Sieve: CMU Sieve 2.2
Date: Thu, 2 Feb 2006 00:58:26 +0100
From: Olaf Dabrunz <od@suse.de>
To: Julian Bradfield <jcb@inf.ed.ac.uk>
Cc: Olaf Dabrunz <od@suse.de>
Subject: Re: TIOCCONS security revisited
Message-ID: <20060201235826.GE21756@suse.de>
References: <17374.5399.546606.933186@palau.inf.ed.ac.uk> <20060201172653.GA22700@suse.de> <17377.6410.121318.124897@palau.inf.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17377.6410.121318.124897@palau.inf.ed.ac.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-Feb-06, Julian Bradfield wrote:
> >    the ioctl TIOCCONS allows any user to redirect console output to
> >    another tty. This allows anyone to suppress messages to the console
> >    at will.
> 
> I do not propose returning to this situation.

Your proposal is:

    I propose that a better security test would be:
    user owns /dev/console OR has CAP_SYS_ADMIN .

Who will own /dev/console? It can either be the root user, but then he
has that capability already. Or it can be some "special" user. But this
needs some setup by the root user then, so again root privileges are
needed.

Or you can let the login program or an X-Windows login script change the
ownership of /dev/console to the user who just logged in (as described
in the xterm manpage under option "-C").

Then a normal user who wants to hijack the console messages now logs in
to the machine and simply redirects the console. So your proposal also
"allows anyone to suppress messages to the console" and that is the same
situation that we had before. 

> >[and in a later mail:]
> >    Changing the ownership on /dev/console causes security problems
> >    (that user can usually access the current virtual terminal anytime,
> >    and the current one may not belong to him).
> 
> If this is seen as a problem, it should be fixed in the virtual
> terminal system. /dev/console and TIOCCONS exist and work in many
> Unices, not just Linux.

If you have a fix, go ahead and post it. I just remember this is
difficult. But this is just another problem with TIOCCONS on Linux that
is fixed by the patch. To replace the patch, you need a better fix for
the hijacking problem as well.

> >Also I refered to a security advisory for SunOS which describes one of
> >the problems (hijacking):
> >http://www.cert.org/advisories/CA-1990-12.html
> 
> And how did Sun fix it? They fixed it by restricting TIOCCONS to users
> who have read access to the console - more liberal than my proposal!

Sun's TIOCCONS still redirects the console output. IOW, it still hijacks
the admin's console and redirects it to the user. This is not a viable
solution for machines that routinely have their console on a serial
terminal (and are monitored through them).

One reason why Sun does this is that if they did not redirect the
console output, it would clutter up the local framebuffer and overwrite
(and even scroll) the X-Windows display. Another reason is that Sun's
machines are often not monitored over serial lines, since the default
console is on the local screen.

This is different with mid-range IBM machines, where serial lines are
routinely used to monitor the system.

> >And I said that there are alternatives to /dev/console, and a commonly
> >used one is /dev/xconsole (see below how to use this). It does not have
> 
> I do not have the option of using /dev/xconsole.

If the machines you use lack /dev/xconsole, tell the administrator or
OS vendor to fix this. You may want to mention that it is a much safer
alternative to /dev/console. ;)

> I use machines that I don't administer, and on all of them for the
> last 15 years until the recent breakage, "xterm -C" worked.

Why don't you use xconsole instead?

I do not see the reason why you have to use "xterm -C". If you really
have to, xterm should be fixed as well. Relying on the availability of
/dev/console may not work and - as the xterm manpage points out -
depends on scripts that change the ownership of /dev/console (which has
security implications in itself).

> >syslog/syslog-ng). But it also does not receive the messages that are
> >simply written to /dev/console.
> 
> Exactly. I have an array of programs that write to /dev/console in the
> expectation that the message will be read by the person sitting at the
> console.
> 
> >The latter problem still needs to be fixed, but is seldom a real
> >problem. AFAICS nowadays only scripts that run at boot time write to
> >/dev/console. The user has several ways to look at these messages
> 
> As I have indicated, there is a world outside your experience of
> Linux. As well as my own scripts, the machines one which I work are
> set up to have syslog write urgent messages to /dev/console.

Obvious solutions:
    - Change your scripts. (Why do you use /dev/console for your own
      personal "urgent" messages anyway? /dev/console is meant as a
      system monitor for the operator and the administrator, not as a
      messaging system for normal users. There are other solutions
      better suited to that (logfiles, mails, SMS, ...).)
    - Make a solution available that copies messages from /dev/console
      to some logging facility (and tell the world, because people may
      be interested in it ;) ).

> >If you want this problem fixed, consider copying messages to
> >/dev/console with a demon to a logging facility. Have a look at
> >bootlogd/blogd.
> 
> I do not administer the machines. If you hadn't broken TIOCCONS,
> everything would still work.

TIOCCONS security problems are fixed now. No better solution is
available. Safer alternatives for its functionality are available. I do
not consider this broken.

What may be broken is:

 - No /dev/xconsole: this is a problem of the administrator and/or OS
   vendor -- tell them. If you or they need pointers on how to set up
   /dev/xconsole: have a look at "man syslogd" or at a SUSE system.

 - xterm -C: use xconsole and/or fix xterm

Regards,

-- 
Olaf Dabrunz (od/odabrunz), SUSE Linux Products GmbH, Nürnberg

