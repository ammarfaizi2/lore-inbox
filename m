Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262622AbVBDAbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262622AbVBDAbf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 19:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262548AbVBDAbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 19:31:17 -0500
Received: from [211.58.254.17] ([211.58.254.17]:61570 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262986AbVBDAat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 19:30:49 -0500
Message-ID: <4202C223.6050802@home-tj.org>
Date: Fri, 04 Feb 2005 09:30:27 +0900
From: Tejun Heo <tj@home-tj.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050118)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 21/29] ide: Merge do_rw_taskfile() and flagged_taskfile().
References: <20050202024017.GA621@htj.dyndns.org>	 <20050202030603.GF1187@htj.dyndns.org> <58cb370e050203103952e1cd22@mail.gmail.com>
In-Reply-To: <58cb370e050203103952e1cd22@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Bartlomiej Zolnierkiewicz wrote:
> On Wed, 2 Feb 2005 12:06:03 +0900, Tejun Heo <tj@home-tj.org> wrote:
> 
>>>21_ide_do_taskfile.patch
>>>
>>>      Merged do_rw_taskfile() and flagged_taskfile() into
>>>      do_taskfile().  During the merge, the following changes took
>>>      place.
>>>      1. flagged taskfile now honors HOB feature register.
>>>         (do_rw_taskfile() did write to HOB feature.)
>>>      2. No do_rw_taskfile() HIHI check on select register.  Except
>>>         for the DEV bit, all bits are honored.
>>>      3. Uses taskfile->data_phase to determine if dma trasfer is
>>>         requested.  (do_rw_taskfile() directly switched on
>>>         taskfile->command for all dma commands)
>>
>>Signed-off-by: Tejun Heo <tj@home-tj.org>
> 
> 
> do_rw_taskfile() is going to be used by fs requests once
> __ide_do_rw_disk() is converted to taskfile transport.
> 
> I don't think that do_rw_taskfile() and flagged_taskfile() merge
> is a good thing as it adds unnecessary overhead for hot path
> (fs requests).

Yeah, I also thought about that, but here are reasons why I still think 
merging is better.

1. The added overhead is small.  It's just a dozen more if's per every 
disk io.  I don't think it will make any noticeable difference.

2. If hot path optimization is needed, it can be easily done inside one 
do_taskfile() function with one or two more if's.

3. Currently, do_rw_taskfile() isn't used by __ide_do_rw_disk().  We can 
think about optimization when actually converting it to use taskfile 
transport.  And IMHO, if hot path optimization is needed, leaving hot 
path optimization where it is now (inside __ide_do_rw_disk()) is better 
  than moving it to separate taskfile function (do_rw_taskfile()).

-- 
tejun

