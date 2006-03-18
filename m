Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932849AbWCRCJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932849AbWCRCJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 21:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932850AbWCRCJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 21:09:28 -0500
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:57236 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932849AbWCRCJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 21:09:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=KxP+xmkpYj/Ygze95GTaMy1s4Oh8LZfPuCr+v8a6aEE0ikB1HyYCQUpIFWhOLkyKP2vg/IkOq6yr84m/x17JNFDYjUDMl4Rh25+TJjDlMR+7YCPwlkZj5qZZMdRh57M1epmXh4Be7hP1qBay61ALFiK/PKYfeilxrm2mVgekvws=  ;
Message-ID: <441B6BD3.2030807@yahoo.com.au>
Date: Sat, 18 Mar 2006 13:09:23 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jack Steiner <steiner@sgi.com>, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] - Reduce overhead of calc_load
References: <20060317145709.GA4296@sgi.com>	<20060317145912.GA13207@elte.hu>	<20060317152611.GA4449@sgi.com> <20060317171538.3826eb41.akpm@osdl.org>
In-Reply-To: <20060317171538.3826eb41.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jack Steiner <steiner@sgi.com> wrote:
> 
>>+unsigned long nr_active(void)
>>+{
>>+	unsigned long i, running = 0, uninterruptible = 0;
>>+
>>+	for_each_online_cpu(i) {
>>+		running += cpu_rq(i)->nr_running;
>>+		uninterruptible += cpu_rq(i)->nr_uninterruptible;
>>+	}
>>+
>>+	if (unlikely((long)uninterruptible < 0))
>>+		uninterruptible = 0;
>>+
>>+	return running + uninterruptible;
>>+}
> 
> 
> Is that check for (uninterruptible < 0) (copied from nr_uninterruptible)
> really needed?  Can rq->nr_uninterruptible actually go negative?
> 

The sum cannot if there are no concurrent updates, however when
there are concurrent updates then it can go negative.

rq->nr_uninterruptible itself is meaningless because it can be
incremented on one rq and decremented on another.

> Perhaps nr_context_switches() and nr_iowait() should also go into this
> function, then we rename it all to
> 
> 	struct sched_stuff {
> 		unsigned nr_uninterruptible;
> 		unsigned nr_running;
> 		unsigned nr_active;
> 		unsigned long nr_context_switches;
> 	};
> 
> 	void get_sched_stuff(struct sched_stuff *);
> 
> and then convert all those random little counter-upper-callers we have.
> 

Is there a need? Do they (except calc_load) use multiple values at
the same time?

> And then give get_sched_stuff() a hotplug handler (probably unneeded) and

What would the hotplug handler do?

> then scratch our heads over why nr_uninterruptible() iterates across all
> possible CPUs while this new nr_active() iterates over all online CPUs like
> nr_running() and unlike nr_context_switches().
> 

I think it need only iterate over possible CPUs.

> 
> IOW: this code's an inefficient mess and needs some caring for.

What are the performance critical places that call the nr_blah() functions?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
