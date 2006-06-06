Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750779AbWFFDeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWFFDeS (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 23:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWFFDeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 23:34:18 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:35788 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1750779AbWFFDeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 23:34:18 -0400
Message-ID: <349564851.10398@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Tue, 6 Jun 2006 11:34:36 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Bart Samwel <bart@samwel.tk>
Cc: Voluspa <lista1@comhem.se>, linux-kernel@vger.kernel.org
Subject: Re: Adaptive Readahead V14 - statistics question...
Message-ID: <20060606033436.GB6071@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Bart Samwel <bart@samwel.tk>, Voluspa <lista1@comhem.se>,
	linux-kernel@vger.kernel.org
References: <20060530053631.57899084.lista1@comhem.se> <448493E9.9030203@samwel.tk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448493E9.9030203@samwel.tk>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2006 at 10:28:25PM +0200, Bart Samwel wrote:
> Hi Mats, Wu,
> 
> Hmmm, video at 1 Mb/s = 128 kB/s (just guessing a typical bitrate) 
> equals 8 seconds between reads at 1 MB readahead, right? That's strange, 
> you should be hearing those sounds normally as well then, as a typical 
> Linux laptop setup accesses the disk less frequently than once every 8 
> seconds. Anyway, _increasing_ the maximum readahead to some film-decent 
> value will probably get rid of the clicking as well.
> 
> I guess the problem is getting this to work without disturbing other 
> applications, i.e. without making slow-but-predictably-reading 
> applications read ahead 10 MB as well. I've been struggling with this 
> with laptop mode for quite some time: last time I checked, there didn't 
> seem to be a good way to do video readahead without making all other 
> reads read ahead too much as well... What I'd like to have is a setting 
> that works based on _time_, so that I can say "read all you think will 
> be needed in the next N seconds".
> 
> I could imagine having the maximum readahead being composed of two settings:
> 
> MAX_BYTES = maximum readahead in bytes
> MAX_TIME = maximum readahead in *time* before the data is expected to be 
> needed
> 
> For instance, if MAX_BYTES = 50MB and MAX_TIME=180 seconds, an 
> application reading at 10 kB/s would get a max readahead of 180*10 = 
> 1800kB, while an application reading at 100 kB/s would get a max 
> readahead of 180*100 = 18000kB. As a use case, the first application 
> would be xmms (128kbit MP3), while the second would be mplayer (800kbit 
> video). In both cases, laptop mode would be able to spin down the disk 
> for a full three minutes between spinups. Ideal for when you're trying 
> to watch a video while on the road.
> 
> Wu, do the adaptive readahead patches have something like this, or could 
> it be included? It would solve a _major_ problem for laptop mode.

Yes, it has the capability you need.

And MAX_TIME is not necessary for this case.
It does not try to estimate the time, but the relative speeds of all
concurrent readers. It automatically arranges appropriate readahead
sizes for all the concurrent readers, so that no readahead thrashing
will happen, provided that the reading speeds do not fluctuate too
much.

However there are some cases not thrashing protected:
        - normal mmapped reading(without POSIX_FADV_SEQUENTIAL hint);
        - backward reading;
        - fs stuffs(i.e. readahead for dirs);

With that in mind, you can safely set max readahead size to as large
as 255M when watching videos by doing the following tricks:

blockdev --setra 524280 /dev/hda[N]     # following opened file will use this aggressive size
mplayer <your video file on hda[N]>     # open it
blockdev --setra 2048 /dev/hda[N]       # revert to sane value
# now continue watching video ...

Cheers,
Wu
