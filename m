Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265429AbRGEUnB>; Thu, 5 Jul 2001 16:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265091AbRGEUml>; Thu, 5 Jul 2001 16:42:41 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:6573 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S265038AbRGEUmk>; Thu, 5 Jul 2001 16:42:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Hua Zhong <huaz@cs.columbia.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] more SAK stuff
Date: Tue, 3 Jul 2001 18:00:50 -0400
X-Mailer: KMail [version 1.2]
Cc: Andries.Brouwer@cwi.nl, andrewm@uow.edu.au, torvalds@transmeta.com,
        tytso@mit.edu, linux-kernel@vger.kernel.org
In-Reply-To: <200107021910.PAA27951@razor.cs.columbia.edu>
In-Reply-To: <200107021910.PAA27951@razor.cs.columbia.edu>
MIME-Version: 1.0
Message-Id: <01070318005005.06999@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 July 2001 15:10, Hua Zhong wrote:
> -> From Alan Cox <alan@lxorguk.ukuu.org.uk> :
> > > (a) It does less, namely will not kill processes with uid 0.
> > > Ted, any objections?
> >
> > That breaks the security guarantee. Suppose I use a setuid app to confuse
> > you into doing something ?
>
> a setuid app only changes euid, doesn't it?

Yup.  And you'd be amazed how many fun little user mode things were either 
never tested with the suid bit or obstinately refuse to run for no good 
reason.  (Okay, I made something like a sudo script.  It's in a directory 
that non-root users can't access and I'm being as careful as I know how to 
be, but I've got a cgi that needs root access to query/set system and network 
configuration.)

Off the top of my head, fun things you can't do suid root:

The samba adduser command.  (But I CAN edit the smb.passwd file directly, 
which got me around this.)

su without password (understandable, implementation detail.  It's always 
suid, being run by somebody other than root is how it knows when it NEEDS to 
ask for a password.  But when I want to DROP root privelidges...  Wound up 
making "suid-to" to do it.)

ps  (What the...?  Worked in Red Hat 7, but not in suse 7.1.  Huh?  "suid-to 
apache ps ax" works fine, though...)

dhcpcd (I patched it and yelled at the maintainer of this months ago, should 
be fixed now.  But a clear case of checking uid when he meant euid, which is 
outright PERVASIVE...).

I keep bumping into more of these all the time.  Often it's fun little 
warnings "you shouldn't have the suid bit on this executable", which is 
frustrating 'cause I haven't GOT the suid bit on that executable, it 
inherited it from its parent process, which DOES explicitly set the $PATH and 
blank most of the environment variables and other fun stuff...)

By the way, anybody who knows why samba goes postal if you change the 
hostname of the box while it's running, please explain it to me.  It's happy 
once HUPed, then again it execs itself.  (Not nmbd.  smbd.  Why does it CARE? 
 And sshd has the most amazing timeouts if it can't do a reverse dns lookup 
on the incoming IP, even if I tell it not to log!)

Apache has a similar problem, and HUP-ing it interrupts in-progress 
transfers, which could be very large files, 'cause it execs itself.  I made 
that happy by telling it its host name was a dot notation IP address, 
although that does mean that logging into a password protected web page using 
the host name forces you to log in twice (again when it switches you to 
http://1.2.3.4/blah...)

Fun, isn't it? :)

Alan's right.  We DO need a rant tag.

Rob
