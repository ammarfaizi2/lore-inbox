Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbWCLVza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWCLVza (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 16:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWCLVza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 16:55:30 -0500
Received: from flex.com ([206.126.0.13]:64005 "EHLO flex.com")
	by vger.kernel.org with ESMTP id S932266AbWCLVz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 16:55:29 -0500
From: Marr <marr@flex.com>
To: Linda Walsh <lkml@tlinx.org>
Subject: Re: Readahead value 128K? (was Re: Drastic Slowdown of 'fseek()' Calls From 2.4 to 2.6 -- VMM Change?)
Date: Sun, 12 Mar 2006 16:53:29 -0500
User-Agent: KMail/1.8.2
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com, Andrew Morton <akpm@osdl.org>, marr@flex.com
References: <200602241522.48725.marr@flex.com> <200603071453.46768.marr@flex.com> <440DF802.8@tlinx.org>
In-Reply-To: <440DF802.8@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603121653.30288.marr@flex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 March 2006 4:15pm, Linda Walsh wrote:
> Marr wrote:
> > On Sunday 05 March 2006 6:02pm, Linda Walsh wrote:
> >> Does this happen with a seek call as well, or is this limited
> >> to fseek?
> >>
> >> if you look at "hdparm's" idea of read-ahead, what does it say
> >> for the device?.  I.e.:
> >>
> >> hdparm /dev/hda:
> >>
> >> There is a line entitled "readahead".  What does it say?
> >
> > Linda,
> >
> > I don't know (based on your email addressing) if you were directing this
> > question at me, but since I'm the guy who originally reported this issue,
> > here are my 'hdparm' results on my (standard Slackware 10.2) ReiserFS
> > filesystem:
> >
> >    2.6.13 (with 'nolargeio=1' for reiserfs mount):
> >       readahead    = 256 (on)
> >
> >    2.6.13 (without 'nolargeio=1' for reiserfs mount):
> >       readahead    = 256 (on)
> >
> >    2.4.31 ('nolargeio' option irrelevant/unavailable for 2.4.x):
> >       readahead    = 8 (on)
> >
> > *** Please CC: me on replies -- I'm not subscribed.
> >
> > Regards,
> > Bill Marr
>
> --------
>     Could you retry your test with read-ahead set to a smaller
> value?  Say the same as in 2.4 (8) or 16 and see if that changes
> anything?
>
> hdparm -a8 /dev/hdx
>   or
> hdparm -a16 /dev/hdx

Linda (et al),

Sorry for the delayed reply. I finally got a chance to run another test (but 
on a different machine than the last time, so don't try to compare old timing 
numbers with these numbers).

I went ahead and tried all permutations, just to be sure. As before, these 
reported times are all for 200,000 random 'fseek()' calls on the same 
zero-filled 4MB file on a standard Slackware 10.2 ReiserFS partition and 
kernels.

(Values shown for 'readahead' are set by 'hdparm -a## /dev/hda' command.)

-----------------------------------
Timing Results:

On 2.6.13, *without* 'nolargeio=1': 4m35s (ouch!) for _all_ variants (256, 16, 
8) of 'readahead'

On 2.6.13, _with_ 'nolargeio=1': 0m6s for _all_ variants (256, 16, 8) of 
'readahead'

On 2.4.31: 0m6s for _all_ variants (128 [256 is illegal -- 'BLKRASET failed: 
Invalid argument'], 16, 8) of 'readahead'

-----------------------------------

I half-expected to see improvement for the '2.6.13 without nolargeio=1' case 
when lowering the read-ahead from 256 sectors to 16 or 8 sectors, but there 
clearly was no improvement whatsoever. 

I tried turning 'readahead' off entirely ('hdparm -A0 /dev/hda') and, although 
it correctly reported "setting drive read-lookahead to 0 (off)", an immediate 
follow-on query ('hdparm /dev/hda') showed that it was still ON ("readahead = 
256 (on)")!  I went ahead and ran the test again anyway and (unsurprisingly) 
got the same excessive times (4m35s) for 200K seeks.

Confused, but still (for now) happily using the 'nolargeio=1' workaround with 
all my 2.6.13 kernels with ReiserFS....   :^/

*** Please CC: me on replies -- I'm not subscribed.
   
Regards,
Bill Marr
