Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422674AbWBAR04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422674AbWBAR04 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 12:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422654AbWBAR04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 12:26:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:58247 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030392AbWBAR0z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 12:26:55 -0500
Date: Wed, 1 Feb 2006 18:26:53 +0100
From: Olaf Dabrunz <od@suse.de>
To: Julian Bradfield <jcb@inf.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org, lhofhansl@yahoo.com
Subject: Re: TIOCCONS security revisited
Message-ID: <20060201172653.GA22700@suse.de>
Mail-Followup-To: Julian Bradfield <jcb@inf.ed.ac.uk>,
	linux-kernel@vger.kernel.org, lhofhansl@yahoo.com
References: <17374.5399.546606.933186@palau.inf.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17374.5399.546606.933186@palau.inf.ed.ac.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-Jan-06, Julian Bradfield wrote:
> In August 2004, Olaf Dabrunz posted a patch, which appears to have got
> into 2.6.10, restricting TIOC_CONS to CAP_SYS_ADMIN .
> 
> He justified this by claiming that normal users don't need to grab the
> console output.

I understand that users want to see these messages and I want them to
see these messages. (I did not emphasize this but I believe I never
stated something else.)

The problem is that TIOCCONS causes security problems.

Please rehash what I wrote in the thread. Essentially, these are my
points (citing myself here):

    the ioctl TIOCCONS allows any user to redirect console output to
    another tty. This allows anyone to suppress messages to the console
    at will.

[and in a later mail:]

    Changing the ownership on /dev/console causes security problems
    (that user can usually access the current virtual terminal anytime,
    and the current one may not belong to him).

Also I refered to a security advisory for SunOS which describes one of
the problems (hijacking):

http://www.cert.org/advisories/CA-1990-12.html

And I said that there are alternatives to /dev/console, and a commonly
used one is /dev/xconsole (see below how to use this). It does not have
the security problems and has other advantages (configurable via
syslog/syslog-ng). But it also does not receive the messages that are
simply written to /dev/console.

The latter problem still needs to be fixed, but is seldom a real
problem. AFAICS nowadays only scripts that run at boot time write to
/dev/console. The user has several ways to look at these messages
already (including watching the "console" window during boot or looking
at /var/log/boot.msg).

If you want this problem fixed, consider copying messages to
/dev/console with a demon to a logging facility. Have a look at
bootlogd/blogd.

> I disagree. Normal users log into the desktop of their machine, and
> should expect to be able to see the console output just as much as if
> they logged into "the console" and worked without graphics.
> For example, I want to know when the machine I'm working on has
> problems, when somebody is probing sshd, and simply when one of my
> batch jobs wants to tell me something.

All this can be done by using /dev/xconsole.

> Further, on our systems, I own the console (ownership is transferred
> to the user by the login procedure), so it's daft that I can't call TIOCCONS
> on it.

Changing ownership of /dev/console is part of the security problem. But
you can do that with /dev/xconsole.

> I propose that a better security test would be:
> user owns /dev/console OR has CAP_SYS_ADMIN .
> 
> It should then be the responsibility of the log-out procedure to
> cancel redirections when it changes the ownership of devices back to
> root.
> 
> In December '04, Lars posted about this breakage, and proposed a
> simpler patch, allowing general TIOCCONS but restricting cancellation

Lars reported that xconsole breaks and proposed to simply revert the
kernel patch. His patch does not fix the security problems, it just
reverts to the old known-broken state.

Xconsole fails because by default it tries to use /dev/console. You can
avoid that by setting the resources to point to another file, e.g.
/dev/xconsole:

/usr/X11R6/lib/X11/app-defaults/XConsole:
XConsole.file:          /dev/xconsole

Alternatively, you can use "xconsole -file /dev/xconsole".

When my TIOCCONS kernel patch is applied, xconsole should never try to
use /dev/console. We fixed this by putting the code that checks for
/dev/console into an #if in xconsole.c:OpenConsole():

#if !defined(linux)
           if (!stat("/dev/console", &sbuf) &&
               (sbuf.st_uid == getuid()) &&
               !access("/dev/console", R_OK|W_OK))
#endif

Later on in the code we use /dev/xconsole as the default.

-- 
Olaf Dabrunz (od/odabrunz), SUSE Linux Products GmbH, Nürnberg

