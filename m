Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbWIZVp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbWIZVp6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 17:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbWIZVp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 17:45:57 -0400
Received: from smtp104.biz.mail.mud.yahoo.com ([68.142.200.252]:44948 "HELO
	smtp104.biz.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964846AbWIZVp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 17:45:56 -0400
In-Reply-To: <20060922140937.GL3478@elf.ucw.cz>
References: <200609191946.k8JJkJmx028840@olwen.urbana.css.mot.com> <20060922140937.GL3478@elf.ucw.cz>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d1d1aeaa8d132e6bf987956d9623ad88@nomadgs.com>
Content-Transfer-Encoding: 7bit
Cc: linux-pm@lists.osdl.org, "Scott E. Preece" <preece@motorola.com>,
       linux-kernel@vger.kernel.org
From: Matthew Locke <matt@nomadgs.com>
Subject: Re: [linux-pm] [PATCH] PowerOP, PowerOP Core, 1/2
Date: Tue, 26 Sep 2006 14:45:56 -0700
To: Pavel Machek <pavel@ucw.cz>
X-Mailer: Apple Mail (2.624)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sep 22, 2006, at 7:09 AM, Pavel Machek wrote:

> Hi!
>
>> | > >>+struct powerop_driver {
>> | > >>+	char *name;
>> | > >>+	void *(*create_point) (const char *pwr_params, va_list args);
>> | > >>+	int (*set_point) (void *md_opt);
>> | > >>+	int (*get_point) (void *md_opt, const char *pwr_params, 
>> va_list
>> | > >>args);
>> | > >>+};
>> | > >
>> | > >We can certainly get better interface than va_list, right?
>> | >
>> | > Please elaborate.
>> |
>> | va_list does not provide adequate type checking. I do not think it
>> | suitable in driver<->core interface.
>> ---
>>
>> Well, in this particular case the typing probably has to be weak, one
>> way or another. The meaning of the parameters is arguably opaque at
>
> Why not have struct powerop_parameters, defined in machine-specific
> header somewhere, but used everywhere?

We started out with a machine-specific header.  The general feedback on 
the linux-pm list was that a complete machine independent interface was 
preferred.  At first Eugeny and I were against that but the resulting 
interface is much more flexible.  Users of the PowerOP API do not have 
to include an asm/powerop.h to use it.  Instead you can get all the 
information you need from the interface.  Also, using the current 
implementation you can get/set any arbitrary number and order of the 
power parameters.  For example, a platform has parameters p0-p5.  An 
operating point could be registered with values for p0,p1 and another 
with p0,p1,p2,p3,p4 and p5.  The code that registers operating points 
and accesses existing operating points don't have to know the correct 
order of  parameters, provide values for the entire parameter list or 
have a machine specific header.  In addition to being machine 
independent, the current implementation seems to  works nicely for 
integrating with cpufreq.

We are not completely satisfied with the string parsing that results 
from the current interface but we can improve it over time.


>
>> the interface - the attributes may be meaningful to specific 
>> components
>> of the system, but are not defined in the standardized interface 
>> (which
>> would otherwise have to know about all possible kinds of power
>> attributes and be changed every time a new one is added).
>>
>> So, if you'd rather have an array of char* or void* values, that would
>> probably also meet the need, but my guess is that the typing is
>> intentionally opaque.
>
> Actually array of integers would be better than this.
>
>> | > >How is it going to work on 8cpu box? will
>> | > >you have states like cpu1_800MHz_cpu2_1600MHz_cpu3_800MHz_... ?
>> | >
>> | > i do not operate with term 'state' so I don't understand what it 
>> means here.
>> |
>> | Okay, state here means "operating point". How will operating points
>> | look on 8cpu box? That's 256 states if cpus only support "low" and
>> | "high". How do you name them?
>>
>> I don't think you would name the compounded states. Each CPU would 
>> need
>> to have its own defined set of operating points (since the 
>> capabilities
>> of the CPUs can reasonably be different).
>
> Well, having few "powerop domains" per system would likely solve that
> problem... and problem of 20 devices on my PC. Can we get that?
>
> 								Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) 
> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm
>

