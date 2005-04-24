Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262484AbVDXXq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbVDXXq2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 19:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262486AbVDXXq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 19:46:28 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:30482 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262484AbVDXXqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 19:46:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=fEK3o/rvwjo/YCmx20KVZb1e8u26wI7I+FYFnPKCDwkj44J+xy/VdH5KPx9uBmHOJOKBNpi3P+TrLQ/UkfIEByrp+VOuH/M3rLfkoobItc6rFxrXhw9IgfgYbZm/374Y1uiDnhkubGBiuXgHdgAZyLZux9Q1tMx9vMpXPv34HKo=
Message-ID: <426C2FC3.4090105@gmail.com>
Date: Mon, 25 Apr 2005 08:46:11 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH scsi-misc-2.6 01/04] scsi: make scsi_send_eh_cmnd use
 its own timer instead of scmd->eh_timeout
References: <20050419143100.E231523D@htj.dyndns.org>	 <20050419143100.0F9A8C3B@htj.dyndns.org> <1114381342.4786.17.camel@mulgrave>
In-Reply-To: <1114381342.4786.17.camel@mulgrave>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hi, James.

James Bottomley wrote:
> On Tue, 2005-04-19 at 23:31 +0900, Tejun Heo wrote:
> 
>>	scmd->eh_timeout is used to resolve the race between command
>>	completion and timeout.  However, during error handling,
>>	scsi_send_eh_cmnd uses scmd->eh_timeout.  This creates a race
>>	condition between eh and normal completion for a request which
>>	has timed out and in the process of error handling.  If the
>>	request completes while scmd->eh_timeout is being used by eh,
>>	eh timeout is lost and the command will be handled by both eh
>>	and completion path.  This patch fixes the race by making
>>	scsi_send_eh_cmnd() use its own timer.
>>
>>	This patch adds shost->eh_timeout field.  The name of the
>>	field equals scmd->eh_timeout which is used for normal command
>>	timeout.  As this can be confusing, renaming scmd->eh_timeout
>>	to something like scmd->cmd_timeout would be good.
>>
>>	Reworked such that timeout race window is kept at minimal
>>	level as pointed out by James Bottomley.
> 
> 
> This looks fine in principle.  However, three comments
> 
> 1. If you're doing this, there's no further use for eh_timeout, so
> remove it (and preferably fix gdth_proc.c; however, it's better to break
> the compile of that driver than have it rely on a now defunct field).

  If you're talking about scmd->eh_timeout, it's our main timer for 
normal command timeouts.  If you're suggesting renaming it to something 
more apparant, I agree.  Maybe just scmd->timeout will do.

> 2. Use of eh_action is private to scsi_error.c, so you don't need to add
> a new field to the host, just make eh_action a pointer to a private
> eh_action structure which contains the timer and the semaphore.

  Sure.

> 3. To close a really tiny window where the running timer could race with
> the del_timer, it should probably be del_timer_sync().  The practical
> effect of this is nil, but it would be correct programming.

  Sorry, but, AFAICT, that wouldn't close any window.  We use timer 
pending for tie-breaker.  When scsi_eh_done() wins, timer never gets to 
run, and if scsi_eh_times_out() wins, the eh thread is woken up only 
after the last reference to the timer/eh is finished (up operation).  If 
I'm missing something, please point out.

  BTW, are you still keeping the bk tree up-to-date?  And, if so, until 
when are you gonna keep the bk tree?  I'm painfully trying to follow and 
convert all my trees to git, but I _really_ miss changeset browsing of 
bk.  Call me lazy but it was just too nice browsing the changesets only 
with mouse.  One way or the other, it's a shame.

  Thanks.

-- 
tejun
