Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbVATXTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbVATXTL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 18:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVATXTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 18:19:06 -0500
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:12739 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261267AbVATXRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 18:17:13 -0500
Message-ID: <41F03C03.3090209@kolivas.org>
Date: Fri, 21 Jan 2005 10:17:23 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ross@jose.lug.udel.edu
Cc: Paul Davis <paul@linuxaudiosystems.com>, "Jack O'Quin" <joq@io.com>,
       linux <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt scheduling
References: <87pt00b01i.fsf@sulphur.joq.us> <200501201542.j0KFgOwo019109@localhost.localdomain> <20050120174939.GA15920@jose.lug.udel.edu>
In-Reply-To: <20050120174939.GA15920@jose.lug.udel.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ross@lug.udel.edu wrote:
> On Thu, Jan 20, 2005 at 10:42:24AM -0500, Paul Davis wrote:
> 
>>over on #ardour last week, we saw appalling performance from
>>reiserfs. a 120GB filesystem with 11GB of space failed to be able to
>>deliver enough read/write speed to keep up with a 16 track
>>session. When the filesystem was cleared to provide 36GB of space,
>>things improved. The actual recording takes place using writes of
>>256kB, and no more than a few hundred MB was being written during the
>>failed tests.
> 
> 
> It's been a long while since I followed ReiserFS development closely,
> *however*, this issue used to be a common problem ReiserFS - when
> free space starts to drop below 10%, performace takes a big hit.  So
> performance improved when space was cleared up.
> 
> I don't remember what causes this or what the status is in modern
> ResierFS systems.
> 
> 
>>everything i read about reiser suggests it is unsuitable for audio
>>work: it is optimized around the common case of filesystems with many
>>small files. the filesystems where we record audio is typically filled
>>with a relatively small number of very, very large files.
> 
> 
> Anecdotally, I've found this to not be the case.  I only use ReiserFS
> and have a few reasonably sized projects in Ardour that work fine:
> maybe 20 tracks, with 10-15 plugins (in the whole project), and I can
> do overdubs with no problems.  It may be relevant that I only have a
> four track card and so load is too small.
> 
> But at least in my practice, it hasn't been a huge hinderance.

This is my understanding of the situation, which is not gospel but 
interpretation of the information data I have had available.

Reiserfs3.6 is in maintenance mode. Its performance was very good in 2.4 
days, but since 2.6 the block layer has matured so much that the code 
paths that were fast in reiserfs are no longer so impressive compared to 
those shared by ext3.

In terms of recommendation, the latency of non-preemptible codepaths 
will be fastest in ext3 in 2.6 due to the nature of it constantly being 
examined, addressed and updated. That does not mean it has the fastest 
performance by any stretch of the imagination. XFS, I believe, has 
significantly faster large file performance, and reiser3.6 has 
significantly faster small file performance. But if throughput is not a 
problem, and latency is, then ext3 is a better choice. Reiser4 is a 
curious beast with obviously high throughput, but for the moment I do 
not think it is remotely suitable for low latency applications.

As for the %full issue; no filesystem works well as it approaches full 
capacity. Performance degrades dramatically beyond 75% on all of them, 
becoming woeful once beyond 85%. If you're looking for good performance, 
more free capacity is more effective than changing filesystems.

All of this should be taken into consideration if you're worried about 
low latency cpu scheduling, as it all will collapse if your filesystem 
code has high latency in the kernel. It also would make benchmarking low 
latency cpu scheduling potentially prone to disastrous mis-interpretation.

Cheers,
Con
