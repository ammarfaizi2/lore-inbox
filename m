Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267633AbTAXKyV>; Fri, 24 Jan 2003 05:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267635AbTAXKyU>; Fri, 24 Jan 2003 05:54:20 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:49637 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S267633AbTAXKyT>;
	Fri, 24 Jan 2003 05:54:19 -0500
Date: Fri, 24 Jan 2003 11:03:28 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: 2.5.59-mm5
Message-ID: <946253340.1043406208@[192.168.100.5]>
In-Reply-To: <20030123195044.47c51d39.akpm@digeo.com>
References: <20030123195044.47c51d39.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On 23 January 2003 19:50 -0800 Andrew Morton <akpm@digeo.com> wrote:

>   So what anticipatory scheduling does is very simple: if an application
>   has performed a read, do *nothing at all* for a few milliseconds.  Just
>   return to userspace (or to the filesystem) in the expectation that the
>   application or filesystem will quickly submit another read which is
>   closeby.

I'm sure this is a really dumb question, as I've never played
with this subsystem, in which case I apologize in advance.

Why not follow (by default) the old system where you put the reads
effectively at the back of the queue. Then rather than doing nothing
for a few milliseconds, you carry on with doing the writes. However,
promote the reads to the front of the queue when you have a "good
lump" of them. If you get further reads while you are processing
a lump of them, put them behind the lump. Switch back to the putting
reads at the end when we have done "a few lumps worth" of
reads, or exhausted the reads at the start of the queue (or
perhaps are short of memory).

IE (with a "lump" = 20) and "a few" = 3.

W0 W1 W2 ... W50 W51

[Read arrives, we process some writes]

W5 ... W50 W51 R0

[More reads arrive, more writes processed]

W10 ... W50 W51 R0 R1 R2 .. R7

[Haven't got a big enough lump, but a
write arrives]

W12 W13... W50 W51 W52 R0 R1 R2 .. R7

[More reads arrive, more writes processed]

W14 W15 ... W50 W51 W52 R0 R1 R2 .. R7 R8 R9.. R19

[Another read arrives, after 4 more writes have
been processed, and we move the lump to the
front]

R0 R1 R2 .. R7 R8 R9.. R19 R20 W18 W19 ... W50 W51 W52

[Some reads are processed, and some more arrive, which
we insert into our lump at the front]

R0 R1 R2 .. R7 R8 R9.. R19 R20 R21 R22 W18 W19 ... W50 W51 W52

Then either if the reads are processed at the front of
the queue faster than they arrive, and the "lump" disappears,
or if we've processed 3 x 20 = 60 reads, we revert to
sticking reads back at the end.

All this does is lump between 20 and 60 reads together.

The advantage being that you don't "do nothing" for a few
milliseconds, and can attract larger lumps, than by
waiting without incurring additional latency.

Now of course you have the ordering problem (in that I've
assumed you can insert things into the queue at will),
but you have that anyway.

--
Alex Bligh
