Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263581AbUDFBbL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 21:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263597AbUDFBbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 21:31:11 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:42906 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263581AbUDFBbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 21:31:02 -0400
Message-ID: <40720853.4040206@yahoo.com.au>
Date: Tue, 06 Apr 2004 11:30:59 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: rusty@au1.ibm.com, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, lhcs-devel@lists.sourceforge.net
Subject: Re: [Experimental CPU Hotplug PATCH] - Move migrate_all_tasks to
 CPU_DEAD handling
References: <20040405121824.GA8497@in.ibm.com> <4071F9C5.2030002@yahoo.com.au> <20040406011508.GA5077@in.ibm.com> <4072077F.7060305@yahoo.com.au>
In-Reply-To: <4072077F.7060305@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Srivatsa Vaddagiri wrote:
> 
>> On Tue, Apr 06, 2004 at 10:28:53AM +1000, Nick Piggin wrote:
>>
>>> First of all, if you're proposing this stuff for inclusion, you
>>> should port it to the -mm tree, because I don't think Andrew
>>> will want any other scheduler work going in just now. It wouldn't
>>> be too hard.
>>
>>
>>
>> Will send out today a patch against latest -mm tree!
>>
>>
>>> I think my stuff is a bit orthogonal to what you're attempting.
>>> And they should probably work well together. My "lazy migrate"
>>> patch means the tasklist lock does not need to be held at all,
>>> only the dying runqueue's lock.
>>
>>
>>
>> Is there some place where I can download your patch (or is it in -mm 
>> tree)?
>>
>>
> 
> I have attached it (against 2.6.5-mm1). I haven't actually tested it
>  #ifdef CONFIG_SMP
> -	if (unlikely(task_running(rq, p) || cpu_is_offline(this_cpu)))
> +	if (unlikely(task_running(rq, p))
>  		goto out_activate;
>  
>  	new_cpu = cpu;
>  
> +#ifdef CONFIG_HOTPLUG_CPU
> +	if (unlikely(cpu_is_offline(cpu))) {
> +		/* Must lazy-migrate off this CPU */
> +		goto out_set_cpu;
> +	}
> +#endif
> +

Err, that should be:
#ifdef CONFIG_HOTPULG_CPU
	if (unlikely(cpu_is_offline(cpu))) {
		/* Must lazy-migrate off this CPU */
		new_cpu = go_away(p);
		goto out_set_cpu;
	}
#endif
