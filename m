Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263204AbTEBXbh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 19:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbTEBXbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 19:31:37 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:14048 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263204AbTEBXbf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 19:31:35 -0400
Message-ID: <3EB3026C.604D6F4C@us.ibm.com>
Date: Fri, 02 May 2003 16:42:36 -0700
From: Jim Keniston <jkenisto@us.ibm.com>
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Joe Perches <joe@perches.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Feldman, Scott" <scott.feldman@intel.com>, Greg KH <greg@kroah.com>,
       Janice Girard <girouard@us.ibm.com>, Jeff Garzik <jgarzik@pobox.com>,
       LOS team <losteam@intel.com>, Phil Cayton <phil.cayton@intel.com>,
       Randy Dunlap <rddunlap@osdl.org>, Larry Kessler <kessler@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] Net device error logging
References: <3EB15849.D0E1556D@us.ibm.com>
		 <1051816594.29929.32.camel@localhost.localdomain>
		 <3EB1A718.1084972F@us.ibm.com> <1051894225.2664.62.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches wrote:
> 
> On Thu, 2003-05-01 at 16:00, Jim Keniston wrote:
> > Anyway, we chose not to add a "message level" arg to the netdev_* macros
> > for the following reasons:
> 
> I don't understand these arguments.
> 
> > 1. Support for ETHTOOL_SMSGLVL, using either approach, is by no means
> > universal.
> 
> Would you like there to be some standard universal usage?  I would.
> Why not attempt to agree now?

I'm happy to discuss this.  As I see it, there are at least 4
possibilities:
1. Standardize on the netif_msg_xxx (bit map) approach.
2. Standardize on simple reporting levels (if (debug >= 2)...).
3. Make the driver provide a filtering function, which can do #1, #2 or
some
other driver-specific test.
4. Status quo: make the message-level test before calling netdev_xxx.

The people I've talked to tend to prefer either #1 or #4, although we
haven't
talked much about #2 and #3.  There's also the issue of whether all this
should
be gated by the severity level -- e.g., always log a message that has a
severity
in the range KERN_ERR - KERN_EMERG.

> 
> > 2. Developers who want to do this filtering can continue doing so using
> > "if" statements.
> 
> Developers can still use printk too.
> 
> > 3.  There is a way to specify an optional message level without adding
> > an arg -- namely, the same way you specify an optional severity level
> > using the KERN_* prefixes.
> 
> There are now 4 message call types: netdev_{dbg,err,warn,info}.
> 
> This is exactly like 1 call with an extra argument but for the
> ability to optionally reduce the code size via selective
> #define netdev_xxx(...) do {} while (0)
> 
> The "reduce the macro argument count by optionally embedding an
> argument as string" argument seems hollow.  All new code for
> net elements should allow filtering anyway.

I think message filtering is a good idea.  I also think the following
features
would be useful:
a. Identify which device and driver the message refers to.
b. Call net_ratelimit() in appropriate contexts.
c. Capture caller info (__FILE__ and/or __FUNCTION__).
d. Actually log the severity level.  (I know, this is a syslogd issue.)
e. Standardize certain messages so that all drivers log predictable,
standard
messages (perhaps along with driver-specific info) under certain
circumstances.
e. Capture the messages in a form that is more amenable to automated
analysis
than is plain text.
f. Capture the messages in a form that lends itself to translation (in
user space)
to other languages.

This can all be done.  Most of it has already been implemented and/or
suggested at
one time or another. Message filtering plus a, b, and e require the
caller to
provide additional info.  The other features have other tradeoffs.  Our
experience
with the dev_* macros is that at least some maintainers consider (a)
worth the
tradeoff.  If there's a demand for other features, we are happy to try
to oblige.

> 
> I believe that embedding extra arguments into existing calls via
> things like KERN_* prefixes is poor style but sometimes useful.
> 
> But these netdev_{blah} calls are not existing calls.  These are
> being defined now.  No code already exists that uses them.
> There's no need to design-in poor style.

Jim
