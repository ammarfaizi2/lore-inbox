Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288762AbSADVHf>; Fri, 4 Jan 2002 16:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288763AbSADVHU>; Fri, 4 Jan 2002 16:07:20 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:40343 "EHLO
	zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S288766AbSADVGo>; Fri, 4 Jan 2002 16:06:44 -0500
Message-ID: <3C361AAC.EB9570B9@nortelnetworks.com>
Date: Fri, 04 Jan 2002 16:12:12 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel log messages using wrong timezone
In-Reply-To: <3C360D22.F6FFFAD6@nortelnetworks.com> <20020104135129.Q12868@lynx.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> On Jan 04, 2002  15:14 -0500, Chris Friesen wrote:
> > How does the kernel figure out how to timestamp the log output?
> > The reason I'm asking is that we have a system that has /etc/localtime
> > pointing to the Americas/Montreal timezone, but the log output from the
> > kernel appears to be UTC.
> 
> The kernel doesn't timestamp the logs, AFAIK.  That is done by syslog when
> it writes the logs to disk.  If you check "dmesg" output - no timestamps.

Hmm...good point.  However, I should clarify that userspace logs are being
corrected for timezone, but kernel logs are not. For userspace apps the
timestamping is done in the glibc syslog() call, so now I need to figure out
where it's done for the kernel.

> > Can anyone point me to the right place to deal with this?
> 
> Restart syslog so that it notices the new timezone, or something else, I
> don't know.  IIRC, you are the one doing strange things with syslog.
> Are you doing network syslog logging now?  Are both of your hosts running
> with the same timezone?

I always was logging remotely, but we wanted to log to NFS-mounted files as well
without hanging the userspace apps when NFS borked.

What I ended up doing was to fork syslog and set up a sysV message queue between
the parent and child.  The child does all writing to the NFS-mounted
filesystem.  Thus, if NFS dies for whatever reason the child blocks and the
parent just dumps messages into the queue.  Eventually (1024 messages or 16KB of
data) the queue fills up and we start to lose messages (the parent uses
non-blocking writes), but in practice we don't hit the limit before NFS is
regained.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
