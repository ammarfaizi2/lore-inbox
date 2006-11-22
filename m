Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756976AbWKVIgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756976AbWKVIgt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 03:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756979AbWKVIgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 03:36:49 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:37361 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1756976AbWKVIgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 03:36:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:reply-to:x-priority:message-id:to:cc:subject:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        b=RHrJwSRTJqJrTOK6FEygelNf5PamM1xzs0kujk70kf3AP4mNhDn9U9BzeYabVBiSVstTAXpYkVOfbQUcAqJKF/iH6+7gl4ad64D32ysTuQ3qZFt4qxVGjTQmEReKXSVQlnlBstGlSPH7f34VsJ9FQbJVo2f0giKTHMO57OniiL4=
Date: Wed, 22 Nov 2006 10:36:48 +0200
From: Paul Sokolovsky <pmiscml@gmail.com>
Reply-To: Paul Sokolovsky <pmiscml@gmail.com>
X-Priority: 3 (Normal)
Message-ID: <685626416.20061122103648@gmail.com>
To: Greg KH <gregkh@suse.de>
CC: Arjan van de Ven <arjan@infradead.org>,
       Matthew Frost <artusemrys@sbcglobal.net>,
       <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>,
       <kernel-discuss@handhelds.org>
Subject: Re[2]: Where did find_bus() go in 2.6.18?
In-Reply-To: <20061121075431.GA30604@suse.de>
References: <1154868495.20061120003437@gmail.com> <4560ECAF.1030901@gmail.com> <20061120001212.GA28427@suse.de> <1148526308.20061120161322@gmail.com> <20061121075431.GA30604@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

Tuesday, November 21, 2006, 9:54:31 AM, you wrote:

[]
>>   So, I assume the answer to my question is "No replacement. Ability
>> to query bus set in the kernel was just removed, period." That's to
>> which conclusion I came myself after studying 2.6.18 source and patch
>> from 2.6.17.

> Yes, it was removed because no one was using it, and no one could think
> of any reason why it would be needed at the time.

>> [Uninteresting specific case]
>> 
>>   Ok, so the situation is following: we have a kind of multi-layered
>> driver here. Lowest level is a w1_slave bus driver, talking to a
>> specific chip and providing low-level API for accessing data in terms
>> of this chip (or chip class) notions. Above it, we have higher-level
>> driver which interprets data from the low-level one, converting it to
>> a standard device-independent form, plus possibly does some other
>> minor things, like providing feedback indication on these data.
>> (Forgot to say that this is battery driver.)
>> 
>>   So, just in case if some reader of this has quick suggestion of
>> merging these drivers into one, thanks, but they do different things,
>> and we want to keep them nicely decoupled. But now issue of how these
>> drivers talk between themselves raises, and that's exactly the grief
>> point.
>> 
>>   High-level driver used to find w1 bus by name, then enumerate
>> devices on the bus, to find compatible device on it, then hooks into
>> that device and its driver.

> Ick, why not just export the pointer to the devices?

  That's what I kept in mind as one possible solution to our problem
with that driver. Indeed, if kernel no longer wants us to enumerate
buses, why reduce to half measures - use static reference to
w1_bus_type, but still enumerate devices on it? Let's just statically
tap into the exact low-level device we need.

  Oops, but w1 core doesn't provide static struct device for w1 devices.
Devices are defined in terms of w1 bus attributes, and struct device's
are allocated solely on demand. And I know very little about w1 bus &
core, but what I know is enough for me *not* to challenge what w1 core
does: that bus is inherently hot pluggable, plus designed for industrial
automation, so it may be the case that thousands of w1 sensors would
be attached to host, so allocating more or less big struct device's on
demand is what I call "saving memory".


  But let me add another para here: in the description of how our
driver works, I didn't wrote we look for *specific* w1 device. We look
for *compatible* w1 device. It's true that at this time we have 1-to-1
mapping, and even true that in our specific case we actually could
live with 1-to-1 mapping for long time more. But with "deprecating"
tendencies towards using introspectives on LDM objects, you rule out
such cases of dynamic binding at all ;-( (And I don't think
noone uses it because it's useless, I think that LDM with its dynamic
features is still too young for people to fully explore its potential
and start use it at its best).

[]

>>   As it was before, it was clear that LDM consists of multiple layers,
>> and each layer offers consistent and complete set of operations on it,
>> like adding new object on this layer, removing, adding child, removing
>> child, *and* query objects on this level or among childs. I may miss
>> some accidental gaps in that picture of course, but it still was an
>> integral, complete design paradigm offering full dynamicity and
>> introspection.

> Hm, I've never heard the driver model be called a "complete design
> paradigm" in the past.  I've heard it called a lot of real nasty things
> though :)

  Well, it's probably still too young for people to take it as
a whole paradigm yet ;-). And I don't share opinion that it is nasty
thing, so skip on that ;-).

[]

[]

> Please, get your code into the main kernel tree so that we can see it
> and know how the driver core is being used.

  That's what we want very much too, so we'll start (actually,
continue, of course) on that.

[]
>>   One reason is of course because it's not that easy to get something
>> into mainline. ;-)

> Why do you feel this way?  Is it a proceedural thing?  A technical
> thing?  A time thing?

> We want to make it as easy as possible to get code into the tree, please
> submit it and be persistant to get it there.

  Well, mere look at kernel release tarball size suggests the kernel
should use conservative change control ;-). And no, I don't think that
people should submit their rough code, and waste kernel maintainers'
time with reviewing unpolished code.

  But thanks for encouraging, it is indeed very nice to hear that ease
of submission and support of people doing that is the priority for
kernel developers.

[]

> Evolve things over time in the main tree, like the main tree works.
> Again, this is nothing different from the rest of the kernel.

>>   All above has little to do with mainline kernel, of course, and not
>> its problem in any way. Just another entry into your sociological
>> survey "Why people don't submit code upstream." ;-)

> No, I really think you are somehow feeling that once the code is in
> mainline it can't be ever changed.  That's just not true...

  Well, I don't have that feeling, it's just when it gets into
mainline it's harder to do the changes, so we'd better do trivial
ones, like ensuring consistent symbol naming on our side first. And of
course we don't want to get bounce simply because code style doesn't
comply. And that's the start of list of 10+ "small" things we need
to do before submission.

  So, we won't be posting our 8Mb+ patch just tomorrow, and of course
won't expect it to to me merged in a week ;-). But we hope to have
something ready to 2.6.20 patch window (even though we probably don't
have anything too serious to require submission only within patch
window). Probably even start before that, to get criticism sooner, as
patch window is too short for our process.



      So, I probably stop wasting your time with this discussion now,
saving it for real things. And I'd like to thank everyone who
responded. I made the following resume out of it:

      There's nothing wrong going with LDM, it's still as shiny as it
was. It's just find_bus() has become to be considered harmful, unless
proven otherwise - with the code in mainline. So far, so good.


      Thanks!



> thanks,

> greg k-h


-- 
Best regards,
 Paul                            mailto:pmiscml@gmail.com

