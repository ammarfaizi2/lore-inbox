Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263036AbTDBVRb>; Wed, 2 Apr 2003 16:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263042AbTDBVRa>; Wed, 2 Apr 2003 16:17:30 -0500
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:20972 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id <S263036AbTDBVR3>;
	Wed, 2 Apr 2003 16:17:29 -0500
Date: Wed, 2 Apr 2003 23:36:29 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Antonio Vargas <wind@cocodriloo.com>, linux-kernel@vger.kernel.org,
       Robert Love <rml@tech9.net>
Subject: Re: fairsched + O(1) process scheduler
Message-ID: <20030402213629.GB13168@wind.cocodriloo.com>
References: <20030401125159.GA8005@wind.cocodriloo.com> <20030401164126.GA993@holomorphy.com> <20030401221927.GA8904@wind.cocodriloo.com> <20030402124643.GA13168@wind.cocodriloo.com> <20030402163512.GC993@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030402163512.GC993@holomorphy.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 02, 2003 at 08:35:12AM -0800, William Lee Irwin III wrote:
> On Wed, Apr 02, 2003 at 02:46:43PM +0200, Antonio Vargas wrote:
> +static inline void update_user_timeslices(void)
> ...
> +	list_for_each(entry, &user_list) {
> +		user = list_entry(entry, struct user_struct, uid_list);
> +
> +		if(!user) continue;
> +
> +		if(0){
> +			user_time_slice = user->time_slice;
> 
> Hmm, this looks very O(n)... BTW, doesn't uidhash_lock lock user_list?
> 
> 
> On Wed, Apr 02, 2003 at 02:46:43PM +0200, Antonio Vargas wrote:
> > @@ -39,10 +42,12 @@ struct user_struct root_user = {
> >  static inline void uid_hash_insert(struct user_struct *up, struct list_head *hashent)
> >  {
> >  	list_add(&up->uidhash_list, hashent);
> > +	list_add(&up->uid_list, &user_list);
> >  }
> 
> Okay, there are three or four problems:
> 
> (1) uidhash_lock can't be taken in interrupt context
> (2) you aren't taking uidhash_lock at all in update_user_timeslices()
> (3) you're not actually handing out user timeslices due to an if (0)
> (4) walking user_list is O(n)

Yes I know there are problems, I'm just trying to make it run compile and run :)

I've been thinking about this thing a while ago, and I think I could do this:

a. Have a kernel thread which wakes up on each tick.

b. The thread just takes the first user_truct from the list, adds one tick to his
   timeslice and sends it to the back. This makes the thread giveone
   tick to each user in turn and slowly, instead of trying to give all ticks
   at the same time.

Now, I don't know too much about the locking rules, but I think I could
send a signal, semaphore o spinlock which wakes the thread from the
scheduler_tick(), and the thread could take the uidhash_lock for the update.

Also, this locking rule means I can't even read current->user->time_slice?
What if I changed the type to an atomic_int?

Greets, Antonio.
