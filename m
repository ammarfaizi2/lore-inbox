Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261966AbTDABX2>; Mon, 31 Mar 2003 20:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261970AbTDABX1>; Mon, 31 Mar 2003 20:23:27 -0500
Received: from 130.146.174.203.mel.ntt.net.au ([203.174.146.130]:5259 "EHLO
	enki.rimspace.net") by vger.kernel.org with ESMTP
	id <S261966AbTDABX0>; Mon, 31 Mar 2003 20:23:26 -0500
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Delaying writes to disk when there's no need
In-Reply-To: <20030331170927.013a0d4a.akpm@digeo.com> (Andrew Morton's
 message of "Mon, 31 Mar 2003 17:09:27 -0800")
References: <slrnb843gi.2tt.usenet@bender.home.hensema.net>
	<20030328231248.GH5147@zaurus.ucw.cz>
	<slrnb8gbfp.1d6.erik@bender.home.hensema.net>
	<3E8845A8.20107@aitel.hist.no> <3E88BAF9.8040100@cyberone.com.au>
	<20030331144500.17bf3a2e.akpm@digeo.com>
	<87el4ngi8l.fsf@enki.rimspace.net>
	<20030331170927.013a0d4a.akpm@digeo.com>
From: Daniel Pittman <daniel@rimspace.net>
Date: Tue, 01 Apr 2003 11:34:50 +1000
Message-ID: <87pto7f1ad.fsf@enki.rimspace.net>
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) XEmacs/21.5 (cabbage)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Mar 2003, Andrew Morton wrote:
> Daniel Pittman <daniel@rimspace.net> wrote:
>>
>> Capturing a real-time video stream from an IEEE1394 DV stream means
>> writing a stead 3.5MB per second for two on two and a half hours.
>> 
>> Linux isn't great at this, using the default writeout policy, even as
>> recent as 2.5.64. The writer goes OK for a while but, eventually,
>> blocks on writeout for long enough to drop a frame -- more than
>> 8/25ths of a second.
>> 
>> 
>> This can be resolved by tuning the default delay before write-out
>> start to 5 seconds, down from 30, or by running sync every second, or
>> by doing fsync tricks.
> 
> Interesting.
> 
> Yes, I expect that you could fix that up by altering
> dirty_background_ratio and dirty_expire_centisecs.

Those are, in fact, the precise knobs I turned. Well, those and the XFS
pagebuf layer equivalents.

> The problem with fsync() is that it waits on the writeout. You don't
> want that to happen - you just want to tell the kernel "I won't be
> overwriting or deleting this data". Make the kernel queue up and start
> the IO but not wait on its completion.

Yes, that would be good, because then I wouldn't need to write an IPC
thing and fork or thread, so that the second thread can be busy blocking
on the writeout for me.

> It is quite appropriate to do this in fadvise(FADV_DONTNEED) - as a
> lower-latency fsync(). The app would need to call it once per second
> or so.
> 
> It would also throw away any written-back pagecache inside your
> (start, len) which is exactly what your applications wants to happen,
> so the app should be calling fadvise _anyway_.
> 
> What do you think?

I will apply the patch and test later today.  This, however, looks like
a *really* good thing to me.

  Daniel

-- 
there's a party going on 
we'll all be here dancing underground 
      there's a riot going on 
we'll all be here dancing underground
        -- Covenant, _Riot_
