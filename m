Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbUCIEq6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 23:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbUCIEq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 23:46:58 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:51435 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S261564AbUCIEqs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 23:46:48 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: George Anzinger <george@mvista.com>
Subject: Re: kgdb for mainline kernel: core-lite [patch 1/3]
Date: Tue, 9 Mar 2004 10:16:30 +0530
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       trini@kernel.crashing.org, pavel@ucw.cz
References: <200403081504.30840.amitkale@emsyssoft.com> <200403081619.16771.amitkale@emsyssoft.com> <404CF07D.1090303@mvista.com>
In-Reply-To: <404CF07D.1090303@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403091016.30844.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 Mar 2004 3:45 am, George Anzinger wrote:
> Amit S. Kale wrote:
> > On Monday 08 Mar 2004 3:56 pm, Andrew Morton wrote:
> >>"Amit S. Kale" <amitkale@emsyssoft.com> wrote:
> >>>Here are features that are present only in full kgdb:
> >>> 1. Thread support  (aka info threads)
> >>
> >>argh, disaster.  I discussed this with Tom a week or so ago when it
> >> looked like this it was being chopped out and I recall being told that
> >> the discussion was referring to something else.
> >>
> >>Ho-hum, sorry.  Can we please put this back in?
> >
> > Err., well this is one of the particularly dirty parts of kgdb. That's
> > why it's been kept away. It takes care of correct thread backtraces in
> > some rare cases.
> >
> > If you consider it an absolutely must, we can do something so that the
> > dirty part is kept away and info threads almost always works.
>
> Amit,
>
> I think we should just put the info threads in the core.  No attempt to do
> any trace back from kgdb.  Let them all show up in the switch code.  I have
> a script (gdb macro) that will give a rather decent "info threads" display.
>  Oh, we need to add one other responce to kgdb for the process info gdb
> command.

qfProcessInfo looks like a very useful command.

This is still a hack. These kinds of hacks are difficult to maintain over a 
long time because they are based on undocumented information.

While setting up kgdb for the first time isn't easy, macros add to that 
complexity.

Have you experienced "shakyness" of macros? I have used process information 
macros at kgdb.sourceforge.net to display a "ps" command like output since 
the days of 2.4.0. I had to change them 3-4 times till now because of kernel 
structure changes. The "changing" part is typically a 2-3 hour regorous 
exercise :-)

-Amit

>   * This query allows the target stub to return an arbitrary string
>   * (or strings) giving arbitrary information about the target process.
>   * This is optional; the target stub isn't required to implement it.
>   *
>   * Syntax: qfProcessInfo        request first string
>   *         qsProcessInfo        request subsequent string
>   * reply:  'O'<hex-encoded-string>
>   *         'l'                  last reply (empty)
>   */
> What we want here is the thread name.
>
> Here is the macro set:
>
> set var $low_sched=0
>
> define do_threads
>    if (void)$low_sched==(void)0
> 	set_b
>    end
>    thread apply all do_th_lines
> end
>
> define do_th_lines
>    set var $do_th_co=0
>    while ($pc > $low_sched) && ($pc < $high_sched)
>      up-silent
>      set var $do_th_co=$do_th_co+1
>    end
>    if $do_th_co==0
>      info remote-process
>      bt
>    else
>      up-silent
>      info remote-process
>      down
>    end
> end
>
> define set_b
>    set var $low_sched=scheduling_functions_start_here
>    set var $high_sched=scheduling_functions_end_here
> end
>
>
> ~

