Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbUCHWPs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 17:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUCHWPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 17:15:48 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:36848 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261331AbUCHWPi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 17:15:38 -0500
Message-ID: <404CF07D.1090303@mvista.com>
Date: Mon, 08 Mar 2004 14:15:25 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Amit S. Kale" <amitkale@emsyssoft.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       trini@kernel.crashing.org, pavel@ucw.cz
Subject: Re: kgdb for mainline kernel: core-lite [patch 1/3]
References: <200403081504.30840.amitkale@emsyssoft.com> <200403081545.09916.amitkale@emsyssoft.com> <20040308022602.766be828.akpm@osdl.org> <200403081619.16771.amitkale@emsyssoft.com>
In-Reply-To: <200403081619.16771.amitkale@emsyssoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amit S. Kale wrote:
> On Monday 08 Mar 2004 3:56 pm, Andrew Morton wrote:
> 
>>"Amit S. Kale" <amitkale@emsyssoft.com> wrote:
>>
>>>Here are features that are present only in full kgdb:
>>> 1. Thread support  (aka info threads)
>>
>>argh, disaster.  I discussed this with Tom a week or so ago when it looked
>>like this it was being chopped out and I recall being told that the
>>discussion was referring to something else.
>>
>>Ho-hum, sorry.  Can we please put this back in?
> 
> 
> Err., well this is one of the particularly dirty parts of kgdb. That's why 
> it's been kept away. It takes care of correct thread backtraces in some rare 
> cases.
> 
> If you consider it an absolutely must, we can do something so that the dirty 
> part is kept away and info threads almost always works.
> 

Amit,

I think we should just put the info threads in the core.  No attempt to do any 
trace back from kgdb.  Let them all show up in the switch code.  I have a script 
(gdb macro) that will give a rather decent "info threads" display.  Oh, we need 
to add one other responce to kgdb for the process info gdb command.

  * This query allows the target stub to return an arbitrary string
  * (or strings) giving arbitrary information about the target process.
  * This is optional; the target stub isn't required to implement it.
  *
  * Syntax: qfProcessInfo        request first string
  *         qsProcessInfo        request subsequent string
  * reply:  'O'<hex-encoded-string>
  *         'l'                  last reply (empty)
  */
What we want here is the thread name.

Here is the macro set:

set var $low_sched=0

define do_threads
   if (void)$low_sched==(void)0
	set_b
   end
   thread apply all do_th_lines
end

define do_th_lines
   set var $do_th_co=0
   while ($pc > $low_sched) && ($pc < $high_sched)
     up-silent
     set var $do_th_co=$do_th_co+1
   end
   if $do_th_co==0
     info remote-process
     bt
   else
     up-silent
     info remote-process
     down
   end
end

define set_b
   set var $low_sched=scheduling_functions_start_here
   set var $high_sched=scheduling_functions_end_here
end


~

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

