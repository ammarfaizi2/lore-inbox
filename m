Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422736AbWJRSOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422736AbWJRSOh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 14:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422750AbWJRSOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 14:14:37 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:6750 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422736AbWJRSOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 14:14:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=AUIgbq5Ao9HWSnL7RL8r1jw+tZyKbXGDo3giiyuH86YaJyOYFUzdLlt2gqKWYcuODxAQN3e7k0rt+94bFIgA3T49KfHzl0AHBj4fEquaGE12SqflerMRXk5ptllpuPTZ/PY/5t3i141kz6FZ9cXZBOqofqRSrNFBsO49zQaPzyQ=  ;
Message-ID: <45366F08.6050903@yahoo.com.au>
Date: Thu, 19 Oct 2006 04:14:32 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Chris Mason <chris.mason@oracle.com>
Subject: Re: 2.6.19-rc2-mm1
References: <20061016230645.fed53c5b.akpm@osdl.org>	 <1161185599.18117.1.camel@dyn9047017100.beaverton.ibm.com>	 <45364CE9.7050002@yahoo.com.au>	 <1161191747.18117.9.camel@dyn9047017100.beaverton.ibm.com>	 <45366515.4050308@yahoo.com.au> <1161194303.18117.17.camel@dyn9047017100.beaverton.ibm.com>
In-Reply-To: <1161194303.18117.17.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
> On Thu, 2006-10-19 at 03:32 +1000, Nick Piggin wrote:

>>Sorry. Can you try with ext2? Alternatively, try with ext3 or reiserfs
>>and change the line in mm/filemap.c:generic_file_buffered_write from
>>
>>		status = a_ops->commit_write(file, page, offset, offset+copied);
>>to
>>		status = a_ops->commit_write(file, page, offset, offset+bytes);
>>
>>and see if that solves your problem (that will result in rubbish being
>>temporarily visible, but there is a similar problem upstream anyway, so it
>>shouldn't cause other failures in your test).
> 
> 
> No. Above change didn't help either :(

OK, so it isn't due to passing in a short / zero length to commit_write.

It is more likely to be a subtle bug when retrying the write after having
faulted on the first page. Hmm, you wouldn't be deadlocking on i_mutex,
due to faulting in fault_in_pages_readable (that is against the documented
lock ordering, but thank god it looks like the documentation is incorrect
as msync doesn't hold mmap_sem over do_fsync).

I can't see anything yet, but I'll keep looking (and try to reproduce
if I can get TLP working).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
