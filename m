Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311890AbSCOBSx>; Thu, 14 Mar 2002 20:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311891AbSCOBSo>; Thu, 14 Mar 2002 20:18:44 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:52147 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S311890AbSCOBS3>; Thu, 14 Mar 2002 20:18:29 -0500
Message-ID: <3C914BC3.2B05C62E@us.ibm.com>
Date: Thu, 14 Mar 2002 17:17:55 -0800
From: Larry Kessler <kessler@us.ibm.com>
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH-RFC] POSIX Event Logging, kernel 2.5.6 & 2.4.18
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian,

I am responding to your comments in reverse order:

> One thing to remember, is that the really hard and important part of
> logging is not the part that can be legislated, or automated, it is
> making sure that the correct events are reported in a accurate manner

I could not agree more, and there has not really been any guidance for
developers about what correct and accurate events are (nor is it clear
that developers would follow the guidance, anyway).  Our focus,
obviously, has been on whether or not the existing logging capabilities 
facilitate the accurate recording of "correct" events.  I will comment
more on that below.

> I understand about POSIX standards, but POSIX standards are not the
> infallible word of of the diety of computing and sometimes are
> completely bogos.

True, but in this case the POSIX standard is not a standard, but 
currently only a draft, and we (the Linux event logging team) have 
been (and are continuing to be) directly involved it its writing,
editing, and (eventual, we hope) adoption as a standard.  Even so,
balloting could lead it into a direction that is contrary to what
is best for Linux, in which case we would drop the "POSIX compliant"
claims and do what's really needed.  I do not expect that to happen,
but you can never tell.

> Instead of adding
> extra kernel functionality, would it not be possible to define a text
> format to messages and some SIMPLE macros, to allow printk's to generate
> the desired information...
> ...it maye be possible to provide some formating guidelines
> and support to printk and some log analysis tools to provide 99%
> solution.

Ok, I am not conceding that your suggestion is "better" than event
logging, but I do like the concept and we have, in fact, been discussing
how to somehow get more information out of printk without asking kernel
maintainers to use a different API.  Specifically, we thought about 
renaming the printk() function and creating a printk macro.  In the
printk macro you would collect source file name, line number and
function name (and maybe some other useful info), and then call the
renamed printk function with the original message plus the additional
stuff (actually we were thinking call posix_log_write() with the orig.
message+addl. info and call the renamed printk with just the original
message).

Is this the sort of thing you had in mind ?

The problem we found is some code like this...

printk("<1>" "And the answer is... %d\n",
#ifdef ONE
1
#else
2
#endif
);

which the compiler/preprocessor rejects.  

Just casually looking I found at least 3 device drivers that log this
way.
Do you think device driver maintainers would be willing to change  
their code to avoid this problem (and the Linux community be willing to 
abandon this style of coding with printks)?

I don't know if you've had a chance to look at the event filtering,
event
notification, and log management utilities that we have in the user lib,
but these work with text-based events, whether printks forwarded to
event 
logging, or messages logged with our new logging functions.  So the user
lib does have some log analysis/processing features like you've
mentioned. 

Another limitation that printk has is that everything has facility of
LOG_KERN.  Don't you think its useful to be able to define a facility of
"XYZ Ethernet 10/100 Device Driver" (which in event logging generates a 
32-bit CRC that gets stored in the event records, and gets converted
back 
to the facility name by the aforementioned utilities)?

I am absolutely open to suggestions for making printk messages better
and more useful--we just haven't figured-out how yet.

Thanks,
Larry Kessler
http://evlog.sourceforge.net/
