Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbTIQR7n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 13:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbTIQR7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 13:59:43 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:55530 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262605AbTIQR7k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 13:59:40 -0400
Message-ID: <3F68A008.12EF3AC1@us.ibm.com>
Date: Wed, 17 Sep 2003 10:55:20 -0700
From: Jim Keniston <jkenisto@us.ibm.com>
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: "Feldman, Scott" <scott.feldman@intel.com>
CC: LKML <linux-kernel@vger.kernel.org>, netdev <netdev@oss.sgi.com>,
       Jeff Garzik <jgarzik@pobox.com>, Larry Kessler <kessler@us.ibm.com>,
       Greg KH <greg@kroah.com>, Randy Dunlap <rddunlap@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       David Brownell <david-b@pacbell.net>,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH] Net device error logging, revised
References: <C6F5CF431189FA4CBAEC9E7DD5441E010124F051@orsmsx402.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Feldman, Scott" wrote:
> 
> > 3. A new macro, netdev_fatal, is included.  Given the call
> >         netdev_fatal(dev, HW, "NIC fried!\n");
> > the indicated message is always logged: the msglevel arg (HW, in this
> > case) is NOT consulted.  In fact, the msglevel arg to netdev_fatal
> > is ignored in this implementation.  (As previously discussed, in some
> > future implementation, the msglevel could be logged to help indicate
> > the circumstances under which the event was logged.)
> 
> I couldn't find the previous discussion on netdev_fatal, so sorry if
> this has already been worked out.  It uses KERN_ERR; did you mean
> something stronger?  If not, why not just use netdev_err(dev, ALL,
> "...")?  What is the situation in the driver where we'd want to use
> _fatal?  How do I know when to use _fatal and when to use _err?
> 
> -scott

Good question.  There was a discussion thread where somebody pared down
the cc list (no LKML, no netdev, an apparently no Scott).  I saved most
of the messages, and can send them along to you if you want.

Anyway, in support of passing the NETIF_MSG_* msglevel as an arg to the 
netdev_* macros, I said that it...
> also opens the door for logging more clearly what part of the driver (PROBE,
> TX, RX, etc.) the message comes from.

David Brownell replied:
> This is a different issue.  Why wouldn't it be enough
> to have unique messages?

I replied:
> First, I don't want acceptance of the netdev_* idea to hinge on this
> minor issue.  Everything below is blue(r) sky...
>
> That said, it could be useful for an error-analysis utility to know that
> the message is (say) a WARNING categorized as an RX_ERR, especially if the
> utility hasn't been configured to recognized that specific message string.
> That's probably info that wouldn't come to you via printk (e.g., since
> syslog discards the severity level), but could come via another logging
> or monitoring system that plugs in (along with printk) via netdev_*.
>
> One problem with this idea is that, as I read Becker's document
> (URL above), "fatal" errors should always be logged, and therefore
> not tagged as PROBE, TX_ERR, etc.  If we wanted to pursue this idea,
> we could implement
>         netdev_fatal(dev, PROBE, "...")
> which logs the message unconditionally (KERN_ERR) and categorizes it as
> a PROBE error.

Jeff Garzik replied:
> printk'ing probe errors is definitely something I want to encourage.
> Probe errors are the most visible indication of what went wrong, if the
> driver fails to load.  These are the messages that help developers
> figure out the problem.  So I like the direction you suggest, in "If we
> wanted to pursue[...]"

In summary, the idea for netdev_fatal() is based on the idea that the msglevel
arg can not only be used for verbosity control, but can be logged as yet
another useful piece of info.  For printk-based logging, it could easily be
added to the message prefix:
	eth2: PROBE: Invalid Ethernet address
If you log this message using
	netdev_err(dev, PROBE, "Invalid Ethernet address\n")
it will be logged only if the PROBE flag is set in the msg_enable bitmap.
If you log it using
	netdev_fatal(dev, PROBE, "Invalid Ethernet address\n")
it will always be logged.

As mentioned above, I don't think the netdev_fatal idea is central to the
whole netdev_printk idea.

By the way, regarding using KERN_ERR vs. something stronger: It's pretty
unusual for a driver to log anything as KERN_CRIT or worse -- presumably
due to a desire not to overreact if the nth of n redundant devices happens
to fail.  So unless we can agree on a definition of KERN_CRIT (e.g., it
applies to any failure that makes a device unavailable pending human
intervention), I'd prefer to steer clear of that.

Jim
