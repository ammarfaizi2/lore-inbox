Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316611AbSFUPHd>; Fri, 21 Jun 2002 11:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316636AbSFUPHc>; Fri, 21 Jun 2002 11:07:32 -0400
Received: from pc-62-31-66-56-ed.blueyonder.co.uk ([62.31.66.56]:31619 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S316611AbSFUPHc>; Fri, 21 Jun 2002 11:07:32 -0400
Date: Fri, 21 Jun 2002 16:06:59 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@zip.com.au>,
       Christopher Li <chrisl@gnuchina.org>,
       Linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: Shrinking ext3 directories
Message-ID: <20020621160659.C2805@redhat.com>
References: <20020619113734.D2658@redhat.com> <20020619234340.A24016@redhat.com> <20020620005452.M5119@redhat.com> <E17LF65-0001K4-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17LF65-0001K4-00@starship>; from phillips@bonn-fries.net on Fri, Jun 21, 2002 at 05:28:28AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 21, 2002 at 05:28:28AM +0200, Daniel Phillips wrote:

> I ran a bakeoff between your new half-md4 and dx_hack_hash on Ext2.  As 
> predicted, half-md4 does produce very even bucket distributions.  For 200,000 
> creates:
> 
>    half-md4:        2872 avg bytes filled per 4k block (70%)
>    dx_hack_hash:    2853 avg bytes filled per 4k block (69%)
> 
> but guess which was faster overall?
> 
>    half-md4:        user 0.43 system 6.88 real 0:07.33 CPU 99%
>    dx_hack_hash:    user 0.43 system 6.40 real 0:06.82 CPU 100%
> 
> This is quite reproducible: dx_hack_hash is always faster by about 6%.  This 
> must be due entirely to the difference in hashing cost, since half-md4 
> produces measurably better distributions.  Now what do we do?

I want to get this thing tested!  

There are far too many factors for this to be resolved very quickly.
In reality, there will be a lot of disk cost under load which you
don't see in benchmarks, too.  We also know for a fact that the early
hashes used in Reiserfs were quick but were vulnerable to terribly bad
behaviour under certain application workloads.  With the half-md4, at
least we can expect decent worst-case behaviour unless we're under
active attack (ie. only maliscious apps get hurt).

I think the md4 is a safer bet until we know more, so I'd vote that we
stick with the ext3 cvs code which uses hash version #1 for that, and
defer anything else until we've seen more --- the hash versioning lets
us do that safely.

> By the way, I'm running about 37 usec per create here, on a 1GHz/1GB PIII, 
> with Ext2.  I think most of the difference vs your timings is that your test 
> code is eating a lot of cpu.

I was getting nearer to 50usec system time, but on an athlon k7-700,
so those timings are pretty comparable.  Mine was ext3, too, which
accounts for a bit.  The difference between that and wall-clock time
was all just idle time, which I think was due to using "touch"/"rm"
--- ie. there was a lot of inode table write activity due to the files
being created/deleted, and that was forcing a journal wrap before the
end of the test.  That effect is not visible on ext2, of course.

--Stephen
