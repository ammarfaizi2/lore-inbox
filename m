Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266859AbTBQG1Z>; Mon, 17 Feb 2003 01:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266865AbTBQG1Z>; Mon, 17 Feb 2003 01:27:25 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:51135 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S266859AbTBQG1X>;
	Mon, 17 Feb 2003 01:27:23 -0500
Message-ID: <3E508308.4020400@colorfullife.com>
Date: Mon, 17 Feb 2003 07:36:56 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Anton Blanchard <anton@samba.org>,
       Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: more signal locking bugs?
References: <Pine.LNX.4.44.0302161620020.1609-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0302161620020.1609-100000@home.transmeta.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Sun, 16 Feb 2003, Manfred Spraul wrote:
>  
>
>>What about this minimal patch? The performance critical operation is 
>>signal delivery - we should fix the synchronization between signal 
>>delivery and exec first.
>>    
>>
>
>Ok, I committed this alternative change, which isn't quite as minimal, but 
>looks a lot cleaner to me.
>
>Also, looking at execve() and other paths, we do seem to have sufficient 
>protection from the tasklist_lock that signal delivery should be fine. So 
>despite a long and confused thread, I think in the end the only real bug 
>was the one Martin found which should be thus fixed..
>  
>
I'm not convinced that exec is correct.
app with two threads, cloned sighand and sig structures.
thread one does exec().
thread two does exit().

Now we can arrive at no_thread_group in de_thread() and 
tsk->sig{,hand}->count == 1.

>no_thread_group:
>
>	write_lock_irq(&tasklist_lock);
>	spin_lock(&oldsighand->siglock);
>	spin_lock(&newsighand->siglock);
>
>	if (current == oldsig->curr_target)
>		oldsig->curr_target = next_thread(current);
>
signal sender: in send_sig_info().
reads tsk->signal. blocks on tsk->sighand->siglock.

>	if (newsig)
>		current->signal = newsig;
>	current->sighand = newsighand;
>	init_sigpending(&current->pending);
>	recalc_sigpending();
>
>	spin_unlock(&newsighand->siglock);
>	spin_unlock(&oldsighand->siglock);
>	write_unlock_irq(&tasklist_lock);
>
>	if (newsig && atomic_dec_and_test(&oldsig->count))
>		kmem_cache_free(signal_cachep, oldsig);
>
>	if (atomic_dec_and_test(&oldsighand->count))
>		kmem_cache_free(sighand_cachep, oldsighand);
>  
>
And now the signal sender continues. BOOM.
sighand structure, sig structure already kfreed, etc.

--
    Manfred

