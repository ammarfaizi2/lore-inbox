Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbWAKWCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWAKWCd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 17:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbWAKWCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 17:02:33 -0500
Received: from web34106.mail.mud.yahoo.com ([66.163.178.104]:64387 "HELO
	web34106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750953AbWAKWCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 17:02:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=AQQNQFTXqk0AK1Yx4Tv0kKTQHnmXlFsHXeuLgSQW7fIUqBdK+GulOXOT2fuQJ2YwZ/WcMO1KB0+ZSZd3Q9WJBMYzKyRUp82Apx2XK1Iniw2u4MLnQj18Ch8RVtVEE/Tx2aqqNJCdml6QEH9hzmeV3pVTvlS4OzBOo2UWQgpHHDc=  ;
Message-ID: <20060111220231.27064.qmail@web34106.mail.mud.yahoo.com>
Date: Wed, 11 Jan 2006 14:02:31 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: Is user-space AIO dead?
To: Phillip Susi <psusi@cfl.rr.com>
Cc: David Lloyd <dmlloyd@tds.net>, linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43C56B08.2000908@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Phillip Susi <psusi@cfl.rr.com> wrote:
> I actually hacked up dd to use async IO ( via io_submit ) in conjunction 
> with O_DIRECT and it did noticeably improve ( ~10% ish ) both throughput 
> and cpu utilization.  I have an OO.o spreadsheet showing the results of 
> some simple benchmarking with various parameters I did at home, which I 
> will post later this evening. 
> 
> Of course, dd is a simplistic case of sequential IO.  If you have 
> something like a big database that needs to concurrently handle dozens 
> or hundreds of random IO requests at once, O_DIRECT async IO is 
> definitely going to be a clear winner. 

The part I am writing looks like a transaction log writer:
  Lots of sequential small-ish writes (call each quanta a transaction)
  Must be written to stable storage
  Must know when the writes are completed
  The data is only read back for recovery processing

  In the past, the way I found to have worked best is to have a dedicated thread pulling
transactions off a queue and doing the blocking syncronous writes either by write(v)/fsync or
write(v) on a file opened with O_SYNC | O_DIRECT.  Once the fsync returned, the thread would
signal completion and grab the next batch to start writing.
  This works very well and can easily max out any real device's bandwidth, but incurs more latency
than should be absolutely needed due to the extra context switching from the completion
signalling.

  I am hoping AIO can be used to reduce the latency, but was a bit discouraged after reading the
IBM paper.

  I am looking forward to your post reguarding dd.

thanks,
-Kenny


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
