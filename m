Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbVAHJsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbVAHJsV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 04:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVAHJfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 04:35:39 -0500
Received: from mail.joq.us ([67.65.12.105]:8321 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261960AbVAHGM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 01:12:26 -0500
To: Chris Wright <chrisw@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, paul@linuxaudiosystems.com,
       arjanv@redhat.com, mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <200501071620.j07GKrIa018718@localhost.localdomain>
	<1105132348.20278.88.camel@krustophenia.net>
	<20050107134941.11cecbfc.akpm@osdl.org>
	<20050107221059.GA17392@infradead.org>
	<20050107142920.K2357@build.pdx.osdl.net>
From: "Jack O'Quin" <joq@io.com>
Date: Sat, 08 Jan 2005 00:12:59 -0600
In-Reply-To: <20050107142920.K2357@build.pdx.osdl.net> (Chris Wright's
 message of "Fri, 7 Jan 2005 14:29:20 -0800")
Message-ID: <87mzvkxxck.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> writes:

> * Christoph Hellwig (hch@infradead.org) wrote:
>> So to make forward progress I'd like the audio people to confirm whether
>> the mlock bits in 2.6.9+ do help that half of their requirement first
>
> It sure should, but I guess they can reply on that.

That does seem to work now (finally).  It looks like that longstanding
CAP_IPC_LOCK bug is finally fixed, too.

I find it hard to understand why some of you think PAM is an adequate
solution.  As currently deployed, it is poorly documented and nearly
impossible for non-experts to administer securely.  On my Debian woody
system, when I login from the console I get one fairly sensible set of
ulimit values, but from gdm I get a much more permissive set (with
ulimited mlocking, BTW).  Apparently, this is because the `gdm' PAM
config includes `session required pam_limits.so' but the system comes
with an empty /etc/security/limits.conf.  I'm just guessing about that
because I can't find any decent documentation for any of this crap.

Remember, if something is difficult to administer, it's *not* secure.

>> (and if not find a way to fix it) and then tackle the scheduling part.
>> For that one I really wonder whether the combination of the now actually
>> working nicelevels (see Mingo's post) and a simple wrapper for the really
>> high requirements cases doesn't work.
>
> I saw Jack (I think) post some numbers showing that it wasn't enough.
> What about making priority level protected via rlimit?

The numbers I reported yesterday were so bad I couldn't figure out why
anyone even thought it was worth trying.  Now I realize why.  

When Ingo said to try "nice -20", I took him literally, forgetting
that the stupid command to achieve a nice value of -20 is `nice --20'.
So I was actually testing with a nice value of 19.  Bah!  No wonder it
sucked.

Running `nice --20' is still significantly worse than SCHED_FIFO, but
not the unmitigated disaster shown in the middle column.  But, this
improved performance is still not adequate for audio work.  The worst
delay was absurdly long (~1/2 sec).

Here are the corrected results...

                                 With -R        Without -R      Without -R
                               (SCHED_FIFO)     (nice -20)      (nice --20)

************* SUMMARY RESULT ****************
Total seconds ran . . . . . . :   300
Number of clients . . . . . . :    20
Ports per client  . . . . . . :     4
Frames per buffer . . . . . . :    64
*********************************************
Timeout Count . . . . . . . . :(    1)          (    1)          (    1)
XRUN Count  . . . . . . . . . :     2             2837               43
Delay Count (>spare time) . . :     0                0                0
Delay Count (>1000 usecs) . . :     0                0                0
Delay Maximum . . . . . . . . :  3130 usecs    5038044 usecs   501374 usecs
Cycle Maximum . . . . . . . . :   960 usecs      18802 usecs     1036 usecs
Average DSP Load. . . . . . . :    34.3 %           44.1 %         34.3 %    
Average CPU System Load . . . :     8.7 %            7.5 %          7.8 %    
Average CPU User Load . . . . :    29.8 %            5.2 %         25.3 %    
Average CPU Nice Load . . . . :     0.0 %           20.3 %          0.0 %    
Average CPU I/O Wait Load . . :     3.2 %            5.2 %          0.1 %    
Average CPU IRQ Load  . . . . :     0.7 %            0.7 %          0.7 %    
Average CPU Soft-IRQ Load . . :     0.0 %            0.2 %          0.0 %    
Average Interrupt Rate  . . . :  1707.6 /sec      1677.3 /sec    1692.9 /sec 
Average Context-Switch Rate . : 11914.9 /sec     11197.6 /sec   11611.2 /sec 
*********************************************

> Here's an uncompiled, untested patch doing that (probably has some math
> error or logic hole in it, but idea seems sound enough).  I think it has
> at least one problem, where nice 19 process, could renice itself back to
> 0.  And it doesn't really handle the different scheduling policies,
> other than implicit 40 - 139 being used for SCHED_FIFO/SCHED_RR.
>
> It takes the 140 priority levels (0-139), inverts their priority
> order, and then uses that number as the basis for the rlimit (so that a
> larger rlimit means higher priority, to fall inline with normal rlimit
> semantics).  Defaults to 19 (which should be niceval of 0).  And allows
> CAP_SYS_NICE to continue to override if the rlimit is too low.

If you really want to use PAM for everything, then this idea makes a
lot of sense.

But, what about all the other programs that would need updating to
make it useful?  We'd need at least a new pam_limits.so module and a
new shell (since ulimit is built-in).  I expect I will need to
maintain the realtime-lsm for at least another year before all that
can trickle down to actual end users.

-- 
  joq
