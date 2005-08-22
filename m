Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751463AbVHVWnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbVHVWnH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbVHVWnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:43:05 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:21388 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751457AbVHVWnC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:43:02 -0400
Message-ID: <43095E10.3010003@symas.com>
Date: Sun, 21 Aug 2005 22:09:36 -0700
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8b4) Gecko/20050810 SeaMonkey/1.0a
MIME-Version: 1.0
To: Florian Weimer <fw@deneb.enyo.de>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: sched_yield() makes OpenLDAP slow
References: <43057641.70700@symas.com.suse.lists.linux.kernel>	<17157.45712.877795.437505@gargle.gargle.HOWL.suse.lists.linux.kernel>	<430666DB.70802@symas.com.suse.lists.linux.kernel>	<p73oe7syb1h.fsf@verdi.suse.de> <87fyt3vzq0.fsf@mid.deneb.enyo.de>
In-Reply-To: <87fyt3vzq0.fsf@mid.deneb.enyo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Weimer wrote:
> * Andi Kleen:
>
>   
>> Has anybody contacted the Sleepycat people with a description of the 
>> problem yet?
>>     
>
> Berkeley DB does not call sched_yield, but OpenLDAP does in some
> wrapper code around the Berkeley DB backend.
That's not the complete story. BerkeleyDB provides a 
db_env_set_func_yield() hook to tell it what yield function it should 
use when its internal locking routines need such a function. If you 
don't set a specific hook, it just uses sleep(). The OpenLDAP backend 
will invoke this hook during some (not necessarily all) init sequences, 
to tell it to use the thread yield function that we selected in autoconf.

Note that (on systems that support inter-process mutexes) a BerkeleyDB 
database environment may be used by multiple processes concurrently. As 
such, the yield function that is provided must work both for threads 
within a single process (PTHREAD_SCOPE_PROCESS) as well as between 
processes (PTHREAD_SCOPE_SYSTEM). The previous comment about slapd only 
needing to yield within a single process is inaccurate; since we allow 
slapcat to run concurrently with slapd (to allow hot backups) we need 
BerkeleyDB's locking/yield functions to work in System scope.

-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

