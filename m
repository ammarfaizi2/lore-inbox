Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265268AbUGBAUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265268AbUGBAUc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 20:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265953AbUGBAUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 20:20:32 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:1178 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265268AbUGBAU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 20:20:28 -0400
Date: Thu, 1 Jul 2004 16:06:14 -0500
From: linas@austin.ibm.com
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.6] PPC64: log firmware errors during boot.
Message-ID: <20040701160614.I21634@forte.austin.ibm.com>
References: <20040629191046.Q21634@forte.austin.ibm.com> <16610.39955.554139.858593@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16610.39955.554139.858593@cargo.ozlabs.ibm.com>; from paulus@samba.org on Wed, Jun 30, 2004 at 08:55:15PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2004 at 08:55:15PM +1000, Paul Mackerras wrote:
> Linas,
> 
> > Firmware can report errors at any time, and not atypically during boot.
> > However, these reports were being discarded until th rtasd comes up,
> > which occurs fairly late in the boot cycle.  As a result, firmware
> > errors during boot were being silently ignored. 
> 
> As far as I can see the main change is in log_rtas_len, which is
> called from pSeries_log_error, which is called from do_event_scan and
> rtasd(), and do_event_scan is only called from rtasd().  And
> get_eventscan_parms() is already called at the beginning of rtasd().

Yes, but rtasd starts up late in the book process.  Most of the 
"interesting" manipulations with firmware are old history by then,
and thus, any firmware errors encountered during the boot were never 
logged.

> So I don't see the point of the get_eventscan_parms call in
> log_rtas_len.  

If the parms aren't set up, then the rtas_error_log_max is zero,
and, as a result, the message is never logged.  By initializing
rtas_error_log_max to the correct non-zero value, the errors can 
get logged.


> > This patch at least gets them printk'ed so that at least they show 
> > up in boot.msg/syslog.  There are two other logging mechanisms,
> > nvram and rtas, that I didn't touch because I don't understand 
> > the reprecussions.  In particular, nvram logging isn't enabled
> > until late in the boot ... but what's the point of nvram logging
> > if not to catch messages that occured very early in boot ?? 
> 
> Indeed.
> 
> As for printk'ing the errors, it is annoying and it seems of somewhat
> dubious benefit to me, given that it is just incomprehensible hex
> numbers that can go on and on.  There has to be a better way.  

Yes, well, you'll be hard-pressed to find a lover of the hex format 
anywhere.  Lets review the history of the design decisions that
got us to this point.  I think a better solution might then become
evident.

-- Originally, these binary messages from firmware were decoded
in the kernel, and printed out in 'plain english'.  However, there
were problems: 1) the format of the binary kept evolving; I think 
we are now up to version 6.  2) the need for supporting version 6 
and *all* of the earlier versions lead to dreaded kernel bloat.
For the current user-space decoder:
# wc *.c *.h
   2207    7056   67959 total

-- So the decision was wisely made to move this all to user-space. 
But what shall the communications link between user-space and kernel be? 
Somebody, somewhere,  I know not who or why, decided that they should 
go into syslog.  And so here we are.

How else could we do this?  I have never had to architect a kernel-to-user
data communications interface, so I don't know what the alternatives 
are.  We could queue them up to some file in /proc, which user-space 
reads.  Or maybe /sys instead ?? Maybe a stunt with sockets? Some 
new device in /dev/ that can be opened, read, closed?  How should 
the user space daemon indicate that its picked up the message and 
doesn't need it any more?  Write a msg number to a /proc file?  
Maybe each individual message should go in its own file, and user 
space just rm's that file after its fetched/saved the message.  
I dunno, I think any one of these could be whipped up in a jiffy.
Convincing the user-space to use the interface might be harder.

Pick one. If it can be coded in under a day, I can volunteer to
do that.

> Putting
> it in nvram seems like a better option to me.  I don't know of any
> reason why we can't use nvram quite early on.

Me neither, Jake knows. I thought the whole point of nvram was to not
loose the messages during crash; the messages are promtly copied out
of nvram once the system is up and stable; nvram is a staging area, 
not a permanent repository.

--linas
