Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbWELMY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbWELMY1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 08:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWELMY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 08:24:27 -0400
Received: from smtp2.wanadoo.fr ([193.252.22.29]:53859 "EHLO smtp2.wanadoo.fr")
	by vger.kernel.org with ESMTP id S1750961AbWELMY0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 08:24:26 -0400
X-ME-UUID: 20060512122425741.1208F1C00467@mwinf0201.wanadoo.fr
Message-ID: <44647E6D.7080905@cosmosbay.com>
Date: Fri, 12 May 2006 14:24:13 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC, PATCH] cond_resched() added to close_files()
References: <20060419112130.GA22648@elte.hu> <44577822.8050103@mbligh.org> <20060502155244.GA5981@elte.hu> <200605022155.31990.dada1@cosmosbay.com> <20060503070152.GB23921@elte.hu> <20060512024446.00a0b407.akpm@osdl.org> <20060512102057.GA22985@elte.hu>
In-Reply-To: <20060512102057.GA22985@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar a écrit :
> * Andrew Morton <akpm@osdl.org> wrote:
>
>   
>> Makes my machine hang early during the startup of init.
>>
>> The last process to pass through close_file() is `hostname', presuably 
>> parented by init.  `hostname' exits then everything stops.  init is 
>> left sleeping in select().
>>
>> All very strange.
>>     
>
> weird. This really shouldnt cause a hang - i think there must be a bug 
> hiding elsewhere, this cond_resched() ought to be fine.
>
> 	Ingo
>
>   
Maybe a process is now awaken because of a closed pipe, instead of a SIGCHLD

Process A, father/parent of process B. They share a pipe (A reads the 
pipe, B writes to)

Before

Process B exits, "atomically close all of its files and sending a SIGCLD 
to its parent"
Process A catch the SIGCLD.

After :
Process B exits "close its files (and the pipe), reschedule before final 
SIGCLD"
Process A gets the POLLIN/POLLHUP indication on the pipe -> Another code 
path is run and may trigger a user side bug ?


Eric




