Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317962AbSGLBPs>; Thu, 11 Jul 2002 21:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317963AbSGLBPr>; Thu, 11 Jul 2002 21:15:47 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:47505 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317962AbSGLBPq>;
	Thu, 11 Jul 2002 21:15:46 -0400
Message-ID: <3D2E2E35.9C0135C0@us.ibm.com>
Date: Thu, 11 Jul 2002 18:17:41 -0700
From: Larry Kessler <kessler@us.ibm.com>
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: kessler@us.ibm.com
Subject: [PATCH-RFC] Enhanced printk with event logging, kernel 2.4.18
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1) Please cc: kessler@us.ibm.com on your replies.
2) Please refer to the following for many more details:
    http://evlog.sourceforge.net/enhanced_printk.html

In response to the original posting...

http://www.uwsg.iu.edu/hypermail/linux/kernel/0204.1/0161.html

with subject "Event Logging vs enhancing printk", the following patches 
are being provided for your comments:
 
http://unc.dl.sourceforge.net/sourceforge/evlog/evlog-1.4.0_kernel2.4.18.patch
http://unc.dl.sourceforge.net/sourceforge/evlog/evlog_printks2.4.18.patch

The first of these patches provides the enhanced printk feature (a 
description follows), and the second one modifies various source files
to allow printk() to be implemented as a macro, which is required by
the enhanced printk feature.  


Goals...

The short-term goal here is to make the most use out of existing 
printk()s, of which there are 10s of thousands, without forcing a 
mass migration to a new logging interface and without modifying
in anyway what's being written to /var/log/messages, etc.

whereas... 

the longer-term goal is to offer some alternatives to printk, which 
are still as simple to use but ensure that a minimum standard set of
useful information is always recorded, and whose use by developers
can be phased-in over time.


Summary of Features...

1) If the "enhanced printk" feature and associated event logging 
   are NOT enabled during kernel config (both are disabled by default),
   the original printk() function is called and the code path is
   the same as before (well, almost...some printk code was moved into
   vprintk() to facilitate the enhanced printk option).
   Also, no additional message/event buffering is allocated.

2) If the feature is ENABLED during kernel config--
   * a static buffer is created (size is set during kernel config)
   * printk() is re-defined to be a macro, which... 
     (1) writes the unaltered, formatted printk string to the printk
         ring buffer (as before); and,
     (2) creates an event record consisting of the original printk
         string, caller's location info (source file name, function 
         name, and line number), and some "standardized" attributes 
         (for example, a flag is set if printk was called from interrupt
         context),  and the event record is written to the newly
         added buffer.   
   * A checksum (CRC32) of source file name, function name, and original 
     printk() format string is stored in the event record.  This will be
     useful later on (see Future Enhancements below).    
     
3) The second of the 2 patches affects 28 source files in 2.4.18 and
   changes this coding style:

   printk("generic options"
# ifdef AUTOPROBE_IRQ
	"AUTOPROBE_IRQ"
# else
	"AUTOSENSE"
# endif
	);
to:

# ifdef AUTOPROBE_IRQ
   printk("generic options"     "AUTOPROBE_IRQ");
# else
   printk("generic options"	"AUTOSENSE");
# endif

thus allowing printk() to be defined as a macro.

4) Userspace daemons and commands are available to read events from 
   the event buffer, write them to a log file, customize displays,
   etc. as described at http://evlog.sourceforge.net/.  evlog-1.4.0
   is needed for enhanced printk, along with these 2 patches.
   For example, here is an event displayed with the evlview command
   with default formatting:

  recid=505, size=93, format=BINARY, event_type=0xd175d27e, 
  facility=KERN, severity=NOTICE, uid=root, gid=root, pid=1, pgrp=0, 
  time=Wed 12 Jun 2002 12:17:55 PM PDT, flags=0x22 (KERNEL|PRINTK),
  thread=0x0, processor=1
  ide-probe.c:init_irq:738
  ide0 at 0x1f0-0x1f7,0x3f6 on irq 14  

   Note that event_type displays the checksum described above.


Future Enhancements...

Instead of applying the varargs to the format string in the kernel, you
could keep them separate when creating the event record.  Then, the
evlview command could read the event record from the log and do one of 
the following:
1)  printf-style formatting with the original format string, just like
    printk 
or, to support multiple languages...
2a) Use the checksum (described above) to look-up the 
    non-english format string (similar to the catgets approach).
or
2b) Use the format string to look-up its non-english equivalent in
    a message catalog (similar to the gettext approach).

Additionally, the individual variables in the varargs list could be 
referenced by name (once they are named in formatting templates, 
another feature of event logging in userspace) to read and display 
only specific events from the log; or, for notifying an application
(for example, when a particular network interface has errors).
