Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265397AbSKFAEI>; Tue, 5 Nov 2002 19:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265398AbSKFAEI>; Tue, 5 Nov 2002 19:04:08 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:12037 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S265397AbSKFADq>;
	Tue, 5 Nov 2002 19:03:46 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200211060010.gA60ALY387457@saturn.cs.uml.edu>
Subject: Re: ps performance sucks
To: wa@almesberger.net (Werner Almesberger)
Date: Tue, 5 Nov 2002 19:10:20 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), linux-kernel@vger.kernel.org,
       mbligh@aracnet.com, jw@pegasys.ws, rml@tech9.net, andersen@codepoet.org,
       woofwoof@hathway.com
In-Reply-To: <20021105203704.K1408@almesberger.net> from "Werner Almesberger" at Nov 05, 2002 08:37:04 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger writes:
> Albert D. Cahalan wrote:

>> If you're going to do that, then specify stuff via the filename:
>> /proc/12345/hack/80basic,20pids,20uids,40argv,4tty,4stat
>
> Well, you'd get the numbers (sizes) from the kernel, as a
> response. Of course, you could define the interface such that
> the query (after all, that's what it is) contains the full
> field name plus size information, and the kernel just says
> "EINVAL" if it doesn't like it, but then you lose some
> flexibility. Might not be a big deal, though.

I was thinking "80basic" would ask for the first 0x80 words
of basic info. If there's less, zero-fill. If there's more,
truncate the struct. Then "20pids" asks for the first 0x20
words of pid info (pid, ppid, sess, pgid...) and so on.

It's saying "give me 0x80 words of struct basic, followed
by 0x20 words of struct pids..." so that there isn't too
much version trouble.

Note: not expressing either approval or condemnation for
the general idea or for any specific implementation

> Yeah, perhaps it's actually better to avoid being overly
> clever. How frequently are ps and friends hit by the removal
> of fields or size changes anyway ?

Removal is a killer. It hit back in the Linux 1.3.xx days
when /proc/meminfo briefly had the current format. It hit
again just recently, when data was removed from /proc/stat
without even a transition period.

Size changes usually don't hurt, because most people are
satisfied with the old limits. If there is to be a binary
kernel interface, it damn well better use 64-bit values
for most everything.

Name changes are nasty, and are the reason I hate the
status file. Is it "SigCgt" or SigCat" in that file?
The answer depends on your kernel version...

> Oh, BTW, it would be more like /proc/hack/<query>, so you do
> all PIDs in one sweep.

That's nice, until you exceed the amount of memory available.
Right now, a "ps" without sorting can work even if there isn't
enough physical memory or address space for ps to hold info about
every process. Using a snapshot interface would cause ps to fail
under some heavy load conditions that it currently survives.

Hey, if reiserfs can have a database query syscall... >:-)
open("/proc/SELECT PID,TTY,TIME,CMD FROM PS WHERE RUID=42",O_RDONLY)
Somebody check if Al Viro needs a defibrilator. On second thought...


