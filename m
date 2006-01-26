Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbWAZOPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWAZOPb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 09:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbWAZOPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 09:15:31 -0500
Received: from smtpout.mac.com ([17.250.248.89]:6120 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932326AbWAZOPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 09:15:30 -0500
In-Reply-To: <43D88D7B.1030204@yahoo.com.au>
References: <20060124225919.GC12566@suse.de> <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de> <20060125121125.GH5465@suse.de> <43D78262.2050809@symas.com> <43D7BA0F.5010907@nortel.com> <43D7C2F0.5020108@symas.com> <43D7CAAB.9070008@yahoo.com.au> <43D7D234.6060005@symas.com> <43D88D7B.1030204@yahoo.com.au>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E47694FE-571C-40BC-B247-2AC3EEBDA63C@mac.com>
Cc: Howard Chu <hyc@symas.com>, Christopher Friesen <cfriesen@nortel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hancockr@shaw.ca
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
Date: Thu, 26 Jan 2006 09:15:15 -0500
To: Nick Piggin <nickpiggin@yahoo.com.au>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Haven't you OpenLDAP guys realized that the pthread model you're  
actually looking for is this?  POSIX mutexes are not designed to  
mandate scheduling requirements *precisely* because this achieves  
your scheduling goals by explicitly stating what they are.

s: pthread_mutex_lock(&mutex);
s: pthread_cond_wait(&wake_slave, &mutex);

m: [do some work]
m: pthread_cond_signal(&wake_slave);
m: pthread_cond_wait(&wake_master, &mutex);

s: [return from pthread_cond_wait]
s: [do some work]
s: pthread_cond_signal(&wake_master);
s: pthread_cond_wait(&wake_slave, &mutex);

Of course, if that's the model you're looking for, you could always  
do this instead:

void master_func() {
	while (1) {
		[do some work]
		slave_func();
	}
}

void slave_func() {
	[do some work]
}

The semantics are effectively the same.

Cheers,
Kyle Moffett

--
Premature optimization is the root of all evil in programming
   -- C.A.R. Hoare



