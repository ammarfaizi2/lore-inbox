Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310459AbSCGTHt>; Thu, 7 Mar 2002 14:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310462AbSCGTHX>; Thu, 7 Mar 2002 14:07:23 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:8583 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S310459AbSCGTHI>;
	Thu, 7 Mar 2002 14:07:08 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Guest section DW <dwguest@win.tue.nl>
Subject: Re: Fwd: [Lse-tech] get_pid() performance fix
Date: Thu, 7 Mar 2002 14:07:38 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Rusty Russell <rusty@rustcorp.com.au>, rajancr@us.ibm.com,
        linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
In-Reply-To: <20020305145004.BFA503FE06@smtp.linux.ibm.com> <20020307143404.A8FFF3FE06@smtp.linux.ibm.com> <20020307145449.GA13062@win.tue.nl>
In-Reply-To: <20020307145449.GA13062@win.tue.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020307190635.9DE533FE08@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 March 2002 09:54 am, Guest section DW wrote:
> On Thu, Mar 07, 2002 at 09:35:09AM -0500, Hubertus Franke wrote:
> ...
>
> Long ago I submitted a patch that changed the max pid from 15 bits to
> 24 or 30 bits or so. (And of course removed the inefficiency noticed
> by some people in the current thread.)
> Probably this is a good moment to try and see what Linus thinks
> about this today.
>
> [Of course Albert Cahalan will object that this is bad for the columns
> of ps output. Maybe Alan will mutter something about sysvipc.
> Roughly speaking there are only advantages, especially since
> I think we'll have to do this sooner or later, and in such cases
> sooner is better.]

I don't think that will solve the N^2 problem you still have the algorithm
do the following:

       if (++last_pid > next_safe) {
 repeat:	
	last_pid++;
	foralltasks p:
		deal with wraparound;
		if (p uses last_pid) goto repeat
		determine next_safe
	}
[ last_pid  ... next_safe ) is the range that can be saftely used

By extending it to 24 or larger bits all you do is handle the wraparound
at some later point and less frequent It also becomes expensive if a large 
number of threads is present. 
Well, the problem can be fixed. Even in the current 16 bit approach.
What we are experimenting around
is a <mark-and-sweep> algorithm that would be invoked if the nr_threads is 
above a threshold. 
The algorithm would do something like this. Rajan will code it up and see
its efficacy.

if (last_pid >= next_safe) {
inside:
	if (nr_threads > threshold) {  // constant 
		last_pid = get_pid_map(last_pid,&next_safe);
	} else {
	 	.. <as now>
	}
}

static unsigned long pid_map[1<<12];

/* determine a range of pids that is available for sure 
 *   [ last_pid .. next_safe ) 
 * pid_map has stale information. some pids might be marked
 * as used even if they had been freed in the meantime
 */

int get_pid_map(int last_pid, int *next_safe)
{
	int again = 1;
repeat:
	for_each_task(p)
		mark_pids_in_bitmap;
		last_pid = ffz(pid_map);   /* we will start from last_pid with wraparound */
		if ((last_pid == -1) && (again)) {
			again = 0;
			memset(pid_map,0);
			goto repeat
		}
	}
	next_safe = first_non_zero(pid_map,last_pid); /* starting from last_pid */
	return last_pid;
}



Note, if the pid map is to large, it can be done in smaller sections or 
windows. Also, note keeping stale information is OK actually desirable, as
it avoids the sweep in almost all cases.
			
-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
