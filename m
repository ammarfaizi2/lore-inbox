Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265165AbSJRP2U>; Fri, 18 Oct 2002 11:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265195AbSJRP2T>; Fri, 18 Oct 2002 11:28:19 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:44560 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S265165AbSJRP2S>;
	Fri, 18 Oct 2002 11:28:18 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Srihari Vijayaraghavan <harisri@bigpond.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20pre11aa1 
In-reply-to: Your message of "Fri, 18 Oct 2002 16:52:04 +0200."
             <20021018145204.GG23930@dualathlon.random> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 19 Oct 2002 01:34:06 +1000
Message-ID: <29723.1034955246@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2002 16:52:04 +0200, 
Andrea Arcangeli <andrea@suse.de> wrote:
>On Sat, Oct 19, 2002 at 12:14:19AM +1000, Srihari Vijayaraghavan wrote:
>> Oct 18 23:40:42 localhost kernel: Process modprobe (pid: 957, 
>
>modprobe was running at 234042, now in the log I see:
>
>20021018 234001 start /sbin/modprobe -s -k -- char-major-14 safemode=1
>20021018 234001 probe ended
>20021018 234004 start /sbin/modprobe -s -k -- char-major-10-134 safemode=1
>20021018 234004 probe ended
>20021018 234014 start /sbin/modprobe -s -k -- char-major-10-134 safemode=1
>20021018 234014 probe ended
>20021018 234021 start /sbin/modprobe -s -k -- char-major-14 safemode=1
>20021018 234021 probe ended
>20021018 234022 start /sbin/modprobe -s -k -- ide-cd safemode=1
>20021018 234022 probe ended
>20021018 234022 start /sbin/modprobe -s -k -- ide-cd safemode=1
>20021018 234022 probe ended
>20021018 234040 start /sbin/modprobe -s -k -- char-major-14 safemode=1
>^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>20021018 234040 probe ended
>20021018 234051 start /sbin/modprobe -s -k -- binfmt-ffff safemode=1
>20021018 234051 probe ended
>20021018 234051 start /sbin/modprobe -s -k -- binfmt-ffff safemode=1
>20021018 234051 probe ended
>
>I don't see any modprobe in the logs at 234042 and the one at 234040 is
>writing "probe ended" at 234040. maybe it was another modprobe that
>crashed before it could write into the logs? or maybe it was the
>underlined one that crashed after writing "probe ended"? But anyways it
>looks like modprobe is innocent if it didn't write into the log any new
>module loaded. Do you agree Keith?

modprobe appends to the log for all operations that might change the
module state.  The data is flushed before changing module state, with

snap_shot_log()
	fprintf(log, "\n");
	fflush(log);
	fdatasync(fileno(log));
	fclose(log);

so the log should always be valid, even if modprobe then crashes.
There is no system code after modprobe writes 'probe ended', crashes
after writing 'probe ended' should not be possible.

Three possibilities :-

(a) The modprobe at 234040 completed the load successfully then the
oops occurred before the modprobe task was completely purged.  IOW, the
module loaded, module_init() ran, modprobe returned to user space then
the module died handling some event.

(b) The failing modprobe at 234042 is real, but is performing an
operation that will not change module state.  For example, it is
doing modprobe -n, this will not log but will still invoke some module
syscalls.  The oops is then caused by corrupt module tables.

(c) modprobe is not being run as root so it cannot log.  Although it
cannot actually change module state, it will do part of the work in
extracting existing module symbols.  Again, the oops is caused by
corrupt module tables.

