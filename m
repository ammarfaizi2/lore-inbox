Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261579AbSKCD3f>; Sat, 2 Nov 2002 22:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261581AbSKCD3f>; Sat, 2 Nov 2002 22:29:35 -0500
Received: from mail.gurulabs.com ([208.177.141.7]:47513 "EHLO
	mail.gurulabs.com") by vger.kernel.org with ESMTP
	id <S261579AbSKCD3a>; Sat, 2 Nov 2002 22:29:30 -0500
Date: Sat, 2 Nov 2002 20:36:01 -0700 (MST)
From: Dax Kelson <dax@gurulabs.com>
X-X-Sender: dkelson@mooru.gurulabs.com
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Rusty Russell <rusty@rustcorp.com.au>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "davej@suse.de" <davej@suse.de>
Subject: [REPORT] current use of capabilities
In-Reply-To: <Pine.GSO.4.21.0211022114280.25010-100000@steklov.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0211021929040.20616-100000@mooru.gurulabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The principle of least privilege says that instead of a system full of 
binaries running as root, we should have a system of binaries running as 
non-root with only the capabilities they need.

The typical break-in involves gaining non-root access first, then doing a 
privilege escalation attack to gain root. A system using capabilities 
makes the escalation attack must more difficult.

How are we currently doing? The following (pathetically short list of)  
binaries use capabilities:

vsftpd
ntptimeset
ntpdate
ntpd
named

What are the potential users of capabilities?

47 SUID root binaries (EVERYTHING install of Red Hat Linux 8.0)

Filesystem capabilities support could take care of these SUID root 
binaries. Historically, SUID root binaries have been heavily used in 
privilege escalation attacks.

How about daemons that are launched as root?  These could be potential 
users of capabilities + drop root right now.  

There is a snag though. When non-root binaries (eg, daemons running as
non-root but with capabilities) execve(), all capabilities are cleared, so
if some of these daemons need to exec other binaries with certain
capabilities, it currently won't work.

"ps aux | grep root" to take a look.  We see stuff like:

syslogd 
cardmgr
apmd
smartd
xinetd
dhclient
gpm
crond
cupsd
anacron
rhnsd
login
mingetty
X

This is not an exhaustive list. The system I checked was not running many 
daemons.

In summary, there is lots that could be done today to secure daemons. The
clearing of capabilities on exec by non-root binaries needs be addressed
(I posted a patch in May 2002).  File system capabilities support can
fix the large amount of SUID root binaries that exist.  OpenBSD 3.2 
(just released) has started to implement a similar technique to get rid 
of SUID root binaries.

Once filesystem capabilities is added to the kernel, RPM and DPKG should
be fixed so that, otherwise SUID root binaries, can be installed with
capabilities support automatically. 

This should be the vendors / package maintainers job. The average sysadmin 
should get the benefits without having to think about it.

Dax Kelson

