Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbWEIEg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWEIEg7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 00:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWEIEg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 00:36:59 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:40824 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751374AbWEIEg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 00:36:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=z2sNPPTe9IZeNQt2FKOWTp/jhvZSMdi2eBTKoSxmgQlqffuWkoXEqRJA6RZBrfPhCvO+p7e8pgcF6uQC0lAD32HrAuxPt+SOPQwrkEa15vkaHocsbE3QzDLH59kq2FNhxhLqGGU7bIcKfzKCVeh5y5w81hoVmy8ijwMuC7kbN7w=  ;
Message-ID: <44601933.2040905@yahoo.com.au>
Date: Tue, 09 May 2006 14:23:15 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, jlan@engr.sgi.com
Subject: Re: [Patch 2/8] Sync block I/O and swapin delay collection
References: <20060502061408.GM13962@in.ibm.com> <20060508141952.2d4b9069.akpm@osdl.org> <20060509035320.GC784@in.ibm.com>
In-Reply-To: <20060509035320.GC784@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:

>On Mon, May 08, 2006 at 02:19:52PM -0700, Andrew Morton wrote:
>
>>Balbir Singh <balbir@in.ibm.com> wrote:
>>
>>>@@ -550,6 +550,12 @@ struct task_delay_info {
>>> 	 * Atomicity of updates to XXX_delay, XXX_count protected by
>>> 	 * single lock above (split into XXX_lock if contention is an issue).
>>> 	 */
>>>+
>>>+	struct timespec blkio_start, blkio_end;	/* Shared by blkio, swapin */
>>>+	u64 blkio_delay;	/* wait for sync block io completion */
>>>+	u64 swapin_delay;	/* wait for swapin block io completion */
>>>+	u32 blkio_count;
>>>+	u32 swapin_count;
>>>
>>These fields are a bit mystifying.
>>
>>In what units are blkio_delay and swapin_delay?
>>
>>What is the meaning behind blkio_count and swapin_count?
>>
>>Better comments needed, please.
>>
>
>Will add more detailed comments and send them as updates.
>

What kinds of usages will this stuff see? Will the CONFIG be usually 
turned on,
with some tasks occasionally using the statistics?

In which case, might it be better to make each delay collector in its 
own data
structure { .list; .start; .end; .delay; .count; .private; .name }, and 
allocate
them and hang them off the task structure when they're in use?

Or even put them in their own data structure (a small hash or something).

OTOH if they're often going to be in use by many tasks, then what you 
have might
be the best option.

Nick

Send instant messages to your online friends http://au.messenger.yahoo.com 
