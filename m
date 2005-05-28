Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbVE1D7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbVE1D7z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 23:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVE1D7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 23:59:55 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:57783 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261892AbVE1D7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 23:59:53 -0400
Subject: Re: RT patch acceptance
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       bhuey@lnxw.com, hch@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050527071800.GA1624@elte.hu>
References: <20050524184351.47d1a147.akpm@osdl.org>
	 <4293DCB1.8030904@mvista.com> <20050524192029.2ef75b89.akpm@osdl.org>
	 <20050525063306.GC5164@elte.hu> <m1br6zxm1b.fsf@muc.de>
	 <1117044019.5840.32.camel@sdietrich-xp.vilm.net>
	 <20050526193230.GY86087@muc.de>
	 <1117138270.1583.44.camel@sdietrich-xp.vilm.net>
	 <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au>
	 <20050527071800.GA1624@elte.hu>
Content-Type: text/plain
Date: Fri, 27 May 2005 23:59:49 -0400
Message-Id: <1117252789.17318.15.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-27 at 09:18 +0200, Ingo Molnar wrote:
> but it's not like hard-RT tasks live in a vacuum: they already have to 
> be aware of the latencies caused by themselves, and they have to be 
> consciously aware of what kernel facilities they use. If you do hard-RT
> you have to be very aware of every line of code your task may execute.
> 
> > So in that sense, if you do hard RT in the Linux kernel, it surely is 
> > always going to be some subset of operations, dependant on exact 
> > locking implementation, other tasks running and resource usage, right?
> 
> yes. The goal is that latencies will fundamentally depend on what 
> facilities (and sharing) the RT task makes use of - instead of depending 
> on what _other_ tasks do in the system.

Real world example: JACK clients form an ordered graph and each must
finish processing a chunk of audio before signaling the next client to
start.  The audio lives in shared memory and FIFOs are used for the IPC
between RT threads; when each client finishes it writes a single byte to
a fifo which wakes the next client, etc.

(we have to use FIFOs because signals are too slow and futexes are not
available on 2.4)

Of course write() will not normally be RT safe, as it can call down into
the journaling code or whatever, but on a tmpfs/shmfs writing a byte to
a FIFO takes constant time, so as long as the user makes sure the FIFOs
are set up correctly it's all 100% RT safe.

Lee 

