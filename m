Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278318AbRJMPZE>; Sat, 13 Oct 2001 11:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278316AbRJMPYx>; Sat, 13 Oct 2001 11:24:53 -0400
Received: from [212.21.93.146] ([212.21.93.146]:36739 "EHLO
	kushida.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S278315AbRJMPYm>; Sat, 13 Oct 2001 11:24:42 -0400
Date: Sat, 13 Oct 2001 17:24:19 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Bernd Eckenfels <ecki@lina.inka.de>, Ulrich Drepper <drepper@redhat.com>,
        Alex Larsson <alexl@redhat.com>, Andi Kleen <ak@suse.de>,
        Padraig Brady <padraig@antefacto.com>,
        Andrew Pimlott <andrew@pimlott.ne.mediaone.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Finegrained a/c/mtime was Re: Directory notification problem
Message-ID: <20011013172419.B20499@kushida.jlokier.co.uk>
In-Reply-To: <oupitdx9n2m.fsf@pigdrop.muc.suse.de> <E15oq5j-00056Z-00@calista.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
EEEEFrom: Jamie Lokier <lk@tantalophile.demon.co.uk>
In-Reply-To: <E15oq5j-00056Z-00@calista.inka.de>; from ecki@lina.inka.de on Wed, Oct 03, 2001 at 07:45:55PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This note explains how to implement file timestamps in such a way that
modifications to file can always be detect reliably.  Currently,
programs such as `make' and other interesting applications cannot give
absolute guarantees of detecting changed files.

Andi Kleen says we can ignore the risk; I disagree, as there are some
applications that cannot be trusted if the risk is plausible, and it can
be fixed easily.

Bernd Eckenfels wrote:
> If you simply check the mtime and the file size you have the two most
> relevant parts. If neighter of those changes this means that programs using
> the dnotify api most likely do not need to act.
                  ^^^^^^^^^^^

In other words, the API is broken for certain applications.

One that springs to mind is transparent caching of JIT-compiled code
between interpreter invocations.  If dnotify misses the notification
sometimes, the caching ceases to be transparent, and you have to switch
it off for reliable behaviour, a major efficiency loss.

Microsecond resolution, of course, does not fix this problem.

Alex Larsson wrote:
> Is a nanoseconds field the right choice though? In reality you might not 
> have a nanosecond resolution timer, so you would miss changes that appear
> on shorter timescale than the timer resolution. Wouldn't a generation 
> counter, increased when ctime was updated, be a better solution?

As has been pointed out, it would not be compatible with other unix
systems and existing software, and timestamps have nice audit trail
possibilities.

I didn't realise there was enough precision left in ext2 inodes for
nanosecond timestamps.

Timestamps have _many_ problems: the main problem is that you can't
guarantee to reliably detect a changed file.  For some interesting
applications this is fatal.

However, you can fix timestamps and keep the best benefits of timestamps
and counters:

  - high resolution timestamps.

  - whenever there is a change event, check whether the timestamp
    would be advanced.  If not, delay the change (i.e. inside the
    write() call) until the clock time has advanced to the next
    high-resolution unit.

  - if you use nanoseconds, this will never occur on current machines
    and only rarely on faster machines.

  - spinning is an acceptable way to delay for such a short time.

  - it's not necessary to delay if nobody read the mtime since the last
    timestamp update, which will nearly always be the case.  So even on
    extremely fast future machines, you would hardly ever pause.

cheers,
-- Jamie
