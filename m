Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbTDIXU7 (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 19:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263849AbTDIXU7 (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 19:20:59 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:31942 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263861AbTDIXU5 (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 19:20:57 -0400
Message-ID: <3E94AD48.B2E91CF9@us.ibm.com>
Date: Wed, 09 Apr 2003 16:31:20 -0700
From: "Jim Keniston[UNIX]" <jkenisto@us.ibm.com>
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: kernel support for non-english user messages
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm one of those IBM guys who has been working on ideas for enhanced
error/event logging in Linux.  As part of this work, we've developed
ideas for I18N of event-log messages.  Here are some observations:

Most developers are comfortable with printk.  Whatever approach you
take, the closer you stay to printk in the programmatic interface, the
more likely you are to gain acceptance.

Kernel messages need to be logged in English.  By application of message
catalogs or similar techniques, they can also be made available in other
languages.  Translation to other languages should be done when the log
is viewed.

If you're serious about I18N, you must keep a message's format string 
distinct from the arg list.  Your event-log viewer combines them all for
you, using the desired language.  For example, given the message
	printk(KERN_INFO "link up, %d Mbps, %s-duplex\n", speed, duplex);
you log the format string and the values of speed and duplex as separate
attributes in the event log.  If/when you compute a hash, it's on the
format string (and possibly on the function name and/or source-file
name, to provide more context).

Note that if you're particularly brave and/or stingy, you don't even
have
to log the format string, just the hash.  The event-log viewer can fetch
the format string given the hash.

As the above suggests, a structured event log (see, for example,
evlog.sourceforge.net) lends itself more readily to manipulation and
analysis than does a simple text file.

We've come up with a couple of ways of generating message catalogs
automatically.  The method we prefer captures information about each
printk* at compile time, and stores it in the .log section of the .o
file.  A post-processor then reads all the .o files and generates a sort
of catalog entry for each printk call.  The .log sections are stripped
out when the bzImage is created.  [*This technique requires some macro
fussing.  For reasons I won't go into, the macro is NOT called "printk",
so this feature doesn't come for free.]

There are tens of thousands of printk calls in Linux.  This has several
implications:

- Inertia is a major factor.

- If we use 32-bit hash codes, there's a real chance of different
messages
yielding the same hash code.  We take the approach that each subsystem
(e.g., each device driver) gets its own facility code (i.e., not KERN
for everybody).  If you key on hash code AND facility, the chance of
collisions is very small.

- Although I believe it's worthwhile to categorize messages and tag them
accordingly -- e.g., "hardware failure: <description of problem>" or
"configuration note: <whatever>" -- most of the existing printk messages
contain very context-specific info, and couldn't be entirely replaced
with standard messages without loss of useful info.

Jim Keniston
IBM Linux Technology Center
